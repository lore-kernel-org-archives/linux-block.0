Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5736CC04EB8
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 16:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A894204FD
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 16:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544459868;
	bh=fVcSZ6ZOwhMZIGX4Jnd1IDW35hyJMPANtNi1j+lxsEo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rfeF4o2lnDRbfwacyIAhl+pTNMXCbxBE3rQ7rP289Yc80irFLnRNNlVzjmUFoNCke
	 o/XIA9aNHyNmUwcuECSnyt4sGeB6Dip8dT43ynJGWF2lcgXUorSIrMilxOm3g8JUvl
	 chy1KJdtstsg3JLo3yZHa+fl7exy9SYiEVjKgzHI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A894204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbeLJQhr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:37:47 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41631 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLJQhr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 11:37:47 -0500
Received: by mail-yw1-f68.google.com with SMTP id f65so4188624ywc.8;
        Mon, 10 Dec 2018 08:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2CyfDJy+iTPBEeQ/7W5t1St9jWeDgth6ZsiwwKiH134=;
        b=pSvi+4hxGeif44cjKokMDKS5OLVgHAJ1p8a6bzvaCOXlwRnA9U3KKpG1mqjJYjWZD3
         QCrtzPdXfPlq2xGpqxOb13vDaAobVAeS4UMHcCdROgxw9gBU1SVY8A3bGL3HxJSalEOs
         BRrrm8mjonGLQMX176kOYVffTSwdQoNoxnfUqtWk/htNcXsWBECDkZ7ez7JJE26ksv/k
         WprmLyuxGpi2dtRD7uMthZgqq7+sNj2k0rz66hd1fY/OEkY+xXKZylqyEdA/xn8C7sIL
         GNQa3oThssq2uZdIddrVX6pNRhmubwXxgqM1qtPEi4n77gTugwtb32bo95UJ8KixZpbL
         B9KA==
X-Gm-Message-State: AA+aEWapoFXkKYN6vpZyMUdZN500zPB1PU5kCKZIBCelx3gZtw4u9Xg1
        AkdRLNbccaK0TYuHkApdDcI=
X-Google-Smtp-Source: AFSGD/WrqwHJDgyf5X4ubnSX00izgeQ1DpdQZsbkXhBzzuA7lFHlNCq/aesUV5if7oUw2w9GZ1/xbg==
X-Received: by 2002:a81:2895:: with SMTP id o143mr13084558ywo.74.1544459866251;
        Mon, 10 Dec 2018 08:37:46 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id c127sm4373894ywb.67.2018.12.10.08.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 08:37:45 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] block: fix iolat timestamp and restore accounting semantics
Date:   Mon, 10 Dec 2018 11:35:10 -0500
Message-Id: <20181210163510.58985-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The blk-iolatency controller measures the time from rq_qos_throttle() to
rq_qos_done_bio() and attributes this time to the first bio that needs
to create the request. This means if a bio is plug-mergeable or
bio-mergeable, it gets to bypass the blk-iolatency controller.

The recent series, to tag all bios w/ blkgs in [1] changed the timing
incorrectly as well. First, the iolatency controller was tagging bios
and using that information if it should process it in rq_qos_done_bio().
However, now that all bios are tagged, this caused the atomic_t for the
struct rq_wait inflight count to underflow resulting in a stall. Second,
now the timing was using the duration a bio from generic_make_request()
rather than the timing mentioned above.

This patch fixes the errors by accounting time separately in a bio
adding the field bi_start. If this field is set, the bio should be
processed by blk-iolatency in rq_qos_done_bio().

[1] https://lore.kernel.org/lkml/20181205171039.73066-1-dennis@kernel.org/

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-iolatency.c     | 17 ++++++-----------
 include/linux/blk_types.h | 12 ++++++++++++
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index bee092727cad..52d5d7cc387c 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -463,6 +463,8 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio)
 	if (!blk_iolatency_enabled(blkiolat))
 		return;
 
+	bio->bi_start = ktime_get_ns();
+
 	while (blkg && blkg->parent) {
 		struct iolatency_grp *iolat = blkg_to_lat(blkg);
 		if (!iolat) {
@@ -480,18 +482,12 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio)
 }
 
 static void iolatency_record_time(struct iolatency_grp *iolat,
-				  struct bio_issue *issue, u64 now,
+				  struct bio *bio, u64 now,
 				  bool issue_as_root)
 {
-	u64 start = bio_issue_time(issue);
+	u64 start = bio->bi_start;
 	u64 req_time;
 
-	/*
-	 * Have to do this so we are truncated to the correct time that our
-	 * issue is truncated to.
-	 */
-	now = __bio_issue_time(now);
-
 	if (now <= start)
 		return;
 
@@ -593,7 +589,7 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 	bool enabled = false;
 
 	blkg = bio->bi_blkg;
-	if (!blkg)
+	if (!blkg || !bio->bi_start)
 		return;
 
 	iolat = blkg_to_lat(bio->bi_blkg);
@@ -612,8 +608,7 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 		atomic_dec(&rqw->inflight);
 		if (!enabled || iolat->min_lat_nsec == 0)
 			goto next;
-		iolatency_record_time(iolat, &bio->bi_issue, now,
-				      issue_as_root);
+		iolatency_record_time(iolat, bio, now, issue_as_root);
 		window_start = atomic64_read(&iolat->window_start);
 		if (now > window_start &&
 		    (now - window_start) >= iolat->cur_win_nsec) {
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 46c005d601ac..c2c02ec08d7c 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -181,6 +181,18 @@ struct bio {
 	 */
 	struct blkcg_gq		*bi_blkg;
 	struct bio_issue	bi_issue;
+#ifdef CONFIG_BLK_CGROUP_IOLATENCY
+	/*
+	 * blk-iolatency measure the time a bio takes between rq_qos_throttle()
+	 * and rq_qos_done_bio().  It attributes the time to the bio that gets
+	 * the request allowing any bios that can tag along via plug merging or
+	 * bio merging to be free (from blk-iolatency's perspective). This is
+	 * different from the time a bio takes from generic_make_request() to
+	 * the end of its life.  So, this also serves as a marker for which bios
+	 * should be processed by blk-iolatency.
+	 */
+	u64			bi_start;
+#endif /* CONFIG_BLK_CGROUP_IOLATENCY */
 #endif
 	union {
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
-- 
2.17.1

