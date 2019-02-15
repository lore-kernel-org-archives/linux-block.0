Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C44CC4360F
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA1C21927
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198122;
	bh=NcKvf8oMC4u7b0tkGEoBYhxO1MaBw/KKt+vj3llO5zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1RZ8dlsTJ/hnWiT60Sy+wglE6d0hB1Xpx0hgtG7wlHkAWhlx7aC9wXzxcgjIhPjJo
	 Xq+wvX2jOJ12tuhSz+lKgB9CtGStJGjlJgBjLCl3cA54lvv1aU1MhKdNyb1bLQMuxc
	 saMFAxWfDN//HWmaJ2gLSEMmF6FU5dF9ZOM5WuHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbfBOCLW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:11:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732214AbfBOCLV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 21:11:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AABC21934;
        Fri, 15 Feb 2019 02:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196680;
        bh=NcKvf8oMC4u7b0tkGEoBYhxO1MaBw/KKt+vj3llO5zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GtEdaNB5zDdRgXiwZ0+lgdwz8xfb0jvqz+gLAm8RnfwOQibEqdgfJLcv7xf4L89ST
         1PIbfT+PcxmJV3JbjnZcqoJQ6CSHMqL5WM9TJYoxN8lakgMG0k9idj6Wd6x5a2OWU/
         5NSi+EdxM1mLfVHGjJ//xTPwu/AQVgIYTiDZPFFQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 77/77] Revert "block: cover another queue enter recursion via BIO_QUEUE_ENTERED"
Date:   Thu, 14 Feb 2019 21:08:55 -0500
Message-Id: <20190215020855.176727-77-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 947b7ac135b16aa60f9141ff72bd494eda0edb5e ]

We can't touch a bio after ->make_request_fn(), for all we know it could
already have been completed by the time this function returns.

This reverts commit 698cef173983b086977e633e46476e0f925ca01e.

Reported-by: syzbot+4df6ca820108fd248943@syzkaller.appspotmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-core.c  | 11 -----------
 block/blk-merge.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 22260339f66f..deb56932f8c4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2449,18 +2449,7 @@ blk_qc_t generic_make_request(struct bio *bio)
 			/* Create a fresh bio_list for all subordinate requests */
 			bio_list_on_stack[1] = bio_list_on_stack[0];
 			bio_list_init(&bio_list_on_stack[0]);
-
-			/*
-			 * Since we're recursing into make_request here, ensure
-			 * that we mark this bio as already having entered the queue.
-			 * If not, and the queue is going away, we can get stuck
-			 * forever on waiting for the queue reference to drop. But
-			 * that will never happen, as we're already holding a
-			 * reference to it.
-			 */
-			bio_set_flag(bio, BIO_QUEUE_ENTERED);
 			ret = q->make_request_fn(q, bio);
-			bio_clear_flag(bio, BIO_QUEUE_ENTERED);
 
 			/* sort new bios into those for a lower level
 			 * and those for the same level
diff --git a/block/blk-merge.c b/block/blk-merge.c
index adfe835ab258..7695034f4b87 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -272,6 +272,16 @@ void blk_queue_split(struct request_queue *q, struct bio **bio)
 		/* there isn't chance to merge the splitted bio */
 		split->bi_opf |= REQ_NOMERGE;
 
+		/*
+		 * Since we're recursing into make_request here, ensure
+		 * that we mark this bio as already having entered the queue.
+		 * If not, and the queue is going away, we can get stuck
+		 * forever on waiting for the queue reference to drop. But
+		 * that will never happen, as we're already holding a
+		 * reference to it.
+		 */
+		bio_set_flag(*bio, BIO_QUEUE_ENTERED);
+
 		bio_chain(split, *bio);
 		trace_block_split(q, split, (*bio)->bi_iter.bi_sector);
 		generic_make_request(*bio);
-- 
2.19.1

