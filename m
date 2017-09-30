Return-Path: <axboe@kernel.dk>
Received: from [10.211.99.86] ([94.127.55.205])
        by smtp.gmail.com with ESMTPSA id r13sm5130981edk.11.2017.09.30.01.06.46
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Sep 2017 01:06:46 -0700 (PDT)
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blk-mq: wire up completion notifier for laptop mode
Message-ID: <05155e41-caab-0ff4-8520-5eff59c9cf7a@kernel.dk>
Date: Sat, 30 Sep 2017 10:06:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

For some reason, the laptop mode IO completion notified was never wired
up for blk-mq. Ensure that we trigger the callback appropriately, to arm
the laptop mode flush timer.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 98a18609755e..09e92667be98 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -476,6 +476,9 @@ void blk_mq_free_request(struct request *rq)
 	if (rq->rq_flags & RQF_MQ_INFLIGHT)
 		atomic_dec(&hctx->nr_active);
 
+	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
+		laptop_io_completion(q->backing_dev_info);
+
 	wbt_done(q->rq_wb, &rq->issue_stat);
 
 	clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags);

-- 
Jens Axboe
