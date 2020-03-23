Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FC0C54EEB
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 18:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290712051A
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 18:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhaSns2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgCWSYA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:24:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45332 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgCWSXw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 14:23:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id o26so1096796pgc.12
        for <linux-block@vger.kernel.org>; Mon, 23 Mar 2020 11:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nTfUmVUYCh35GIwC+cQp9S24IuXHaD8ADVR/tUaCHh4=;
        b=NhaSns2d49Hz2dbuq93wJRDzZmkkvJz/LDe2GbTFdwsHL1P4WnjKRRHCk2Q1YpXMP/
         5N/STNii3bPbZ8DknCUZuRBMPW9cHFzpkqovJwllYbDDe0yO8/a06sdVN3NnAzTi46cO
         mVkj9vMt2/9Bf+sG0n0SGtEi0YvYui2PTPFIAnijKpzuBpUkQKZl+pvOxSxHB/8LJNQj
         T6993Y6EZqBKI0cIP0Y41uIV5pW70L8vnHg3CLu1/qjJucPhaexNsZ03eYdfiH6XXkla
         JuLI52CthoQTABMS8YT8sQwkH5sfdMirJITeAD4gf63nIBdq+9I16gySXiE6nUar7UEj
         uGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nTfUmVUYCh35GIwC+cQp9S24IuXHaD8ADVR/tUaCHh4=;
        b=Fi1UYFbElDe7DYowVQNplQM4LAAP8GsAfOFQoFQsq816VQylBF3M2vHThz/V8mPhhJ
         gqkYbmfNI+MvtUBsjkHDtwFYvwXqI1N/fT4CO5qg5k1ANFjBRRitTYfPlYV7pBz0FJzl
         DMQIYPO8ATbX45QC+Y1jG7jisP4ZRV2FktS9SrzmdsO9Rl0TNantQir0hQFI22jTUxgu
         C0+hqWKKgj2OQhDIKmVm82JPyznvq2+fNOCO+YAOCodyGHTlGUf5aYnaT5n52IXCBg8i
         jBnUK8tvZuLt9f0G5CY1wQ39QukoBvHPxu/L58kwg2vxVv64+9nC7/uf5oThy+mkmzUA
         gXkw==
X-Gm-Message-State: ANhLgQ2b3q1yZdtmJb1D7ztgWgMRxWiGxRFkFqKx7rGgZH0GF0CAfUH/
        gRnGXS7op7CYtWzPUThhEggbErbr
X-Google-Smtp-Source: ADFU+vuR5UNMG7iJXu/V2a0mCllyPnYkO1GVX6uXEfkedqlfzEaPy0kbekxuKhsZyc6YMJYgZJqOwg==
X-Received: by 2002:a62:7c15:: with SMTP id x21mr26528164pfc.132.1584987831280;
        Mon, 23 Mar 2020 11:23:51 -0700 (PDT)
Received: from localhost.localdomain (M106072039032.v4.enabler.ne.jp. [106.72.39.32])
        by smtp.googlemail.com with ESMTPSA id bt19sm266854pjb.3.2020.03.23.11.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 11:23:50 -0700 (PDT)
From:   Tokunori Ikegami <ikegami.t@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Tokunori Ikegami <ikegami.t@gmail.com>,
        linux-nvme@lists.infradead.org
Subject: [PATCH] block, nvme: Increase max segments parameter setting value
Date:   Tue, 24 Mar 2020 03:23:24 +0900
Message-Id: <20200323182324.3243-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently data length can be specified as UINT_MAX but failed.
This is caused by the max segments parameter limit set as USHRT_MAX.
To resolve this issue change to increase the value limit range.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
---
 block/blk-settings.c     | 2 +-
 drivers/nvme/host/core.c | 2 +-
 include/linux/blkdev.h   | 7 ++++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index c8eda2e7b91e..ed40bda573c2 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -266,7 +266,7 @@ EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
  *    Enables a low level driver to set an upper limit on the number of
  *    hw data segments in a request.
  **/
-void blk_queue_max_segments(struct request_queue *q, unsigned short max_segments)
+void blk_queue_max_segments(struct request_queue *q, unsigned int max_segments)
 {
 	if (!max_segments) {
 		max_segments = 1;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a4d8c90ee7cc..2b48aab0969e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2193,7 +2193,7 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 
 		max_segments = min_not_zero(max_segments, ctrl->max_segments);
 		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
-		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
+		blk_queue_max_segments(q, min_t(u32, max_segments, UINT_MAX));
 	}
 	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
 	    is_power_of_2(ctrl->max_hw_sectors))
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f629d40c645c..4f4224e20c28 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -338,8 +338,8 @@ struct queue_limits {
 	unsigned int		max_write_zeroes_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
+	unsigned int		max_segments;
 
-	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
 
@@ -1067,7 +1067,8 @@ extern void blk_queue_make_request(struct request_queue *, make_request_fn *);
 extern void blk_queue_bounce_limit(struct request_queue *, u64);
 extern void blk_queue_max_hw_sectors(struct request_queue *, unsigned int);
 extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
-extern void blk_queue_max_segments(struct request_queue *, unsigned short);
+extern void blk_queue_max_segments(struct request_queue *q,
+				   unsigned int max_segments);
 extern void blk_queue_max_discard_segments(struct request_queue *,
 		unsigned short);
 extern void blk_queue_max_segment_size(struct request_queue *, unsigned int);
@@ -1276,7 +1277,7 @@ static inline unsigned int queue_max_hw_sectors(const struct request_queue *q)
 	return q->limits.max_hw_sectors;
 }
 
-static inline unsigned short queue_max_segments(const struct request_queue *q)
+static inline unsigned int queue_max_segments(const struct request_queue *q)
 {
 	return q->limits.max_segments;
 }
-- 
2.17.1

