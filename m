Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7FBC433DF
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 06:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A866207D4
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 06:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mCyOm5Dc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgERGkA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 02:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgERGkA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 02:40:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF71C061A0C
        for <linux-block@vger.kernel.org>; Sun, 17 May 2020 23:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=eEbc6GmBu6T9TFAOeYRcZBrEiZohTKZkLmwH8qooxv8=; b=mCyOm5DcSmukz70acweNT6iCYl
        IVNe84bx6lbCMHHvELeebRvMC19tZEA3KGrMr/5aSR/5bpDmGOF8MTvJu5Ed2UnMerFX+1YUkkaV9
        snVLXjqqW7Mx2r9UBkn9i+qtX1lYoDfTuhZtvpMEplBPb7Dk7vUMHhLERgD/X3KcMWsNIA//oJz/P
        2Kl2iuZPv60SLcG0fzI59SrgZ0lUoI/pWeD4Uzl3xJXNvOm3SySbtHA3k3toxCbsQFajBg3qAP368
        /nbHuyVkUiRcGukb9JyU3eTMKKR/9qlhL2RMcHrNuBLFBUdpVOKnrIXdeNREG05rO5s/Qxc+O4ge6
        L2xz8Lew==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaZRP-0001zU-Lv; Mon, 18 May 2020 06:40:00 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 7/9] blk-mq: disable preemption during allocating request tag
Date:   Mon, 18 May 2020 08:39:35 +0200
Message-Id: <20200518063937.757218-8-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518063937.757218-1-hch@lst.de>
References: <20200518063937.757218-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

Disable preempt for a little while during allocating request tag, so
request's tag(internal tag) is always allocated on the cpu of data->ctx,
prepare for improving to handle cpu hotplug during allocating request.

In the following patch, hctx->state will be checked to see if it becomes
inactive which is always set on the last CPU of hctx->cpumask.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
[hch: keep the preempt disable confined inside blk_mq_get_tag]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-tag.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index b526f1f5a3bf3..0cc38883618b9 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -108,6 +108,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	unsigned int tag_offset;
 	int tag;
 
+	preempt_disable();
 	data->ctx = blk_mq_get_ctx(data->q);
 	data->hctx = blk_mq_map_queue(data->q, data->cmd_flags, data->ctx);
 	tags = blk_mq_tags_from_data(data);
@@ -115,10 +116,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		blk_mq_tag_busy(data->hctx);
 
 	if (data->flags & BLK_MQ_REQ_RESERVED) {
-		if (unlikely(!tags->nr_reserved_tags)) {
-			WARN_ON_ONCE(1);
-			return BLK_MQ_TAG_FAIL;
-		}
+		if (WARN_ON_ONCE(!tags->nr_reserved_tags))
+			goto fail;
 		bt = &tags->breserved_tags;
 		tag_offset = 0;
 	} else {
@@ -131,7 +130,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		goto found_tag;
 
 	if (data->flags & BLK_MQ_REQ_NOWAIT)
-		return BLK_MQ_TAG_FAIL;
+		goto fail;
 
 	ws = bt_wait_ptr(bt, data->hctx);
 	do {
@@ -158,11 +157,13 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != -1)
 			break;
 
+		preempt_enable();
+
 		bt_prev = bt;
 		io_schedule();
-
 		sbitmap_finish_wait(bt, ws, &wait);
 
+		preempt_disable();
 		data->ctx = blk_mq_get_ctx(data->q);
 		data->hctx = blk_mq_map_queue(data->q, data->cmd_flags,
 						data->ctx);
@@ -186,7 +187,11 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	sbitmap_finish_wait(bt, ws, &wait);
 
 found_tag:
+	preempt_enable();
 	return tag + tag_offset;
+fail:
+	preempt_enable();
+	return BLK_MQ_TAG_FAIL;
 }
 
 bool __blk_mq_get_driver_tag(struct request *rq)
-- 
2.26.2

