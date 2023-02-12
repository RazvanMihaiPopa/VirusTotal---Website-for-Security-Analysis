import vibe.vibe;
import virus_total;
import db_conn;

import std.stdio;

void main()
{

    auto dbClient = DBConnection("root", "example", "mongo", "27017", "testing");
    auto virusTotalAPI = new VirusTotalAPI(dbClient);

    auto router = new URLRouter;
    router.any("/api/*", delegate void(scope HTTPServerRequest req, scope HTTPServerResponse res) {
        res.headers["Access-Control-Allow-Origin"] = "*";
    });
    router.registerRestInterface(virusTotalAPI);

    auto settings = new HTTPServerSettings;
    settings.port = 8080;
    settings.bindAddresses = ["0.0.0.0"];
    auto listener = listenHTTP(settings, router);
    scope (exit)
    {
        listener.stopListening();
    }

    writeln(router.getAllRoutes());
    logInfo("Please open http://127.0.0.1:8080/ in your browser.");
    runApplication();
}

// void hello(HTTPServerRequest req, HTTPServerResponse res)
// {
//     auto username = "Hardcoded";
//     render!("landing.dt", username)(res);
// }

// void loginpage(HTTPServerRequest req, HTTPServerResponse res)
// {
//     render!("login.dt")(res);
// }

// void signuppage(HTTPServerRequest req, HTTPServerResponse res)
// {
//     render!("signup.dt")(res);
// }