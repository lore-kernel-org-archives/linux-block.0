Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4804C433B4
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 16:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2D06144D
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 16:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243936AbhDUQFk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 12:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbhDUQFk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 12:05:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A30C06174A
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 09:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=htUpHJwJqX+Z9jK5xH9qtxTOtPB/kKgeHlpEOwU21qE=; b=DI6FrRGvuNmsbUcHgh31OtAItk
        tYgtHAU/SIpCs3DDfaxf+Bg3/Umln1tjtb/sHuaxcLOocfRhmBUjs9rhapsLg0U4aLfbYxuRsyLCN
        vXKIEppljNoeOeLXfQnmuLa9LPlOBMYKnDnfcNLCnQ9rpaSuL5L4/w+gg1hJCkNb4wpQ4VmGlwzyN
        siltum74ciG3Bo0Iz5jy68YZBR6RouvIC8WDuXAMvF/Am+gxIeeoKN1H0IsQhRgRnoKTyAcDe6lRj
        5Au0RsY81DxWmVaVu+tHBv0KUnx80i5sUwkRmfNfy2JLzJl0XAI9m1/22mCMpAMC/O9ZHVp6os7W1
        WBjwc6nA==;
Received: from [2001:4bb8:19b:f845:3a02:1dd5:15f8:f374] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZFLe-00D143-7q; Wed, 21 Apr 2021 16:05:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: [PATCH] block: return -EBUSY when there are open partitions in blkdev_reread_part
Date:   Wed, 21 Apr 2021 18:05:02 +0200
Message-Id: <20210421160502.447418-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The switch to go through blkdev_get_by_dev means we now ignore the
return value from bdev_disk_changed in __blkdev_get.  Add a manual
check to restore the old semantics.

Fixes: 4601b4b130de ("block: reopen the device in blkdev_reread_part")
Reported-by: Karel Zak <kzak@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index ff241e663c018f..8ba1ed8defd0bb 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -89,6 +89,8 @@ static int blkdev_reread_part(struct block_device *bdev, fmode_t mode)
 		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
+	if (bdev->bd_part_count)
+		return -EBUSY;
 
 	/*
 	 * Reopen the device to revalidate the driver state and force a
-- 
2.30.1

