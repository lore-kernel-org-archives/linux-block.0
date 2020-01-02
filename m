Return-Path: <SRS0=T2Jf=2X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A421C2D0DC
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 14:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C94217F4
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 14:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgABO7c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 09:59:32 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:60111 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728544AbgABO7c (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 09:59:32 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MMoOy-1j3asu1Afs-00Ip7v; Thu, 02 Jan 2020 15:58:56 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/22] compat_ioctl: move CDROMREADADIO to cdrom.c
Date:   Thu,  2 Jan 2020 15:55:25 +0100
Message-Id: <20200102145552.1853992-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200102145552.1853992-1-arnd@arndb.de>
References: <20200102145552.1853992-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yC0KphMQ1+jnKNs/TZQcxE6mhJ8DI2BYfsTPoVcbUgaeAslYM1E
 +kDeZqbUJadN1PpR9x8xf6D1wRqI76SYi4qPB8Pn5nQ5LVbniZIaEa5h5YVIDwT0GvC4BEc
 VSbWkOJMe6hAEy4xQ5Qilz8rsgyXx60SBBEXK2X/bPWP2D+3dyjKdrOdXgRD7sf+oCaeOSw
 MvEzObUZ8SGijvgCyrrGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0LyknXyySuU=:QGnS3AemUqQiWwsUb3cQ/0
 uuErWnUU23YRVY1fLesU2gdZctGhMViXl8+td7MXCS35Fk9iowBsTwHZRD80P/Hx91wyK6v/R
 5nt5w2FQNTNwP8rgUFqVHjzku2BAMJPhyoj4KQ89HowsHYZim9Ldxo68o4b+8/XxWwNP2qkNz
 pnNUU8PuHd6PcfuanisY4QTXj6pk9A/67mABX40gtjRWMYddnOgA8uL1ZaY1kuwL6isZEs9Ki
 /JDLvt9IWDOIm7pYo7AKlFRW5383nr+mb+NrYM0uV3SU0412iMKKcAbkE97TDFif92HbVyfbc
 QeBy3LD2IZFHu3HFxT52awhYufiOTtQSgJkL1IPStQfWUl2JerUq9vcQqTMJt7I7UjOvtJuoL
 k9cqEqREoPTUgLY3Xq0QqnvxMjkCtihchOz6CHtpxNW763ZJjRC6zp7HZoQodID3Pea7pB4u2
 FgbeWeX+xdwf/I9UXF87392pBu0Nx+xQGf4t6whI7RTSy/NmYlROtB/9vjp0TOXiQuNGETnqm
 SMYt86fggLGoYEV5V6T/9CQEweNSxvbqouK+e1KmGvCKKNXD719X8rhh0MqOJ9LS1k6+ZfAzz
 pCPwjiU2N9LigHlM0PyXlgoM2pwP+CYbRTy9jQMzn0k6fx97qiQOC+xlurx1PiiTFw33mJGvq
 bu1DrM1gKavMfJUn8yJIFWTaLVWvFLYfpaAFci+kzktY40ScAYUbMzdOmcGG827F/Q7FRK5ez
 2SGBpPcAaSrLNUSqVjg1vLhmCixfxq+wUHqRYHK9FtXMk1/9LvZRmhhiBKISNVyRy5iXHiwln
 Yvd5ArmMtpq1/2599K8jgYBJvrinU6YiMZELyzXSRBdwPQ1kq7hc0beTn0IGb1XZDtNP9u6hn
 UW6qirvFHKQzVxCJVrJA==
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
index e34203f7d1cf..91a5dcf6e36c 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -96,40 +96,6 @@ static int compat_hdio_ioctl(struct block_device *bdev, fmode_t mode,
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
@@ -179,8 +145,6 @@ static int compat_blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
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

