Return-Path: <axboe@kernel.dk>
Received: from [192.168.1.154] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w195sm5647261ita.44.2017.11.14.09.24.59
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2017 09:24:59 -0800 (PST)
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH/RFC] blk-mq: improve heavily contended tag case
Message-ID: <3de98bc5-d2f5-64cb-d2da-1670a25f4e52@kernel.dk>
Date: Tue, 14 Nov 2017 10:24:58 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Even with a number of waitqueues, we can get into a situation where we
are heavily contended on the waitqueue lock. I got a report on spc1
where we're spending seconds doing this. Arguably the use case is nasty,
I reproduce it with one device and 1000 threads banging on the device.
But that doesn't mean we shouldn't be handling it better.

What ends up happening is that a thread will fail to get a tag, add
itself to the waitqueue, and subsequently get woken up when a tag is
freed - only to find itself going back to sleep on the waitqueue.

Instead of waking all threads, use an exclusive wait and wake up our
sbitmap batch count instead. This seems to work well for me (massive
improvement for this use case), and it survives basic testing. But I
haven't fully verified it yet.

An additional improvement is running the queue and checking for a new
tag BEFORE needing to add ourselves to the waitqueue.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index c81b40ecd3f1..336dde07b230 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -134,12 +134,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	ws = bt_wait_ptr(bt, data->hctx);
 	drop_ctx = data->ctx == NULL;
 	do {
-		prepare_to_wait(&ws->wait, &wait, TASK_UNINTERRUPTIBLE);
-
-		tag = __blk_mq_get_tag(data, bt);
-		if (tag != -1)
-			break;
-
 		/*
 		 * We're out of tags on this hardware queue, kick any
 		 * pending IO submits before going to sleep waiting for
@@ -155,6 +149,13 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != -1)
 			break;
 
+		prepare_to_wait_exclusive(&ws->wait, &wait,
+						TASK_UNINTERRUPTIBLE);
+
+		tag = __blk_mq_get_tag(data, bt);
+		if (tag != -1)
+			break;
+
 		if (data->ctx)
 			blk_mq_put_ctx(data->ctx);
 
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 80aa8d5463fa..42b5ca0acf93 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -462,7 +462,7 @@ static void sbq_wake_up(struct sbitmap_queue *sbq)
 		 */
 		atomic_cmpxchg(&ws->wait_cnt, wait_cnt, wait_cnt + wake_batch);
 		sbq_index_atomic_inc(&sbq->wake_index);
-		wake_up(&ws->wait);
+		wake_up_nr(&ws->wait, wake_batch);
 	}
 }
 
-- 
Jens Axboe
