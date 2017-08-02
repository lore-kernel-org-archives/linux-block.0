Return-Path: <zhangweiping@didichuxing.com>
Date: Thu, 3 Aug 2017 00:26:00 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH 0/2] null_blk: make sure submit_queues > 0
Message-ID: <20170802162555.GA30489@bogon.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

Hi,

two misc patch for null_blk,

null_blk: simplify logic for use_per_node_hctx
simplify code logic, if use_per_node_hctx set submit_queues same as
nr_online_nodes.

null_blk: make sure submit_queues > 0
set submit_queues to 1 by default, and add a handle for it's value < 0,
no matter what user want, otherwise kmalloc has a negtive parameters.

weiping zhang (2):
  null_blk: simplify logic for use_per_node_hctx
  null_blk: make sure submit_queues > 0

 drivers/block/null_blk.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

-- 
2.9.4
