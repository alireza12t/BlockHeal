const catchAsync = require("../utils/catchAsync");
const { Blockchain } = require("../db/blockchain");

exports.create = catchAsync(async (req, res, next) => {
  const { transaction } = req.body;
  if (!transaction)
    return res.status(400).send("transaction must be provided!");

  const found = await Blockchain.find({ transaction });
  console.log(found);
  if (found.length) return res.status(400).send("transaction already exists!");

  const blockchain = new Blockchain({
    user: req.user.id,
    transaction,
  });

  await blockchain.save();

  return res.status(200).send({
    userId: req.user.id,
    transaction,
  });
});
