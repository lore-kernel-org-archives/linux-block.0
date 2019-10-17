Return-Path: <SRS0=WMYH=YK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569BAC4CECE
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 03:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327DF2082C
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 03:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406975AbfJQDvL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Oct 2019 23:51:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390324AbfJQDvL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Oct 2019 23:51:11 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F29C5B755C0162164F35;
        Thu, 17 Oct 2019 11:51:06 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Thu, 17 Oct 2019 11:50:59 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <yangerkun@huawei.com>, <yi.zhang@huawei.com>, <houtao1@huawei.com>
Subject: [PATCH] io_uring: fix logic error in io_timeout
Date:   Thu, 17 Oct 2019 12:12:35 +0800
Message-ID: <20191017041235.45594-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If ctx->cached_sq_head < nxt_sq_head, we should add UINT_MAX to tmp, not
tmp_nxt.

Fixes: 5da0fb1ab34c ("io_uring: consider the overflow of sequence for timeout req")
Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d2cb277da2f4..8781ab37b170 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1934,7 +1934,7 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		 * once there is some timeout req still be valid.
 		 */
 		if (ctx->cached_sq_head < nxt_sq_head)
-			tmp_nxt += UINT_MAX;
+			tmp += UINT_MAX;
 
 		if (tmp >= tmp_nxt)
 			break;
-- 
2.17.2

