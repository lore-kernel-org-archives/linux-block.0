Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBD2C2D0C7
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2931D2464B
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfLKUqa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:46:30 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:47121 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfLKUq3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 15:46:29 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MdNPq-1i65A826tc-00ZQLd; Wed, 11 Dec 2019 21:45:44 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>, Martin Wilck <mwilck@suse.com>,
        Hannes Reinecke <hare@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>
Subject: [PATCH 10/24] compat_ioctl: cdrom: handle CDROM_LAST_WRITTEN
Date:   Wed, 11 Dec 2019 21:42:44 +0100
Message-Id: <20191211204306.1207817-11-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191211204306.1207817-1-arnd@arndb.de>
References: <20191211204306.1207817-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OgKProSambYiHxIdc4WgI96dWkA775je0kzaKhUxPtesDlYoKyr
 gFFE1yy9DzEM7a5B5AA/oSqXoT7QuiY4bPuyHN27QCD94Ex8qoyXne6agA5MTSOyDSrPZGD
 b1iEfWDWCeor9YWE98KUBDkDqgzEcVe4XsydwGdKj0HN1+aNts0vphUCJe97+YwSV7Cwuc1
 NPTBUBiYBp0q71uYDhjLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hu2x/EQ5Akw=:kkX8RCM7OH0NzXIm2tqs9i
 sLHHlNRUC31BYCN7hIZytGYHFX+czQfkQlwPZsH8e+XKW0dHB9up5hnk5z1rU4r2NUrUdAr0v
 VyFaamsfs6G8SqhUkpOmVGoWOAFaSQ9MrbqI8sLODVKtntYt8R9eWpeRcFnSTEuNb3g+whPI4
 mSoYVxg6+8o8mtCTLdVnfxhCUDVnh8gqsJ4JQFVfHK22DWhxEvcMJ9T7tE6IdA9ZA/EZjXdGV
 sLfZpMxbGKRov84Jy/2ZqSVMIfpDQMWZXGjo/+qFZeKurqf54xnsjNmZsaPHpyaZBMnfiW+TX
 lCwVM07T3jmrVnam7Xonjfn9L7acTC6cFTWU9o7QQ+kpCJa/ZdAi70SzHbyMuOL4ZYkH05Xud
 mDpr4nwzEIgJLWzGkvxxX1iaWM1j4ZEEm9HjrCQlOCY8TCNRxHspFNWoOWvTOMzjjm8iD8Xua
 QvN6mPKXr5GZvwpMwnKbRHX+uEzUYLGg4npHHrWkdI/zRcVEjRL5Eza8kz+EtRENOfL6ITRXh
 zX8zKnuUaxBeEyYR/X5pQjKN0SeBGmVyB7RyJJSdUdUj8PsBoUMfCVEe2kyuBOSZPdzMyWBSh
 oXqLDy417zcfrnc+7Ec9vujspmUmVuaAc1qWxswpslZCkHlvfejhXZNJ4vt34IFAZSTkG28+y
 BmG53KpQIu9xron0cA3NL0rgACyTESFb8ouD/QfdlH5XSnKUcEzLZAd+9sLL35tAeKq1A9PSf
 kY7ij1PIMzoQc6ix9EpU5tLRR18Ky03ORsAG97f+/xE/WXSpPvyjACZw8W5Z1HkwulabSwBkC
 B5mgacsSWMkl7bJNu7JTb9YAezAK7f0wmDxlDBqeVfLIwvb4vJNJXpOMn3ZIPtML6Qg51rh4x
 UCB0u9rL3bexsg3A8PyA==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is the only ioctl command that does not have a proper
compat handler. Making the normal implementation do the
right thing is actually very simply, so just do that by
using an in_compat_syscall() check to avoid the special
case in the pkcdvd driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/pktcdvd.c | 24 +-----------------------
 drivers/cdrom/cdrom.c   |  7 ++++---
 2 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index ab4d3be4b646..5f970a7d32c0 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2663,26 +2663,6 @@ static int pkt_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
-static int pkt_compat_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-	/* compatible */
-	case CDROMEJECT:
-	case CDROMMULTISESSION:
-	case CDROMREADTOCENTRY:
-	case CDROM_SEND_PACKET: /* compat mode handled in scsi_cmd_ioctl */
-	case SCSI_IOCTL_SEND_COMMAND:
-		return pkt_ioctl(bdev, mode, cmd, (unsigned long)compat_ptr(arg));
-
-	/* FIXME: no handler so far */
-	default:
-	case CDROM_LAST_WRITTEN:
-		return -ENOIOCTLCMD;
-	}
-}
-#endif
-
 static unsigned int pkt_check_events(struct gendisk *disk,
 				     unsigned int clearing)
 {
@@ -2704,9 +2684,7 @@ static const struct block_device_operations pktcdvd_ops = {
 	.open =			pkt_open,
 	.release =		pkt_close,
 	.ioctl =		pkt_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl =		pkt_compat_ioctl,
-#endif
+	.compat_ioctl =		blkdev_compat_ptr_ioctl,
 	.check_events =		pkt_check_events,
 };
 
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 48095025e588..faca0f346fff 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3293,9 +3293,10 @@ static noinline int mmc_ioctl_cdrom_last_written(struct cdrom_device_info *cdi,
 	ret = cdrom_get_last_written(cdi, &last);
 	if (ret)
 		return ret;
-	if (copy_to_user((long __user *)arg, &last, sizeof(last)))
-		return -EFAULT;
-	return 0;
+	if (in_compat_syscall())
+		return put_user(last, (__s32 __user *)arg);
+
+	return put_user(last, (long __user *)arg);
 }
 
 static int mmc_ioctl(struct cdrom_device_info *cdi, unsigned int cmd,
-- 
2.20.0

