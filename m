Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70403C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5D82465B
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfLKUq0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:46:26 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:34855 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfLKUq0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 15:46:26 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MacWq-1i8qJS0cf4-00cBEd; Wed, 11 Dec 2019 21:45:32 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-block@vger.kernel.org
Subject: [PATCH 09/24] compat_ioctl: move CDROMREADADIO to cdrom.c
Date:   Wed, 11 Dec 2019 21:42:43 +0100
Message-Id: <20191211204306.1207817-10-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191211204306.1207817-1-arnd@arndb.de>
References: <20191211204306.1207817-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9eLcpqX9qM3wY9O4JMlBOGxtF6980Tea0e3xYW37bDIbuBQTU3d
 EBt9uH6NIbNAq3wnxnKjoZGRiY26U6pGdg8mn4FyQwBgKP3hprv2duU5iz3Bj/tpbriZqX1
 rAicuFbxRQ2b8PzXcWI0CpjiIAIqjITj0IyontPLj5Ii8Z0oB8HwnOC5O59p9zHFz77n5DX
 vbJmPvFNQp9dPaV6e2OjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:miUaOKDhzGc=:NQ5w4Tv6kJpsYc2hAv9MBL
 XPFl09NhiZJ8sFOqfF9F6Cr0nFZNVPknX8DvCdwadIpGG8vRZo0r2s0GEMW9I0GOEweeE4rtJ
 QULXit1ZqycFg4OdaK+bhQ9D/a6sGdIPqRq/savDBCKzANNZ8KcYlBXcH3WXNn+1eiAhEuDME
 QUqMGSkKqO+8dKz80yFyRPYmBlQNqi1yxHppfyltSyZHDwFSCH4vTKVPyYUCSE6+PK/wBR27z
 bDFmAi2h7AyJqvyBsvL0B15h67jZPpncHFqDMMsXIzYOtzFDinZ/Pk+Eiz+HAyjWEGmIY4WCk
 gjFVUOOF1DM3vptgfDBdc949e53LeRbkee6q1XSX9/knW68cf7dY4iqtT4YaMctWk0NVt6/Qq
 yOgqoJ+L2zfHVcjYpTo/mO7y+U9Jb9fGjPAEbC2dRKepMRAXlFp9orwg01MUw5gTHUFpNXF0r
 F4/0uYnJtIbL6UVVdPb4Mzz3N/yM3uwOBOCgZYXdTC5bfojvOjoooqbCZw0jbfo499FagB50m
 NTEyfrR+0mBnjv8tM4JMB2DDwb4rWu/gS6Om1UJVoBX7Q0rnHucA9D+5Ff57mZSCtB50gwMLl
 yb7btU8OddXIGAUuT6SWlQQAA9I4xsIJTnizjWoJpvJFJGioNGxOjXcsRpIGt20yHftYoNm5v
 HzHEwir5mPeDEw3UlbGCdrKs8aylgUiApZdYTe0ZwMOz0u6geXJq+fgdmkO4TUTMmsLoQauSF
 AruH41K6eLFBjyFIgqO6brjg92nbkNTjp2QNuLLonSDCIkuqB3RwIf0XXsw8fVFaD0GWoFDUA
 EjF4z4yAkWSlMWSADJPdLzeicqaNoSaOlGnSJeqz7KlHL6ICc7FfoKH7ZcHaZcWcmjysT1Glv
 kWY027vK4y78pBqNljdw==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Again, there is only one file that needs this, so move the conversion
handler into the native implementation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/compat_ioctl.c  | 36 ------------------------------------
 drivers/cdrom/cdrom.c | 28 +++++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 39 deletions(-)

diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
index 578e04f94619..cf136bc2c9fc 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -95,40 +95,6 @@ static int compat_hdio_ioctl(struct block_device *bdev, fmode_t mode,
 	return error;
 }
 
-struct compat_cdrom_read_audio {
-	union cdrom_addr	addr;
-	u8			addr_format;
-	compat_int_t		nframes;
-	compat_caddr_t		buf;
-};
-
-static int compat_cdrom_read_audio(struct block_device *bdev, fmode_t mode,
-		unsigned int cmd, unsigned long arg)
-{
-	struct cdrom_read_audio __user *cdread_audio;
-	struct compat_cdrom_read_audio __user *cdread_audio32;
-	__u32 data;
-	void __user *datap;
-
-	cdread_audio = compat_alloc_user_space(sizeof(*cdread_audio));
-	cdread_audio32 = compat_ptr(arg);
-
-	if (copy_in_user(&cdread_audio->addr,
-			 &cdread_audio32->addr,
-			 (sizeof(*cdread_audio32) -
-			  sizeof(compat_caddr_t))))
-		return -EFAULT;
-
-	if (get_user(data, &cdread_audio32->buf))
-		return -EFAULT;
-	datap = compat_ptr(data);
-	if (put_user(datap, &cdread_audio->buf))
-		return -EFAULT;
-
-	return __blkdev_driver_ioctl(bdev, mode, cmd,
-			(unsigned long)cdread_audio);
-}
-
 struct compat_blkpg_ioctl_arg {
 	compat_int_t op;
 	compat_int_t flags;
@@ -178,8 +144,6 @@ static int compat_blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
 	case HDIO_GET_ADDRESS:
 	case HDIO_GET_BUSSTATE:
 		return compat_hdio_ioctl(bdev, mode, cmd, arg);
-	case CDROMREADAUDIO:
-		return compat_cdrom_read_audio(bdev, mode, cmd, arg);
 
 	/*
 	 * No handler required for the ones below, we just need to
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index eebdcbef0578..48095025e588 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3017,9 +3017,31 @@ static noinline int mmc_ioctl_cdrom_read_audio(struct cdrom_device_info *cdi,
 	struct cdrom_read_audio ra;
 	int lba;
 
-	if (copy_from_user(&ra, (struct cdrom_read_audio __user *)arg,
-			   sizeof(ra)))
-		return -EFAULT;
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall()) {
+		struct compat_cdrom_read_audio {
+			union cdrom_addr	addr;
+			u8			addr_format;
+			compat_int_t		nframes;
+			compat_caddr_t		buf;
+		} ra32;
+
+		if (copy_from_user(&ra32, arg, sizeof(ra32)))
+			return -EFAULT;
+
+		ra = (struct cdrom_read_audio) {
+			.addr		= ra32.addr,
+			.addr_format	= ra32.addr_format,
+			.nframes	= ra32.nframes,
+			.buf		= compat_ptr(ra32.buf),
+		};
+	} else
+#endif
+	{
+		if (copy_from_user(&ra, (struct cdrom_read_audio __user *)arg,
+				   sizeof(ra)))
+			return -EFAULT;
+	}
 
 	if (ra.addr_format == CDROM_MSF)
 		lba = msf_to_lba(ra.addr.msf.minute,
-- 
2.20.0

