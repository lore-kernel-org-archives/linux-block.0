Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED268C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53A3222C4
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfLKUqN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:46:13 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:54809 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfLKUqH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 15:46:07 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MO9vD-1iKzPs165J-00OU2W; Wed, 11 Dec 2019 21:45:21 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Martin Wilck <mwilck@suse.com>
Subject: [PATCH 08/24] compat_ioctl: move CDROM_SEND_PACKET handling into scsi
Date:   Wed, 11 Dec 2019 21:42:42 +0100
Message-Id: <20191211204306.1207817-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191211204306.1207817-1-arnd@arndb.de>
References: <20191211204306.1207817-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T9YafS4Y5YdpmurpT0bF6+4sbIuel2ibFF2FSIKvxx5hotg9jpx
 gpb9EGkrCvb5mTBd03vG9GRI3caFpeQHTodhTU8m1iUDy84RzO/uWY8gk2vbA6MzIpJAwO3
 /rudggSeJ4PhGSjx0xcF0kQBQm8vpu0E//s3mtVRDN+aQz0V5eJ3tPWU1oeYY/aUvjgcatF
 qRhFkz/tUwaR8xIEr6R9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RKPMK4n3QW8=:+BvTC9yynSn32rTUD6Fm3I
 06HHnAhgSO4ExRPzrlKj18jH7CGbz9a95Le1wRutYE3vjIVovOAEnKT8a3aZ7OEqTHznepmSA
 7K8++CEcbgfDjarB609ju63go2ttSC6cMPRdz62MNimbftrJsrzE1TWaAumP/+b3T8g0qKWt7
 QcWTiIhX7sTPprF6MdfkBNUo6nQzjD5HSDUZCaA+DbzkS0e6bn2lvNhysouUsE+9AMa+nF8DU
 FO7NCyioHdkV8bMF9qhsWzL+GE/M8qwpLKWbiAUSH+BR+itVACnT4+M5U5KVxktWoGrt+4+Et
 gJp1o9eGj+hMxnKfMDkGCo9/SNgEjxERTszDn0dY1v9Hp8xCD0Lwtn6Uv/s7mZwQGF45KV6rL
 xZgk1TjHgDHDye5RHoh0e+4kJEKXA2vkbF4xqyijzrHlfgfCzkhhjNpSXnSmxHGU+UCiMflDM
 C+xNkEfm63qmi0doNwq78TRq7LgXnlbc6L5oCw4j/cc1mCq1MGv04aCNEDD2+TXcGJEz5XY8Q
 4snbzIfdWWKssaUl7UR4CY8F1HGL6sz75v22nNr7O6OSxyPlBFSH7VAkK+6d2bsb/zYu6Ne9p
 iE1f9g8gj7O2GK0wE1lTIp77NQ1KZW6DlquGLiOziSyL6vMuzYGKYcp/zEmpvLdYNSGn+Ki8g
 sJD3W8ifzhpj5nm19n/VuPpxFB/6dITjGhb0X25JzN+cigEQnI52cEAbrKycTROerSAXudApw
 zzIZg+7KKCi9kgG2nJ+o5xarNSZ5hKM7F09BILVKoOO6FwKfcAeCvRBS6Xxw4VMZkpYReonUn
 ZWCGxKkhQeGPnuFanX0w6iQ8c53UC4hGFErTIy81otoBekO4OIPUX+ebqp5XE5lEntoGTU6cE
 z801MArhGTGAKoEKdjAQ==
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
index f16ae92065d7..578e04f94619 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -102,18 +102,6 @@ struct compat_cdrom_read_audio {
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
@@ -141,38 +129,6 @@ static int compat_cdrom_read_audio(struct block_device *bdev, fmode_t mode,
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
@@ -224,8 +180,6 @@ static int compat_blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
 		return compat_hdio_ioctl(bdev, mode, cmd, arg);
 	case CDROMREADAUDIO:
 		return compat_cdrom_read_audio(bdev, mode, cmd, arg);
-	case CDROM_SEND_PACKET:
-		return compat_cdrom_generic_command(bdev, mode, cmd, arg);
 
 	/*
 	 * No handler required for the ones below, we just need to
@@ -263,6 +217,7 @@ static int compat_blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
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

