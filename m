Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBA8C63777
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 08:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C180620C56
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 08:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgLCIeu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 03:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbgLCIeu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 03:34:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373A8C061A4F
        for <linux-block@vger.kernel.org>; Thu,  3 Dec 2020 00:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qvAOtP4i2xjTdP1JCqQlORCSEl7Zi1quIaWRUjaTDBg=; b=XuY172gPtzr7Fz46uw4ACL2b4c
        +Dta0WvPyQEuttgo2+Ha4kHCKOdn3Xnbg6hWoxqKAD9qh/bGgpG+Ph5bIb3gST8yz2XTzQWxo4FoH
        hG7Y6XHhrwptRttd8kcP9DMcxKevVIKZDIN8OeedZr8qbp0ncqAWo6vZ63kV4XxS1sU+77f4cedbx
        4wiTLxuQB0G72UG//ejFj8Li2ph9yt7CzqqnJ50EPTIsQkPy952sdzCM3DymgWdwnN8LWsovWUnOU
        t6mLuBypdZ3pTfexEFTEekaSMKUQh1oOpk/0fowS4fTiLLPMAfV7ZhjKaM2sE7VmX3EnABAT1V8V7
        R0afP5rQ==;
Received: from [2001:4bb8:184:6389:95c7:ad23:6ee2:3b91] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkk3y-0008I8-0c; Thu, 03 Dec 2020 08:34:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] block: fix two kerneldoc comment
Date:   Thu,  3 Dec 2020 09:34:05 +0100
Message-Id: <20201203083405.2097558-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix up two comments for the recent merge of hd_struct into
structc block_device.

Fixes: 37c3fc9abb25 ("block: simplify the block device claiming interface")
Fixes: 4e7b5671c6a8 ("block: remove i_bdev")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e56ee1f265230..9ab18364d96172 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1056,7 +1056,6 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder)
 /**
  * bd_abort_claiming - abort claiming of a block device
  * @bdev: block device of interest
- * @whole: whole block device
  * @holder: holder that has claimed @bdev
  *
  * Abort claiming of a block device when the exclusive open failed. This can be
@@ -1829,9 +1828,10 @@ const struct file_operations def_blk_fops = {
 /**
  * lookup_bdev  - lookup a struct block_device by name
  * @pathname:	special file representing the block device
+ * @dev:	returned device
  *
- * Get a reference to the blockdevice at @pathname in the current
- * namespace if possible and return it.  Return ERR_PTR(error)
+ * Look up the inode at @pathname, and if it is a block device node return the
+ * dev_t for it in @dev.  Returns 0 if successful, or a negative error code
  * otherwise.
  */
 int lookup_bdev(const char *pathname, dev_t *dev)
-- 
2.29.2

