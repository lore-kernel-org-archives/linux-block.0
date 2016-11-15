Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35848 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935064AbcKOTMI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Nov 2016 14:12:08 -0500
Received: by mail-pg0-f50.google.com with SMTP id f188so69457274pgc.3
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2016 11:12:07 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 2/2] scsi_lib: untangle 0 and BLK_MQ_RQ_QUEUE_OK
Date: Tue, 15 Nov 2016 11:11:59 -0800
Message-Id: <f4d1d248035a6d9ae110464a700272d8c2ef98e0.1479236597.git.osandov@fb.com>
In-Reply-To: <ec8930a71efdc30f9d5e5c69954f5b10cfab9927.1479236597.git.osandov@fb.com>
References: <ec8930a71efdc30f9d5e5c69954f5b10cfab9927.1479236597.git.osandov@fb.com>
In-Reply-To: <ec8930a71efdc30f9d5e5c69954f5b10cfab9927.1479236597.git.osandov@fb.com>
References: <ec8930a71efdc30f9d5e5c69954f5b10cfab9927.1479236597.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Let's not depend on any of the BLK_MQ_RQ_QUEUE_* constants having
specific values. No functional change.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/scsi/scsi_lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 2e35132..47a5c87 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1810,7 +1810,7 @@ static inline int prep_to_mq(int ret)
 {
 	switch (ret) {
 	case BLKPREP_OK:
-		return 0;
+		return BLK_MQ_RQ_QUEUE_OK;
 	case BLKPREP_DEFER:
 		return BLK_MQ_RQ_QUEUE_BUSY;
 	default:
@@ -1897,7 +1897,7 @@ static int scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	int reason;
 
 	ret = prep_to_mq(scsi_prep_state_check(sdev, req));
-	if (ret)
+	if (ret != BLK_MQ_RQ_QUEUE_OK)
 		goto out;
 
 	ret = BLK_MQ_RQ_QUEUE_BUSY;
@@ -1914,7 +1914,7 @@ static int scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	if (!(req->rq_flags & RQF_DONTPREP)) {
 		ret = prep_to_mq(scsi_mq_prep_fn(req));
-		if (ret)
+		if (ret != BLK_MQ_RQ_QUEUE_OK)
 			goto out_dec_host_busy;
 		req->rq_flags |= RQF_DONTPREP;
 	} else {
-- 
2.10.2

