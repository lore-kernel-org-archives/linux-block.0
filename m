Return-Path: <SRS0=T2Jf=2X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DD4C2D0DC
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 14:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979BE2072C
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 14:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgABO7p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 09:59:45 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:60677 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728544AbgABO7p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 09:59:45 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N49xZ-1jn8pu1q4X-0105tC; Thu, 02 Jan 2020 15:59:07 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Martin Wilck <mwilck@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/22] compat_ioctl: cdrom: handle CDROM_LAST_WRITTEN
Date:   Thu,  2 Jan 2020 15:55:26 +0100
Message-Id: <20200102145552.1853992-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200102145552.1853992-1-arnd@arndb.de>
References: <20200102145552.1853992-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IWmxlyxI1qDwOyVeMVL1WEG4Wr9pkXMYxQX0pGf2w844D03lneV
 mJ+v/3Zju8V9e+ypSQIdzA7JlLVZDaOpD4oA+aLLJN9iDnF3iB0zWPl9PwpeYIrAMzq1yxa
 5emoGaoNRK+PsiIAybanfpyNDZr8DB0jz8KcocrzKhStdA5dDEwNZPLKWSS23HS5ffM/zEx
 gIpNBKqIzppGYrr3etarA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1IH1nB+jcXY=:HSkthDNTH1sqo6kPxACiAN
 31gKDaW2LonLFIknfehsDRwI8jCQ/x4+dX7A/MFQphAzpdmupNQosnyjmKgRL4oiTp5p2NZjw
 nWZM5IadK8L5/enUkP9N7fhF/NOxlF2y/tbPuUwa88yG7BrDDbb1T0W6GN/I5p7MFcHl66dKW
 AfwKqOSgSzIwg0KOSRKtBzMPsfavscLljV4oDfYcBknrpux5V7f22qySw3jSeidJ/I0SmW6h/
 6NpG4ZJLlOchf5vV0zQUkcUsOk+nECfl8ukIbXLTheGkeODX/8s8KwtFQr7P5Yykq+g4GV8iZ
 HDykSId0YwNcmn7nZTDKBPrqqRA7XMhoI9mwqTULGEGW+E0Y3Du2w6hgwwh23lOGt/iIN5thE
 MkCvBWqZZWYlWwvKdu3ZklZsEIe4Sst5fF3i6tdtKSZn1IlmX428IpmyIJj5jO3To0bd8WwOP
 4k2NchSVuF5hYan2+nlikM+scEclYSg3LojcmKzh07wLR0tH1GESd7di1eseVp1U1FNUy8jwr
 iWz853oY0iPx4dbBhqYN+U+QS+y5UINZ3eo1JJ3cnT1eUZFJ4ALPBLpQvoYdZ5Od3SmB8tODS
 SptVWPTIJK6Sz5cartwYIZxoCjtoV35hvPQO7AKDWgMm8FsQ5RkmIZj8xjMqA+jIX3IPepPVq
 BlYkEIxNKghbtycuROaZazY42KOyi+bm53XovQgC0bgJmRtMBDLDY52cguuGRzFKUMIda/h/h
 6ix+khD0ESk4QbdhJtmojUjUKpwkDQ93dLiNvqVbOk5637CxBE6EBLTSqw55Qd8CrJ2++GysO
 iHAm3iNRqDlNjDOSHir/6LmTkAobhf1E4VP8TJpS5q+6KqHFHo7+rFa9NO2DpUam4YdD0VVbN
 96L9Bcrit/jRuaAjbsTQ==
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

