Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A36C3A6F03
	for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323704; cv=none; b=AFU73qkEToT8UokFAqMB/0UPs9ajYW1Kld1dqG7YVmH1fIo6dbPoMxe7A6ayr54RnmeSALhRpTtIBV6N+DgL6DgkRaAlCr8SCT2jVi5QQI7qnUVFC2rCd/oUH8wlP/Oj2hfWi/h6WE7CaxA5CzNOXxLiChxVRyEhUu7eHUGeeXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323704; c=relaxed/simple;
	bh=DMYo8c5VzwVanI6pDlbRSD1fqI8VAID5eX77Y8Vew3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHmh14YCjfGBLj56572VpibyPLLBHRBd3wRjo3bIb4tiOFyL8k3wcisT6cpyuCUTk2K2jbJY7xwzVdexA5KfrmtbVi4w/Ywmrbyi+NF9jmhXz+I1T+CLKU3J5sqAp7Um/QNVRHsPm9F0LfR4w1PsIx3y+T4mGWTROF/R4ZMpPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b=g1OEd0HP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b="g1OEd0HP"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b0046078so97447855e9.1
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 14:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20251104.gappssmtp.com; s=20251104; t=1777323701; x=1777928501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wA+yuz7SrZYQ4SsuCPpdAHGvtFDl3R8DObMuYOnhTA=;
        b=g1OEd0HP6y78aI0YTwA6jNVpWunI6+uG8yeKHKF5JlWymbxV7VEPSmHj7hAFuSuXBx
         WwC5BGteJRTkf85Bsh0/Vau0dkQguE+w13cdoGKaf2FN8c6vZLsh/I5KCE9B3tQ7zmgQ
         x4w3PSjp/DtWJRScPS3v2g8ciy4FoGgoX2+f4wanOg7H9fel8CgEKImXCrmaPWHE5suZ
         /8JrfVsHGAJJ65vMkQLKisaw87gGA7O6muo1GZ4HemhKDfv6TLwGkmGYhDDfnYFHNsi9
         qMEHu/4/z+us2H7UrbtjRtiQkpof3iXSe/XHl5zaf9M7bcdblzatQ9P7jNviMH4BYIav
         94iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777323701; x=1777928501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2wA+yuz7SrZYQ4SsuCPpdAHGvtFDl3R8DObMuYOnhTA=;
        b=My8xyeJ8yQlEoRS3asx8SbMGbOuExsJcxt2J+e4v6R46SIIVOy9uL6gCsVivkNuJrN
         Dofsf63A8t+l6IIY8G6L0Pd/onNdkont9/RjW66iq+7NDWvZlcKwMLbjdG8+yOEV/8DG
         KvceoeqmJlTQiowVZR+ju/XKu3i7FX+Nhh7Idrz8aC0O3Q+foi6rVau2PMKQIEJugJkl
         Bm0jvaCZ569WaBjfWNlYDBA4DgPL8YxO/FyYEyetyd3wQxR3STJcx73c9bPKFbBb3ewC
         pwMCx16GbHLZHYGGTnRguUL2HdCWfBDwfMBloBYNXeOxW303WnySl63NvsIjgtYmeRr2
         MVJQ==
X-Gm-Message-State: AOJu0YzkUb/ja327WmKUEBcNkolMleTT+lNytRm8NCoCPgk8ieiCaxQz
	ipnZQiqYIu/lpu/O55f1IfOIho/yL54TBfJx+F21D8rgBkNn+N+5Ysq1Q7O5gPDqP/oVgxnDkzo
	akyai
X-Gm-Gg: AeBDies1qjdN32GOPDx1LPRjEwtRi9vOuWhXXAvfTmNBvSG/c1cPdOjBRNStjIL3zyS
	00cJpRIk5mj7OAy/hXurptquitE+ggHFwwjk827CvDvnJCCPq7Zl65qOEEmqD9JTZxKFQVUF2ir
	jw1tZbPlGAXSfdyBUztA3oCmjLoDljGHHmnsVkR/tF3gZpFWKxMPmt7H/xEhzTbg8dVRljL6/pm
	SDgYEANBksV88cpd3yiy6Y+pb31PDJ/0fqFwugJgrXZJXNqW9bKaBFVTRrbDOLmn34WHxsYlWGt
	3I6no9gbRUeljJZS9PHqKx3HOOey3w3UZplwLAtYCWm1+NV2kWqgAZfdydPNgHA8FgNWL34BRPD
	GtCcJJqx5xE62FH82XbU9cD/mgbeWLdgfvvWHpGx6IB9mDFxuv2nXVl94LKTsC0qx86rm91Me3q
	0Xl9YyVih5cj/vt8Fsem4p70KluMOKpGzdUgbdf0J/orgAEQ+sZEfPI535Pt+XreexM2ErSgR6O
	KHuqr3I4qMVb2SlJnbQ5Q==
X-Received: by 2002:a5d:64e6:0:b0:43d:7a97:78c0 with SMTP id ffacd0b85a97d-4464aa092d7mr688887f8f.36.1777323700929;
        Mon, 27 Apr 2026 14:01:40 -0700 (PDT)
Received: from KernelVM (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463cb59e65sm1165027f8f.1.2026.04.27.14.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:01:40 -0700 (PDT)
From: Phillip Potter <phil@philpotter.co.uk>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	daan@amutable.com
Subject: [PATCH 1/1] cdrom, scsi: sr: propagate read-only status to block layer via set_disk_ro()
Date: Mon, 27 Apr 2026 22:01:39 +0100
Message-ID: <20260427210139.1400-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427210139.1400-1-phil@philpotter.co.uk>
References: <20260427210139.1400-1-phil@philpotter.co.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daan De Meyer <daan@amutable.com>

The cdrom core never calls set_disk_ro() for a registered device, so
BLKROGET on a CD-ROM device always returns 0 (writable), even when the
drive has no write capabilities and writes will inevitably fail. This
causes problems for userspace that relies on BLKROGET to determine
whether a block device is read-only. For example, systemd's loop device
setup uses BLKROGET to decide whether to create a loop device with
LO_FLAGS_READ_ONLY. Without the read-only flag, writes pass through the
loop device to the CD-ROM and fail with I/O errors. systemd-fsck
similarly checks BLKROGET to decide whether to run fsck in no-repair
mode (-n).

The write-capability bits in cdi->mask come from two different sources:
CDC_DVD_RAM and CDC_CD_RW are populated by the driver from the MODE
SENSE capabilities page (page 0x2A) before register_cdrom() is called,
while CDC_MRW_W and CDC_RAM require the MMC GET CONFIGURATION command
and were only probed by cdrom_open_write() at device open time. This
meant that any attempt to compute the writable state from the full
mask at probe time was incorrect, because the GET CONFIGURATION bits
were still unset (and cdi->mask is initialized such that capabilities
are assumed present).

Fix this by factoring the GET CONFIGURATION probing out of
cdrom_open_write() into a new exported helper,
cdrom_probe_write_features(), and having sr call it from sr_probe()
right after get_capabilities() has populated the MODE SENSE bits.
register_cdrom() then calls set_disk_ro() based on the full
write-capability mask (CDC_DVD_RAM | CDC_MRW_W | CDC_RAM | CDC_CD_RW)
so the block layer reflects the drive's actual write support. The
feature queries used (CDF_MRW and CDF_RWRT via GET CONFIGURATION with
RT=00) report drive-level capabilities that are persistent across
media, so a single probe before register_cdrom() is sufficient and the
redundant probe at open time is dropped.

With set_disk_ro() now accurate, the long-vestigial cd->writeable flag
in sr can go: get_capabilities() used to set cd->writeable based on
the same four mask bits, but because CDC_MRW_W and CDC_RAM default to
"capability present" in cdi->mask and aren't touched by MODE SENSE,
the condition that gated cd->writeable was always true, making it
unconditionally 1. Replace the corresponding gate in sr_init_command()
with get_disk_ro(cd->disk), which turns a previously no-op check into
a real one and also catches kernel-internal bio writers that bypass
blkdev_write_iter()'s bdev_read_only() check.

The sd driver (SCSI disks) does not have this problem because it
checks the MODE SENSE Write Protect bit and calls set_disk_ro()
accordingly. The sr driver cannot use the same approach because the
MMC specification does not define the WP bit in the MODE SENSE
device-specific parameter byte for CD-ROM devices.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Daan De Meyer <daan@amutable.com>
Link: https://lore.kernel.org/all/20260422113206.246267-1-daan@amutable.com
Reviewed-by: Phillip Potter <phil@philpotter.co.uk>
Link: https://lore.kernel.org/all/ae59luYMh6npxD09@equinox
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Link: https://lore.kernel.org/all/yq1jytti447.fsf@ca-mkp.ca.oracle.com
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/cdrom/cdrom.c | 73 ++++++++++++++++++++++++++++---------------
 drivers/scsi/sr.c     | 11 ++-----
 drivers/scsi/sr.h     |  1 -
 include/linux/cdrom.h |  1 +
 4 files changed, 51 insertions(+), 35 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index fc049612d6dc..62934cf4b10d 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -631,6 +631,16 @@ int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi)
 
 	WARN_ON(!cdo->generic_packet);
 
+	/*
+	 * Propagate the drive's write support to the block layer so BLKROGET
+	 * reflects actual write capability. Drivers that use GET CONFIGURATION
+	 * features (CDC_MRW_W, CDC_RAM) must have called
+	 * cdrom_probe_write_features() before register_cdrom() so the mask is
+	 * complete here.
+	 */
+	set_disk_ro(disk, !CDROM_CAN(CDC_DVD_RAM | CDC_MRW_W | CDC_RAM |
+				     CDC_CD_RW));
+
 	cd_dbg(CD_REG_UNREG, "drive \"/dev/%s\" registered\n", cdi->name);
 	mutex_lock(&cdrom_mutex);
 	list_add(&cdi->list, &cdrom_list);
@@ -742,6 +752,44 @@ static int cdrom_is_random_writable(struct cdrom_device_info *cdi, int *write)
 	return 0;
 }
 
+/*
+ * Probe write-related MMC features via GET CONFIGURATION and update
+ * cdi->mask accordingly. Drivers that populate cdi->mask from the MODE SENSE
+ * capabilities page (e.g. sr) should call this after those MODE SENSE bits
+ * have been set but before register_cdrom(), so that the full set of
+ * write-capability bits is known by the time register_cdrom() decides on the
+ * initial read-only state of the disk.
+ */
+void cdrom_probe_write_features(struct cdrom_device_info *cdi)
+{
+	int mrw, mrw_write, ram_write;
+
+	mrw = 0;
+	if (!cdrom_is_mrw(cdi, &mrw_write))
+		mrw = 1;
+
+	if (CDROM_CAN(CDC_MO_DRIVE))
+		ram_write = 1;
+	else
+		(void) cdrom_is_random_writable(cdi, &ram_write);
+
+	if (mrw)
+		cdi->mask &= ~CDC_MRW;
+	else
+		cdi->mask |= CDC_MRW;
+
+	if (mrw_write)
+		cdi->mask &= ~CDC_MRW_W;
+	else
+		cdi->mask |= CDC_MRW_W;
+
+	if (ram_write)
+		cdi->mask &= ~CDC_RAM;
+	else
+		cdi->mask |= CDC_RAM;
+}
+EXPORT_SYMBOL(cdrom_probe_write_features);
+
 static int cdrom_media_erasable(struct cdrom_device_info *cdi)
 {
 	disc_information di;
@@ -894,33 +942,8 @@ static int cdrom_is_dvd_rw(struct cdrom_device_info *cdi)
  */
 static int cdrom_open_write(struct cdrom_device_info *cdi)
 {
-	int mrw, mrw_write, ram_write;
 	int ret = 1;
 
-	mrw = 0;
-	if (!cdrom_is_mrw(cdi, &mrw_write))
-		mrw = 1;
-
-	if (CDROM_CAN(CDC_MO_DRIVE))
-		ram_write = 1;
-	else
-		(void) cdrom_is_random_writable(cdi, &ram_write);
-	
-	if (mrw)
-		cdi->mask &= ~CDC_MRW;
-	else
-		cdi->mask |= CDC_MRW;
-
-	if (mrw_write)
-		cdi->mask &= ~CDC_MRW_W;
-	else
-		cdi->mask |= CDC_MRW_W;
-
-	if (ram_write)
-		cdi->mask &= ~CDC_RAM;
-	else
-		cdi->mask |= CDC_RAM;
-
 	if (CDROM_CAN(CDC_MRW_W))
 		ret = cdrom_mrw_open_write(cdi);
 	else if (CDROM_CAN(CDC_DVD_RAM))
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 7adb2573f50d..c36c54ecd354 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -395,7 +395,7 @@ static blk_status_t sr_init_command(struct scsi_cmnd *SCpnt)
 
 	switch (req_op(rq)) {
 	case REQ_OP_WRITE:
-		if (!cd->writeable)
+		if (get_disk_ro(cd->disk))
 			goto out;
 		SCpnt->cmnd[0] = WRITE_10;
 		cd->cdi.media_written = 1;
@@ -681,6 +681,7 @@ static int sr_probe(struct scsi_device *sdev)
 	error = -ENOMEM;
 	if (get_capabilities(cd))
 		goto fail_minor;
+	cdrom_probe_write_features(&cd->cdi);
 	sr_vendor_init(cd);
 
 	set_capacity(disk, cd->capacity);
@@ -899,14 +900,6 @@ static int get_capabilities(struct scsi_cd *cd)
 	/*else    I don't think it can close its tray
 		cd->cdi.mask |= CDC_CLOSE_TRAY; */
 
-	/*
-	 * if DVD-RAM, MRW-W or CD-RW, we are randomly writable
-	 */
-	if ((cd->cdi.mask & (CDC_DVD_RAM | CDC_MRW_W | CDC_RAM | CDC_CD_RW)) !=
-			(CDC_DVD_RAM | CDC_MRW_W | CDC_RAM | CDC_CD_RW)) {
-		cd->writeable = 1;
-	}
-
 	kfree(buffer);
 	return 0;
 }
diff --git a/drivers/scsi/sr.h b/drivers/scsi/sr.h
index dc899277b3a4..2d92f9cb6fec 100644
--- a/drivers/scsi/sr.h
+++ b/drivers/scsi/sr.h
@@ -35,7 +35,6 @@ typedef struct scsi_cd {
 	struct scsi_device *device;
 	unsigned int vendor;	/* vendor code, see sr_vendor.c         */
 	unsigned long ms_offset;	/* for reading multisession-CD's        */
-	unsigned writeable : 1;
 	unsigned use:1;		/* is this device still supportable     */
 	unsigned xa_flag:1;	/* CD has XA sectors ? */
 	unsigned readcd_known:1;	/* drive supports READ_CD (0xbe) */
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index b907e6c2307d..260d7968cf72 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -108,6 +108,7 @@ int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
 extern unsigned int cdrom_check_events(struct cdrom_device_info *cdi,
 				       unsigned int clearing);
 
+extern void cdrom_probe_write_features(struct cdrom_device_info *cdi);
 extern int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi);
 extern void unregister_cdrom(struct cdrom_device_info *cdi);
 
-- 
2.53.0

