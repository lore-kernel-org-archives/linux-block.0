Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD0DC43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 09:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2063420657
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 09:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfCFJ7k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:59:40 -0500
Received: from relay.sw.ru ([185.231.240.75]:41156 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbfCFJ7k (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Mar 2019 04:59:40 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1h1TKq-0001gJ-M0; Wed, 06 Mar 2019 12:59:36 +0300
Subject: [PATCH] loop: Add file_xxx_write() wrapping around call of
 fallocate()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, ktkhai@virtuozzo.com
Date:   Wed, 06 Mar 2019 12:59:35 +0300
Message-ID: <155186622194.11790.1816551593715324958.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

FALLOC_FL_PUNCH_HOLE changes file content, so it looks strange
we skip such the operations, when we are doing freeze_super().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 drivers/block/loop.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1e6edd568214..741e0a7bce41 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -434,7 +434,9 @@ static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
 		goto out;
 	}
 
+	file_start_write(file);
 	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
+	file_end_write(file);
 	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
 		ret = -EIO;
  out:

