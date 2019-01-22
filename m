Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BDBC282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 15:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBEE217D6
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 15:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170752;
	bh=H5F4UgyusDZ7Ef0oy+Za7vJwL7xKGf1CV3vNOpALKd8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=So1BUCHx/GQQ2Uc8qsvJ91RG6QHBvpWeQ7L7fWkRgoIvGjrQmaVT1/NrZslaitcSw
	 Ew4iGqmipP3q8ua9wqjXbLhhO2XDRIoMHIZI/2R7m61nAkqxZvcKDHdzWe663fvl90
	 PQ5FbhJwKjMFJGcNi6b8luEbADdTDpq56mz94Mcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfAVPXb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:23:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:36602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbfAVPXb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 10:23:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20C9A217D4;
        Tue, 22 Jan 2019 15:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170610;
        bh=H5F4UgyusDZ7Ef0oy+Za7vJwL7xKGf1CV3vNOpALKd8=;
        h=From:To:Cc:Subject:Date:From;
        b=w4g0NIzJ1raZV7zSWvX+Mc4t6iqRssVIPbzdDgyaQG3Vj958Y6tBqnVipepad/Zp2
         ZoTu1BcrwdDUenJXVBXwE7MOBwTq934ndOwzJ9r4nw5/N4T+uJyMMV1EPFkoAzqWI2
         dDW9Vl6V8r3dKzDLcDoQ0Ru2WMQB5cBLOMfT3/0M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org
Subject: [PATCH] blktrace: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:41 +0100
Message-Id: <20190122152151.16139-42-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-block@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/blktrace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index fac0ddf8a8e2..97ee6b5a2887 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -512,8 +512,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	dir = debugfs_lookup(buts->name, blk_debugfs_root);
 	if (!dir)
 		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
-	if (!dir)
-		goto err;
 
 	bt->dev = dev;
 	atomic_set(&bt->dropped, 0);
@@ -522,12 +520,8 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	ret = -EIO;
 	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
 					       &blk_dropped_fops);
-	if (!bt->dropped_file)
-		goto err;
 
 	bt->msg_file = debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
-	if (!bt->msg_file)
-		goto err;
 
 	bt->rchan = relay_open("trace", dir, buts->buf_size,
 				buts->buf_nr, &blk_relay_callbacks, bt);
-- 
2.20.1

