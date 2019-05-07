Return-Path: <SRS0=61bd=TH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763C8C004C9
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 06:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4898520675
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 06:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557209226;
	bh=70TvJEmu8OvJflZWtXYL2j9zSm78Falniq/Upr9UmP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KrK4YRjes8ihGCi21ajoLsPPgHKDLZ4rGqaTdpyTlsv8aMS1PEBpkQPCLdZlAAUH+
	 KKAoRn4NEyjakEDssPyg/SQNESES0rSQj9sxsg0tnKH6I3elUPhFZtwyNbaYaYPYO2
	 29IttE2BPkP+43kTQKhccI11W8HbWVn2nw0CKxGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfEGGGw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 May 2019 02:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfEGFdk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 May 2019 01:33:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C035F20C01;
        Tue,  7 May 2019 05:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207219;
        bh=70TvJEmu8OvJflZWtXYL2j9zSm78Falniq/Upr9UmP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCR+6p+WrVtBRY8/bv88sRfLYsXqCCyit1/5UD+ZDZSHPBdzA0X+KPXQRomQz9T6y
         ammL22PgEymNESxWuOfAJ+yOPCHN+WSeNxWeuV5sLiaO6UyN8tOKR3pTRwQlO1hufB
         yNsAT6RIJ4aCyEjQVsqT7xExU+x3HCcIJxol4hAU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Kai Krakow <kai@kaishome.de>,
        Paolo Valente <paolo.valente@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 33/99] bfq: update internal depth state when queue depth changes
Date:   Tue,  7 May 2019 01:31:27 -0400
Message-Id: <20190507053235.29900-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 77f1e0a52d26242b6c2dba019f6ebebfb9ff701e ]

A previous commit moved the shallow depth and BFQ depth map calculations
to be done at init time, moving it outside of the hotter IO path. This
potentially causes hangs if the users changes the depth of the scheduler
map, by writing to the 'nr_requests' sysfs file for that device.

Add a blk-mq-sched hook that allows blk-mq to inform the scheduler if
the depth changes, so that the scheduler can update its internal state.

Tested-by: Kai Krakow <kai@kaishome.de>
Reported-by: Paolo Valente <paolo.valente@linaro.org>
Fixes: f0635b8a416e ("bfq: calculate shallow depths at init time")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-iosched.c      | 8 +++++++-
 block/blk-mq.c           | 2 ++
 include/linux/elevator.h | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 72510c470001..356620414cf9 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5353,7 +5353,7 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
 	return min_shallow;
 }
 
-static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
+static void bfq_depth_updated(struct blk_mq_hw_ctx *hctx)
 {
 	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
 	struct blk_mq_tags *tags = hctx->sched_tags;
@@ -5361,6 +5361,11 @@ static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
 
 	min_shallow = bfq_update_depths(bfqd, &tags->bitmap_tags);
 	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, min_shallow);
+}
+
+static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
+{
+	bfq_depth_updated(hctx);
 	return 0;
 }
 
@@ -5783,6 +5788,7 @@ static struct elevator_type iosched_bfq_mq = {
 		.requests_merged	= bfq_requests_merged,
 		.request_merged		= bfq_request_merged,
 		.has_work		= bfq_has_work,
+		.depth_updated		= bfq_depth_updated,
 		.init_hctx		= bfq_init_hctx,
 		.init_sched		= bfq_init_queue,
 		.exit_sched		= bfq_exit_queue,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 16f9675c57e6..9ab847d0d6d2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3123,6 +3123,8 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 		}
 		if (ret)
 			break;
+		if (q->elevator && q->elevator->type->ops.depth_updated)
+			q->elevator->type->ops.depth_updated(hctx);
 	}
 
 	if (!ret)
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 2e9e2763bf47..6e8bc53740f0 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -31,6 +31,7 @@ struct elevator_mq_ops {
 	void (*exit_sched)(struct elevator_queue *);
 	int (*init_hctx)(struct blk_mq_hw_ctx *, unsigned int);
 	void (*exit_hctx)(struct blk_mq_hw_ctx *, unsigned int);
+	void (*depth_updated)(struct blk_mq_hw_ctx *);
 
 	bool (*allow_merge)(struct request_queue *, struct request *, struct bio *);
 	bool (*bio_merge)(struct blk_mq_hw_ctx *, struct bio *);
-- 
2.20.1

