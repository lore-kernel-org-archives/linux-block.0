Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57701C433C1
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 08:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF2F619BA
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 08:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCWIPU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 04:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229995AbhCWIPF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 04:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616487304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxIb99wCDwJ/FwD327/UwYNz3Wa/2Q5hnwILWKtjdcQ=;
        b=XRshb6y/z06+yNbL66fKmoyBkvXAj5PwHoFYXoemsjIYyLqYLzkCswD6sfwPsVN7koDEHX
        1ZAw+7mFcN/mod8rQQ7vA1+uBi1ZRNUBNcJn+ro8g79+GhxXn3FPlkUc7ySIC/1HI7wU+M
        UGRRrRwZLKW5Z85eSNiRAqYxVDOfl9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-T9tUyQf5O_-WKgptSe1VqA-1; Tue, 23 Mar 2021 04:15:01 -0400
X-MC-Unique: T9tUyQf5O_-WKgptSe1VqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 802F181621;
        Tue, 23 Mar 2021 08:15:00 +0000 (UTC)
Received: from localhost (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E08114106;
        Tue, 23 Mar 2021 08:14:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] block: shutdown blktrace in case of fatal signal pending
Date:   Tue, 23 Mar 2021 16:14:39 +0800
Message-Id: <20210323081440.81343-2-ming.lei@redhat.com>
In-Reply-To: <20210323081440.81343-1-ming.lei@redhat.com>
References: <20210323081440.81343-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blktrace may allocate lots of memory, if the process is terminated
by user or OOM, we need to provide one chance to remove the trace
buffer, otherwise memory leak may be caused.

Fix the issue by shutdown blktrace in case of task exiting in
blkdev_close().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/block_dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 92ed7d5df677..1370eb731cea 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -34,6 +34,7 @@
 #include <linux/part_stat.h>
 #include <linux/uaccess.h>
 #include <linux/suspend.h>
+#include <linux/blktrace_api.h>
 #include "internal.h"
 
 struct bdev_inode {
@@ -1646,6 +1647,11 @@ EXPORT_SYMBOL(blkdev_put);
 static int blkdev_close(struct inode * inode, struct file * filp)
 {
 	struct block_device *bdev = I_BDEV(bdev_file_inode(filp));
+
+	/* shutdown blktrace in case of exiting which may be from OOM */
+	if (current->flags & PF_EXITING)
+		blk_trace_shutdown(bdev->bd_disk->queue);
+
 	blkdev_put(bdev, filp->f_mode);
 	return 0;
 }
-- 
2.29.2

