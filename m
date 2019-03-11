Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9107EC43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 20:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F222087C
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 20:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334750;
	bh=VSRK+e64H6DBXbP0DsbedvCI3y0Sh8fLno4v5ZN3k7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YeADOdDT7wwOz/Uo6S9nvD5lT8uUNtmzG4NkxfQ3XfnRR1Q+afM7GHGPWazHuKf7p
	 FFH/buRxpVuMkqnDdT41f4P9X5KDuLMxPTEXn/UWn6uCVbLBzvD23yTMydzFwut644
	 5bPCtRpLu5HkDXk04orZIrncCV9iJYo/UHu92YNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfCKT55 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:57:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728521AbfCKT54 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 302E5214AF;
        Mon, 11 Mar 2019 19:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334275;
        bh=VSRK+e64H6DBXbP0DsbedvCI3y0Sh8fLno4v5ZN3k7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQ6o7ciYab7g5Szsxgoh2gtwz6gyqH+QAIpfnef5zXqdbfiorpIfsyHn5FdFKZTOb
         Up5rnFsshi7AGiJnCDKaXfODQQCj2ULE5c9LkkfaZyc/1UEOEh23LSBikGoHsjXsaX
         /salGs4rM4kCcm+pGQ4DxM+mSMIwnwpKOi4dC6+8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yufen Yu <yuyufen@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 31/44] floppy: check_events callback should not return a negative number
Date:   Mon, 11 Mar 2019 15:56:47 -0400
Message-Id: <20190311195700.138462-31-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
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
index fdabd0b74492..a8de56f1936d 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4084,7 +4084,7 @@ static unsigned int floppy_check_events(struct gendisk *disk,
 
 	if (time_after(jiffies, UDRS->last_checked + UDP->checkfreq)) {
 		if (lock_fdc(drive))
-			return -EINTR;
+			return 0;
 		poll_drive(false, 0);
 		process_fd_request();
 	}
-- 
2.19.1

