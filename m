Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4E9C47258
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 12:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660C82071C
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 12:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GQHvYYB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgEDM53 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 08:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729159AbgEDM5Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 08:57:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CEDC061A0F;
        Mon,  4 May 2020 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Autalor2HnaVg7sTrMY+BkN6sE+InpNYUQGKGb8+cg8=; b=GQHvYYB8L5B0TijA/sRUg9JqrN
        4DhgWlgaPbV16881PP9WGxeTyRrmh2I/a7jcQ89JLaaCCxHIUaggYS4FhoMBtTYROe4VIFQxLn/yP
        4EobLerhlPjtUH5fjSQvJdfO0h2s7BO5B2x7hBGxf0CFeRhwyziKfozJMa0+yRk3wQZqvvL1GPy4/
        rk9T3f4+MkIaRgIt+TgICzH/d1OGS92x6YwSiOtbEmZRGWIYBgG36tyT3idwq5Xl0WKKP7ddZw12X
        5l1FH2RjBDFEYDVH1Kr4itdv03Iwy36vcZ988mRreRBtL2PlgYau4veon+pLJncpDQsIFx/rvh4sw
        MRa8Buiw==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVaeh-0007h8-5A; Mon, 04 May 2020 12:57:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] bdi: simplify bdi_alloc
Date:   Mon,  4 May 2020 14:48:00 +0200
Message-Id: <20200504124801.2832087-9-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504124801.2832087-1-hch@lst.de>
References: <20200504124801.2832087-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Merge the _node vs normal version and drop the superflous gfp_t argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c            | 2 +-
 drivers/mtd/mtdcore.c       | 2 +-
 fs/super.c                  | 2 +-
 include/linux/backing-dev.h | 6 +-----
 mm/backing-dev.c            | 7 +++----
 5 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7f11560bfddbb..285a2f8ee8d3a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -501,7 +501,7 @@ struct request_queue *__blk_alloc_queue(int node_id)
 	if (ret)
 		goto fail_id;
 
-	q->backing_dev_info = bdi_alloc_node(GFP_KERNEL, node_id);
+	q->backing_dev_info = bdi_alloc(node_id);
 	if (!q->backing_dev_info)
 		goto fail_split;
 
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 2916674208b32..39ec563d9a14b 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -2036,7 +2036,7 @@ static struct backing_dev_info * __init mtd_bdi_init(char *name)
 	struct backing_dev_info *bdi;
 	int ret;
 
-	bdi = bdi_alloc(GFP_KERNEL);
+	bdi = bdi_alloc(NUMA_NO_NODE);
 	if (!bdi)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/super.c b/fs/super.c
index cd352530eca90..dd28fcd706ff5 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1598,7 +1598,7 @@ int super_setup_bdi_name(struct super_block *sb, char *fmt, ...)
 	int err;
 	va_list args;
 
-	bdi = bdi_alloc(GFP_KERNEL);
+	bdi = bdi_alloc(NUMA_NO_NODE);
 	if (!bdi)
 		return -ENOMEM;
 
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 4098ed6ba6b43..6b3504bf7a42b 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -36,11 +36,7 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt,
 void bdi_set_owner(struct backing_dev_info *bdi, struct device *owner);
 void bdi_unregister(struct backing_dev_info *bdi);
 
-struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id);
-static inline struct backing_dev_info *bdi_alloc(gfp_t gfp_mask)
-{
-	return bdi_alloc_node(gfp_mask, NUMA_NO_NODE);
-}
+struct backing_dev_info *bdi_alloc(int node_id);
 
 void wb_start_background_writeback(struct bdi_writeback *wb);
 void wb_workfn(struct work_struct *work);
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index bb993f99d4244..1f55d5b8269ff 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -865,12 +865,11 @@ static int bdi_init(struct backing_dev_info *bdi)
 	return ret;
 }
 
-struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id)
+struct backing_dev_info *bdi_alloc(int node_id)
 {
 	struct backing_dev_info *bdi;
 
-	bdi = kmalloc_node(sizeof(struct backing_dev_info),
-			   gfp_mask | __GFP_ZERO, node_id);
+	bdi = kzalloc_node(sizeof(*bdi), GFP_KERNEL, node_id);
 	if (!bdi)
 		return NULL;
 
@@ -880,7 +879,7 @@ struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id)
 	}
 	return bdi;
 }
-EXPORT_SYMBOL(bdi_alloc_node);
+EXPORT_SYMBOL(bdi_alloc);
 
 static struct rb_node **bdi_lookup_rb_node(u64 id, struct rb_node **parentp)
 {
-- 
2.26.2

