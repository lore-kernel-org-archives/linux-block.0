Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32C8C761A6
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 00:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjDGARU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjDGARS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 20:17:18 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1E48A6E
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 17:17:17 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso42137430pjb.2
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 17:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680826637; x=1683418637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDZ0a4ViXZtUJ7fNZdyM/i6Nk6el+pS0D6Bc/VV4l5M=;
        b=BxqDgQrkyvsp1XIHSJ7lZXOVw4EBcJE7vpnd9tn+T1aTv9fwrJUxzIAaQQFAMW/zy/
         mx/wtpH2qXcTo7+QaCJzK+MBPw4WM9wTN1DTUye/Nva+w+1vEKMLhenQFdwmYsOB4u+M
         GokpzuM3Lezy3F+kFWYDHJEU6mN8PmYnF/qaOlN6KVqtOzcBc4wu0rKDziVUvUG3PurP
         BEG8/VqPtMRezXf04gfGAWajC3K8SvY2AAbo6u6FWCXqrQ+nVH+HCHCVS06yks0nY8AV
         92APAjEY/RCe6rJsgy4RrLeE4Gddq/j31sq0kg+Md2lHpAwr3KqEEJqIf3qB70ulHkDT
         IMCQ==
X-Gm-Message-State: AAQBX9cgj8+bZfihmm1PYC3qhvRo2Tf42Nt16jDosIAIBwbtzU6l9ZPf
        JnEC4IU8ceqY81invhCyI5M=
X-Google-Smtp-Source: AKy350ZM5SI0hrLRmHMV4XIfvBLTLNKsZroJ+AKwj8YipOXxU4tRhNAsWv9tvemmugNBfyEq1CV6lA==
X-Received: by 2002:a17:902:c941:b0:1a4:fc40:bf04 with SMTP id i1-20020a170902c94100b001a4fc40bf04mr1078722pla.27.1680826637156;
        Thu, 06 Apr 2023 17:17:17 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709028ec900b0019a773419a6sm1873676plo.170.2023.04.06.17.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 17:17:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 01/12] block: Send zoned writes to the I/O scheduler
Date:   Thu,  6 Apr 2023 17:16:59 -0700
Message-Id: <20230407001710.104169-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407001710.104169-1-bvanassche@acm.org>
References: <20230407001710.104169-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Send zoned writes inserted by the device mapper to the I/O scheduler.
This prevents that zoned writes get reordered if a device mapper driver
has been stacked on top of a driver for a zoned block device.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 16 +++++++++++++---
 block/blk.h    | 19 +++++++++++++++++++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index db93b1a71157..fefc9a728e0e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3008,9 +3008,19 @@ blk_status_t blk_insert_cloned_request(struct request *rq)
 	blk_account_io_start(rq);
 
 	/*
-	 * Since we have a scheduler attached on the top device,
-	 * bypass a potential scheduler on the bottom device for
-	 * insert.
+	 * Send zoned writes to the I/O scheduler if an I/O scheduler has been
+	 * attached.
+	 */
+	if (q->elevator && blk_rq_is_seq_zoned_write(rq)) {
+		blk_mq_sched_insert_request(rq, /*at_head=*/false,
+					    /*run_queue=*/true,
+					    /*async=*/false);
+		return BLK_STS_OK;
+	}
+
+	/*
+	 * If no I/O scheduler has been attached or if the request is not a
+	 * zoned write bypass the I/O scheduler attached to the bottom device.
 	 */
 	blk_mq_run_dispatch_ops(q,
 			ret = blk_mq_request_issue_directly(rq, true));
diff --git a/block/blk.h b/block/blk.h
index d65d96994a94..4b6f8d7a6b84 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -118,6 +118,25 @@ static inline bool bvec_gap_to_prev(const struct queue_limits *lim,
 	return __bvec_gap_to_prev(lim, bprv, offset);
 }
 
+/**
+ * blk_rq_is_seq_zoned_write() - Whether @rq is a write request for a sequential zone.
+ * @rq: Request to examine.
+ *
+ * In this context sequential zone means either a sequential write required or
+ * to a sequential write preferred zone.
+ */
+static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
+{
+	switch (req_op(rq)) {
+	case REQ_OP_WRITE:
+	case REQ_OP_WRITE_ZEROES:
+		return disk_zone_is_seq(rq->q->disk, blk_rq_pos(rq));
+	case REQ_OP_ZONE_APPEND:
+	default:
+		return false;
+	}
+}
+
 static inline bool rq_mergeable(struct request *rq)
 {
 	if (blk_rq_is_passthrough(rq))
