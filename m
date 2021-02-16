Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83A6C433DB
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 15:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985FD64E07
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 15:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhBPPxe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Feb 2021 10:53:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhBPPxd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Feb 2021 10:53:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC00C64DFF;
        Tue, 16 Feb 2021 15:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613490771;
        bh=85pvH/6s9rXjIqk70HW7aM3bLbiVGgC/BtO6nClFq5w=;
        h=From:To:Cc:Subject:Date:From;
        b=T5WmsOzMnPc2RPtDKZavX0SqT3pGSqwjiKsNRBfdtnGj18F6GOU7mPt5W7w5f3svv
         D2dxcvwhg9k1yaJT/FTbLGbgPKUSq1Y8i/sxOV67Tbw+fSZcgtDCywoZfd7LtPwWHo
         euuikgj4k2cp/72p7ovpuxVaAqQGNz0DM9PKWQt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     axboe@kernel.dk, rostedt@goodmis.org, mingo@redhat.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blktrace: remove debugfs file dentries from struct blk_trace
Date:   Tue, 16 Feb 2021 16:52:47 +0100
Message-Id: <20210216155247.1015870-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These debugfs dentries do not need to be saved for anything as the whole
directory and everything in it is properly cleaned up when the parent
directory is removed.  So remove them from struct blk_trace and don't
save them when created as it's not necessary.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/blktrace_api.h | 2 --
 kernel/trace/blktrace.c      | 8 ++------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 05556573b896..79979d33c140 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -23,8 +23,6 @@ struct blk_trace {
 	u32 pid;
 	u32 dev;
 	struct dentry *dir;
-	struct dentry *dropped_file;
-	struct dentry *msg_file;
 	struct list_head running_list;
 	atomic_t dropped;
 };
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index fb0fe4c66b84..67c730f0b6ef 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -311,8 +311,6 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 
 static void blk_trace_free(struct blk_trace *bt)
 {
-	debugfs_remove(bt->msg_file);
-	debugfs_remove(bt->dropped_file);
 	relay_close(bt->rchan);
 	debugfs_remove(bt->dir);
 	free_percpu(bt->sequence);
@@ -544,10 +542,8 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	INIT_LIST_HEAD(&bt->running_list);
 
 	ret = -EIO;
-	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
-					       &blk_dropped_fops);
-
-	bt->msg_file = debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
+	debugfs_create_file("dropped", 0444, dir, bt, &blk_dropped_fops);
+	debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
 
 	bt->rchan = relay_open("trace", dir, buts->buf_size,
 				buts->buf_nr, &blk_relay_callbacks, bt);
-- 
2.30.1

