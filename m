Return-Path: <SRS0=lAXC=BD=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: vgoyal@redhat.com,
	tj@kernel.org,
	axboe@kernel.dk,
	Kernel-team@fb.com,
	Shaohua Li <shli@fb.com>
Subject: [RFC 1/2] block: record blkcss in request
Date: Wed,  4 Oct 2017 10:41:19 -0700
Message-Id: <95356f4da3de009464a06c314bf79db672be6adf.1507138530.git.shli@fb.com>
In-Reply-To: <cover.1507138530.git.shli@fb.com>
References: <cover.1507138530.git.shli@fb.com>
In-Reply-To: <cover.1507138530.git.shli@fb.com>
References: <cover.1507138530.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

Currently we record block css info in bio but not in request. Normally
we can get a request's css from its bio, but in some situations, we
can't access request's bio, for example, after blk_update_request. Add
the css to request, so we can access css through the life cycle of a
request.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-core.c       | 12 ++++++++++++
 include/linux/blkdev.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index adb064a..07f8f7e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1551,6 +1551,11 @@ void __blk_put_request(struct request_queue *q, struct request *req)
 		return;
 	}
 
+#ifdef CONFIG_BLK_CGROUP
+	if (req->css)
+		css_put(req->css);
+#endif
+
 	lockdep_assert_held(q->queue_lock);
 
 	blk_pm_put_request(req);
@@ -3094,6 +3099,13 @@ void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
 		rq->rq_flags |= RQF_QUIET;
 	if (bio->bi_disk)
 		rq->rq_disk = bio->bi_disk;
+#ifdef CONFIG_BLK_CGROUP
+	rq->css = NULL;
+	if (bio->bi_css) {
+		rq->css = bio->bi_css;
+		css_get(rq->css);
+	}
+#endif
 }
 
 #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 02fa42d..cdd3aeb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -208,6 +208,7 @@ struct request {
 	struct request_list *rl;		/* rl this rq is alloced from */
 	unsigned long long start_time_ns;
 	unsigned long long io_start_time_ns;    /* when passed to hardware */
+	struct cgroup_subsys_state *css;
 #endif
 	/* Number of scatter-gather DMA addr+len pairs after
 	 * physical address coalescing is performed.
-- 
2.9.5
