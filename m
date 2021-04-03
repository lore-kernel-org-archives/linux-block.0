Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03100C433ED
	for <linux-block@archiver.kernel.org>; Sat,  3 Apr 2021 09:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C26DF61210
	for <linux-block@archiver.kernel.org>; Sat,  3 Apr 2021 09:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhDCJFF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Apr 2021 05:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236440AbhDCJFF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 3 Apr 2021 05:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617440702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GHdvJGYwSTRvs/+kkZxZ2UvghQjRHwXsjaQRu47DCMY=;
        b=YPHKbbo2Q16BHjOGPnPtOQO1IzTIQpRw9rkUepfak46DVjxS0s2PziWK3CKxP+mwqIDwaG
        1sI3uw2XDAGCAjg29PhSzjICMvMu6BO2Zz7PsH5V1yLlmYw8GnuRc2+udyMiOZWG1CaTME
        AenDm0vCfhmCFVq2bG+19l+xUP8ejgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-l4C8PxvPN9yU2QMMY8PFUA-1; Sat, 03 Apr 2021 05:04:59 -0400
X-MC-Unique: l4C8PxvPN9yU2QMMY8PFUA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F122107ACCA;
        Sat,  3 Apr 2021 09:04:58 +0000 (UTC)
Received: from T590 (ovpn-12-28.pek2.redhat.com [10.72.12.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CECDD19D61;
        Sat,  3 Apr 2021 09:04:51 +0000 (UTC)
Date:   Sat, 3 Apr 2021 17:04:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] block: shutdown blktrace in case of fatal signal
 pending
Message-ID: <YGgvrxiQUTQMfUeN@T590>
References: <20210323081440.81343-1-ming.lei@redhat.com>
 <20210323081440.81343-2-ming.lei@redhat.com>
 <20210330165330.GA13829@lst.de>
 <YGO/cpalyGevAJjn@T590>
 <20210402172730.GA22923@lst.de>
 <YGgi6FOr6cEiei+7@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGgi6FOr6cEiei+7@T590>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 03, 2021 at 04:10:16PM +0800, Ming Lei wrote:
> On Fri, Apr 02, 2021 at 07:27:30PM +0200, Christoph Hellwig wrote:
> > On Wed, Mar 31, 2021 at 08:16:50AM +0800, Ming Lei wrote:
> > > On Tue, Mar 30, 2021 at 06:53:30PM +0200, Christoph Hellwig wrote:
> > > > On Tue, Mar 23, 2021 at 04:14:39PM +0800, Ming Lei wrote:
> > > > > blktrace may allocate lots of memory, if the process is terminated
> > > > > by user or OOM, we need to provide one chance to remove the trace
> > > > > buffer, otherwise memory leak may be caused.
> > > > > 
> > > > > Fix the issue by shutdown blktrace in case of task exiting in
> > > > > blkdev_close().
> > > > > 
> > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > 
> > > > This just seems weird.  blktrace has no relationship to open
> > > > block device instances.
> > > 
> > > blktrace still needs to open one blkdev, then send its own ioctl
> > > commands to block layer. In case of OOM, the allocated memory in
> > > these ioctl commands won't be released.
> > > 
> > > Or any other suggestion?
> > 
> > Not much we can do there I think.  If we want to autorelease memory
> > it needs to be an API that ties the memory allocation to an FD.
> 
> We still may shutdown blktrace if current is the last opener, otherwise
> new blktrace can't be started and memory should be leaked forever, and
> what do you think of the revised version?

This way seems not good enough, another better one is to use
file->private_data for such purpose since blkdev fs doesn't use
file->privete_data, then we can shutdown blktrace just for the
blktrace FD:

From 191dff30abfd48c38a78dec78e011a39a3b606ca Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 23 Mar 2021 10:32:23 +0800
Subject: [PATCH] block: shutdown blktrace in case of task exiting

blktrace may allocate lots of memory, if the process is terminated
by user or OOM, we need to provide one chance to remove the trace
buffer, otherwise memory leak may be caused. Also new blktrace
instance can't be started too.

Fix the issue by shutdown blktrace in bdev_close() if blktrace
was setup on this FD.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/ioctl.c                |  2 ++
 fs/block_dev.c               | 12 ++++++++++++
 include/linux/blktrace_api.h | 11 +++++++++++
 3 files changed, 25 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index ff241e663c01..7dad4a546db3 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -611,6 +611,8 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	else
 		mode &= ~FMODE_NDELAY;
 
+	blkdev_mark_blktrace(file, cmd);
+
 	switch (cmd) {
 	/* These need separate implementations for the data structure */
 	case HDIO_GETGEO:
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 92ed7d5df677..aaa7d7d1e5a4 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -34,6 +34,7 @@
 #include <linux/part_stat.h>
 #include <linux/uaccess.h>
 #include <linux/suspend.h>
+#include <linux/blktrace_api.h>
 #include "internal.h"
 
 struct bdev_inode {
@@ -1646,6 +1647,15 @@ EXPORT_SYMBOL(blkdev_put);
 static int blkdev_close(struct inode * inode, struct file * filp)
 {
 	struct block_device *bdev = I_BDEV(bdev_file_inode(filp));
+
+	/*
+	 * The task running blktrace is supposed to shutdown blktrace
+	 * by ioctl. If they forget to shutdown or can't do it because
+	 * of OOM or sort of situation, we shutdown for them.
+	 */
+	if (blkdev_has_run_blktrace(filp))
+		blk_trace_shutdown(bdev->bd_disk->queue);
+
 	blkdev_put(bdev, filp->f_mode);
 	return 0;
 }
@@ -1664,6 +1674,8 @@ static long block_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	else
 		mode &= ~FMODE_NDELAY;
 
+	blkdev_mark_blktrace(file, cmd);
+
 	return blkdev_ioctl(bdev, mode, cmd, arg);
 }
 
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index a083e15df608..754058c1965c 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -135,4 +135,15 @@ static inline unsigned int blk_rq_trace_nr_sectors(struct request *rq)
 	return blk_rq_is_passthrough(rq) ? 0 : blk_rq_sectors(rq);
 }
 
+static inline void blkdev_mark_blktrace(struct file *file, unsigned int cmd)
+{
+	if (cmd == BLKTRACESETUP)
+		file->private_data = (void *)-1;
+}
+
+static inline bool blkdev_has_run_blktrace(struct file *file)
+{
+	return file->private_data == (void *)-1;
+}
+
 #endif
-- 
2.29.2


-- 
Ming

