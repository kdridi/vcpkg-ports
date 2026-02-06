// 10Duke Client EE vcpkg Integration Test
// This test verifies tenduke-client-ee libraries are properly linked

#include <iostream>
#include <exception>

// Include headers from the bundle
#include "createTendukeClientForBrowser.h"
#include "createTendukeClientForDevice.h"
#include "createTendukeClient.h"
#include "oidc/osbrowser/BrowserAuthenticationConfig.h"

int main() {
    std::cout << "=== 10Duke Client EE vcpkg Integration Test ===" << std::endl;
    std::cout << std::endl;

    // Test 1: Verify basic types from bundle are accessible (compilation test)
    std::cout << "[Test 1] Testing type accessibility..." << std::endl;

    using ::tenduke::ee::ClientProperties;
    using ::tenduke::oidc::osbrowser::BrowserAuthenticationConfig;

    std::cout << "  ✓ ClientProperties type is accessible" << std::endl;
    std::cout << "  ✓ BrowserAuthenticationConfig type is accessible" << std::endl;
    std::cout << "  ✓ Bundle headers are properly included" << std::endl;

    // Test 2: Verify ClientProperties builder pattern
    std::cout << std::endl;
    std::cout << "[Test 2] Testing ClientProperties builder..." << std::endl;
    auto clientProps = ClientProperties::Builder()
        .hardwareId("test-hardware-id")
        .build();
    std::cout << "  ✓ ClientProperties::Builder works" << std::endl;

    // Test 3: Verify BrowserAuthenticationConfig construction
    std::cout << std::endl;
    std::cout << "[Test 3] Testing BrowserAuthenticationConfig construction..." << std::endl;
    BrowserAuthenticationConfig authConfig(
        "test-client-id",
        "http://localhost:8080/callback",
        "HTTP/1.1 200 OK\n\n<html><body>Authentication successful</body></html>"
    );
    std::cout << "  ✓ BrowserAuthenticationConfig constructed successfully" << std::endl;

    // Test 4: Test client creation (this will test deep linking)
    // This is the critical test that will expose ABI issues with STL symbols
    std::cout << std::endl;
    std::cout << "[Test 4] Testing client creation with autodiscovery..." << std::endl;
    std::cout << "  Note: This will fail at runtime without valid credentials," << std::endl;
    std::cout << "        but should succeed at link time (no LNK2019 errors)." << std::endl;

    try {
        auto client = tenduke::ee::createClientUsingAutodiscovery(
            "test-vcpkg-integration/1.0.0",
            clientProps,
            "https://example.10duke.net",
            authConfig,
            ""  // No initial state
        );

        std::cout << "  ✓ Client created successfully (unexpected with test config!)" << std::endl;

    } catch (const std::exception& e) {
        // Expected to fail at runtime with invalid config
        std::cout << "  ✓ Client creation threw exception (expected with test config)" << std::endl;
        std::cout << "    Exception: " << e.what() << std::endl;
        std::cout << "  ✓ Most importantly: No linker errors (LNK2019)" << std::endl;
    }

    std::cout << std::endl;
    std::cout << "=== ALL TESTS PASSED ===" << std::endl;
    std::cout << std::endl;
    std::cout << "Summary:" << std::endl;
    std::cout << "  • Headers are accessible and types compile correctly" << std::endl;
    std::cout << "  • Builder patterns work as expected" << std::endl;
    std::cout << "  • Deep linking works (no STL symbol errors like __std_find_end_1)" << std::endl;
    std::cout << "  • The executable successfully links against tenduke libraries" << std::endl;
    std::cout << std::endl;
    std::cout << "Note: For actual licensing functionality, you need:" << std::endl;
    std::cout << "      - Valid 10Duke deployment URL" << std::endl;
    std::cout << "      - OAuth credentials" << std::endl;
    std::cout << "      See samples/getting-started/ in the official repository." << std::endl;

    return 0;
}
