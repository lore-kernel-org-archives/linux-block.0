Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE849C5518A
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 07:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBBCA2076A
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 07:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H6INQmab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgDVHjY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726528AbgDVHjU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 03:39:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B905CC03C1A6;
        Wed, 22 Apr 2020 00:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wnRfqx1VoCTyZu/k8lNZZmFfqSwOg7HpqVhS1+x+fA4=; b=H6INQmabbIGiZI854RTp/0wiTT
        6SxoKlEodn2N/yYVxRSCNXHcHdvu2Roxo+u7FgvoS9Sbeer+gOBTfkfKhwwEAwp+SI9dyj0X9HeGE
        tJ+GtuArLi9b39lUyOiF+SBTlSdUeOrQ6H1knPi01zC3xf+1s/sKqLCZrXpuYPxRtYn44qHWIy6LM
        zaIXdzeL7JHt4BOv55LaNuYJauKSJy1/HrvCMFyA95D5tD+yjPBwKZFlA2RsJe6itDqBwva0wGh6d
        aG6lTZl94iFc+qrDXny9KAJT8yrNxu9G+DnQKK0WGyTEUE1GZzZIMJtNBUJZCI9EE98BLu6tWF12k
        /eMMR7Vg==;
Received: from [2001:4bb8:191:e12c:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR9yV-0000Dr-AH; Wed, 22 Apr 2020 07:39:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] bdi: remove the name field in struct backing_dev_info
Date:   Wed, 22 Apr 2020 09:38:51 +0200
Message-Id: <20200422073851.303714-10-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200422073851.303714-1-hch@lst.de>
References: <20200422073851.303714-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The name is only printed for a not registered bdi in writeback.  Use the
device name there as is more useful anyway for the unlike case that the
warning triggers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-core.c                 | 1 -
 drivers/mtd/mtdcore.c            | 1 -
 fs/fs-writeback.c                | 2 +-
 fs/super.c                       | 2 --
 include/linux/backing-dev-defs.h | 2 --
 mm/backing-dev.c                 | 1 -
 6 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ab87f2833ab2..f37068c611bf 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -494,7 +494,6 @@ struct request_queue *__blk_alloc_queue(int node_id)
 
 	q->backing_dev_info->ra_pages = VM_READAHEAD_PAGES;
 	q->backing_dev_info->capabilities = BDI_CAP_CGROUP_WRITEBACK;
-	q->backing_dev_info->name = "block";
 	q->node = node_id;
 
 	timer_setup(&q->backing_dev_info->laptop_mode_wb_timer,
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 39ec563d9a14..fcb018ce17c3 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -2040,7 +2040,6 @@ static struct backing_dev_info * __init mtd_bdi_init(char *name)
 	if (!bdi)
 		return ERR_PTR(-ENOMEM);
 
-	bdi->name = name;
 	/*
 	 * We put '-0' suffix to the name to get the same name format as we
 	 * used to get. Since this is called only once, we get a unique name. 
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 76ac9c7d32ec..d85323607b49 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2320,7 +2320,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 
 			WARN(bdi_cap_writeback_dirty(wb->bdi) &&
 			     !test_bit(WB_registered, &wb->state),
-			     "bdi-%s not registered\n", wb->bdi->name);
+			     "bdi-%s not registered\n", bdi_dev_name(wb->bdi));
 
 			inode->dirtied_when = jiffies;
 			if (dirtytime)
diff --git a/fs/super.c b/fs/super.c
index dd28fcd706ff..4991f441988e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1602,8 +1602,6 @@ int super_setup_bdi_name(struct super_block *sb, char *fmt, ...)
 	if (!bdi)
 		return -ENOMEM;
 
-	bdi->name = sb->s_type->name;
-
 	va_start(args, fmt);
 	err = bdi_register_va(bdi, fmt, args);
 	va_end(args);
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 2849bdbb3acb..011bb8ad0738 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -194,8 +194,6 @@ struct backing_dev_info {
 	congested_fn *congested_fn; /* Function pointer if device is md/dm */
 	void *congested_data;	/* Pointer to aux data for congested func */
 
-	const char *name;
-
 	struct kref refcnt;	/* Reference counter for the structure */
 	unsigned int capabilities; /* Device capabilities */
 	unsigned int min_ratio;
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 1f55d5b8269f..d382272bcc31 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -15,7 +15,6 @@
 #include <trace/events/writeback.h>
 
 struct backing_dev_info noop_backing_dev_info = {
-	.name		= "noop",
 	.capabilities	= BDI_CAP_NO_ACCT_AND_WRITEBACK,
 };
 EXPORT_SYMBOL_GPL(noop_backing_dev_info);
-- 
2.26.1

