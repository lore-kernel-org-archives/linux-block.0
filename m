Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A0BC433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 10:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC1EE6101D
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 10:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbhJLKsx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 06:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbhJLKsw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 06:48:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B816C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 03:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=opPIlqg5Wfp6Q61GZbdfU3xCFt5dSsgckrhLVpNU78E=; b=e3UcRDGGqyxr9c/bThg+9JWqb4
        OTTuBMvZpZatrlhZDhePMoOYcA3Hkg73dViF0seFVkOujEfcKjBEzTkAyaBkR/A8D/zcLm69zqdeQ
        MYYZ+MgQ+NOKZ6t9JqK/HjLHvd6lchdmjcSWva34OUrr9APpsiEMbhvpvzGQQFcjSfuhtx3SJRCeT
        Jgq1VpAji5myHCesgGWzLVhV/9TcaVSY4nb3e3Po+i3+gTLsUcqEa+i/4l7SRAc59jUCj97Dk8Xen
        SK8BlxJ3GupdwZnvW54RyGMKg4R66Xx+eotFxr5Dlumf69jcOxX1xAHEkYYksiLgaff6myPpZAfQv
        JF7fyKyA==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maFID-006QZ2-6w; Tue, 12 Oct 2021 10:46:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/3] block: unexport blkdev_ioctl
Date:   Tue, 12 Oct 2021 12:44:48 +0200
Message-Id: <20211012104450.659013-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012104450.659013-1-hch@lst.de>
References: <20211012104450.659013-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the raw driver gone, there is no modular user left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/ioctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index eb0491e90b9a0..0f823444cc557 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -588,7 +588,6 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 		return -ENOTTY;
 	return bdev->bd_disk->fops->ioctl(bdev, mode, cmd, arg);
 }
-EXPORT_SYMBOL_GPL(blkdev_ioctl); /* for /dev/raw */
 
 #ifdef CONFIG_COMPAT
 
-- 
2.30.2

