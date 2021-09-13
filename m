Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0847BC4167B
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 23:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04E861222
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 23:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343562AbhIMXMT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 19:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349296AbhIMXLW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 19:11:22 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3B6C061760
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 16:09:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u15so11026083wru.6
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 16:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/kEzwIDg6GDAUXvVP4/yOeSqg1VEdFGil0UW15RiAf8=;
        b=Up+/HUSzB+pEHTVOOHwBb6ETThDZoEB3MKssm3yHtgySbOJmzYhGnZWwBCMUjOtkOm
         69KM898Vo+zqFLb3Q9yoiokJgYNjKxkodRuh9qJ+Gg0/5HKqxk500DNs+qZXN7xiDaNs
         3p/JdZGFpO4NGJprZrQ/XcEg1BkU/Lf2QmfTY+gIg4It8ewWnb7dXTYCzr3uAXQRcsQG
         CUoOxFZIhdsUU8E2K9wXaCfiJrHCN7U6PXiWH/ixyxDFF/kpuK1dZDCdzsuPhqX8VKzg
         MVNWY5RtsNlf3LK7AWSgX1r990/ovGroqYHvVgOVpKpWMZW6ebmraDHrt51ULbZdIGm5
         dEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/kEzwIDg6GDAUXvVP4/yOeSqg1VEdFGil0UW15RiAf8=;
        b=kUDrhDK2/OXyscNoc5IqyvsKQNxWLU/zIPWk/qL1/Q0arLoEGEyseW4kSCb1xf9mAW
         5WISACeCOGRGgqkDNcVUyhvKLRc1bR2R8Feoaco3W6fDVu7Jj/4UXzVOQUAulbKur0/g
         C883M9oUAgdVX22iFUGSFx7HLZF8O/gymAN7cEGptzItYpglw5FIRUhYIO7IOWUFyCxo
         v04SHeY4ZV7aFg8UfdoxdfZphzO/0y0ITo+zQhIVfoWA63h6YjfKNLlZQMTibVRYF5Bq
         ds2JWNT3KphgGXxiubDMCwTI5ahAwBmtIhnxB4uflwyM1wZrpKshgpTuOCzbV1P8+6Cw
         bdjA==
X-Gm-Message-State: AOAM5336kc9XvxnB4n/FRm49v4vdQw9W0/9z9hBu/n7YMOGqQKnrCeFq
        PDPYpJkOg+5H2WswKCobqZ5JS6jZvRLsLg==
X-Google-Smtp-Source: ABdhPJydPYwBU4Wnxq3od2wtwWxdqGJZfJGlmTG8KzE1GRjjzYmqT8gw6MTGNkO36yWYL6ot3VnHoQ==
X-Received: by 2002:adf:e408:: with SMTP id g8mr15386500wrm.138.1631574583802;
        Mon, 13 Sep 2021 16:09:43 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id q7sm5299621wrr.10.2021.09.13.16.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 16:09:43 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v3] drivers/cdrom: improved ioctl for media change detection
Date:   Tue, 14 Sep 2021 00:09:42 +0100
Message-Id: <20210913230942.1188-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Lukas Prediger <lumip@lumip.de>

The current implementation of the CDROM_MEDIA_CHANGED ioctl relies on
global state, meaning that only one process can detect a disc change
while the ioctl call will return 0 for other calling processes afterwards
(see bug 213267).

This introduces a new cdrom ioctl, CDROM_TIMED_MEDIA_CHANGE, that
works by maintaining a timestamp of the last detected disc change instead
of a boolean flag: Processes calling this ioctl command can provide
a timestamp of the last disc change known to them and receive
an indication whether the disc was changed since then and the updated
timestamp.

I considered fixing the buggy behavior in the original
CDROM_MEDIA_CHANGED ioctl but that would require maintaining state
for each calling process in the kernel, which seems like a worse
solution than introducing this new ioctl.

Signed-off-by: Lukas Prediger <lumip@lumip.de>
Link: https://lore.kernel.org/all/20210912191207.74449-1-lumip@lumip.de
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 Documentation/cdrom/cdrom-standard.rst      | 11 ++++
 Documentation/userspace-api/ioctl/cdrom.rst |  3 ++
 drivers/cdrom/cdrom.c                       | 59 +++++++++++++++++++--
 include/linux/cdrom.h                       |  1 +
 include/uapi/linux/cdrom.h                  | 19 +++++++
 5 files changed, 89 insertions(+), 4 deletions(-)

diff --git a/Documentation/cdrom/cdrom-standard.rst b/Documentation/cdrom/cdrom-standard.rst
index 5845960ca382..52ea7b6b2fe8 100644
--- a/Documentation/cdrom/cdrom-standard.rst
+++ b/Documentation/cdrom/cdrom-standard.rst
@@ -907,6 +907,17 @@ commands can be identified by the underscores in their names.
 	specifies the slot for which the information is given. The special
 	value *CDSL_CURRENT* requests that information about the currently
 	selected slot be returned.
+`CDROM_TIMED_MEDIA_CHANGE`
+	Checks whether the disc has been changed since a user supplied time
+	and returns the time of the last disc change.
+
+	*arg* is a pointer to a *cdrom_timed_media_change_info* struct.
+	*arg->last_media_change* may be set by calling code to signal
+	the timestamp of the last known media change (by the caller).
+	Upon successful return, this ioctl call will set
+	*arg->last_media_change* to the latest media change timestamp (in ms)
+	known by the kernel/driver and set *arg->has_changed* to 1 if
+	that timestamp is more recent than the timestamp set by the caller.
 `CDROM_DRIVE_STATUS`
 	Returns the status of the drive by a call to
 	*drive_status()*. Return values are defined in cdrom_drive_status_.
diff --git a/Documentation/userspace-api/ioctl/cdrom.rst b/Documentation/userspace-api/ioctl/cdrom.rst
index 3b4c0506de46..bac5bbf93ca0 100644
--- a/Documentation/userspace-api/ioctl/cdrom.rst
+++ b/Documentation/userspace-api/ioctl/cdrom.rst
@@ -54,6 +54,9 @@ are as follows:
 	CDROM_SELECT_SPEED	Set the CD-ROM speed
 	CDROM_SELECT_DISC	Select disc (for juke-boxes)
 	CDROM_MEDIA_CHANGED	Check is media changed
+	CDROM_TIMED_MEDIA_CHANGE	Check if media changed
+					since given time
+					(struct cdrom_timed_media_change_info)
 	CDROM_DRIVE_STATUS	Get tray position, etc.
 	CDROM_DISC_STATUS	Get disc type, etc.
 	CDROM_CHANGER_NSLOTS	Get number of slots
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index bd2e5b1560f5..89a68457820a 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -344,6 +344,12 @@ static void cdrom_sysctl_register(void);
 
 static LIST_HEAD(cdrom_list);
 
+static void signal_media_change(struct cdrom_device_info *cdi)
+{
+	cdi->mc_flags = 0x3; /* set media changed bits, on both queues */
+	cdi->last_media_change_ms = ktime_to_ms(ktime_get());
+}
+
 int cdrom_dummy_generic_packet(struct cdrom_device_info *cdi,
 			       struct packet_command *cgc)
 {
@@ -616,6 +622,7 @@ int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi)
 	ENSURE(cdo, generic_packet, CDC_GENERIC_PACKET);
 	cdi->mc_flags = 0;
 	cdi->options = CDO_USE_FFLAGS;
+	cdi->last_media_change_ms = ktime_to_ms(ktime_get());
 
 	if (autoclose == 1 && CDROM_CAN(CDC_CLOSE_TRAY))
 		cdi->options |= (int) CDO_AUTO_CLOSE;
@@ -1421,8 +1428,7 @@ static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
 		cdi->ops->check_events(cdi, 0, slot);
 
 	if (slot == CDSL_NONE) {
-		/* set media changed bits, on both queues */
-		cdi->mc_flags = 0x3;
+		signal_media_change(cdi);
 		return cdrom_load_unload(cdi, -1);
 	}
 
@@ -1455,7 +1461,7 @@ static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
 		slot = curslot;
 
 	/* set media changed bits on both queues */
-	cdi->mc_flags = 0x3;
+	signal_media_change(cdi);
 	if ((ret = cdrom_load_unload(cdi, slot)))
 		return ret;
 
@@ -1521,7 +1527,7 @@ int media_changed(struct cdrom_device_info *cdi, int queue)
 	cdi->ioctl_events = 0;
 
 	if (changed) {
-		cdi->mc_flags = 0x3;    /* set bit on both queues */
+		signal_media_change(cdi);
 		ret |= 1;
 		cdi->media_written = 0;
 	}
@@ -2336,6 +2342,49 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
 	return ret;
 }
 
+/*
+ * Media change detection with timing information.
+ *
+ * arg is a pointer to a cdrom_timed_media_change_info struct.
+ * arg->last_media_change may be set by calling code to signal
+ * the timestamp (in ms) of the last known media change (by the caller).
+ * Upon successful return, ioctl call will set arg->last_media_change
+ * to the latest media change timestamp known by the kernel/driver
+ * and set arg->has_changed to 1 if that timestamp is more recent
+ * than the timestamp set by the caller.
+ */
+static int cdrom_ioctl_timed_media_change(struct cdrom_device_info *cdi,
+		unsigned long arg)
+{
+	int ret;
+	struct cdrom_timed_media_change_info __user *info;
+	struct cdrom_timed_media_change_info tmp_info;
+
+	if (!CDROM_CAN(CDC_MEDIA_CHANGED))
+		return -ENOSYS;
+
+	info = (struct cdrom_timed_media_change_info __user *)arg;
+	cd_dbg(CD_DO_IOCTL, "entering CDROM_TIMED_MEDIA_CHANGE\n");
+
+	ret = cdrom_ioctl_media_changed(cdi, CDSL_CURRENT);
+	if (ret < 0)
+		return ret;
+
+	if (copy_from_user(&tmp_info, info, sizeof(tmp_info)) != 0)
+		return -EFAULT;
+
+	tmp_info.media_flags = 0;
+	if (tmp_info.last_media_change - cdi->last_media_change_ms < 0)
+		tmp_info.media_flags |= MEDIA_CHANGED_FLAG;
+
+	tmp_info.last_media_change = cdi->last_media_change_ms;
+
+	if (copy_to_user(info, &tmp_info, sizeof(*info)) != 0)
+		return -EFAULT;
+
+	return 0;
+}
+
 static int cdrom_ioctl_set_options(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
@@ -3313,6 +3362,8 @@ int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
 		return cdrom_ioctl_eject_sw(cdi, arg);
 	case CDROM_MEDIA_CHANGED:
 		return cdrom_ioctl_media_changed(cdi, arg);
+	case CDROM_TIMED_MEDIA_CHANGE:
+		return cdrom_ioctl_timed_media_change(cdi, arg);
 	case CDROM_SET_OPTIONS:
 		return cdrom_ioctl_set_options(cdi, arg);
 	case CDROM_CLEAR_OPTIONS:
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index c4fef00abdf3..0a89f111e00e 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -64,6 +64,7 @@ struct cdrom_device_info {
 	int for_data;
 	int (*exit)(struct cdrom_device_info *);
 	int mrw_mode_page;
+	__s64 last_media_change_ms;
 };
 
 struct cdrom_device_ops {
diff --git a/include/uapi/linux/cdrom.h b/include/uapi/linux/cdrom.h
index 6c34f6e2f1f7..804ff8d98f71 100644
--- a/include/uapi/linux/cdrom.h
+++ b/include/uapi/linux/cdrom.h
@@ -147,6 +147,8 @@
 #define CDROM_NEXT_WRITABLE	0x5394	/* get next writable block */
 #define CDROM_LAST_WRITTEN	0x5395	/* get last block written on disc */
 
+#define CDROM_TIMED_MEDIA_CHANGE   0x5396  /* get the timestamp of the last media change */
+
 /*******************************************************
  * CDROM IOCTL structures
  *******************************************************/
@@ -295,6 +297,23 @@ struct cdrom_generic_command
 	};
 };
 
+/* This struct is used by CDROM_TIMED_MEDIA_CHANGE */
+struct cdrom_timed_media_change_info {
+	__s64	last_media_change;	/* Timestamp of the last detected media
+					 * change in ms. May be set by caller,
+					 * updated upon successful return of
+					 * ioctl.
+					 */
+	__u64	media_flags;		/* Flags returned by ioctl to indicate
+					 * media status.
+					 */
+};
+#define MEDIA_CHANGED_FLAG	0x1	/* Last detected media change was more
+					 * recent than last_media_change set by
+					 * caller.
+					 */
+/* other bits of media_flags available for future use */
+
 /*
  * A CD-ROM physical sector size is 2048, 2052, 2056, 2324, 2332, 2336, 
  * 2340, or 2352 bytes long.  
-- 
2.31.1

