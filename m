Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ACCC433F5
	for <linux-block@archiver.kernel.org>; Tue, 17 May 2022 22:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiEQWzZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 May 2022 18:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiEQWzZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 May 2022 18:55:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0154F46A
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 15:55:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCC0A61389
        for <linux-block@vger.kernel.org>; Tue, 17 May 2022 22:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ADCC385B8;
        Tue, 17 May 2022 22:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652828123;
        bh=IjhLch1Kk3hCKO0qp6OQnXnIm9Orr1T8BKONZMzVIsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPZHmCE93QGa74snM7VjHIds4VZ5mBlb2/2tIuAPrrAEhhMoOtsRFP9oD3xFdStvi
         OlRgaFYAALfhzWRqUEjFe4BNuDA00eDW5J/WxxJWuxCfYREMwfUodHr3+rue8B5+Bl
         Xxjl7Zk85C/QoXsLdhKM+2FMXEOOgAveSX+TROS5nSFxMdBRJwRh62xM1mF12jzDdw
         nolmzl/9lMJjhzvTMO9LDQY7gKI+K89plUKn6MrFcI2cq3EaK4YtNl+gK8mN+zIRSe
         LI9eZQxpbRTTnQVdomP9wSvqGfO6SZu+HvTCf9FrWje8MbSKdpqzWQ2/tdJBAmTTcS
         pyjWsm13KsH9g==
Date:   Tue, 17 May 2022 16:55:20 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 1/3] block: export dma_alignment attribute
Message-ID: <YoQn2KkI/nwnUmIG@kbusch-mbp.dhcp.thefacebook.com>
References: <20220513161339.1580042-1-kbusch@fb.com>
 <YoH0vuUA4KdcpEAz@infradead.org>
 <YoJgdrMpIiobiDy3@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoJgdrMpIiobiDy3@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 16, 2022 at 08:32:22AM -0600, Keith Busch wrote:
>  
> > The XFS_IOC_DIOINFO ioctl from xfs is one, although ugly, option.
> > The other is to export the alignment requirements through statx.
> > We had that whole discussion with the inline crypto direct I/O support,
> > and we really need to tackle it rather sooner than later.
> 
> I'll try out assigning one of the spares in 'struct statx' for the purpose. I
> like the interface for that, and looks easy enough to pass along the dma
> alignment requirement through it.

A little less easy than I thought... This is what I'm coming up with, and it's
bad enough that I'm sure there has to be a better way. Specifically concerning
is the new "do_dma()" function below, and was the only way I managed to get the
correct 'struct block_device' whether we're stat'ing a filesystem file or raw
block device file.

---
diff --git a/fs/stat.c b/fs/stat.c
index 5c2c94464e8b..72c0b36599c2 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -17,6 +17,7 @@
 #include <linux/syscalls.h>
 #include <linux/pagemap.h>
 #include <linux/compat.h>
+#include <linux/blkdev.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -594,6 +595,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_uid = from_kuid_munged(current_user_ns(), stat->uid);
 	tmp.stx_gid = from_kgid_munged(current_user_ns(), stat->gid);
 	tmp.stx_mode = stat->mode;
+	tmp.stx_dma = stat->dma;
 	tmp.stx_ino = stat->ino;
 	tmp.stx_size = stat->size;
 	tmp.stx_blocks = stat->blocks;
@@ -615,6 +617,35 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
 
+static void do_dma(int dfd, struct filename *filename, struct kstat *stat)
+{
+	struct open_flags op = {};
+	struct block_device *bdev;
+	struct file *f;
+
+	stat->dma = 511;
+
+	if (S_ISBLK(stat->mode)) {
+		bdev = blkdev_get_no_open(stat->rdev);
+
+		if (bdev) {
+			stat->dma = bdev_dma_alignment(bdev);
+			blkdev_put_no_open(bdev);
+		}
+		return;
+	}
+
+	f = do_filp_open(dfd, filename, &op);
+	if (IS_ERR(f))
+		return;
+
+	bdev = f->f_inode->i_sb->s_bdev;
+	if (bdev)
+		stat->dma = bdev_dma_alignment(bdev);
+	fput(f);
+}
+
 int do_statx(int dfd, struct filename *filename, unsigned int flags,
 	     unsigned int mask, struct statx __user *buffer)
 {
@@ -630,6 +661,7 @@ int do_statx(int dfd, struct filename *filename, unsigned int flags,
 	if (error)
 		return error;
 
+	do_dma(dfd, filename, &stat);
 	return cp_statx(&stat, buffer);
 }
 
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 7df06931f25d..0a12c7498aa0 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -50,6 +50,7 @@ struct kstat {
 	struct timespec64 btime;			/* File creation time */
 	u64		blocks;
 	u64		mnt_id;
+	u16		dma;
 };
 
 #endif
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 1500a0f58041..380820c29c35 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -106,7 +106,7 @@ struct statx {
 	__u32	stx_uid;	/* User ID of owner */
 	__u32	stx_gid;	/* Group ID of owner */
 	__u16	stx_mode;	/* File mode */
-	__u16	__spare0[1];
+	__u16	stx_dma;	/* DMA alignment */
 	/* 0x20 */
 	__u64	stx_ino;	/* Inode number */
 	__u64	stx_size;	/* File size */
--
