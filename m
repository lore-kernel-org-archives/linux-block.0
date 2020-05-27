Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9697C433E3
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C718F2084C
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WsmsmBgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389091AbgE0SG6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 14:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388952AbgE0SG5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:06:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93FAC03E97D
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 11:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RmFXUDABrtnvbESD6brVVX5e4mRXVISKjd3BoEdyD88=; b=WsmsmBghJbRJmes6YYM2dZGMk3
        wv4AGZiUWggygBHTvKLVO9Sd8QhWorE5MZL1/2XfI1ISDDjEY/FDRGVtAwzLbrfbi0KEjxO1mFYfI
        R5ONTMGBZXGmXdXVwi2B0Fv/940VENH9JB3DcF4t4XftGbMH2E/aU6j883MUtTxrgcgFT1noGlg8K
        i6KsLHDSo8fGfo9u2494udrW8ABhj/zf49g4lBx8nBuJZLUhB0J55F9qpIoDwJG+lZYQths8tEbNY
        fy5IgathCJW0/5/8CjtXY5BcyH1zliTC0if8bheH86+oteNoKrwOt5/J78r1bt0ciTcdtI9V7CbKc
        XFkgCvmQ==;
Received: from p4fdb0aaa.dip0.t-ipconnect.de ([79.219.10.170] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1je0S9-00050n-DC; Wed, 27 May 2020 18:06:57 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4/8] blk-mq: rename BLK_MQ_TAG_FAIL to BLK_MQ_NO_TAG
Date:   Wed, 27 May 2020 20:06:40 +0200
Message-Id: <20200527180644.514302-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527180644.514302-1-hch@lst.de>
References: <20200527180644.514302-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To prepare for wider use of this constant give it a more applicable name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-tag.c | 4 ++--
 block/blk-mq-tag.h | 4 ++--
 block/blk-mq.c     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 586c9d6e904ab..c76ba4f90fa09 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -111,7 +111,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	if (data->flags & BLK_MQ_REQ_RESERVED) {
 		if (unlikely(!tags->nr_reserved_tags)) {
 			WARN_ON_ONCE(1);
-			return BLK_MQ_TAG_FAIL;
+			return BLK_MQ_NO_TAG;
 		}
 		bt = &tags->breserved_tags;
 		tag_offset = 0;
@@ -125,7 +125,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		goto found_tag;
 
 	if (data->flags & BLK_MQ_REQ_NOWAIT)
-		return BLK_MQ_TAG_FAIL;
+		return BLK_MQ_NO_TAG;
 
 	ws = bt_wait_ptr(bt, data->hctx);
 	do {
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 2b8321efb6820..8a741752af8b9 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -44,9 +44,9 @@ static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 }
 
 enum {
-	BLK_MQ_TAG_FAIL		= -1U,
+	BLK_MQ_NO_TAG		= -1U,
 	BLK_MQ_TAG_MIN		= 1,
-	BLK_MQ_TAG_MAX		= BLK_MQ_TAG_FAIL - 1,
+	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
 };
 
 extern bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1ffbc5d9e7cfe..826ff8f97489c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -386,7 +386,7 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 	}
 
 	tag = blk_mq_get_tag(data);
-	if (tag == BLK_MQ_TAG_FAIL) {
+	if (tag == BLK_MQ_NO_TAG) {
 		if (clear_ctx_on_error)
 			data->ctx = NULL;
 		return NULL;
-- 
2.26.2

