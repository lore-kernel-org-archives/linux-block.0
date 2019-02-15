Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A64CC4360F
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B4121900
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198343;
	bh=+rX6YSeAoRMM5r7BNd2h7IP68/H/CQjCsUnBIab07dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k7ehV6kr9umOLrtazoNPf7TZjQD5785MzmUMeuRXLPs4yUeCPTag6mix3ODc2ImKE
	 PJtE9dibdFK3dhRXZ5KbxLy9lVsmdL11sPBVQmOrZ3fKwLYTfA+qPttRyc52kDfoc8
	 hzkGMOdKJEoDvo5IK5FmuDm+qi0uBonPseGFQjwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbfBOCKT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:10:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:50428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729960AbfBOCKT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 21:10:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2818222C9;
        Fri, 15 Feb 2019 02:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196617;
        bh=+rX6YSeAoRMM5r7BNd2h7IP68/H/CQjCsUnBIab07dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZVgpj1cidBOzF1r3LU6aRD1FICRx+v/fdoYfeYnBPAgeI5t+Ft+dzdI42Q2jrvOe
         qaauuTnir4lmQv2yRMuIuCHPZlwJpXSCBFFNZr/IoPVxCxH1u9EcKEA/zguDG9k27m
         GfetA5XdjQIHcmOnHIHHyAPihC5NC6YBAibqS/4E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        NeilBrown <neilb@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 49/77] block: cover another queue enter recursion via BIO_QUEUE_ENTERED
Date:   Thu, 14 Feb 2019 21:08:27 -0500
Message-Id: <20190215020855.176727-49-sashal@kernel.org>
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

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 698cef173983b086977e633e46476e0f925ca01e ]

Except for blk_queue_split(), bio_split() is used for splitting bio too,
then the remained bio is often resubmit to queue via generic_make_request().
So the same queue enter recursion exits in this case too. Unfortunatley
commit cd4a4ae4683dc2 doesn't help this case.

This patch covers the above case by setting BIO_QUEUE_ENTERED before calling
q->make_request_fn.

In theory the per-bio flag is used to simulate one stack variable, it is
just fine to clear it after q->make_request_fn is returned. Especially
the same bio can't be submitted from another context.

Fixes: cd4a4ae4683dc2 ("block: don't use blocking queue entered for recursive bio submits")
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: NeilBrown <neilb@suse.com>
Reviewed-by:  Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-core.c  | 11 +++++++++++
 block/blk-merge.c | 10 ----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index deb56932f8c4..22260339f66f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2449,7 +2449,18 @@ blk_qc_t generic_make_request(struct bio *bio)
 			/* Create a fresh bio_list for all subordinate requests */
 			bio_list_on_stack[1] = bio_list_on_stack[0];
 			bio_list_init(&bio_list_on_stack[0]);
+
+			/*
+			 * Since we're recursing into make_request here, ensure
+			 * that we mark this bio as already having entered the queue.
+			 * If not, and the queue is going away, we can get stuck
+			 * forever on waiting for the queue reference to drop. But
+			 * that will never happen, as we're already holding a
+			 * reference to it.
+			 */
+			bio_set_flag(bio, BIO_QUEUE_ENTERED);
 			ret = q->make_request_fn(q, bio);
+			bio_clear_flag(bio, BIO_QUEUE_ENTERED);
 
 			/* sort new bios into those for a lower level
 			 * and those for the same level
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 7695034f4b87..adfe835ab258 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -272,16 +272,6 @@ void blk_queue_split(struct request_queue *q, struct bio **bio)
 		/* there isn't chance to merge the splitted bio */
 		split->bi_opf |= REQ_NOMERGE;
 
-		/*
-		 * Since we're recursing into make_request here, ensure
-		 * that we mark this bio as already having entered the queue.
-		 * If not, and the queue is going away, we can get stuck
-		 * forever on waiting for the queue reference to drop. But
-		 * that will never happen, as we're already holding a
-		 * reference to it.
-		 */
-		bio_set_flag(*bio, BIO_QUEUE_ENTERED);
-
 		bio_chain(split, *bio);
 		trace_block_split(q, split, (*bio)->bi_iter.bi_sector);
 		generic_make_request(*bio);
-- 
2.19.1

