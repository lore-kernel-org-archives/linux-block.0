Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCDAC2D0C6
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7CE22B48
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfLKUqT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:46:19 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:38855 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfLKUp5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 15:45:57 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N0o7f-1hkohk3wnd-00wiOe; Wed, 11 Dec 2019 21:45:10 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Justin Sanders <justin@coraid.com>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alex Dewar <alex.dewar@gmx.co.uk>,
        Daniel Walter <dwalter@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-um@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 07/24] compaT_ioctl: ubd, aoe: use blkdev_compat_ptr_ioctl
Date:   Wed, 11 Dec 2019 21:42:41 +0100
Message-Id: <20191211204306.1207817-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191211204306.1207817-1-arnd@arndb.de>
References: <20191211204306.1207817-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gy8z+YAlxaJ9blvRYgmlwoOjM5ATVorSryFF8QdI4xwnfePEif2
 ZPqNZhXPZ2zKjqu+nHu5cY9UbimuPi3idKRpKUHXeFhUocrdiKGZl1/ztl9P/tv6FzJ/PhQ
 QfZ8OcX0GLkWwfNM3Vvs0xduPX27a2+KLP8a3SGV7HE9F75Njm6oBeKzUmFnAvHr12Ec8N9
 5gn9BVCoxS5wHBp8wOO0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pGK6m1crKsA=:gSjJQpNokt5OeOSFQeubXS
 DhaKLPBBb6EV6alKwS18pbLZRwhjKMomynM6uF1IwkqUjosaLsZM5+fPzPTj8qcCy3o/bvOwH
 ak7ENd0/P9BEOfygvkRK/sXam/1u76ZTGCHaowaE3HMgWdLm9nqlluqoXOTs/Fd2bujikB0Is
 AmWz+dOLA7fovKnGj+0oVpPptqiYyDbtX/GSGi7EqN6K5gmr1HrDHd+tj1ZSC08UdOlCGZGCu
 IwBvuLdlgsdnEWnEV3tmDNgqWm4Ttd9r5m30tPJLnByHL83pkyWR0Z4L4vI7JqnEYy44gTLb0
 IMwp1vEBhGRws4JPpInvZbQ+0MvlDuk20B8fxUByf4ihqvnZi7FWnJ7Q39NR8oWoTNONmqm64
 9SCQaclMLWn9UYQypRTiJfpbR1eLtANQTZOMCSTZZ8C717vegRMJtsSM7d8yySarspbydIClD
 NIU7HCCBp+OZ/j2z0MHerIfJ++Q5nY22EAdBnqLN7Z9Faswsn6mOj9S3cio22FmZkwoKtmJwH
 FzaZEi/of2JEyPSYXrmUEKDgQxOEj+obRUPtt9kogZRoE2aFCnUj5dfZT6qgwCZVdsxo998PC
 dCZmerXpuxR4YytniK67YdDWyX1RXOrapkFwk+rBwcRMAE7HMAFRAblqF4l1SeLuYK7QHfgx+
 +3+QmrVkplwr1i0Nkn0I+bNKP0/Tfc4BP0Rr1c8cfvERunmo/gbQumMgI98O+9FPHPabF3g5m
 iB33cvRo47XAQc1md8dzuy9DuqR4oNh/yFNLdzDwNFrp+74V1cGw7aGxXXpPZPNQpYFwUAu0y
 uaWmDUA6OYy4cA2yP5Ia24bfQsCYvmIeIdnTNcaMMsQsAwh/3ObdpFUTbiYn44CScMJmpYMEH
 9z/m1cveMeFXPF7tB5tA==
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

