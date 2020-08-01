const mongoose = require("mongoose");

const blockchainSchema = mongoose.Schema({
  user: {
    type: mongoose.Schema.ObjectId,
    ref: "User",
    required: true,
  },
  transaction: {
    type: String,
    required: true,
  },
});

const Blockchain = mongoose.model("Blockchain", blockchainSchema);

module.exports = { Blockchain };
