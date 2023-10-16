Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC8DCDB465
	for <linux-block@archiver.kernel.org>; Mon, 16 Oct 2023 20:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjJPUrr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Oct 2023 16:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjJPUrq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Oct 2023 16:47:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D4AA2
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 13:47:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32daeed7771so1655905f8f.3
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 13:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1697489263; x=1698094063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=km3YaL6rk2BDMCLAR7JsdKXwCZgtVX3RoJiE7ckNzOU=;
        b=tTiBckgTnl81Clh4Lw7j31/q85rfX3FfkF6Zxtz0Fl5DWzBcZDkt7qe+546udtabMs
         y05YUkx9NGn+krtty6ndYkU1px/Wdh4+bXRWrQp4zlb+vC+X7AXPqeXIv287FsClp6HE
         oiDxiyRy80OVEJ+S4ATZ1/A5NjRtterrm1HMWbuOE88mlNMKPMWc/rSH6D08MXTbZBcY
         VlBC+9z6YtFeEY85FXwfA0/JO2xUhpab9nxg7PmmFDP5Wr4+Pcf4N8KlzITbagoSTaSV
         ZEt2JKagsdXdr7XDLQHalvqwEMQxodiGdgo+ZnvzoNU9rrmHhY+vN2tZfAlWqyj9Yecl
         8Rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697489263; x=1698094063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=km3YaL6rk2BDMCLAR7JsdKXwCZgtVX3RoJiE7ckNzOU=;
        b=Jzri5mJ7F7HPw+EjWiYMMPyGhSEZaqYG2eP7TZzhQnw2xHKvZgASAIaGLf2Y65Why8
         g+TgiG+Icq4fAJuGFWpOINRgyEGRRV2//ehWTU7EQbnghN2d9CRvikNg+0ppJBRYfpzD
         R9FM+pi2HzQL0LWkcitxGYxL1l7hoxfG81zoESc8anC+FVZzM4FGsT7yYXq6nUR1EWVh
         A3OyItqsxTGfSwCJYOIZ3Y0f7F92XZeLkrIyQZShgsyg44hg8b+0MrgLdne/cVCYbNXN
         gcBxwxrTBLv1okIsq+0+aqnYqN958/PDWnxyA/knhM2I1cbjuq0zKOkBtzEtTYsq5Xxu
         ICSg==
X-Gm-Message-State: AOJu0Ywd8gR4yUJ0M+OuIEyaM/JK5EIGLD5ki73jvErC3ckOzQUSPgGk
        esTeLIx+FDqwq2/TGpyLtdwHMw==
X-Google-Smtp-Source: AGHT+IFt4h5aSXRNneXef4lpN+1Wp56DtNvMf/uK93PtpdNu2aJTKfZvB+PaFZGfqU4LRQZqSK1L4A==
X-Received: by 2002:a05:6000:ac1:b0:32d:9776:273f with SMTP id di1-20020a0560000ac100b0032d9776273fmr408166wrb.45.1697489262815;
        Mon, 16 Oct 2023 13:47:42 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id g15-20020adfe40f000000b003217cbab88bsm124441wrm.16.2023.10.16.13.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:47:42 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/1] cdrom: Add missing blank lines after declarations
Date:   Mon, 16 Oct 2023 21:47:41 +0100
Message-ID: <20231016204741.1014-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016204741.1014-1-phil@philpotter.co.uk>
References: <20231016204741.1014-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

Add missing blank lines after declarations to fix warning found by
checkpatch.pl script.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
https://lore.kernel.org/lkml/20231015172846.7275-1-edson.drosdeck@gmail.com
Reviewed-by: Phillip Potter <phil@philpotter.co.uk>
https://lore.kernel.org/lkml/ZS2eKOZF2J7q7zkE@equinox
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/cdrom/cdrom.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index a5e07270e0d4..d1c2c1095fdd 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -985,6 +985,7 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
 	struct cdrom_tochdr header;
 	struct cdrom_tocentry entry;
 	int ret, i;
+
 	tracks->data = 0;
 	tracks->audio = 0;
 	tracks->cdi = 0;
@@ -1038,6 +1039,7 @@ int open_for_data(struct cdrom_device_info *cdi)
 	int ret;
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	tracktype tracks;
+
 	cd_dbg(CD_OPEN, "entering open_for_data\n");
 	/* Check if the driver can report drive status.  If it can, we
 	   can do clever things.  If it can't, well, we at least tried! */
@@ -1202,6 +1204,7 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
 {
         int ret;
 	tracktype tracks;
+
 	cd_dbg(CD_OPEN, "entering check_for_audio_disc\n");
 	if (!(cdi->options & CDO_CHECK_TYPE))
 		return 0;
@@ -3038,6 +3041,7 @@ static noinline int mmc_ioctl_cdrom_subchannel(struct cdrom_device_info *cdi,
 	int ret;
 	struct cdrom_subchnl q;
 	u_char requested, back;
+
 	if (copy_from_user(&q, (struct cdrom_subchnl __user *)arg, sizeof(q)))
 		return -EFAULT;
 	requested = q.cdsc_format;
@@ -3063,6 +3067,7 @@ static noinline int mmc_ioctl_cdrom_play_msf(struct cdrom_device_info *cdi,
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_msf msf;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYMSF\n");
 	if (copy_from_user(&msf, (struct cdrom_msf __user *)arg, sizeof(msf)))
 		return -EFAULT;
@@ -3083,6 +3088,7 @@ static noinline int mmc_ioctl_cdrom_play_blk(struct cdrom_device_info *cdi,
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_blk blk;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYBLK\n");
 	if (copy_from_user(&blk, (struct cdrom_blk __user *)arg, sizeof(blk)))
 		return -EFAULT;
@@ -3177,6 +3183,7 @@ static noinline int mmc_ioctl_cdrom_start_stop(struct cdrom_device_info *cdi,
 					       int cmd)
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROMSTART/CDROMSTOP\n");
 	cgc->cmd[0] = GPCMD_START_STOP_UNIT;
 	cgc->cmd[1] = 1;
@@ -3190,6 +3197,7 @@ static noinline int mmc_ioctl_cdrom_pause_resume(struct cdrom_device_info *cdi,
 						 int cmd)
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROMPAUSE/CDROMRESUME\n");
 	cgc->cmd[0] = GPCMD_PAUSE_RESUME;
 	cgc->cmd[8] = (cmd == CDROMRESUME) ? 1 : 0;
@@ -3230,6 +3238,7 @@ static noinline int mmc_ioctl_dvd_auth(struct cdrom_device_info *cdi,
 {
 	int ret;
 	dvd_authinfo ai;
+
 	if (!CDROM_CAN(CDC_DVD))
 		return -ENOSYS;
 	cd_dbg(CD_DO_IOCTL, "entering DVD_AUTH\n");
@@ -3248,6 +3257,7 @@ static noinline int mmc_ioctl_cdrom_next_writable(struct cdrom_device_info *cdi,
 {
 	int ret;
 	long next = 0;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROM_NEXT_WRITABLE\n");
 	ret = cdrom_get_next_writable(cdi, &next);
 	if (ret)
@@ -3262,6 +3272,7 @@ static noinline int mmc_ioctl_cdrom_last_written(struct cdrom_device_info *cdi,
 {
 	int ret;
 	long last = 0;
+
 	cd_dbg(CD_DO_IOCTL, "entering CDROM_LAST_WRITTEN\n");
 	ret = cdrom_get_last_written(cdi, &last);
 	if (ret)
-- 
2.41.0

