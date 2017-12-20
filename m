Return-Path: <axboe@kernel.dk>
Received: from [192.168.1.154] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l129sm5984770ioa.77.2017.12.20.11.34.56
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Dec 2017 11:34:56 -0800 (PST)
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] null_blk: unalign call_single_data
Message-ID: <eef1f996-e8dd-46a5-f0e2-b41a86c13fe6@kernel.dk>
Date: Wed, 20 Dec 2017 12:34:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Commit 966a967116e6 randomly added alignment to this structure, but
it's actually detrimental to performance of null_blk. Test case:

# modprobe null_blk queue_mode=1 irqmode=1 home_node={0,1}
# echo noop > /sys/block/nullb0/queue/scheduler
# fio --name=csd --filename=/dev/nullb0 --numjobs=8 --direct=1 --rw=randread --norandommap --cpus_allowed=$(cat /sys/devices/system/node/node0/cpulist) --group_reporting=1

Running on both the home and remote node shows a ~5% degradation
in performance.

Fixes: 966a967116e69 ("smp: Avoid using two cache lines for struct call_single_data")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index ccb9975a97fa..8c6912dd5142 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -35,7 +35,7 @@ static inline u64 mb_per_tick(int mbps)
 struct nullb_cmd {
 	struct list_head list;
 	struct llist_node ll_list;
-	call_single_data_t csd;
+	struct __call_single_data csd;
 	struct request *rq;
 	struct bio *bio;
 	unsigned int tag;


-- 
Jens Axboe
