Return-Path: <SRS0=GXCF=VD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDB7C0650E
	for <linux-block@archiver.kernel.org>; Sat,  6 Jul 2019 15:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E460920989
	for <linux-block@archiver.kernel.org>; Sat,  6 Jul 2019 15:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562428247;
	bh=DoMosQyj+D2mjOogflP8YGGJ6A9R8/xlAkdk2iL0qLk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=SEoy7IZ7v4bwP9DSwVogSC5uvh+dAheA/9zLXkLP7i9ol3Uxn1Q1tqFbs1ZzmA/q1
	 4jbyvBjeQ6EXsaf5nCPlCRLi55LBp9AAWZ4Hl4MJe0Mj0Y/Qu6UB4oFd0P7WEntLrp
	 N+FJfR+33scvvm7ao5RGOwEo67NsLKJVl1Z69NDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfGFPuq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Jul 2019 11:50:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfGFPuq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 6 Jul 2019 11:50:46 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 123AE20838;
        Sat,  6 Jul 2019 15:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562428245;
        bh=DoMosQyj+D2mjOogflP8YGGJ6A9R8/xlAkdk2iL0qLk=;
        h=Date:From:To:Cc:Subject:From;
        b=kbjtnzPQNMvZHlhZ/kx7zMACMZ7PPjTCyuSNTZ93unBmycxP/8i7lY0yA/VpfVq9r
         rgmzBLFZkfc6hpAGJs6Ys68JjkqahB6er5JvH7gooh+lVn78rR6XMmDq7hG27Dt9sk
         K+Bi4RvnPAtYT3HrHkd0CPHOzRBhi8R5nhs4ZihM=
Date:   Sat, 6 Jul 2019 17:50:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>
Subject: [PATCH] blk-mq: fix up placement of debugfs directory of queue files
Message-ID: <20190706155032.GA3106@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the blk-mq debugfs file creation logic was "cleaned up" it was
cleaned up too much, causing the queue file to not be created in the
correct location.  Turns out the check for the directory being present
is needed as if that has not happened yet, the files should not be
created, and the function will be called later on in the initialization
code so that the files can be created in the correct location.

Fixes: 6cfc0081b046 ("blk-mq: no need to check return value of debugfs_create functions")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: stable <stable@vger.kernel.org> # 5.2+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-mq-debugfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 2489ddbb21db..3afe327f816f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -934,6 +934,13 @@ void blk_mq_debugfs_register_sched(struct request_queue *q)
 {
 	struct elevator_type *e = q->elevator->type;
 
+	/*
+	 * If the parent directory has not been created yet, return, we will be
+	 * called again later on and the directory/files will be created then.
+	 */
+	if (!q->debugfs_dir)
+		return;
+
 	if (!e->queue_debugfs_attrs)
 		return;
 
-- 
2.22.0

