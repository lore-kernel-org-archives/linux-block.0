Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BCDC10F0B
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 19:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323DA21734
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 19:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334334;
	bh=IG/QmBlCQ/BXkYWRO0x2yMArthahtn01d9Y69zUBFzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2XbK6Mmqpz4cHn8x+seJX2BK0tsiBePECOfnXqbCLbiQnzM/sYm2lpJUbkqb+2lt6
	 BkOdhjDdrodkh6vbtSDL2CWF8QFqbGDlXxYU2ob+b5a7N5j0/0boedMvfIBqZrfif0
	 waHPWBxO2XQa22tFfh6i1JEL2ZzYGzAahdCaKWpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfCKT6x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729472AbfCKT6w (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 15:58:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C892087C;
        Mon, 11 Mar 2019 19:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334332;
        bh=IG/QmBlCQ/BXkYWRO0x2yMArthahtn01d9Y69zUBFzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eo+C7WWBNok4aV/FGuMR7/gUsAeG89jxI0Pxubu0FBl6ZiT2jbQ3IQyoxqUiv/0mm
         unL9dUYxTn0GXLAeWcKAzCx6hUSQEevNc4FI7LWECNXbdQpae7+qVHqhLHEsLTfdHN
         QFmG7ivMhtf86OzDIE8z65XkJhv+Vg7K2GDZbHd4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yufen Yu <yuyufen@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 18/27] floppy: check_events callback should not return a negative number
Date:   Mon, 11 Mar 2019 15:58:15 -0400
Message-Id: <20190311195824.139043-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195824.139043-1-sashal@kernel.org>
References: <20190311195824.139043-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yufen Yu <yuyufen@huawei.com>

[ Upstream commit 96d7cb932e826219ec41ac02e5af037ffae6098c ]

floppy_check_events() is supposed to return bit flags to say which
events occured. We should return zero to say that no event flags are
set.  Only BIT(0) and BIT(1) are used in the caller. And .check_events
interface also expect to return an unsigned int value.

However, after commit a0c80efe5956, it may return -EINTR (-4u).
Here, both BIT(0) and BIT(1) are cleared. So this patch shouldn't
affect runtime, but it obviously is still worth fixing.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: a0c80efe5956 ("floppy: fix lock_fdc() signal handling")
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/floppy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index a7f212ea17bf..3ea9c3e9acb3 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4079,7 +4079,7 @@ static unsigned int floppy_check_events(struct gendisk *disk,
 
 	if (time_after(jiffies, UDRS->last_checked + UDP->checkfreq)) {
 		if (lock_fdc(drive))
-			return -EINTR;
+			return 0;
 		poll_drive(false, 0);
 		process_fd_request();
 	}
-- 
2.19.1

