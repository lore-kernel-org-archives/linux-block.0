Return-Path: <SRS0=T2Jf=2X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85E8C2D0DC
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 14:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B991F21835
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 14:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgABO6t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 09:58:49 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:58161 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728544AbgABO6t (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 09:58:49 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M433w-1in1vY3uwi-0003Hv; Thu, 02 Jan 2020 15:58:21 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Justin Sanders <justin@coraid.com>,
        Jens Axboe <axboe@kernel.dk>,
        Daniel Walter <dwalter@google.com>,
        Alex Dewar <alex.dewar@gmx.co.uk>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH v3 05/22] compat_ioctl: ubd, aoe: use blkdev_compat_ptr_ioctl
Date:   Thu,  2 Jan 2020 15:55:23 +0100
Message-Id: <20200102145552.1853992-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200102145552.1853992-1-arnd@arndb.de>
References: <20200102145552.1853992-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8p6BJLwWlOj4GvZq2jwHiMBi4e9jJiHHbTeRXtMc/ApbEdKhklc
 gKlW1NaJh90o2mvhxJRo47hmvCzaB15auzhfRK08JSJldtXQK+TFAbQnCnVZulkj5SogMn4
 LfbZdloSdsbQbAhiQeotT/ZakSv8yylow0e+EApZlUEBrIppF2EzpE6WOgmXG/gLywQZxZx
 rjT/qfDnsWHma4CB8nMaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MrbTKH9MBv8=:tGOIcVKUd15dl5QCSnQhWi
 l92uQbcHjmyxlz3mrYVH+VEzMKjGo99LlZCaa00Cs9CW/8c1yR4TqOnAqtq2cyyTm7BydkDN3
 M1oQrb3D0yzJNz2qT5vhX3uAaH9ELre7mNJf1lFrEaltKs9LrMdgZRFSTBKHTv0XwHoIhlFrK
 iAfucu65aHNau9imkICR//naYpZqEe9oJQsmFCqqC/NXNoZoEy0HdLC/zwDzcJxQr++0Ql1w7
 OmyB01FdKfIB+dNOl9q4mUPgwSCJ2FF8GOI7rLsVEajQ3twqYGU532orIIbPP579kpe+vW6Wd
 0UTU50Gqjbi3Rdb7hQIOoPue8RDQlEMCADDW1tijPnR+7ds73XPy+g8cy3nK1lgTPGntDwN4U
 w9nzLdHkPHMEbkIxd7zHVKlkHwJecfUC9u9xk4Y8PDzsJVnuVkSthxgVpw5j2b1lT7QAzLA3p
 MEBPOADTWWZwQjSFNVx4yflFSY0A+SzaTL7NlPJYWlyciQyUDWeKi3+wD5GIvBAi4GKCNRwL3
 zWoZHo9QzmA2vj8e5m5I6i+17omfJdbjOcb8IJKcPC0vF7ZnuMluOIRnSvlSOJ2Dhc4xk8+qx
 DpCnZNOjGxjAAQOT/1dsbvbJD4T7byudIqLDyiiYxeZ5RIiZeHk0Vl/p0hK8pn06oKk1ZSIMb
 dW+VDrNJlVEVt21k5K7jrzRxpAY0n0AF41TdhraKf3lagtDcva/ON8ug0sirgQiezEBvcovUr
 pMDACkpS3KTrz8X6yZpRQlhYjuCAKlBRv8D8gk3191Z52wetwpvcQSfgE7bszS0A1ItxITQlj
 n5szWhlnByKP4I8KStDZLS1PXM/QlWPFNuHICr8hjXvzl7SKGhsHGE1BmVHcWsG6s8qFFncjK
 iNE5bzoy6IW09u5hSBow==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These drivers implement the HDIO_GET_IDENTITY and CDROMVOLREAD ioctl
commands, which are compatible between 32-bit and 64-bit user space and
traditionally handled by compat_blkdev_driver_ioctl().

As a prerequisite to removing that function, make both drivers use
blkdev_compat_ptr_ioctl() as their .compat_ioctl callback.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/um/drivers/ubd_kern.c | 1 +
 drivers/block/aoe/aoeblk.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 6627d7c30f37..582eb5b1f09b 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -113,6 +113,7 @@ static const struct block_device_operations ubd_blops = {
         .open		= ubd_open,
         .release	= ubd_release,
         .ioctl		= ubd_ioctl,
+        .compat_ioctl	= blkdev_compat_ptr_ioctl,
 	.getgeo		= ubd_getgeo,
 };
 
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index bd19f8af950b..7b32fb673375 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -329,6 +329,7 @@ static const struct block_device_operations aoe_bdops = {
 	.open = aoeblk_open,
 	.release = aoeblk_release,
 	.ioctl = aoeblk_ioctl,
+	.compat_ioctl = blkdev_compat_ptr_ioctl,
 	.getgeo = aoeblk_getgeo,
 	.owner = THIS_MODULE,
 };
-- 
2.20.0

