Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9C3C433FE
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 12:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB2C60F59
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 12:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhJIM2a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Oct 2021 08:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbhJIM23 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Oct 2021 08:28:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3A5C061762;
        Sat,  9 Oct 2021 05:26:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e12so38207168wra.4;
        Sat, 09 Oct 2021 05:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lOkOoGCR8g+RaYSCtRD/VjPKL2otHRzFfysHjyl+ocY=;
        b=FDp7XT6/26f/AYeKRd6/diB0FlzRUVDak/RHzV867K5Im1qGg8AVVM1lACJY/7acY6
         cld2zNvBL6Q5j9KAQAo5vJtAaM5rsEuIdw4iep+0xQ35Gi+kgdUjqoY5RuFRxBy/Tenf
         7GQXnNIkLlWiwp4Uqv+7Y5bgRwzCUo89YtHjwIkQM8M01poTmoBp6XvMRsP5mOw9M2O1
         9bBKBA+5nzrHc97Y8yJ990JU/AzVjoiTUyZa/WapXOuoVOLrewIFqyiD+3jelxFFzC4m
         4GWLnAtftAQmhWYL8PiddpB0Hc3pBDEsPXDXa+XELrU38YnNy7J0a/TNPAt9E6zXNVoy
         tdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lOkOoGCR8g+RaYSCtRD/VjPKL2otHRzFfysHjyl+ocY=;
        b=Fy7ZpkNFYC9I69R37NcRZnUir3lJyU4fTEaJM/onNRfs2ljq+hTdzBpxU3UEcZ+VbL
         h/NfxXzB/gjMxeW+JTc8qkKrMpLQ/F+D1GNRUPVvQfRO7IapaX9xAwGdjCndtj9y08VD
         LOY1z19DSvRhPYa+qqOIZFJShJBkus5mCN/xA1ncwhj4OQKN1jqrFwATH/yGKoyFichl
         iMU92oB+bWRUXBp+9oSqSFBB8khpnWpQN6FGp3lYYGhWIMSgxjqyQuvHv0zt147Diodx
         38nCYXyBG/rosRl6yFZsZpLp4CnaEN4ZhQ+afWuVtlK7ps9F1dirLhuAAHOYU3DorzaP
         4fLA==
X-Gm-Message-State: AOAM530vQAgmXiPb82EJYG2TF5x5rOytQRolXXmhXZKCT+CKgu5LFj6D
        STUXuRbnym1ciy1Zpt8jI42L/3IROBo=
X-Google-Smtp-Source: ABdhPJyO+HGYW7FAnINHgkVxQgTCzAdx/0I0dl+mhSzO3wVcTg2vIHhxSTwggKVzvJXElOxN/Wa6lQ==
X-Received: by 2002:adf:b185:: with SMTP id q5mr10853402wra.213.1633782391235;
        Sat, 09 Oct 2021 05:26:31 -0700 (PDT)
Received: from localhost.localdomain ([85.255.236.155])
        by smtp.gmail.com with ESMTPSA id o12sm2157468wrv.78.2021.10.09.05.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 05:26:30 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     asml.silence@gmail.com
Subject: [PATCH 2/6] block: inline BDEV_I and friends
Date:   Sat,  9 Oct 2021 13:25:39 +0100
Message-Id: <7c112aa98c9268d3d488cbee8b2832dc707812f6.1633781740.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633781740.git.asml.silence@gmail.com>
References: <cover.1633781740.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I_BDEV and BDEV_I are very simple, they worth a single arith instruction
or can even be almost completely compiled out. Inline them.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bdev.c           | 16 ----------------
 include/linux/blkdev.h | 16 +++++++++++++++-
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 567534c63f3d..a6cdfc49bc7e 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -30,22 +30,6 @@
 #include "../fs/internal.h"
 #include "blk.h"
 
-struct bdev_inode {
-	struct block_device bdev;
-	struct inode vfs_inode;
-};
-
-static inline struct bdev_inode *BDEV_I(struct inode *inode)
-{
-	return container_of(inode, struct bdev_inode, vfs_inode);
-}
-
-struct block_device *I_BDEV(struct inode *inode)
-{
-	return &BDEV_I(inode)->bdev;
-}
-EXPORT_SYMBOL(I_BDEV);
-
 static void bdev_write_inode(struct block_device *bdev)
 {
 	struct inode *inode = bdev->bd_inode;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4522acee81fb..591f14522f78 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1271,10 +1271,24 @@ void blkdev_put_no_open(struct block_device *bdev);
 
 struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
 void bdev_add(struct block_device *bdev, dev_t dev);
-struct block_device *I_BDEV(struct inode *inode);
 int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
 		loff_t lend);
 
+struct bdev_inode {
+	struct block_device bdev;
+	struct inode vfs_inode;
+};
+
+static inline struct bdev_inode *BDEV_I(struct inode *inode)
+{
+	return container_of(inode, struct bdev_inode, vfs_inode);
+}
+
+static inline struct block_device *I_BDEV(struct inode *inode)
+{
+	return &BDEV_I(inode)->bdev;
+}
+
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
 int sync_blockdev(struct block_device *bdev);
-- 
2.33.0

