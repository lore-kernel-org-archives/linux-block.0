Return-Path: <SRS0=T2Jf=2X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD34C2D0DC
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 15:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BD42072C
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 15:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgABPBt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 10:01:49 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:43503 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgABPBt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 10:01:49 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MgNMV-1jNDHv2yNj-00huQe; Thu, 02 Jan 2020 15:58:36 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Martin Wilck <mwilck@suse.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/22] compat_ioctl: move CDROM_SEND_PACKET handling into scsi
Date:   Thu,  2 Jan 2020 15:55:24 +0100
Message-Id: <20200102145552.1853992-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200102145552.1853992-1-arnd@arndb.de>
References: <20200102145552.1853992-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T0MtbbbNn4rNNb/Anyk65rw4LDZWytRlnVScu4W2i/Dg0nz4nlW
 pMqNaQCjZ7zhJDlD/BvC2guey0iURPwYaDKlZWmNNwucLt7t2s7CWwdnaJXO0qXRTJHUkir
 x+Wl2nqYmfKUrxFP/2/yeZYCEi+g4MYySOSGeyK7It38/Oz9W/WLrx7VsWCXCR4s6w/uQZ3
 xbj1olaPsNfgXVf40KEHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xQDwJs3SNtw=:Ne6Q6kaaP4dZ0JUaNyZ3ZQ
 uiWUxURhTQxVkBo5lzD1fieHmGc5cG97RTyD0UDseP3tMra1DZKJGxMYfeCOMsH+PDt6q8kda
 dFjMxQ9EoiQK5I+8X+KjsXL1USg7TdDg34sN69L91oaKOBs6olqzre2AeQhviL+6jZ0+HgiX8
 6aIRXOlqCmVRK4ysQWqgmmss0WUhRtPVv9kQ54U0Ce/3S5SF2wAVwwz1N8fVLKrpwWw1kr7d8
 dAfgbRenlw0EUtg/tbDox6jMAtV9G2d7pL+yOZEo9CP/kxgMNZOdxk8FvwqCRBnsTGqspj3yc
 Qbv759INyyYhk7Kl0tjNqpOC6UmjeVex885Fyb6r2QxbomASej4g62F+lWg9VGcnEBewhPO3i
 QYveh9IG2dMTLSEPIqh8SFtLGOVG6SSA0lHv9cThoCDGXGQYAH/DPwdr5EErVwidCB0YojgdI
 eoYnfe52syeSyqkGWhPIg6Z2TrINcWWkWXJ/xsQ+65DKlFrGzD29geIs2Hytv7deVFWpwb+dZ
 t1VNNtovQuvSidVN/i37unQVZ/NhuSaTF+1jz73qZjqAz/GMknGDpaDDIeX4gPUpccnt6AEbY
 66l66Dl8QkpP03Yk/SAMy2NjTdlNH4hJ3/b8qPPMTdmBWzT+DeROOq3/R/Jb+ZCARSoATOqVk
 YrDRYpz2ymfyVSHHHWZr+KceNcroJU52y3ExDnPj6UpdZVO9tKHcvx6VkpYxJimMSWHB9wXhS
 ZJsyNpAZx1cq3aZ7tiV+NNJRLQlOBioNwjXQApvoaVqxU/T2VhtGWUPQcvOUIGRxNlGFDlxj0
 wdY3dfJOO4W0ej9yD5d6OgKo3g1aTh85nCt8b8k6BixJOWmca2aOh62RpKI90Hd+qJND1szYX
 iW77BYAmhF4uMmdXJYlg==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is only one implementation of this ioctl, so move the handling out
of the common block layer code into the place where it's actually needed.

It also gets called indirectly through pktcdvd, which needs to be aware
of this change.

As I noticed, the old implementation of the compat handler failed to
convert the structure on the way out, so the updated fields never got
written back to user space. This is either not important, or it has
never worked and should be fixed now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/compat_ioctl.c    |  47 +---------
 block/scsi_ioctl.c      | 185 ++++++++++++++++++++++++++++------------
 drivers/block/pktcdvd.c |   6 +-
 3 files changed, 135 insertions(+), 103 deletions(-)

diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
index 3ed7a0f144a9..e34203f7d1cf 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -103,18 +103,6 @@ struct compat_cdrom_read_audio {
 	compat_caddr_t		buf;
 };
 
-struct compat_cdrom_generic_command {
-	unsigned char	cmd[CDROM_PACKET_SIZE];
-	compat_caddr_t	buffer;
-	compat_uint_t	buflen;
-	compat_int_t	stat;
-	compat_caddr_t	sense;
-	unsigned char	data_direction;
-	compat_int_t	quiet;
-	compat_int_t	timeout;
-	compat_caddr_t	reserved[1];
-};
-
 static int compat_cdrom_read_audio(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
@@ -142,38 +130,6 @@ static int compat_cdrom_read_audio(struct block_device *bdev, fmode_t mode,
 			(unsigned long)cdread_audio);
 }
 
-static int compat_cdrom_generic_command(struct block_device *bdev, fmode_t mode,
-		unsigned int cmd, unsigned long arg)
-{
-	struct cdrom_generic_command __user *cgc;
-	struct compat_cdrom_generic_command __user *cgc32;
-	u32 data;
-	unsigned char dir;
-	int itmp;
-
-	cgc = compat_alloc_user_space(sizeof(*cgc));
-	cgc32 = compat_ptr(arg);
-
-	if (copy_in_user(&cgc->cmd, &cgc32->cmd, sizeof(cgc->cmd)) ||
-	    get_user(data, &cgc32->buffer) ||
-	    put_user(compat_ptr(data), &cgc->buffer) ||
-	    copy_in_user(&cgc->buflen, &cgc32->buflen,
-			 (sizeof(unsigned int) + sizeof(int))) ||
-	    get_user(data, &cgc32->sense) ||
-	    put_user(compat_ptr(data), &cgc->sense) ||
-	    get_user(dir, &cgc32->data_direction) ||
-	    put_user(dir, &cgc->data_direction) ||
-	    get_user(itmp, &cgc32->quiet) ||
-	    put_user(itmp, &cgc->quiet) ||
-	    get_user(itmp, &cgc32->timeout) ||
-	    put_user(itmp, &cgc->timeout) ||
-	    get_user(data, &cgc32->reserved[0]) ||
-	    put_user(compat_ptr(data), &cgc->reserved[0]))
-		return -EFAULT;
-
-	return __blkdev_driver_ioctl(bdev, mode, cmd, (unsigned long)cgc);
-}
-
 struct compat_blkpg_ioctl_arg {
 	compat_int_t op;
 	compat_int_t flags;
@@ -225,8 +181,6 @@ static int compat_blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
 		return compat_hdio_ioctl(bdev, mode, cmd, arg);
 	case CDROMREADAUDIO:
 		return compat_cdrom_read_audio(bdev, mode, cmd, arg);
-	case CDROM_SEND_PACKET:
-		return compat_cdrom_generic_command(bdev, mode, cmd, arg);
 
 	/*
 	 * No handler required for the ones below, we just need to
@@ -264,6 +218,7 @@ static int compat_blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
 	case CDROM_DISC_STATUS:
 	case CDROM_CHANGER_NSLOTS:
 	case CDROM_GET_CAPABILITY:
+	case CDROM_SEND_PACKET:
 	/* Ignore cdrom.h about these next 5 ioctls, they absolutely do
 	 * not take a struct cdrom_read, instead they take a struct cdrom_msf
 	 * which is compatible.
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index b61dbf4d8443..b4e73d5dd5c2 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -639,6 +639,136 @@ int get_sg_io_hdr(struct sg_io_hdr *hdr, const void __user *argp)
 }
 EXPORT_SYMBOL(get_sg_io_hdr);
 
+#ifdef CONFIG_COMPAT
+struct compat_cdrom_generic_command {
+	unsigned char	cmd[CDROM_PACKET_SIZE];
+	compat_caddr_t	buffer;
+	compat_uint_t	buflen;
+	compat_int_t	stat;
+	compat_caddr_t	sense;
+	unsigned char	data_direction;
+	compat_int_t	quiet;
+	compat_int_t	timeout;
+	compat_caddr_t	reserved[1];
+};
+#endif
+
+static int scsi_get_cdrom_generic_arg(struct cdrom_generic_command *cgc,
+				      const void __user *arg)
+{
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall()) {
+		struct compat_cdrom_generic_command cgc32;
+
+		if (copy_from_user(&cgc32, arg, sizeof(cgc32)))
+			return -EFAULT;
+
+		*cgc = (struct cdrom_generic_command) {
+			.buffer		= compat_ptr(cgc32.buffer),
+			.buflen		= cgc32.buflen,
+			.stat		= cgc32.stat,
+			.sense		= compat_ptr(cgc32.sense),
+			.data_direction	= cgc32.data_direction,
+			.quiet		= cgc32.quiet,
+			.timeout	= cgc32.timeout,
+			.reserved[0]	= compat_ptr(cgc32.reserved[0]),
+		};
+		memcpy(&cgc->cmd, &cgc32.cmd, CDROM_PACKET_SIZE);
+		return 0;
+	}
+#endif
+	if (copy_from_user(cgc, arg, sizeof(*cgc)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int scsi_put_cdrom_generic_arg(const struct cdrom_generic_command *cgc,
+				      void __user *arg)
+{
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall()) {
+		struct compat_cdrom_generic_command cgc32 = {
+			.buffer		= (uintptr_t)(cgc->buffer),
+			.buflen		= cgc->buflen,
+			.stat		= cgc->stat,
+			.sense		= (uintptr_t)(cgc->sense),
+			.data_direction	= cgc->data_direction,
+			.quiet		= cgc->quiet,
+			.timeout	= cgc->timeout,
+			.reserved[0]	= (uintptr_t)(cgc->reserved[0]),
+		};
+		memcpy(&cgc32.cmd, &cgc->cmd, CDROM_PACKET_SIZE);
+
+		if (copy_to_user(arg, &cgc32, sizeof(cgc32)))
+			return -EFAULT;
+
+		return 0;
+	}
+#endif
+	if (copy_to_user(arg, cgc, sizeof(*cgc)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int scsi_cdrom_send_packet(struct request_queue *q,
+				  struct gendisk *bd_disk,
+				  fmode_t mode, void __user *arg)
+{
+	struct cdrom_generic_command cgc;
+	struct sg_io_hdr hdr;
+	int err;
+
+	err = scsi_get_cdrom_generic_arg(&cgc, arg);
+	if (err)
+		return err;
+
+	cgc.timeout = clock_t_to_jiffies(cgc.timeout);
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.interface_id = 'S';
+	hdr.cmd_len = sizeof(cgc.cmd);
+	hdr.dxfer_len = cgc.buflen;
+	switch (cgc.data_direction) {
+		case CGC_DATA_UNKNOWN:
+			hdr.dxfer_direction = SG_DXFER_UNKNOWN;
+			break;
+		case CGC_DATA_WRITE:
+			hdr.dxfer_direction = SG_DXFER_TO_DEV;
+			break;
+		case CGC_DATA_READ:
+			hdr.dxfer_direction = SG_DXFER_FROM_DEV;
+			break;
+		case CGC_DATA_NONE:
+			hdr.dxfer_direction = SG_DXFER_NONE;
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	hdr.dxferp = cgc.buffer;
+	hdr.sbp = cgc.sense;
+	if (hdr.sbp)
+		hdr.mx_sb_len = sizeof(struct request_sense);
+	hdr.timeout = jiffies_to_msecs(cgc.timeout);
+	hdr.cmdp = ((struct cdrom_generic_command __user*) arg)->cmd;
+	hdr.cmd_len = sizeof(cgc.cmd);
+
+	err = sg_io(q, bd_disk, &hdr, mode);
+	if (err == -EFAULT)
+		return -EFAULT;
+
+	if (hdr.status)
+		return -EIO;
+
+	cgc.stat = err;
+	cgc.buflen = hdr.resid;
+	if (scsi_put_cdrom_generic_arg(&cgc, arg))
+		return -EFAULT;
+
+	return err;
+}
+
 int scsi_cmd_ioctl(struct request_queue *q, struct gendisk *bd_disk, fmode_t mode,
 		   unsigned int cmd, void __user *arg)
 {
@@ -689,60 +819,9 @@ int scsi_cmd_ioctl(struct request_queue *q, struct gendisk *bd_disk, fmode_t mod
 				err = -EFAULT;
 			break;
 		}
-		case CDROM_SEND_PACKET: {
-			struct cdrom_generic_command cgc;
-			struct sg_io_hdr hdr;
-
-			err = -EFAULT;
-			if (copy_from_user(&cgc, arg, sizeof(cgc)))
-				break;
-			cgc.timeout = clock_t_to_jiffies(cgc.timeout);
-			memset(&hdr, 0, sizeof(hdr));
-			hdr.interface_id = 'S';
-			hdr.cmd_len = sizeof(cgc.cmd);
-			hdr.dxfer_len = cgc.buflen;
-			err = 0;
-			switch (cgc.data_direction) {
-				case CGC_DATA_UNKNOWN:
-					hdr.dxfer_direction = SG_DXFER_UNKNOWN;
-					break;
-				case CGC_DATA_WRITE:
-					hdr.dxfer_direction = SG_DXFER_TO_DEV;
-					break;
-				case CGC_DATA_READ:
-					hdr.dxfer_direction = SG_DXFER_FROM_DEV;
-					break;
-				case CGC_DATA_NONE:
-					hdr.dxfer_direction = SG_DXFER_NONE;
-					break;
-				default:
-					err = -EINVAL;
-			}
-			if (err)
-				break;
-
-			hdr.dxferp = cgc.buffer;
-			hdr.sbp = cgc.sense;
-			if (hdr.sbp)
-				hdr.mx_sb_len = sizeof(struct request_sense);
-			hdr.timeout = jiffies_to_msecs(cgc.timeout);
-			hdr.cmdp = ((struct cdrom_generic_command __user*) arg)->cmd;
-			hdr.cmd_len = sizeof(cgc.cmd);
-
-			err = sg_io(q, bd_disk, &hdr, mode);
-			if (err == -EFAULT)
-				break;
-
-			if (hdr.status)
-				err = -EIO;
-
-			cgc.stat = err;
-			cgc.buflen = hdr.resid;
-			if (copy_to_user(arg, &cgc, sizeof(cgc)))
-				err = -EFAULT;
-
+		case CDROM_SEND_PACKET:
+			err = scsi_cdrom_send_packet(q, bd_disk, mode, arg);
 			break;
-		}
 
 		/*
 		 * old junk scsi send command ioctl
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 861fc65a1b75..ab4d3be4b646 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2671,15 +2671,13 @@ static int pkt_compat_ioctl(struct block_device *bdev, fmode_t mode, unsigned in
 	case CDROMEJECT:
 	case CDROMMULTISESSION:
 	case CDROMREADTOCENTRY:
+	case CDROM_SEND_PACKET: /* compat mode handled in scsi_cmd_ioctl */
 	case SCSI_IOCTL_SEND_COMMAND:
 		return pkt_ioctl(bdev, mode, cmd, (unsigned long)compat_ptr(arg));
 
-
 	/* FIXME: no handler so far */
-	case CDROM_LAST_WRITTEN:
-	/* handled in compat_blkdev_driver_ioctl */
-	case CDROM_SEND_PACKET:
 	default:
+	case CDROM_LAST_WRITTEN:
 		return -ENOIOCTLCMD;
 	}
 }
-- 
2.20.0

