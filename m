Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DF5C433B4
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 07:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E356120B
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 07:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbhDLHi7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:38:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16445 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbhDLHi6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 03:38:58 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FJgXS3gbMzqTFX;
        Mon, 12 Apr 2021 15:36:24 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 15:38:31 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <mb@lightnvm.io>
CC:     <linux-block@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] lightnvm: Return the correct return value
Date:   Mon, 12 Apr 2021 15:38:54 +0800
Message-ID: <1618213134-21099-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When memdup_user returns an error, memdup_user has two different return
values, use PTR_ERR to get the correct return value.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/lightnvm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 28ddcaa..42774be 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1257,7 +1257,7 @@ static long nvm_ioctl_info(struct file *file, void __user *arg)
 
 	info = memdup_user(arg, sizeof(struct nvm_ioctl_info));
 	if (IS_ERR(info))
-		return -EFAULT;
+		return PTR_ERR(info);
 
 	info->version[0] = NVM_VERSION_MAJOR;
 	info->version[1] = NVM_VERSION_MINOR;
-- 
2.7.4

