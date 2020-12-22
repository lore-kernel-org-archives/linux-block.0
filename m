Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4F5C433E0
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 13:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C7B23105
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 13:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbgLVNat (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Dec 2020 08:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgLVNat (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Dec 2020 08:30:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB771C0613D3
        for <linux-block@vger.kernel.org>; Tue, 22 Dec 2020 05:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=YCu4csy/mxer5fYnsax39tqEZZf/yXtZRuwE+1/5VOo=; b=s+pY5r+Ho0pqUaPw5+LkDMSIH9
        eL7pUPi7ffUrmPAnR5Wy5xhJ4QWhYx3Y3yS+5i5y4gz1pcdwN/hX8h71g4+BVj8Ml2xwlZQMLji+L
        nn+c+t3Dn1YkmAqjJbS+mn5drbN4Lzi3b1eZJeFQGAQUJMLwlS2W6QpIF7U47Ya5BV9xC00XijAzK
        9KQwwKg3lQLDKzECkKOSWs3EMu3kwM43mqUxTGJgujd+tSxgdMH8txfBLI5wiLffLetq2X/exlQUG
        1crN5rp6YSllDNQes0olIxyJ+Y0B9FUn5G7UxC3hogVIaXQblEtFCs8Uy+9c7W/P8KfR2bqaXvv2p
        /NbK1Gag==;
Received: from [2001:4bb8:180:8063:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krhjq-0001FK-Ro; Tue, 22 Dec 2020 13:30:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/2] block: fixup the kerneldoc for bd_abort_claiming
Date:   Tue, 22 Dec 2020 14:30:03 +0100
Message-Id: <20201222133004.3016790-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the documentation for a removed parameter.

Fixes: 37c3fc9abb25 ("block: simplify the block device claiming interface")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e56ee1f265230..7633e5ac0885f7 100644
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
-- 
2.29.2

