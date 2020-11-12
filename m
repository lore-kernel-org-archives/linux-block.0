Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052D4C5519F
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 14:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B03FA20872
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 14:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgKLOwp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 09:52:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7526 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbgKLOwo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 09:52:44 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CX4MN1WtwzhkLK;
        Thu, 12 Nov 2020 22:52:32 +0800 (CST)
Received: from localhost (10.174.176.180) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 12 Nov 2020
 22:52:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <axboe@kernel.dk>, <maco@android.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] loop: Fix passing zero to 'PTR_ERR' warning
Date:   Thu, 12 Nov 2020 22:52:33 +0800
Message-ID: <20201112145233.53060-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.176.180]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix smatch warning:

drivers/block/loop.c:799 loop_attr_backing_file_show() warn: passing zero to 'PTR_ERR'

file_path() never returns 0, so use IS_ERR instead of
IS_ERR_OR_NULL to fix this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 83701c2ae3ca..65d392307c6a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -795,7 +795,7 @@ static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
 		p = file_path(lo->lo_backing_file, buf, PAGE_SIZE - 1);
 	spin_unlock_irq(&lo->lo_lock);
 
-	if (IS_ERR_OR_NULL(p))
+	if (IS_ERR(p))
 		ret = PTR_ERR(p);
 	else {
 		ret = strlen(p);
-- 
2.17.1

