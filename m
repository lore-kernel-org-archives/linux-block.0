Received: from smtp.tiscali.it (santino-notr.mail.tiscali.it [213.205.33.215])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BAA3BBF5
	for <linux-block@vger.kernel.org>; Sun,  2 Jun 2024 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.205.33.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717353458; cv=none; b=sOnxR8LoUHW+XrYSXp2MxV/XpPS3VDuf6g51nWVsh5x94307BdD7bfvQsjxJai6NM+4qEloNPQ+9/a865YTrEeNa8mBFj64q7xuV10L3y2NjuQCDU8Vz6KZv88IQxIeossT1Gb7KE9WhPNywmImoSs562tsEwPUwW1cAFB91cHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717353458; c=relaxed/simple;
	bh=8Vo17OmuU+v63OTwVzwDFPwIG+Ka1MDQUxVqHalM1Ek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VjcH3DnjGNx6w2VwlvRIMQm+k6M/3TVt/hoDCBr7Akkryzc7SgaxUs6wCxy70K/P88o4g0MPkYDWTx6PIGD9ZNqMFT5Phok8mOVBFhDCCq1RKa2fTjWWusKYH2gXAefEZmkKoTve0cVjWaU53F8aOcLpJlG76GXa7Xbt8dPuSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it; spf=pass smtp.mailfrom=tiscali.it; dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b=2N74Pw6g; arc=none smtp.client-ip=213.205.33.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tiscali.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="2N74Pw6g"
Received: from localhost.localdomain ([87.0.86.194])
	by santino.mail.tiscali.it with 
	id WicN2C00o4BaX8701icN1P; Sun, 02 Jun 2024 18:36:23 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: fantonifabio@tiscali.it
From: Fabio Fantoni <fantonifabio@tiscali.it>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabio Fantoni <fantonifabio@tiscali.it>
Subject: [PATCH] block: fix some typo
Date: Sun,  2 Jun 2024 20:36:03 +0200
Message-Id: <20240602183603.18799-1-fantonifabio@tiscali.it>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
	t=1717353383; bh=rleMtP1ew2ItAJZRQ+5UxW/qkxk3oyyl4iv3r3svIrY=;
	h=From:To:Cc:Subject:Date;
	b=2N74Pw6g8g7AxOeoCpqVzi0OyfUVSXbJ/gfcrhJgfoyt6yOiLsGMx8DvkzK23tARj
	 GTsAw1M6KZCtvdPGvQ69lC9KqTavnF1AFK1K+itAOW+t/6sAxnH7n7n6fnwie7fexW
	 OFCppZBrRFyhg2Qz9gW2gTTqOnSJmVwZosqWn7Kk=

During some blksnap patch checks I noticed that the codespell one
detected other errors outside of patch changes, so I created this patch
to fix those detected for the block folder.

Signed-off-by: Fabio Fantoni <fantonifabio@tiscali.it>
---
 block/bdev.c                | 4 ++--
 block/bfq-iosched.c         | 4 ++--
 block/bfq-iosched.h         | 2 +-
 block/bio-integrity.c       | 2 +-
 block/bio.c                 | 2 +-
 block/blk-cgroup-fc-appid.c | 2 +-
 block/blk-cgroup-rwstat.c   | 2 +-
 block/blk-cgroup.c          | 2 +-
 block/blk-core.c            | 6 +++---
 block/blk-iocost.c          | 8 ++++----
 block/blk-iolatency.c       | 4 ++--
 block/blk-ioprio.c          | 2 +-
 block/blk-merge.c           | 6 +++---
 block/blk-mq.c              | 2 +-
 block/blk-settings.c        | 2 +-
 block/blk-sysfs.c           | 2 +-
 block/blk-zoned.c           | 2 +-
 block/genhd.c               | 2 +-
 block/ioprio.c              | 4 ++--
 block/kyber-iosched.c       | 2 +-
 block/opal_proto.h          | 4 ++--
 block/partitions/ibm.c      | 2 +-
 block/partitions/sun.c      | 2 +-
 block/sed-opal.c            | 2 +-
 24 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 353677ac49b3..0059bcf6ae6a 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -580,7 +580,7 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
  * @holder: holder that has claimed @bdev
  * @hops: block device holder operations
  *
- * Finish exclusive open of a block device. Mark the device as exlusively
+ * Finish exclusive open of a block device. Mark the device as exclusively
  * open by the holder and wake up all waiters for exclusive open to finish.
  */
 static void bd_finish_claiming(struct block_device *bdev, void *holder,
@@ -1183,7 +1183,7 @@ EXPORT_SYMBOL(lookup_bdev);
  * to %true the device or media is already gone, if not we are preparing for an
  * orderly removal.
  *
- * This calls into the file system, which then typicall syncs out all dirty data
+ * This calls into the file system, which then typical syncs out all dirty data
  * and writes back inodes and then invalidates any cached data in the inodes on
  * the file system.  In addition we also invalidate the block device mapping.
  */
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4b88a54a9b76..cb67f5bdd561 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1964,7 +1964,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	 * As for throughput, we ask bfq_better_to_idle() whether we
 	 * still need to plug I/O dispatching. If bfq_better_to_idle()
 	 * says no, then plugging is not needed any longer, either to
-	 * boost throughput or to perserve service guarantees. Then
+	 * boost throughput or to preserve service guarantees. Then
 	 * the best option is to stop plugging I/O, as not doing so
 	 * would certainly lower throughput. We may end up in this
 	 * case if: (1) upon a dispatch attempt, we detected that it
@@ -5363,7 +5363,7 @@ void bfq_put_queue(struct bfq_queue *bfqq)
 		 * by the fact that bfqq has just been merged.
 		 * 2) burst_size is greater than 0, to handle
 		 * unbalanced decrements. Unbalanced decrements may
-		 * happen in te following case: bfqq is inserted into
+		 * happen in the following case: bfqq is inserted into
 		 * the current burst list--without incrementing
 		 * bust_size--because of a split, but the current
 		 * burst list is not the burst list bfqq belonged to
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 467e8cfc41a2..19654d8215c4 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -843,7 +843,7 @@ struct bfq_data {
 	 * We set the threshold, empirically, to the minimum possible
 	 * value for which an actuator is fully utilized, or close to
 	 * be fully utilized. By doing so, injected I/O 'steals' as
-	 * few drive-queue slots as possibile to the in-service
+	 * few drive-queue slots as possible to the in-service
 	 * queue. This reduces as much as possible the probability
 	 * that the service of I/O from the in-service bfq_queue gets
 	 * delayed because of slot exhaustion, i.e., because all the
diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 2e3e8e04961e..e86a6a4cb6ce 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -419,7 +419,7 @@ static blk_status_t bio_integrity_process(struct bio *bio,
  * Description:  Checks if the bio already has an integrity payload attached.
  * If it does, the payload has been generated by another kernel subsystem,
  * and we just pass it through. Otherwise allocates integrity payload.
- * The bio must have data direction, target device and start sector set priot
+ * The bio must have data direction, target device and start sector set prior
  * to calling.  In the WRITE case, integrity metadata will be generated using
  * the block device's integrity function.  In the READ case, the buffer
  * will be prepared for DMA and a suitable end_io handler set up.
diff --git a/block/bio.c b/block/bio.c
index e9e809a63c59..700931dfe95f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -520,7 +520,7 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 				return bio;
 			/*
 			 * No cached bio available, bio returned below marked with
-			 * REQ_ALLOC_CACHE to particpate in per-cpu alloc cache.
+			 * REQ_ALLOC_CACHE to participate in per-cpu alloc cache.
 			 */
 		} else {
 			opf &= ~REQ_ALLOC_CACHE;
diff --git a/block/blk-cgroup-fc-appid.c b/block/blk-cgroup-fc-appid.c
index 3ec21333f393..c26fedaf6827 100644
--- a/block/blk-cgroup-fc-appid.c
+++ b/block/blk-cgroup-fc-appid.c
@@ -3,7 +3,7 @@
 #include "blk-cgroup.h"
 
 /**
- * blkcg_set_fc_appid - set the fc_app_id field associted to blkcg
+ * blkcg_set_fc_appid - set the fc_app_id field associated to blkcg
  * @app_id: application identifier
  * @cgrp_id: cgroup id
  * @app_id_len: size of application identifier
diff --git a/block/blk-cgroup-rwstat.c b/block/blk-cgroup-rwstat.c
index a55fb0c53558..c3afb0b62aaa 100644
--- a/block/blk-cgroup-rwstat.c
+++ b/block/blk-cgroup-rwstat.c
@@ -31,7 +31,7 @@ EXPORT_SYMBOL_GPL(blkg_rwstat_exit);
  * @pd: policy private data of interest
  * @rwstat: rwstat to print
  *
- * Print @rwstat to @sf for the device assocaited with @pd.
+ * Print @rwstat to @sf for the device associated with @pd.
  */
 u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 			 const struct blkg_rwstat_sample *rwstat)
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 37e6cc91d576..e638653b932d 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1542,7 +1542,7 @@ EXPORT_SYMBOL_GPL(io_cgrp_subsys);
  * always enough for dereferencing policy data.
  *
  * The caller is responsible for synchronizing [de]activations and policy
- * [un]registerations.  Returns 0 on success, -errno on failure.
+ * [un]registrations.  Returns 0 on success, -errno on failure.
  */
 int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 {
diff --git a/block/blk-core.c b/block/blk-core.c
index 82c3ae22d76d..83c784feb406 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -728,7 +728,7 @@ void submit_bio_noacct_nocheck(struct bio *bio)
 	/*
 	 * We only want one ->submit_bio to be active at a time, else stack
 	 * usage with stacked devices could be a problem.  Use current->bio_list
-	 * to collect a list of requests submited by a ->submit_bio method while
+	 * to collect a list of requests submitted by a ->submit_bio method while
 	 * it is active, and then process them after it returned.
 	 */
 	if (current->bio_list)
@@ -801,7 +801,7 @@ void submit_bio_noacct(struct bio *bio)
 	case REQ_OP_FLUSH:
 		/*
 		 * REQ_OP_FLUSH can't be submitted through bios, it is only
-		 * synthetized in struct request by the flush state machine.
+		 * synthesized in struct request by the flush state machine.
 		 */
 		goto not_supported;
 	case REQ_OP_DISCARD:
@@ -960,7 +960,7 @@ int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
 	 * point to a freshly allocated bio at this point.  If that happens
 	 * we have a few cases to consider:
 	 *
-	 *  1) the bio is beeing initialized and bi_bdev is NULL.  We can just
+	 *  1) the bio is being initialized and bi_bdev is NULL.  We can just
 	 *     simply nothing in this case
 	 *  2) the bio points to a not poll enabled device.  bio_poll will catch
 	 *     this and return 0
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 690ca99dfaca..7a11e04a87fa 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -853,7 +853,7 @@ static int ioc_autop_idx(struct ioc *ioc, struct gendisk *disk)
 }
 
 /*
- * Take the followings as input
+ * Take the following as input
  *
  *  @bps	maximum sequential throughput
  *  @seqiops	maximum sequential 4k iops
@@ -1267,7 +1267,7 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 
 	/*
 	 * If seem to be already active, just update the stamp to tell the
-	 * timer that we're still active.  We don't mind occassional races.
+	 * timer that we're still active.  We don't mind occasional races.
 	 */
 	if (!list_empty(&iocg->active_list)) {
 		ioc_now(ioc, now);
@@ -2154,7 +2154,7 @@ static void ioc_forgive_debts(struct ioc *ioc, u64 usage_us_sum, int nr_debtors,
 }
 
 /*
- * Check the active iocgs' state to avoid oversleeping and deactive
+ * Check the active iocgs' state to avoid oversleeping and deactivate
  * idle iocgs.
  *
  * Since waiters determine the sleep durations based on the vrate
@@ -2356,7 +2356,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 				 *
 				 * Don't reset debtors as their inuse's are
 				 * owned by debt handling. This shouldn't affect
-				 * donation calculuation in any meaningful way
+				 * donation calculation in any meaningful way
 				 * as @iocg doesn't have a meaningful amount of
 				 * share anyway.
 				 */
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index ebb522788d97..e8d71c6f8c30 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -18,7 +18,7 @@
  * every configured node, and each configured node has it's own independent
  * queue depth.  This means that we only care about our latency targets at the
  * peer level.  Some group at the bottom of the hierarchy isn't going to affect
- * a group at the end of some other path if we're only configred at leaf level.
+ * a group at the end of some other path if we're only configured at leaf level.
  *
  * Consider the following
  *
@@ -34,7 +34,7 @@
  * throttle "unloved", but nobody else.
  *
  * In this example "fast", "slow", and "normal" will be the only groups actually
- * accounting their io latencies.  We have to walk up the heirarchy to the root
+ * accounting their io latencies.  We have to walk up the hierarchy to the root
  * on every submit and complete so we can do the appropriate stat recording and
  * adjust the queue depth of ourselves if needed.
  *
diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 4051fada01f1..a5d978756496 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -8,7 +8,7 @@
  * - This policy is cgroup based so it has all the advantages of cgroups.
  * - While ioprio_set() does not affect page cache writeback I/O, this rq-qos
  *   controller affects page cache writeback I/O for filesystems that support
- *   assiociating a cgroup with writeback I/O. See also
+ *   associating a cgroup with writeback I/O. See also
  *   Documentation/admin-guide/cgroup-v2.rst.
  */
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8534c35e0497..56a1638bfb40 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -96,7 +96,7 @@ static inline bool req_gap_front_merge(struct request *req, struct bio *bio)
 }
 
 /*
- * The max size one bio can handle is UINT_MAX becasue bvec_iter.bi_size
+ * The max size one bio can handle is UINT_MAX because bvec_iter.bi_size
  * is defined as 'unsigned int', meantime it has to be aligned to with the
  * logical block size, which is the minimum accepted unit by hardware.
  */
@@ -327,7 +327,7 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 	/*
 	 * Bio splitting may cause subtle trouble such as hang when doing sync
 	 * iopoll in direct IO routine. Given performance gain of iopoll for
-	 * big IO can be trival, disable iopoll when split needed.
+	 * big IO can be trivial, disable iopoll when split needed.
 	 */
 	bio_clear_polled(bio);
 	return bio_split(bio, bytes >> SECTOR_SHIFT, GFP_NOIO, bs);
@@ -738,7 +738,7 @@ static void blk_rq_set_mixed_merge(struct request *rq)
 	/*
 	 * @rq will no longer represent mixable attributes for all the
 	 * contained bios.  It will just track those of the first one.
-	 * Distributes the attributs to each bio.
+	 * Distributes the attributes to each bio.
 	 */
 	for (bio = rq->bio; bio; bio = bio->bi_next) {
 		WARN_ON_ONCE((bio->bi_opf & REQ_FAILFAST_MASK) &&
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3b4df8e5ac9e..ad03e7c7fa16 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2253,7 +2253,7 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 EXPORT_SYMBOL(blk_mq_run_hw_queue);
 
 /*
- * Return prefered queue to dispatch from (if any) for non-mq aware IO
+ * Return preferred queue to dispatch from (if any) for non-mq aware IO
  * scheduler.
  */
 static struct blk_mq_hw_ctx *blk_mq_get_sq_hctx(struct request_queue *q)
diff --git a/block/blk-settings.c b/block/blk-settings.c
index effeb9a639bb..b8961c2d28f7 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -835,7 +835,7 @@ void blk_queue_write_cache(struct request_queue *q, bool wc, bool fua)
 EXPORT_SYMBOL_GPL(blk_queue_write_cache);
 
 /**
- * disk_set_zoned - inidicate a zoned device
+ * disk_set_zoned - indicate a zoned device
  * @disk:	gendisk to configure
  */
 void disk_set_zoned(struct gendisk *disk)
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f0f9314ab65c..e7e8b58f1d91 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -818,7 +818,7 @@ int blk_register_queue(struct gendisk *disk)
 	/*
 	 * SCSI probing may synchronously create and destroy a lot of
 	 * request_queues for non-existent devices.  Shutting down a fully
-	 * functional queue takes measureable wallclock time as RCU grace
+	 * functional queue takes measurable wallclock time as RCU grace
 	 * periods are involved.  To avoid excessive latency in these
 	 * cases, a request_queue starts out in a degraded mode which is
 	 * faster to shut down and is made fully functional here as
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 52abebf56027..ea43f07ce9d5 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1563,7 +1563,7 @@ void disk_free_zone_resources(struct gendisk *disk)
 
 	/*
 	 * Wait for the zone write plugs to be RCU-freed before
-	 * destorying the mempool.
+	 * destroying the mempool.
 	 */
 	rcu_barrier();
 
diff --git a/block/genhd.c b/block/genhd.c
index 8f1f3c6b4d67..7ef2726aa3d3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -352,7 +352,7 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 
 	/*
 	 * If the device is opened exclusively by current thread already, it's
-	 * safe to scan partitons, otherwise, use bd_prepare_to_claim() to
+	 * safe to scan partitions, otherwise, use bd_prepare_to_claim() to
 	 * synchronize with other exclusive openers and other partition
 	 * scanners.
 	 */
diff --git a/block/ioprio.c b/block/ioprio.c
index 73301a261429..66cdf8e9b9df 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2004 Jens Axboe <axboe@kernel.dk>
  *
  * Helper functions for setting/querying io priorities of processes. The
- * system calls closely mimmick getpriority/setpriority, see the man page for
+ * system calls closely mimic getpriority/setpriority, see the man page for
  * those. The prio argument is a composite of prio class and prio data, where
  * the data argument has meaning within that class. The standard scheduling
  * classes have 8 distinct prio levels, with 0 being the highest prio and 7
@@ -157,7 +157,7 @@ static int get_task_ioprio(struct task_struct *p)
  * Return raw IO priority value as set by userspace. We use this for
  * ioprio_get(pid, IOPRIO_WHO_PROCESS) so that we keep historical behavior and
  * also so that userspace can distinguish unset IO priority (which just gets
- * overriden based on task's nice value) from IO priority set to some value.
+ * overridden based on task's nice value) from IO priority set to some value.
  */
 static int get_task_raw_ioprio(struct task_struct *p)
 {
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 4155594aefc6..274e08dc678d 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -140,7 +140,7 @@ struct kyber_cpu_latency {
  */
 struct kyber_ctx_queue {
 	/*
-	 * Used to ensure operations on rq_list and kcq_map to be an atmoic one.
+	 * Used to ensure operations on rq_list and kcq_map to be an atomic one.
 	 * Also protect the rqs on rq_list when merge.
 	 */
 	spinlock_t lock;
diff --git a/block/opal_proto.h b/block/opal_proto.h
index d247a457bf6e..f7bdc017b773 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -232,7 +232,7 @@ enum opal_revertlsp {
 
 /* Packets derived from:
  * TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
- * Secion: 3.2.3 ComPackets, Packets & Subpackets
+ * Section: 3.2.3 ComPackets, Packets & Subpackets
  */
 
 /* Comm Packet (header) for transmissions. */
@@ -425,7 +425,7 @@ struct d0_single_user_mode {
 };
 
 /*
- * Additonal Datastores feature
+ * Additional Datastores feature
  *
  * code == 0x0202
  */
diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index 82d9c4c3fb41..eb2327fcaa59 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -247,7 +247,7 @@ static int find_lnx1_partitions(struct parsed_partitions *state,
 		size = label->lnx.formatted_blocks * secperblk;
 	} else {
 		/*
-		 * Formated w/o large volume support. If the sanity check
+		 * Formatted w/o large volume support. If the sanity check
 		 * 'size based on geo == size based on nr_sectors' is true, then
 		 * we can safely assume that we know the formatted size of
 		 * the disk, otherwise we need additional information
diff --git a/block/partitions/sun.c b/block/partitions/sun.c
index ddf9e6def4b2..a0e46679d0aa 100644
--- a/block/partitions/sun.c
+++ b/block/partitions/sun.c
@@ -100,7 +100,7 @@ int sun_partition(struct parsed_partitions *state)
 
 	/*
 	 * So that old Linux-Sun partitions continue to work,
-	 * alow the VTOC to be used under the additional condition ...
+	 * allow the VTOC to be used under the additional condition ...
 	 */
 	use_vtoc = use_vtoc || !(label->vtoc.sanity ||
 				 label->vtoc.version || label->vtoc.nparts);
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 14fe0fef811c..9cbf504a3f77 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2095,7 +2095,7 @@ static int set_lr_boolean_ace(struct opal_dev *dev,
 		/*
 		 * Add boolean operator in postfix only with
 		 * two or more authorities being added in ACE
-		 * expresion.
+		 * expression.
 		 * */
 		if (u > 0)
 			add_boolean_object_ref(&err, dev, OPAL_BOOLEAN_OR);
-- 
2.25.1

