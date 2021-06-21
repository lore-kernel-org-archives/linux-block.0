Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00A4C49EA7
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 08:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75FDC610EA
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 08:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFUIEf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 04:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhFUIEe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 04:04:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90D0C061574;
        Mon, 21 Jun 2021 01:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=JtH+BJ83UKkZsmM2/s6DGMHrwGxZ9Os/k7xFLgZ7ELk=; b=We8PqCjjv3Yo+mSm+mnxkdSBGc
        JUfOpEJtP4XbbEWqDAQge8E/dVJqWaxld53jKJ65shwRsgn7RkTSQ4i23tFNowMxo8Iy3i+FWFD/6
        gtAuPhWGhi8jJcNLVZ0Ec1La7OU88sGpkzvTRXC7z1vAh/LrFFZjb7T3IZeTyV1JZtPevMUWI1w9m
        JzJZdBncNP+nyX8xj417jDn3HaintdGPjxx0GWVGGl38SbxtIfG4nNhMI2zzK4tC6pi2nu/4c2UQU
        se6hdutLhX5bzw/Ikh8uh9SXd07LfaCWYEvA7fRl+bJfuAvXSKmvqCWnjzyH6aAKU2IrtYwR2QilH
        IRjrpGXw==;
Received: from [2001:4bb8:188:3e21:8988:c934:59d4:cfe6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvEsL-00Crj9-NG; Mon, 21 Jun 2021 08:01:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] mmc: initialized disk->minors
Date:   Mon, 21 Jun 2021 10:01:44 +0200
Message-Id: <20210621080144.3655131-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix a let hunk from the blk_mq_alloc_disk conversion.

Fixes: 281ea6a5bfdc ("mmc: switch to blk_mq_alloc_disk")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mmc/core/block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index e7f89cbf9232..9890a1532cb0 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2331,6 +2331,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	md->queue.blkdata = md;
 
 	md->disk->major	= MMC_BLOCK_MAJOR;
+	md->disk->minors = perdev_minors;
 	md->disk->first_minor = devidx * perdev_minors;
 	md->disk->fops = &mmc_bdops;
 	md->disk->private_data = md;
-- 
2.30.2

