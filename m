Return-Path: <SRS0=I4RS=DX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2C9C433E7
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 14:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E737520897
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 14:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408907AbgJPOdz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Oct 2020 10:33:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48244 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405999AbgJPOdx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Oct 2020 10:33:53 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kTQnn-0006UY-CP; Fri, 16 Oct 2020 14:33:51 +0000
From:   Colin King <colin.king@canonical.com>
To:     Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>,
        Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lightnvm: fix out-of-bounds write to array devices->info[]
Date:   Fri, 16 Oct 2020 15:33:51 +0100
Message-Id: <20201016143351.677352-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is an off-by-one array check that can lead to a out-of-bounds
write to devices->info[i].  Fix this by checking by using >= rather
than > for the size check. Also replace hard-coded array size limit
with ARRAY_SIZE on the array.

Addresses-Coverity: ("Out-of-bounds write")
Fixes: cd9e9808d18f ("lightnvm: Support for Open-Channel SSDs")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/lightnvm/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index fe78bf0fdce5..f9f5dd38c697 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1311,8 +1311,9 @@ static long nvm_ioctl_get_devices(struct file *file, void __user *arg)
 		strlcpy(info->bmname, "gennvm", sizeof(info->bmname));
 		i++;
 
-		if (i > 31) {
-			pr_err("max 31 devices can be reported.\n");
+		if (i >= ARRAY_SIZE(devices->info)) {
+			pr_err("max %zd devices can be reported.\n",
+			       ARRAY_SIZE(devices->info));
 			break;
 		}
 	}
-- 
2.27.0

