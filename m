Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62299C433DB
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 13:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323C223133
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 13:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgLVNbB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Dec 2020 08:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgLVNa7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Dec 2020 08:30:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E4EC0613D6
        for <linux-block@vger.kernel.org>; Tue, 22 Dec 2020 05:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gipqDoV/3w9NrVhIFxS/QtPwIzE4z//qItjhh69SQIA=; b=FPtr1etZ50O+gWzo0dwrISWt2X
        kOX6w61vYbcx0xBRQbJvifizwflC+lKWBqNAXToaB7kpx1Kix1fFlXVkScg5p9/wAojbafeu34Lyg
        s3VSSX5fmw2DgCBFPO5t+i93rRob9cErvFswz+3kyGlUoCbEFgxRCnc037H395U7W0gx8vy8mQ1OQ
        qhMOWh4jKudHDW2zJXNXFK/AHgeM4cZSv8n7B4PxjTfkoJzyatucNHov+Lhdqi/radI02v1lApkPI
        j1XCMe9/EUW7U8vsNgJFo/9J0EAriKz8ZAwwkMiGNEUDqBOJkV2pnjwE8+dZ9Xrudcsb8wunUME88
        dcv28Row==;
Received: from [2001:4bb8:180:8063:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krhjs-0001FO-06; Tue, 22 Dec 2020 13:30:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 2/2] block: fixup the kerneldoc for lookup_bdev
Date:   Tue, 22 Dec 2020 14:30:04 +0100
Message-Id: <20201222133004.3016790-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201222133004.3016790-1-hch@lst.de>
References: <20201222133004.3016790-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Document the new dev parameter and the changed return value convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 4e7b5671c6a8 ("block: remove i_bdev")
---
 fs/block_dev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7633e5ac0885f7..d6ee0bb7005538 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1828,10 +1828,11 @@ const struct file_operations def_blk_fops = {
 /**
  * lookup_bdev  - lookup a struct block_device by name
  * @pathname:	special file representing the block device
+ * @dev:	returns the dev_t for the device
  *
- * Get a reference to the blockdevice at @pathname in the current
- * namespace if possible and return it.  Return ERR_PTR(error)
- * otherwise.
+ * Find the dev_t for the block device at @pathname.  Returns 0 if there is a
+ * block device at @pathname, or a negative errno value if not.  The dev_t for
+ * the block device is placed in the variable pointed to by the @dev parameter.
  */
 int lookup_bdev(const char *pathname, dev_t *dev)
 {
-- 
2.29.2

