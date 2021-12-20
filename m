Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D86C433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Dec 2021 20:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhLTUyQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Dec 2021 15:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLTUyQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 15:54:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BD7C061574
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 12:54:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2970612F5
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 20:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61DBC36AE2;
        Mon, 20 Dec 2021 20:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640033654;
        bh=i6SMjylMgnOtdZjNc5cfxz6pXieJkwDgmjP1VG4FmLI=;
        h=From:To:Cc:Subject:Date:From;
        b=XoWq/EUIg9VCNdbBwaUBthccT3wiiBjqhvIpr760ERZQdENlU89GhLlMOWgNEbWsa
         6mtJP3Znjw2lXOP2iZKYYPNY2bIvbFJKHQFAIOi11gKkh8z0ggvU3au6EpsM5+u4xe
         l4+g3im22fW5AZtXFmWiAwpwqY+wfBtFLd6HnO2BA43mAZVB0eJyQYKcEw0xBRuGwl
         cNbbDD77NVTnz0j8vQrbbsr9VPryp7lYct6tF0zV5cGR+nRBBPGceIMuLRXpLEGObn
         ekgcmgWkm32kMpqEkA468KaUBtgmFp47K+2Tm9iX48VtuTa8sVOd00o92Rb/UiKpvR
         l3VBjV9nalP4w==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     Keith Busch <kbusch@kernel.org>
Subject: [PATCH] blk-mq: check quiesce state before queue_rqs
Date:   Mon, 20 Dec 2021 12:54:12 -0800
Message-Id: <20211220205412.151342-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The low level drivers don't expect to see new requests after a
successful quiesce completes. Check the queue quiesce state within the
rcu protected area prior to calling the driver's queue_rqs().

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 51991232824a..c8a30017c778 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2549,6 +2549,13 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 		blk_mq_commit_rqs(hctx, &queued, from_schedule);
 }
 
+void __blk_mq_flush_plug_list(struct request_queue *q, struct blk_plug *plug)
+{
+	if (blk_queue_quiesced(q))
+		return;
+	q->mq_ops->queue_rqs(&plug->mq_list);
+}
+
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	struct blk_mq_hw_ctx *this_hctx;
@@ -2580,7 +2587,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		if (q->mq_ops->queue_rqs &&
 		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
 			blk_mq_run_dispatch_ops(q,
-				q->mq_ops->queue_rqs(&plug->mq_list));
+				__blk_mq_flush_plug_list(q, plug));
 			if (rq_list_empty(plug->mq_list))
 				return;
 		}
-- 
2.25.4

