Return-Path: <prvs=408be853d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 1/5] bfq: Annotate fall-through in a switch statement
Date: Wed, 30 Aug 2017 11:42:07 -0700
Message-Id: <20170830184211.12471-2-bart.vanassche@wdc.com>
In-Reply-To: <20170830184211.12471-1-bart.vanassche@wdc.com>
References: <20170830184211.12471-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch avoids that gcc 7 issues a warning about fall-through
when building with W=1.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 6a7a26b6cec1..8c11c2e827a5 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3780,6 +3780,7 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 	default:
 		dev_err(bfqq->bfqd->queue->backing_dev_info->dev,
 			"bfq: bad prio class %d\n", ioprio_class);
+		/* fall through */
 	case IOPRIO_CLASS_NONE:
 		/*
 		 * No prio set, inherit CPU scheduling settings.
-- 
2.14.1
