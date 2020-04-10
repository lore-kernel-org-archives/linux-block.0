Return-Path: <SRS0=rO4A=52=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3CAC2BB85
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 03:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F5020CC7
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 03:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490498;
	bh=4FfjHUzoXOQuHsFmCwjdJHNFyyAOjk/AM8IR/EFRMnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P48IXQwE5gc/9abqTGHSNU6rZlP38dzIO+FR3ZNonOi3X7h4hpybMAkD59x/KlgYx
	 X0PnAO8XRW+giLVDTq+wHHnBSM+6rwuIJFwQ5zzn7C6/gCjlyQdn1NG0i48P4gZE07
	 HyCjlJkBT6u224DhyYWFgAGUGixj7ajrmN6GraTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgDJDsQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:48:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgDJDsQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Apr 2020 23:48:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB77A21473;
        Fri, 10 Apr 2020 03:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490495;
        bh=4FfjHUzoXOQuHsFmCwjdJHNFyyAOjk/AM8IR/EFRMnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rEKgPRhEzmQMazvEKBDDjz7vetyHuO6cfPtvFsmePtb2ww8rn4bnom4cw2r2paL8K
         xAy5zs+LIkL76JrBsFQjdtQdAex44dXC35InrKSt28iT9OVzvb3VOuns/O3jtRxxKq
         KxWjpoOsITVdwwxF2z7GwLBf57KN+gOrzXwWbFnY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 12/56] null_blk: Handle null_add_dev() failures properly
Date:   Thu,  9 Apr 2020 23:47:16 -0400
Message-Id: <20200410034800.8381-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034800.8381-1-sashal@kernel.org>
References: <20200410034800.8381-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 9b03b713082a31a5b90e0a893c72aa620e255c26 ]

If null_add_dev() fails then null_del_dev() is called with a NULL argument.
Make null_del_dev() handle this scenario correctly. This patch fixes the
following KASAN complaint:

null-ptr-deref in null_del_dev+0x28/0x280 [null_blk]
Read of size 8 at addr 0000000000000000 by task find/1062

Call Trace:
 dump_stack+0xa5/0xe6
 __kasan_report.cold+0x65/0x99
 kasan_report+0x16/0x20
 __asan_load8+0x58/0x90
 null_del_dev+0x28/0x280 [null_blk]
 nullb_group_drop_item+0x7e/0xa0 [null_blk]
 client_drop_item+0x53/0x80 [configfs]
 configfs_rmdir+0x395/0x4e0 [configfs]
 vfs_rmdir+0xb6/0x220
 do_rmdir+0x238/0x2c0
 __x64_sys_unlinkat+0x75/0x90
 do_syscall_64+0x6f/0x2f0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Johannes Thumshirn <jth@kernel.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/null_blk_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 97bb53d7fa348..635904bfcf777 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1432,7 +1432,12 @@ static void cleanup_queues(struct nullb *nullb)
 
 static void null_del_dev(struct nullb *nullb)
 {
-	struct nullb_device *dev = nullb->dev;
+	struct nullb_device *dev;
+
+	if (!nullb)
+		return;
+
+	dev = nullb->dev;
 
 	ida_simple_remove(&nullb_indexes, nullb->index);
 
-- 
2.20.1

