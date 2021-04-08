Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2D6C433B4
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 19:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B403C610A8
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 19:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhDHToI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhDHToH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 15:44:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E4AC061760
        for <linux-block@vger.kernel.org>; Thu,  8 Apr 2021 12:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=wMZTzE4yYYfGghPCav3EXHbVROxh5waE4+e2TSPRsi4=; b=O6XSut7MPsS8mNxKZsD04uP1mS
        tmfIE6UXR4gJeqLP46dVSVMI9naUyJ+LIDsxLuzDK8HxvUZynrhRwXnyrDdp8d6+h8z60kYLMSUeU
        E6NoGptotOL5mioiPwIei8SVWBUIIpj07sWs/hbiJMG2CAkxZQrEno7z8NQH5HzrJrxcUpfvZ18N2
        B3ZCl56gYJAT2WdgF9voN+kOsBmJUmoCCqmMx9VxV8I6RdrLscCxrConaI7Zgtmi6h6+lOtZan4JK
        3jqMr41bT9RFBUpdeBgknTFFw3jitxvfe0mJxC9CQHXgKi0dUmYh2QZIcAEski9R/6wVkpC2dWAm+
        KTbLqwTQ==;
Received: from 213-225-2-171.nat.highway.a1.net ([213.225.2.171] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUaZF-0010lm-Qi; Thu, 08 Apr 2021 19:43:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] block: initialize ret in bdev_disk_changed
Date:   Thu,  8 Apr 2021 21:41:40 +0200
Message-Id: <20210408194140.1816537-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Avoid a potentially initialized variabe in the invalidate case.

Fixes: d3c4a43d9291 ("block: refactor blk_drop_partitions")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 594a1bee9dd9ac..363015fcffdbba 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1236,7 +1236,7 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 {
 	struct gendisk *disk = bdev->bd_disk;
-	int ret;
+	int ret = 0;
 
 	lockdep_assert_held(&bdev->bd_mutex);
 
-- 
2.30.1

