Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B26C10F05
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946D921B1C
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196796;
	bh=0vSfSMiU+8pGBB8ZgIziX9dfMiKns8BV9JC+iioPptU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z10M3jgTiGHToUVR3nVKCDcSZESm5x+Hy8a4kmrAXyTlSprftin1zEMEAUD3vq3nY
	 vafvrQ0w+oYM7qDKFnPnhj6d4xDy1G5RWc7Q2ysRu5kLOogFux7sOjmnhoQrjsnsdt
	 eQ6oJ3dGzkLbiEEeHj1HRLrFczjPC3vCA0nQPTKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391333AbfBOCNO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:13:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389380AbfBOCNN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 21:13:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1208421934;
        Fri, 15 Feb 2019 02:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196792;
        bh=0vSfSMiU+8pGBB8ZgIziX9dfMiKns8BV9JC+iioPptU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgQRybK9A2+hQQmInmBcnqea9pFcnEMi1k5v9MVIN9sULc3FqazQwE+O/HzVjhu8+
         /6spDx+wSQB1yCMIju5lkoTtCgTPYz7NaFVMgVesNIg90Xwcz2Z0ugNO+ACdJSHWru
         zX51P3AMB11tEeR6DVflgaejCcYaZjJYqR2Xi5rc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 65/65] Revert "block: cover another queue enter recursion via BIO_QUEUE_ENTERED"
Date:   Thu, 14 Feb 2019 21:11:21 -0500
Message-Id: <20190215021121.177674-65-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
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
index a9fde80606d7..eb8b52241453 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2454,18 +2454,7 @@ blk_qc_t generic_make_request(struct bio *bio)
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
index ba7f732c519e..2e042190a4f1 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -211,6 +211,16 @@ void blk_queue_split(struct request_queue *q, struct bio **bio)
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

