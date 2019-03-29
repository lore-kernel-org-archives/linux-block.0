Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8196C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 17:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744072184D
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 17:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kdsudl5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfC2Rqh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:46:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49996 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729463AbfC2Rqg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 13:46:36 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2THiFV3011574
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 10:46:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=jN8k8+6e/0W/WHkHWb+SZMwdlbMnh2t9nGQvuMfxq28=;
 b=kdsudl5e/Hr1mcQHTd1nqjTWXJsTCVaFmG4TcQ5i7oZjWIGhAG+EPb9z9XRi9jmgfNrI
 +sgwtN0a5so43v2hrxVJoky0I6x+yweOzhUJT39WRCAD+yS5sDBROk8URn2+FUl4yFYt
 EDnyk5TSPW0lc2xTDxsHXeMISzZ47SPK0oY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rhq1j08w6-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 10:46:35 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 29 Mar 2019 10:46:32 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 6161862E1BDA; Fri, 29 Mar 2019 10:46:31 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-raid@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <kernel-team@fb.com>, <neilb@suse.com>, <xni@redhat.com>,
        <ncroxon@redhat.com>, <axboe@kernel.dk>, <stable@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 3/3] md: batch flush requests.
Date:   Fri, 29 Mar 2019 10:46:17 -0700
Message-ID: <20190329174617.3670341-4-songliubraving@fb.com>
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

Currently if many flush requests are submitted to an md device is quick
succession, they are serialized and can take a long to process them all.
We don't really need to call flush all those times - a single flush call
can satisfy all requests submitted before it started.
So keep track of when the current flush started and when it finished,
allow any pending flush that was requested before the flush started
to complete without waiting any more.

Test results from Xiao:

Test is done on a raid10 device which is created by 4 SSDs. The tool is
dbench.

1. The latest linux stable kernel
  Operation                Count    AvgLat    MaxLat
  --------------------------------------------------
  Deltree                    768    10.509    78.305
  Flush                  2078376     0.013    10.094
  Close                  21787697     0.019    18.821
  LockX                    96580     0.007     3.184
  Mkdir                      384     0.008     0.062
  Rename                 1255883     0.191    23.534
  ReadX                  46495589     0.020    14.230
  WriteX                 14790591     7.123    60.706
  Unlink                 5989118     0.440    54.551
  UnlockX                  96580     0.005     2.736
  FIND_FIRST             10393845     0.042    12.079
  SET_FILE_INFORMATION   2415558     0.129    10.088
  QUERY_FILE_INFORMATION 4711725     0.005     8.462
  QUERY_PATH_INFORMATION 26883327     0.032    21.715
  QUERY_FS_INFORMATION   4929409     0.010     8.238
  NTCreateX              29660080     0.100    53.268

Throughput 1034.88 MB/sec (sync open)  128 clients  128 procs
max_latency=60.712 ms

2. With patch1 "Revert "MD: fix lock contention for flush bios""
  Operation                Count    AvgLat    MaxLat
  --------------------------------------------------
  Deltree                    256     8.326    36.761
  Flush                   693291     3.974   180.269
  Close                  7266404     0.009    36.929
  LockX                    32160     0.006     0.840
  Mkdir                      128     0.008     0.021
  Rename                  418755     0.063    29.945
  ReadX                  15498708     0.007     7.216
  WriteX                 4932310    22.482   267.928
  Unlink                 1997557     0.109    47.553
  UnlockX                  32160     0.004     1.110
  FIND_FIRST             3465791     0.036     7.320
  SET_FILE_INFORMATION    805825     0.015     1.561
  QUERY_FILE_INFORMATION 1570950     0.005     2.403
  QUERY_PATH_INFORMATION 8965483     0.013    14.277
  QUERY_FS_INFORMATION   1643626     0.009     3.314
  NTCreateX              9892174     0.061    41.278

Throughput 345.009 MB/sec (sync open)  128 clients  128 procs
max_latency=267.939 m

3. With patch1 and patch2
  Operation                Count    AvgLat    MaxLat
  --------------------------------------------------
  Deltree                    768     9.570    54.588
  Flush                  2061354     0.666    15.102
  Close                  21604811     0.012    25.697
  LockX                    95770     0.007     1.424
  Mkdir                      384     0.008     0.053
  Rename                 1245411     0.096    12.263
  ReadX                  46103198     0.011    12.116
  WriteX                 14667988     7.375    60.069
  Unlink                 5938936     0.173    30.905
  UnlockX                  95770     0.005     4.147
  FIND_FIRST             10306407     0.041    11.715
  SET_FILE_INFORMATION   2395987     0.048     7.640
  QUERY_FILE_INFORMATION 4672371     0.005     9.291
  QUERY_PATH_INFORMATION 26656735     0.018    19.719
  QUERY_FS_INFORMATION   4887940     0.010     7.654
  NTCreateX              29410811     0.059    28.551

Throughput 1026.21 MB/sec (sync open)  128 clients  128 procs
max_latency=60.075 ms

Cc: <stable@vger.kernel.org> # v4.19+
Tested-by: Xiao Ni <xni@redhat.com>
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 drivers/md/md.c | 27 +++++++++++++++++++++++----
 drivers/md/md.h |  3 +++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 021e522001c1..d0f688399a56 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -427,6 +427,7 @@ static void submit_flushes(struct work_struct *ws)
 	struct mddev *mddev = container_of(ws, struct mddev, flush_work);
 	struct md_rdev *rdev;
 
+	mddev->start_flush = ktime_get_boottime();
 	INIT_WORK(&mddev->flush_work, md_submit_flush_data);
 	atomic_set(&mddev->flush_pending, 1);
 	rcu_read_lock();
@@ -467,6 +468,7 @@ static void md_submit_flush_data(struct work_struct *ws)
 	 * could wait for this and below md_handle_request could wait for those
 	 * bios because of suspend check
 	 */
+	mddev->last_flush = mddev->start_flush;
 	mddev->flush_bio = NULL;
 	wake_up(&mddev->sb_wait);
 
@@ -481,15 +483,32 @@ static void md_submit_flush_data(struct work_struct *ws)
 
 void md_flush_request(struct mddev *mddev, struct bio *bio)
 {
+	ktime_t start = ktime_get_boottime();
 	spin_lock_irq(&mddev->lock);
 	wait_event_lock_irq(mddev->sb_wait,
-			    !mddev->flush_bio,
+			    !mddev->flush_bio ||
+			    ktime_after(mddev->last_flush, start),
 			    mddev->lock);
-	mddev->flush_bio = bio;
+	if (!ktime_after(mddev->last_flush, start)) {
+		WARN_ON(mddev->flush_bio);
+		mddev->flush_bio = bio;
+		bio = NULL;
+	}
 	spin_unlock_irq(&mddev->lock);
 
-	INIT_WORK(&mddev->flush_work, submit_flushes);
-	queue_work(md_wq, &mddev->flush_work);
+	if (!bio) {
+		INIT_WORK(&mddev->flush_work, submit_flushes);
+		queue_work(md_wq, &mddev->flush_work);
+	} else {
+		/* flush was performed for some other bio while we waited. */
+		if (bio->bi_iter.bi_size == 0)
+			/* an empty barrier - all done */
+			bio_endio(bio);
+		else {
+			bio->bi_opf &= ~REQ_PREFLUSH;
+			mddev->pers->make_request(mddev, bio);
+		}
+	}
 }
 EXPORT_SYMBOL(md_flush_request);
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 2deb84fa93f9..257cb4c9e22b 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -463,6 +463,9 @@ struct mddev {
 	 */
 	struct bio *flush_bio;
 	atomic_t flush_pending;
+	ktime_t start_flush, last_flush; /* last_flush is when the last completed
+					  * flush was started.
+					  */
 	struct work_struct flush_work;
 	struct work_struct event_work;	/* used by dm to report failure event */
 	void (*sync_super)(struct mddev *mddev, struct md_rdev *rdev);
-- 
2.17.1

