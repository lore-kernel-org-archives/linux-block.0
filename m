Return-Path: <axboe@kernel.dk>
Received: from [192.168.1.12] (mobile-166-170-48-161.mycingular.net. [166.170.48.161])
        by smtp.gmail.com with ESMTPSA id n22sm17335411pfa.161.2017.11.19.10.52.56
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2017 10:52:56 -0800 (PST)
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blktrace: fix trace mutex deadlock
Message-ID: <a0e84358-d9af-4999-4512-3219f0d558ac@kernel.dk>
Date: Sun, 19 Nov 2017 11:52:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

A previous commit changed the locking around registration/cleanup,
but direct callers of blk_trace_remove() were missed. This means
that if we hit the error path in setup, we will deadlock on
attempting to re-acquire the queue trace mutex.

Fixes: 1f2cac107c59 ("blktrace: fix unlocked access to init/start-stop/teardown")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 206e0e2ace53..f224985de5fa 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -591,7 +591,7 @@ static int __blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		return ret;
 
 	if (copy_to_user(arg, &buts, sizeof(buts))) {
-		blk_trace_remove(q);
+		__blk_trace_remove(q);
 		return -EFAULT;
 	}
 	return 0;
@@ -637,7 +637,7 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 		return ret;
 
 	if (copy_to_user(arg, &buts.name, ARRAY_SIZE(buts.name))) {
-		blk_trace_remove(q);
+		__blk_trace_remove(q);
 		return -EFAULT;
 	}
 

-- 
Jens Axboe
