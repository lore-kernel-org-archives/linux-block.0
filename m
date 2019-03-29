Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F09C10F05
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 17:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A722184D
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 17:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bQ+buCRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfC2Rqf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:46:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49962 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729652AbfC2Rqd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 13:46:33 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2THiFUs011574
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 10:46:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=BTatwtPVujTOvj9QKt/gTnI1Ftj2vjcKjk6l8/vV3FY=;
 b=bQ+buCRsn2lGr0aYnIWWL99DYyLTpd84RfKaINAd/UeulIkOoI9e0o1/+0HSxn8gWUz8
 f0rSIic7Ef2ZL5udNnZj3zvLEpMXmxxl06FsNCg5HBLbu9ITQeZ6KvYTUCAMrdFhSOXj
 Ga5TBBoJ+KwLzdq2on9Rv3vtLutjvpGTy68= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rhq1j08w6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 10:46:31 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 29 Mar 2019 10:46:30 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 263AC62E1BDA; Fri, 29 Mar 2019 10:46:30 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-raid@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <kernel-team@fb.com>, <neilb@suse.com>, <xni@redhat.com>,
        <ncroxon@redhat.com>, <axboe@kernel.dk>, <stable@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 2/3] Revert "MD: fix lock contention for flush bios"
Date:   Fri, 29 Mar 2019 10:46:16 -0700
Message-ID: <20190329174617.3670341-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190329174617.3670341-1-songliubraving@fb.com>
References: <20190329174617.3670341-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: NeilBrown <neilb@suse.com>

This reverts commit 5a409b4f56d50b212334f338cb8465d65550cd85.

This patch has two problems.

1/ it make multiple calls to submit_bio() from inside a make_request_fn.
 The bios thus submitted will be queued on current->bio_list and not
 submitted immediately.  As the bios are allocated from a mempool,
 this can theoretically result in a deadlock - all the pool of requests
 could be in various ->bio_list queues and a subsequent mempool_alloc
 could block waiting for one of them to be released.

2/ It aims to handle a case when there are many concurrent flush requests.
  It handles this by submitting many requests in parallel - all of which
  are identical and so most of which do nothing useful.
  It would be more efficient to just send one lower-level request, but
  allow that to satisfy multiple upper-level requests.

Fixes: 5a409b4f56d5 ("MD: fix lock contention for flush bios")
Cc: <stable@vger.kernel.org> # v4.19+
Tested-by: Xiao Ni <xni@redhat.com>
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 drivers/md/md.c | 159 +++++++++++++++++-------------------------------
 drivers/md/md.h |  22 +++----
 2 files changed, 62 insertions(+), 119 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 05ffffb8b769..021e522001c1 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -132,24 +132,6 @@ static inline int speed_max(struct mddev *mddev)
 		mddev->sync_speed_max : sysctl_speed_limit_max;
 }
 
-static void * flush_info_alloc(gfp_t gfp_flags, void *data)
-{
-        return kzalloc(sizeof(struct flush_info), gfp_flags);
-}
-static void flush_info_free(void *flush_info, void *data)
-{
-        kfree(flush_info);
-}
-
-static void * flush_bio_alloc(gfp_t gfp_flags, void *data)
-{
-	return kzalloc(sizeof(struct flush_bio), gfp_flags);
-}
-static void flush_bio_free(void *flush_bio, void *data)
-{
-	kfree(flush_bio);
-}
-
 static struct ctl_table_header *raid_table_header;
 
 static struct ctl_table raid_table[] = {
@@ -423,54 +405,30 @@ static int md_congested(void *data, int bits)
 /*
  * Generic flush handling for md
  */
-static void submit_flushes(struct work_struct *ws)
-{
-	struct flush_info *fi = container_of(ws, struct flush_info, flush_work);
-	struct mddev *mddev = fi->mddev;
-	struct bio *bio = fi->bio;
-
-	bio->bi_opf &= ~REQ_PREFLUSH;
-	md_handle_request(mddev, bio);
-
-	mempool_free(fi, mddev->flush_pool);
-}
 
-static void md_end_flush(struct bio *fbio)
+static void md_end_flush(struct bio *bio)
 {
-	struct flush_bio *fb = fbio->bi_private;
-	struct md_rdev *rdev = fb->rdev;
-	struct flush_info *fi = fb->fi;
-	struct bio *bio = fi->bio;
-	struct mddev *mddev = fi->mddev;
+	struct md_rdev *rdev = bio->bi_private;
+	struct mddev *mddev = rdev->mddev;
 
 	rdev_dec_pending(rdev, mddev);
 
-	if (atomic_dec_and_test(&fi->flush_pending)) {
-		if (bio->bi_iter.bi_size == 0) {
-			/* an empty barrier - all done */
-			bio_endio(bio);
-			mempool_free(fi, mddev->flush_pool);
-		} else {
-			INIT_WORK(&fi->flush_work, submit_flushes);
-			queue_work(md_wq, &fi->flush_work);
-		}
+	if (atomic_dec_and_test(&mddev->flush_pending)) {
+		/* The pre-request flush has finished */
+		queue_work(md_wq, &mddev->flush_work);
 	}
-
-	mempool_free(fb, mddev->flush_bio_pool);
-	bio_put(fbio);
+	bio_put(bio);
 }
 
-void md_flush_request(struct mddev *mddev, struct bio *bio)
+static void md_submit_flush_data(struct work_struct *ws);
+
+static void submit_flushes(struct work_struct *ws)
 {
+	struct mddev *mddev = container_of(ws, struct mddev, flush_work);
 	struct md_rdev *rdev;
-	struct flush_info *fi;
-
-	fi = mempool_alloc(mddev->flush_pool, GFP_NOIO);
-
-	fi->bio = bio;
-	fi->mddev = mddev;
-	atomic_set(&fi->flush_pending, 1);
 
+	INIT_WORK(&mddev->flush_work, md_submit_flush_data);
+	atomic_set(&mddev->flush_pending, 1);
 	rcu_read_lock();
 	rdev_for_each_rcu(rdev, mddev)
 		if (rdev->raid_disk >= 0 &&
@@ -480,40 +438,59 @@ void md_flush_request(struct mddev *mddev, struct bio *bio)
 			 * we reclaim rcu_read_lock
 			 */
 			struct bio *bi;
-			struct flush_bio *fb;
 			atomic_inc(&rdev->nr_pending);
 			atomic_inc(&rdev->nr_pending);
 			rcu_read_unlock();
-
-			fb = mempool_alloc(mddev->flush_bio_pool, GFP_NOIO);
-			fb->fi = fi;
-			fb->rdev = rdev;
-
 			bi = bio_alloc_mddev(GFP_NOIO, 0, mddev);
-			bio_set_dev(bi, rdev->bdev);
 			bi->bi_end_io = md_end_flush;
-			bi->bi_private = fb;
+			bi->bi_private = rdev;
+			bio_set_dev(bi, rdev->bdev);
 			bi->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
-
-			atomic_inc(&fi->flush_pending);
+			atomic_inc(&mddev->flush_pending);
 			submit_bio(bi);
-
 			rcu_read_lock();
 			rdev_dec_pending(rdev, mddev);
 		}
 	rcu_read_unlock();
+	if (atomic_dec_and_test(&mddev->flush_pending))
+		queue_work(md_wq, &mddev->flush_work);
+}
 
-	if (atomic_dec_and_test(&fi->flush_pending)) {
-		if (bio->bi_iter.bi_size == 0) {
-			/* an empty barrier - all done */
-			bio_endio(bio);
-			mempool_free(fi, mddev->flush_pool);
-		} else {
-			INIT_WORK(&fi->flush_work, submit_flushes);
-			queue_work(md_wq, &fi->flush_work);
-		}
+static void md_submit_flush_data(struct work_struct *ws)
+{
+	struct mddev *mddev = container_of(ws, struct mddev, flush_work);
+	struct bio *bio = mddev->flush_bio;
+
+	/*
+	 * must reset flush_bio before calling into md_handle_request to avoid a
+	 * deadlock, because other bios passed md_handle_request suspend check
+	 * could wait for this and below md_handle_request could wait for those
+	 * bios because of suspend check
+	 */
+	mddev->flush_bio = NULL;
+	wake_up(&mddev->sb_wait);
+
+	if (bio->bi_iter.bi_size == 0) {
+		/* an empty barrier - all done */
+		bio_endio(bio);
+	} else {
+		bio->bi_opf &= ~REQ_PREFLUSH;
+		md_handle_request(mddev, bio);
 	}
 }
+
+void md_flush_request(struct mddev *mddev, struct bio *bio)
+{
+	spin_lock_irq(&mddev->lock);
+	wait_event_lock_irq(mddev->sb_wait,
+			    !mddev->flush_bio,
+			    mddev->lock);
+	mddev->flush_bio = bio;
+	spin_unlock_irq(&mddev->lock);
+
+	INIT_WORK(&mddev->flush_work, submit_flushes);
+	queue_work(md_wq, &mddev->flush_work);
+}
 EXPORT_SYMBOL(md_flush_request);
 
 static inline struct mddev *mddev_get(struct mddev *mddev)
@@ -560,6 +537,7 @@ void mddev_init(struct mddev *mddev)
 	atomic_set(&mddev->openers, 0);
 	atomic_set(&mddev->active_io, 0);
 	spin_lock_init(&mddev->lock);
+	atomic_set(&mddev->flush_pending, 0);
 	init_waitqueue_head(&mddev->sb_wait);
 	init_waitqueue_head(&mddev->recovery_wait);
 	mddev->reshape_position = MaxSector;
@@ -5511,22 +5489,6 @@ int md_run(struct mddev *mddev)
 		if (err)
 			return err;
 	}
-	if (mddev->flush_pool == NULL) {
-		mddev->flush_pool = mempool_create(NR_FLUSH_INFOS, flush_info_alloc,
-						flush_info_free, mddev);
-		if (!mddev->flush_pool) {
-			err = -ENOMEM;
-			goto abort;
-		}
-	}
-	if (mddev->flush_bio_pool == NULL) {
-		mddev->flush_bio_pool = mempool_create(NR_FLUSH_BIOS, flush_bio_alloc,
-						flush_bio_free, mddev);
-		if (!mddev->flush_bio_pool) {
-			err = -ENOMEM;
-			goto abort;
-		}
-	}
 
 	spin_lock(&pers_lock);
 	pers = find_pers(mddev->level, mddev->clevel);
@@ -5686,11 +5648,8 @@ int md_run(struct mddev *mddev)
 	return 0;
 
 abort:
-	mempool_destroy(mddev->flush_bio_pool);
-	mddev->flush_bio_pool = NULL;
-	mempool_destroy(mddev->flush_pool);
-	mddev->flush_pool = NULL;
-
+	bioset_exit(&mddev->bio_set);
+	bioset_exit(&mddev->sync_set);
 	return err;
 }
 EXPORT_SYMBOL_GPL(md_run);
@@ -5894,14 +5853,6 @@ static void __md_stop(struct mddev *mddev)
 		mddev->to_remove = &md_redundancy_group;
 	module_put(pers->owner);
 	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-	if (mddev->flush_bio_pool) {
-		mempool_destroy(mddev->flush_bio_pool);
-		mddev->flush_bio_pool = NULL;
-	}
-	if (mddev->flush_pool) {
-		mempool_destroy(mddev->flush_pool);
-		mddev->flush_pool = NULL;
-	}
 }
 
 void md_stop(struct mddev *mddev)
diff --git a/drivers/md/md.h b/drivers/md/md.h
index c52afb52c776..2deb84fa93f9 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -252,19 +252,6 @@ enum mddev_sb_flags {
 	MD_SB_NEED_REWRITE,	/* metadata write needs to be repeated */
 };
 
-#define NR_FLUSH_INFOS 8
-#define NR_FLUSH_BIOS 64
-struct flush_info {
-	struct bio			*bio;
-	struct mddev			*mddev;
-	struct work_struct		flush_work;
-	atomic_t			flush_pending;
-};
-struct flush_bio {
-	struct flush_info *fi;
-	struct md_rdev *rdev;
-};
-
 struct mddev {
 	void				*private;
 	struct md_personality		*pers;
@@ -470,8 +457,13 @@ struct mddev {
 						   * metadata and bitmap writes
 						   */
 
-	mempool_t			*flush_pool;
-	mempool_t			*flush_bio_pool;
+	/* Generic flush handling.
+	 * The last to finish preflush schedules a worker to submit
+	 * the rest of the request (without the REQ_PREFLUSH flag).
+	 */
+	struct bio *flush_bio;
+	atomic_t flush_pending;
+	struct work_struct flush_work;
 	struct work_struct event_work;	/* used by dm to report failure event */
 	void (*sync_super)(struct mddev *mddev, struct md_rdev *rdev);
 	struct md_cluster_info		*cluster_info;
-- 
2.17.1

