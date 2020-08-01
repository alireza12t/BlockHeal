const router = require("express").Router();
const jwtAuth = require("../middlewares/jwtAuth");
const blockchainController = require("./../controllers/blockchainController");

router.post("/transaction", [jwtAuth], blockchainController.create);

module.exports = router;
