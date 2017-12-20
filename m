Return-Path: <axboe@kernel.dk>
Received: from [192.168.1.154] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id d14sm2933080itj.11.2017.12.20.11.25.36
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Dec 2017 11:25:36 -0800 (PST)
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: unalign call_single_data in struct request
Message-ID: <aedc557e-bfa2-d0ae-39fe-1a937c19bf87@kernel.dk>
Date: Wed, 20 Dec 2017 12:25:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

A previous change blindly added massive alignment to the
call_single_data structure in struct request. This ballooned it in
size from 296 to 320 bytes on my setup, for no valid reason at all.

Use the unaligned struct __call_single_data variant instead.

Fixes: 966a967116e69 ("smp: Avoid using two cache lines for struct call_single_data")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 100d0df38026..0ce8a372d506 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -135,7 +135,7 @@ typedef __u32 __bitwise req_flags_t;
 struct request {
 	struct list_head queuelist;
 	union {
-		call_single_data_t csd;
+		struct __call_single_data csd;
 		u64 fifo_time;
 	};
 

-- 
Jens Axboe
