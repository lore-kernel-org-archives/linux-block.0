Return-Path: <prvs=408be853d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 5/5] bfq: Use icq_to_bic() consistently
Date: Wed, 30 Aug 2017 11:42:11 -0700
Message-Id: <20170830184211.12471-6-bart.vanassche@wdc.com>
In-Reply-To: <20170830184211.12471-1-bart.vanassche@wdc.com>
References: <20170830184211.12471-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Some code uses icq_to_bic() to convert an io_cq pointer to a
bfq_io_cq pointer while other code uses a direct cast. Convert
the code that uses a direct cast such that it uses icq_to_bic().

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d375b29ad085..7d1b85e393b2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -239,7 +239,7 @@ static int T_slow[2];
 static int T_fast[2];
 static int device_speed_thresh[2];
 
-#define RQ_BIC(rq)		((struct bfq_io_cq *) (rq)->elv.priv[0])
+#define RQ_BIC(rq)		icq_to_bic((rq)->elv.priv[0])
 #define RQ_BFQQ(rq)		((rq)->elv.priv[1])
 
 struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync)
-- 
2.14.1
