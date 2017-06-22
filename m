Return-Path: <zwp10758@gmail.com>
MIME-Version: 1.0
From: Erics Di <zwp10758@gmail.com>
Date: Thu, 22 Jun 2017 17:29:14 +0800
Message-ID: <CAA70yB4PT=uPio1owQ7AaBnZABid92ywRUcX7kzEqiTGGJJeMw@mail.gmail.com>
Subject: [PATCH] blk-mq: remove double set queue_num
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

hwctx's queue_num has been set prior call blk_mq_init_hctx, so no need

set it again.


Signed-off-by: weiping <zhangweiping@didichuxing.com>

---

 block/blk-mq.c | 1 -

 1 file changed, 1 deletion(-)


diff --git a/block/blk-mq.c b/block/blk-mq.c

index bb66c96..adcb79c 100644

--- a/block/blk-mq.c

+++ b/block/blk-mq.c

@@ -1900,7 +1900,6 @@ static int blk_mq_init_hctx(struct request_queue *q,

  spin_lock_init(&hctx->lock);

  INIT_LIST_HEAD(&hctx->dispatch);

  hctx->queue = q;

- hctx->queue_num = hctx_idx;

  hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;



  cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);

-- 

1.8.3.1
