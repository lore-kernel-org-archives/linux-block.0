Return-Path: <prvs=750bc9d11=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 1/2] cfq: Annotate fall-through in a switch statement
Date: Tue,  7 Aug 2018 16:17:28 -0700
Message-Id: <20180807231729.30308-2-bart.vanassche@wdc.com>
In-Reply-To: <20180807231729.30308-1-bart.vanassche@wdc.com>
References: <20180807231729.30308-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch avoids that gcc complains about fall-through when building
with W=1.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 block/cfq-iosched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 82b6c27b3245..ec6acdd58b7a 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -3666,6 +3666,7 @@ static void cfq_init_prio_data(struct cfq_queue *cfqq, struct cfq_io_cq *cic)
 	switch (ioprio_class) {
 	default:
 		printk(KERN_ERR "cfq: bad prio %x\n", ioprio_class);
+		/* fall through */
 	case IOPRIO_CLASS_NONE:
 		/*
 		 * no prio set, inherit CPU scheduling settings
-- 
2.18.0
