Return-Path: <axboe@kernel.dk>
Subject: Re: [BUG] Potential deadlock in the block layer
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
References: <alpine.DEB.2.20.1702131505580.3619@nanos>
Cc: linux-block@vger.kernel.org, Gabriel C <nix.or.die@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4d3f25fc-7480-769c-2f4f-e5271a47f7c3@kernel.dk>
Date: Mon, 13 Feb 2017 08:02:12 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1702131505580.3619@nanos>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/13/2017 07:14 AM, Thomas Gleixner wrote:
> Gabriel reported the lockdep splat below while investigating something
> different.
> 
> Explanation for the splat is in the function comment above
> del_timer_sync().
> 
> I can reproduce it as well and it's clearly broken.

Agree, the disable logic is broken. The below isn't super pretty, but it
should do the trick for 4.10.

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index c73a6fcaeb9d..838f07e2b64a 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -3758,7 +3758,7 @@ static void cfq_init_cfqq(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 }
 
 #ifdef CONFIG_CFQ_GROUP_IOSCHED
-static void check_blkcg_changed(struct cfq_io_cq *cic, struct bio *bio)
+static bool check_blkcg_changed(struct cfq_io_cq *cic, struct bio *bio)
 {
 	struct cfq_data *cfqd = cic_to_cfqd(cic);
 	struct cfq_queue *cfqq;
@@ -3775,15 +3775,7 @@ static void check_blkcg_changed(struct cfq_io_cq *cic, struct bio *bio)
 	 * spuriously on a newly created cic but there's no harm.
 	 */
 	if (unlikely(!cfqd) || likely(cic->blkcg_serial_nr == serial_nr))
-		return;
-
-	/*
-	 * If we have a non-root cgroup, we can depend on that to
-	 * do proper throttling of writes. Turn off wbt for that
-	 * case, if it was enabled by default.
-	 */
-	if (nonroot_cg)
-		wbt_disable_default(cfqd->queue);
+		return nonroot_cg;
 
 	/*
 	 * Drop reference to queues.  New queues will be assigned in new
@@ -3804,9 +3796,13 @@ static void check_blkcg_changed(struct cfq_io_cq *cic, struct bio *bio)
 	}
 
 	cic->blkcg_serial_nr = serial_nr;
+	return nonroot_cg;
 }
 #else
-static inline void check_blkcg_changed(struct cfq_io_cq *cic, struct bio *bio) { }
+static inline bool check_blkcg_changed(struct cfq_io_cq *cic, struct bio *bio)
+{
+	return false;
+}
 #endif  /* CONFIG_CFQ_GROUP_IOSCHED */
 
 static struct cfq_queue **
@@ -4448,11 +4444,12 @@ cfq_set_request(struct request_queue *q, struct request *rq, struct bio *bio,
 	const int rw = rq_data_dir(rq);
 	const bool is_sync = rq_is_sync(rq);
 	struct cfq_queue *cfqq;
+	bool disable_wbt;
 
 	spin_lock_irq(q->queue_lock);
 
 	check_ioprio_changed(cic, bio);
-	check_blkcg_changed(cic, bio);
+	disable_wbt = check_blkcg_changed(cic, bio);
 new_queue:
 	cfqq = cic_to_cfqq(cic, is_sync);
 	if (!cfqq || cfqq == &cfqd->oom_cfqq) {
@@ -4488,6 +4485,10 @@ cfq_set_request(struct request_queue *q, struct request *rq, struct bio *bio,
 	rq->elv.priv[0] = cfqq;
 	rq->elv.priv[1] = cfqq->cfqg;
 	spin_unlock_irq(q->queue_lock);
+
+	if (disable_wbt)
+		wbt_disable_default(q);
+
 	return 0;
 }
 

-- 
Jens Axboe
