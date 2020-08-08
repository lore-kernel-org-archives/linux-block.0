Return-Path: <SRS0=lwW3=BS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F61C433E1
	for <linux-block@archiver.kernel.org>; Sat,  8 Aug 2020 09:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECF320855
	for <linux-block@archiver.kernel.org>; Sat,  8 Aug 2020 09:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgHHJKX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 Aug 2020 05:10:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49382 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbgHHJKX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 8 Aug 2020 05:10:23 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 265F5153194962AA996F;
        Sat,  8 Aug 2020 17:10:17 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Sat, 8 Aug 2020
 17:10:06 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] badblocks: Convert to use the fallthrough macro
Date:   Sat, 8 Aug 2020 17:12:33 +0800
Message-ID: <1596877953-23320-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

Convert the uses of fallthrough comments to fallthrough macro.

Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 block/badblocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 2e5f5697db35..d39056630d9c 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -525,7 +525,7 @@ ssize_t badblocks_store(struct badblocks *bb, const char *page, size_t len,
 	case 3:
 		if (newline != '\n')
 			return -EINVAL;
-		/* fall through */
+		fallthrough;
 	case 2:
 		if (length <= 0)
 			return -EINVAL;
-- 
2.19.1

