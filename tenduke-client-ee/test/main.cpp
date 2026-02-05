// 10Duke Client EE vcpkg Integration Test
// This test verifies tenduke-client-ee libraries are properly linked

#include <iostream>

// Include headers from the bundle
#include "createTendukeClientForBrowser.h"
#include "createTendukeClientForDevice.h"
#include "createTendukeClient.h"

int main() {
    std::cout << "=== 10Duke Client EE vcpkg Integration Test ===" << std::endl;

    // Test 1: Verify basic types from bundle are accessible (compilation test)
    std::cout << "Testing 10Duke Client EE type accessibility..." << std::endl;

    // These are just pointer declarations to test that headers are included
    // and that the types compile properly
    using ::tenduke::ee::ClientProperties;
    using ::tenduke::oidc::osbrowser::BrowserAuthenticationConfig;

    ClientProperties* props = nullptr;
    BrowserAuthenticationConfig* authConfig = nullptr;

    (void)props;        // Silence unused warnings
    (void)authConfig;

    std::cout << "✓ ClientProperties type is accessible" << std::endl;
    std::cout << "✓ BrowserAuthenticationConfig type is accessible" << std::endl;
    std::cout << "✓ Bundle headers are properly included" << std::endl;

    // Test 2: Verify ClientProperties builder pattern
    std::cout << "Testing ClientProperties builder..." << std::endl;
    auto clientProps = ClientProperties::Builder()
        .hardwareId("test-hardware-id")
        .build();
    std::cout << "✓ ClientProperties::Builder works" << std::endl;

    std::cout << std::endl;
    std::cout << "=== TEST PASSED ===" << std::endl;
    std::cout << "10Duke Client EE headers are accessible and types are properly defined." << std::endl;
    std::cout << "The executable successfully links against tenduke_client_ee_bundle." << std::endl;
    std::cout << std::endl;
    std::cout << "Note: This is a compilation test. To test actual licensing functionality," << std::endl;
    std::cout << "      you need a valid 10Duke deployment URL and OAuth credentials." << std::endl;
    std::cout << "      See samples/getting-started/ in the official repository for a full example." << std::endl;

    return 0;
}
