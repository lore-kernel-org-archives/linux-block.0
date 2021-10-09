Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9D2C4167D
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 12:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E7E60F59
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 12:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244811AbhJIM2f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Oct 2021 08:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244802AbhJIM2d (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Oct 2021 08:28:33 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E21EC061764;
        Sat,  9 Oct 2021 05:26:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u18so38278300wrg.5;
        Sat, 09 Oct 2021 05:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f0JhrekTKY9vxYly7vj2LWwfA9ARSkjdGbzmdHw9WmY=;
        b=L1EMbvUqLZid8kfwv2zU/4SQiNs49xmit9AXaEtv1oLXKxy1Anf4+yUiXSxDcGlDxA
         zRaCfFr6biePLTycor4vApxY07CXxHK1L7CdVz+/cRfjcyVPQsCY6smJ1+nZkX1+IeF8
         gpZNiVGEl432OjRZcSg45MNQDuz1z19zbQCyntRKdf0rEacU+vckuxVCiT3kcpjse4hA
         TNqpAyXxPGB4qbLe0TABk+0VYudh6IwdJOk+/92krQ2i2sAf3PmStG/UEuDj8fgzI9FB
         +HM+pj0jqX8UaT0vuJi1srBbwbiUVbUlkYYXVQUHrsIS34YJPzhk7zOr01JUL33kYHEn
         HMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f0JhrekTKY9vxYly7vj2LWwfA9ARSkjdGbzmdHw9WmY=;
        b=F0If0ezmFcdPkz//+BZsPyo1ot6i5l51drkQFtaI58a3M3S+7aF/vcEftTHfJ97vX4
         rF9a3A42vceH6kDwvWTZ6FBxQzJZQezZYxrb0CblnXyBvTrspitP+ypaVFL1rhxdWe3X
         2nyfLY4Z7LYk/jGtWpqQhtQ0Oy6Mu0wEVfMQbEGGlkP6Py8baalh9JDYa9cRqI96bGv2
         uYK5v3bNoNOKumRM9zgawo7HOL/X3EE5EwTOl3oPKs2Yq5Y/MiWBsocJourEXZQ7TjJf
         zt+Pomi7BYFmPOJ4hZ1l29OIfzrwBhjmgWGQr1VS1DvPfKyDTUnBQsrmlnw1cyp8Tx+f
         Fjww==
X-Gm-Message-State: AOAM530IxKjsNOVBXvabU/nlshSzed8Vj3H5HEuZNbf/vQ8kcQIYc2cp
        yN62BITy9TeHMDpWmoaXzr8=
X-Google-Smtp-Source: ABdhPJz9Ha7rjVm1WKtlR2FyUUcbAmIXHm9H+DKclk9cd6VZk2xOznra66Hkuqt85ComN4d62H/1dw==
X-Received: by 2002:a1c:9dcb:: with SMTP id g194mr9579136wme.174.1633782394916;
        Sat, 09 Oct 2021 05:26:34 -0700 (PDT)
Received: from localhost.localdomain ([85.255.236.155])
        by smtp.gmail.com with ESMTPSA id o12sm2157468wrv.78.2021.10.09.05.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 05:26:34 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     asml.silence@gmail.com
Subject: [PATCH 6/6] block: convert ->bd_inode to container_of()
Date:   Sat,  9 Oct 2021 13:25:43 +0100
Message-Id: <41af3da80d59b705eb2260f7f469955ad68a96d2.1633781740.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633781740.git.asml.silence@gmail.com>
References: <cover.1633781740.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We don't need bdev->bd_inode as we know the layout, they are stored in
the same structure and so offset_of is enough. Convert extra
dereferencing to offseting starting from the block layer.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c           | 10 ++++++----
 include/linux/blkdev.h | 15 ++++++++++-----
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 99e699427f31..5438ed9cfcf7 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -17,14 +17,16 @@
 #include <linux/fs.h>
 #include "blk.h"
 
-static inline struct inode *bdev_file_inode(struct file *file)
+static inline struct block_device *blkdev_get_bdev(struct file *file)
 {
-	return file->f_mapping->host;
+	return file->private_data;
 }
 
-static inline struct block_device *blkdev_get_bdev(struct file *file)
+static inline struct inode *bdev_file_inode(struct file *file)
 {
-	return file->private_data;
+	struct block_device *bdev = blkdev_get_bdev(file);
+
+	return bdev_get_inode(bdev);
 }
 
 static int blkdev_get_block(struct inode *inode, sector_t iblock,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 591f14522f78..a56f3a852206 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1139,11 +1139,6 @@ static inline unsigned int blksize_bits(unsigned int size)
 	return bits;
 }
 
-static inline unsigned int block_size(struct block_device *bdev)
-{
-	return 1 << bdev->bd_inode->i_blkbits;
-}
-
 int kblockd_schedule_work(struct work_struct *work);
 int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
 
@@ -1289,6 +1284,16 @@ static inline struct block_device *I_BDEV(struct inode *inode)
 	return &BDEV_I(inode)->bdev;
 }
 
+static inline struct inode *bdev_get_inode(struct block_device *bdev)
+{
+	return &container_of(bdev, struct bdev_inode, bdev)->vfs_inode;
+}
+
+static inline unsigned int block_size(struct block_device *bdev)
+{
+	return 1 << bdev_get_inode(bdev)->i_blkbits;
+}
+
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
 int sync_blockdev(struct block_device *bdev);
-- 
2.33.0

