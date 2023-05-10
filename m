Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC76C77B7D
	for <linux-block@archiver.kernel.org>; Wed, 10 May 2023 07:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbjEJHmj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 May 2023 03:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbjEJHmi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 May 2023 03:42:38 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DB430DD
        for <linux-block@vger.kernel.org>; Wed, 10 May 2023 00:42:36 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f42d937d2eso8046565e9.2
        for <linux-block@vger.kernel.org>; Wed, 10 May 2023 00:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683704555; x=1686296555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7jBo/0gaqOcpWDn9v+f25CR/FvK3dzqVxHQDA11D/+A=;
        b=ck17UrgCHcvsEeF7v2HDWMksbJ4b5Z3kbk9Z/GvhbVQUwsv9NGdNo+1Btunoalycth
         A0MYshPsLsdc0vdvmdJFr/E4MzNTgae2WinZwlz10VG5fT/6WQZqoyzNWgOj4i/SH32H
         v57jywQfNVNpwAMLfdxjNn9XXT6eQ0OX/FFEzwJ5f8Py+tLFWmsbKb9ttG2/+Fke94tl
         JD/qBO5qpUFZxyuxyJUjaRNelqvpzhhTMZ+ZVa5+e3/PVvlAytq04ATgC08aFl40d7wm
         iNm6Fg10vQvY5wctGpSbUA30hVzLAoxtI+6w/9ZLgUStU+rnr34UyAe6CTk/g5WJ9f4f
         xxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683704555; x=1686296555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jBo/0gaqOcpWDn9v+f25CR/FvK3dzqVxHQDA11D/+A=;
        b=BR1J9MbYkiqV4DLTgnvQ6RLq0jsNevKFDkVC/Xh7GFbYPpUB9NnUSsauYsIwnBvSgm
         5391HTlb7j/FmhECugJxwbjgKsL0ei5qZy1UMbKlRzeuF3XCQ9Qr/XI5pyYROVJekTyt
         nicRK1PaMrQlC+Nhi2LD/ptv8EvvRhtzqRBg6RfkRLa/jDhP1gPd0UUPjoXYFka4QwLz
         cHsgnyD/btmf/ArnJoff9/2XB9mESVQbPS6jU7duNI82Ayw863q7HaHhWM2panQXTI2K
         aEUwIzGHrplTG5fc4j0lmWx0qT2w+0p67fMn92wtQ/yS+T+DCGNNmGzKsj4rBcI7PF+o
         cEEw==
X-Gm-Message-State: AC+VfDz8tOX69fhuIcLvw6l1jGZeQ4FrL81U/z1zLsMZWtXo2p5V85Gp
        sOZfDRBlFo6WtHBm1G+reL6v2irK/dvxNmqdi+Ebzw==
X-Google-Smtp-Source: ACHHUZ5KXZLxkupb7Woo0uDJlVcJPoJ8THFYvgVyj56TSq4effvtNlIl5JLyozmztq2xypAhmrTFUQ==
X-Received: by 2002:a5d:5003:0:b0:306:37d9:201c with SMTP id e3-20020a5d5003000000b0030637d9201cmr11124020wrt.17.1683704554944;
        Wed, 10 May 2023 00:42:34 -0700 (PDT)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:28c8:5790:aa30:6a9d])
        by smtp.gmail.com with ESMTPSA id f5-20020adff985000000b002fda1b12a0bsm16680692wrr.2.2023.05.10.00.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 00:42:34 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] block: Deny writable memory mapping if block is read-only
Date:   Wed, 10 May 2023 09:42:23 +0200
Message-Id: <20230510074223.991297-1-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

User should not be able to write block device if it is read-only at
block level (e.g force_ro attribute). This is ensured in the regular
fops write operation (blkdev_write_iter) but not when writing via
user mapping (mmap), allowing user to actually write a read-only
block device via a PROT_WRITE mapping.

Example: This can lead to integrity issue of eMMC boot partition
(e.g mmcblk0boot0) which is read-only by default.

To fix this issue, simply deny shared writable mapping if the block
is readonly.

Note: Block remains writable if switch to read-only is performed
after the initial mapping, but this is expected behavior according
to commit a32e236eb93e ("Partially revert "block: fail op_is_write()
requests to read-only partitions"")'.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 block/fops.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index d2e6be4e3d1c..58d0aebc7313 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -678,6 +678,16 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	return error;
 }
 
+static int blkdev_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct inode *bd_inode = bdev_file_inode(file);
+
+	if (bdev_read_only(I_BDEV(bd_inode)))
+		return generic_file_readonly_mmap(file, vma);
+
+	return generic_file_mmap(file, vma);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_close,
@@ -685,7 +695,7 @@ const struct file_operations def_blk_fops = {
 	.read_iter	= blkdev_read_iter,
 	.write_iter	= blkdev_write_iter,
 	.iopoll		= iocb_bio_iopoll,
-	.mmap		= generic_file_mmap,
+	.mmap		= blkdev_mmap,
 	.fsync		= blkdev_fsync,
 	.unlocked_ioctl	= blkdev_ioctl,
 #ifdef CONFIG_COMPAT
-- 
2.34.1

