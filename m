Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0545EC7618F
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 17:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A0C21897
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 17:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMnH79el"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfGVRaw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:30:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46733 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfGVRaw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 13:30:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id i8so17969022pgm.13;
        Mon, 22 Jul 2019 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=3WkrBlhQGLRNnJo/MXZZ7vnmbCcs74q4XJirvLk0V8M=;
        b=sMnH79elSRWNVhT7udK5QBveox3svU97zhfgWSuiCqRHFr423/n22/TjxOGShUPHJ5
         glbE8Wkj/A91exHCpMAiiYFTrwYE2AYlLInM/cMkICuEY06qwxfkjqDZbyNJBstapcx5
         jKcRXT60w04z9Fuv0T7Bl0HZFY83C7lrE63T4HC9+vEZpE/7LWqKKAYCwhmr6rJN+SUw
         XYRSydbnF0NZE1keAvOjfQZLePK/QKpKaaLs3BLj750WLkx5I+SCHdGWB4dRiF2KsziF
         242EFmmgJr+o1jBWMLck5PWTILTWnu3nKdEzqlxRK01QVEQjJTWjocpHmG4mHeaufh/z
         OzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=3WkrBlhQGLRNnJo/MXZZ7vnmbCcs74q4XJirvLk0V8M=;
        b=azr9CHQ59Ig9F7Pwh67GYzOFuTlgaehW/DVteIICL3dDq28jIXEbH7x2Sr6JW7xh83
         YRyGesMjfYC5jOmQ9BUySq6xj9gWOiDklB/eCYQwVsm4UOGhyW7ih/zhIRCwN+Xphq9J
         gFx2Bni/UicE69xhdrgLLIQDvwG9qqAKCRr7u68qn4bsCOj8GnTvOKqNYwGNdDqsAVmn
         miBr6V539URHCFSZuXPbgMP5RoE5ton7h4i2EpyLZWZhPqrNhi9IYb10Y5Lr6vEC6nqu
         WACSMsZLlxApxwYro4dYPgqyKNTK5R+WwRLywWR2SCnAjgj3qo9ZxxAj3glnF7hoDk7R
         mITA==
X-Gm-Message-State: APjAAAVDjllKVoMA47IEoSxv/h8s/+VS+N+UpCelRLShFOB7MdoQj1nH
        GwXkZyfHv9RBVGLZgXft6qBMjCzJ
X-Google-Smtp-Source: APXvYqybia81FEHbBtIsKy2f17+dgZLRK5oM7wUDCFjbIJnf2XyxwwRcQFfFwNNfePBYPs7mNxd6QQ==
X-Received: by 2002:aa7:8d98:: with SMTP id i24mr1343890pfr.199.1563816651231;
        Mon, 22 Jul 2019 10:30:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o12sm30748558pjr.22.2019.07.22.10.30.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 10:30:50 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Hsin-Yi Wang <hsinyi@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH] bfq: Check if bfqq is NULL in bfq_insert_request
Date:   Mon, 22 Jul 2019 10:30:48 -0700
Message-Id: <1563816648-12057-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In bfq_insert_request(), bfqq is initialized with:
	bfqq = bfq_init_rq(rq);
In bfq_init_rq(), we find:
	if (unlikely(!rq->elv.icq))
		return NULL;
Indeed, rq->elv.icq can be NULL if the memory allocation in
create_task_io_context() failed.

A comment in bfq_insert_request() suggests that bfqq is supposed to be
non-NULL if 'at_head || blk_rq_is_passthrough(rq)' is false. Yet, as
debugging and practical experience shows, this is not the case in the
above situation.

This results in the following crash.

Unable to handle kernel NULL pointer dereference
	at virtual address 00000000000001b0
...
Call trace:
 bfq_setup_cooperator+0x44/0x134
 bfq_insert_requests+0x10c/0x630
 blk_mq_sched_insert_requests+0x60/0xb4
 blk_mq_flush_plug_list+0x290/0x2d4
 blk_flush_plug_list+0xe0/0x230
 blk_finish_plug+0x30/0x40
 generic_writepages+0x60/0x94
 blkdev_writepages+0x24/0x30
 do_writepages+0x74/0xac
 __filemap_fdatawrite_range+0x94/0xc8
 file_write_and_wait_range+0x44/0xa0
 blkdev_fsync+0x38/0x68
 vfs_fsync_range+0x68/0x80
 do_fsync+0x44/0x80

The problem is relatively easy to reproduce by running an image with
failslab enabled, such as with:

cd /sys/kernel/debug/failslab
echo 10 > probability
echo 300 > times

Avoid the problem by checking if bfqq is NULL before using it. With the
NULL check in place, requests with missing io context are queued
immediately, and the crash is no longer seen.

Fixes: 18e5a57d79878 ("block, bfq: postpone rq preparation to insert or merge")
Reported-by: Hsin-Yi Wang  <hsinyi@google.com>
Cc: Hsin-Yi Wang <hsinyi@google.com>
Cc: Nicolas Boichat <drinkcat@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 72860325245a..56f3f4227010 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5417,7 +5417,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	spin_lock_irq(&bfqd->lock);
 	bfqq = bfq_init_rq(rq);
-	if (at_head || blk_rq_is_passthrough(rq)) {
+	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
 		if (at_head)
 			list_add(&rq->queuelist, &bfqd->dispatch);
 		else
-- 
2.7.4

