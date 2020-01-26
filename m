Return-Path: <SRS0=p+1D=3P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21940C35240
	for <linux-block@archiver.kernel.org>; Sun, 26 Jan 2020 04:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E992083E
	for <linux-block@archiver.kernel.org>; Sun, 26 Jan 2020 04:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAZEmo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Jan 2020 23:42:44 -0500
Received: from mga03.intel.com ([134.134.136.65]:26154 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbgAZEmo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Jan 2020 23:42:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2020 20:42:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,364,1574150400"; 
   d="scan'208";a="260691567"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.70.106])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2020 20:42:42 -0800
From:   Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
To:     axboe@kernel.dk, song@kernel.org
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Subject: [PATCH 2/2] md: enable io polling
Date:   Sat, 25 Jan 2020 21:41:38 -0700
Message-Id: <20200126044138.5066-3-andrzej.jakowski@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200126044138.5066-1-andrzej.jakowski@linux.intel.com>
References: <20200126044138.5066-1-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Provide a callback for polling the mddev which in turn polls the active
member devices. Activate it only if all members support polling.

Signed-off-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
---
 drivers/md/md.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 4e7c9f398bc6..95173cd4f8fd 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5421,6 +5421,27 @@ int mddev_init_writes_pending(struct mddev *mddev)
 }
 EXPORT_SYMBOL_GPL(mddev_init_writes_pending);
 
+static int md_poll(struct request_queue *q, blk_qc_t cookie)
+{
+	struct mddev *mddev = q->queuedata;
+	struct md_rdev *rdev;
+	int ret = 0;
+	int rv;
+
+	rdev_for_each(rdev, mddev) {
+		if (rdev->raid_disk >= 0 && !test_bit(Faulty, &rdev->flags)) {
+			rv = blk_poll(bdev_get_queue(rdev->bdev), cookie, false);
+			if (rv < 0) {
+				ret = rv;
+				break;
+			}
+			ret += rv;
+		}
+	}
+
+	return ret;
+}
+
 static int md_alloc(dev_t dev, char *name)
 {
 	/*
@@ -5485,6 +5506,7 @@ static int md_alloc(dev_t dev, char *name)
 
 	blk_queue_make_request(mddev->queue, md_make_request);
 	blk_set_stacking_limits(&mddev->queue->limits);
+	mddev->queue->bio_poll_fn = md_poll;
 
 	disk = alloc_disk(1 << shift);
 	if (!disk) {
@@ -5789,12 +5811,17 @@ int md_run(struct mddev *mddev)
 
 	if (mddev->queue) {
 		bool nonrot = true;
+		bool poll = true;
 
 		rdev_for_each(rdev, mddev) {
-			if (rdev->raid_disk >= 0 &&
-			    !blk_queue_nonrot(bdev_get_queue(rdev->bdev))) {
-				nonrot = false;
-				break;
+			if (rdev->raid_disk >= 0) {
+				struct request_queue *q;
+
+				q = bdev_get_queue(rdev->bdev);
+				if (!blk_queue_nonrot(q))
+					nonrot = false;
+				if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+					poll = false;
 			}
 		}
 		if (mddev->degraded)
@@ -5803,6 +5830,10 @@ int md_run(struct mddev *mddev)
 			blk_queue_flag_set(QUEUE_FLAG_NONROT, mddev->queue);
 		else
 			blk_queue_flag_clear(QUEUE_FLAG_NONROT, mddev->queue);
+		if (poll)
+			blk_queue_flag_set(QUEUE_FLAG_POLL, mddev->queue);
+		else
+			blk_queue_flag_clear(QUEUE_FLAG_POLL, mddev->queue);
 		mddev->queue->backing_dev_info->congested_data = mddev;
 		mddev->queue->backing_dev_info->congested_fn = md_congested;
 	}
-- 
2.20.1

