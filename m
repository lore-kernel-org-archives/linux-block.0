Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716C9C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 578BF6135F
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhJTOnp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhJTOnp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 10:43:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E35C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=k+n1oiBU7KBgUgw2XiTLrMfZpONQgKvMBxKValR7KgQ=; b=KYn80AJPrJdq2lLc7M19NKRIaK
        fMyZq2RyvwVnl8gxHv22MTxpxN0s99EDf81VuSwRGoypEokombizsLHbrdDk3M2/c7kW8JS1pVFcF
        ZRZIvNn8a2P0aM9YFsiBlX0Wl64OPrbXu+qJcQZOtBw5c+lcHzyWMqXC4fN2pOS/13VHNAIW5i3sQ
        eiKIywDWWlYSV/BdU/XrFzu8+jG8irOrLfx624c3l1jTt7oorrdHo0JsH237JTL2qyvZDcGZDnxbj
        P2uIFROHAD0nHD/RWWgrQ/+9A/eK5s6YAvlil1a/7AUflsPVALJfBQ4ISYjeLl47zMUaeC/jr1SIE
        cH95HX9g==;
Received: from [2001:4bb8:180:8777:a130:d02a:a9b5:7d80] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdCmX-004oGJ-8d; Wed, 20 Oct 2021 14:41:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 2/4] blk-mq: move blk_mq_flush_plug_list to block/blk-mq.h
Date:   Wed, 20 Oct 2021 16:41:17 +0200
Message-Id: <20211020144119.142582-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211020144119.142582-1-hch@lst.de>
References: <20211020144119.142582-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This helper is internal to the block layer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.h         | 1 +
 include/linux/blk-mq.h | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index d8ccb341e82e9..08fb5922e611b 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -122,6 +122,7 @@ extern int blk_mq_sysfs_register(struct request_queue *q);
 extern void blk_mq_sysfs_unregister(struct request_queue *q);
 extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 void blk_mq_free_plug_rqs(struct blk_plug *plug);
+void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule);
 
 void blk_mq_release(struct request_queue *q);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 6cf35de151a95..e137802365509 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -656,8 +656,6 @@ int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
 		unsigned int set_flags);
 void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
 
-void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule);
-
 void blk_mq_free_request(struct request *rq);
 
 bool blk_mq_queue_inflight(struct request_queue *q);
-- 
2.30.2

