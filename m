Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BDDC2BA1A
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 10:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB2D620776
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 10:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r1rCJz3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgDXK4m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXK4l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 06:56:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499B3C09B045
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2020 03:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=MjVANjHcG+dtZ91vYlZSlIYd7LxTWV/bKKHSFTYah+k=; b=r1rCJz3NdSCP4mQH+ZZ/vmNQ/l
        Ij6joV/tWdOunU8avWl6qN6qH+RAiSovMUc4Wk/DqCBrEogfHqCZ8//Pg2dKRDlnUov/LBi3r/rQc
        VlP7AuAm+W6ICFnZ4Xeusedq30zjUlgTHwbD0Wlq4rvL5uxhcX4RaMS0e545Lm06tl9cU5k0bXlGh
        gg6MwCZdCfvkdNXGxjkLyardAgnS7NTJezlJAVCSWn8IfStmyZDfubbmaUM2V6WBLpuGf/oi/MJl1
        FpfJ8S7WRCtjzJQq0P48fEGpWculuS/YA/EgwT/mG61nb0HDw48bocrdAPEtpiP+36SMq+S960CPQ
        3f06dLRA==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRw0b-0002qK-3w; Fri, 24 Apr 2020 10:56:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: unexport bdev_read_page and bdev_write_page
Date:   Fri, 24 Apr 2020 12:56:34 +0200
Message-Id: <20200424105634.570597-1-hch@lst.de>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Each one just has two calles, both in always built-in code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 998820174d3ed..5eb30a474f6d1 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -714,7 +714,6 @@ int bdev_read_page(struct block_device *bdev, sector_t sector,
 	blk_queue_exit(bdev->bd_queue);
 	return result;
 }
-EXPORT_SYMBOL_GPL(bdev_read_page);
 
 /**
  * bdev_write_page() - Start writing a page to a block device
@@ -759,7 +758,6 @@ int bdev_write_page(struct block_device *bdev, sector_t sector,
 	blk_queue_exit(bdev->bd_queue);
 	return result;
 }
-EXPORT_SYMBOL_GPL(bdev_write_page);
 
 /*
  * pseudo-fs
-- 
2.26.1

