Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9035C61DD8
	for <linux-block@archiver.kernel.org>; Sat, 14 Nov 2020 17:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB3F20B80
	for <linux-block@archiver.kernel.org>; Sat, 14 Nov 2020 17:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MlQ1Q9JT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgKNRI1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Nov 2020 12:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgKNRI1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Nov 2020 12:08:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D19C0613D1
        for <linux-block@vger.kernel.org>; Sat, 14 Nov 2020 09:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2tS1FftECAqopTDwTRaknsDFob2jwJYzXh8NLEkdKio=; b=MlQ1Q9JT3MvM9b0AuiyAorpGiE
        /yhLisDEUZgRYYAUlv2cCckqF6m8w9YvTQuO4ENQJar4W/QiqlmP+a5PSMvn+bKT33Z+EX5mtxbHJ
        cH2xzad4+Q9xl2UyU3VV9ND2W6WOH7X83ILNZ/cV8PzPuIfm9kYgXGvoaWSXuiSP1JWh8HXr5zg8o
        ZMYv3J0GyUWJiQJX1W0tpzPB23fTfGU3qSs8Hxxjb9oixaxBgbQYk921OTFcXCJ14BJLFIqzpbbVl
        0IYCvkbGk1ghGlgEVBhrX+Pf5Bp221KBgB6STZlOv+b6se6JNUWjbIccj/nZi40L81oE1vmejTiDt
        uw8gk5Yg==;
Received: from [2001:4bb8:180:6600:c0c4:d8af:ec59:797] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdz2F-0006eb-H7; Sat, 14 Nov 2020 17:08:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] block: fix the kerneldoc comment for __register_blkdev
Date:   Sat, 14 Nov 2020 18:08:21 +0100
Message-Id: <20201114170821.4714-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Switch the comment to talk about __register_blkdev instead of
register_blkdev and document the new probe parameter.

Fixes: 3da1a61e7046 ("block: add an optional probe callback to major_names")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 15b90e56a1a6ea..e7b7cae30f7f85 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -415,11 +415,12 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
 #endif /* CONFIG_PROC_FS */
 
 /**
- * register_blkdev - register a new block device
+ * __register_blkdev - register a new block device
  *
  * @major: the requested major device number [1..BLKDEV_MAJOR_MAX-1]. If
  *         @major = 0, try to allocate any unused major number.
  * @name: the name of the new block device as a zero terminated string
+ * @probe: allback that is called on access to any minor number of @major
  *
  * The @name must be unique within the system.
  *
@@ -433,6 +434,8 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
  *
  * See Documentation/admin-guide/devices.txt for the list of allocated
  * major numbers.
+ *
+ * Use register_blkdev instead for any new code.
  */
 int __register_blkdev(unsigned int major, const char *name,
 		void (*probe)(dev_t devt))
-- 
2.28.0

