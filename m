Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFFBC433EF
	for <linux-block@archiver.kernel.org>; Mon, 11 Apr 2022 17:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239379AbiDKRwx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Apr 2022 13:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348988AbiDKRww (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Apr 2022 13:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A42F30F4A
        for <linux-block@vger.kernel.org>; Mon, 11 Apr 2022 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649699436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jZr8+/3dMtuPdhdci07RfqKq5wNhW11aZAga7dGt9wM=;
        b=apfhV/3qSuZ3Gwosry5zqyXGXiDPQdg0sFjUSjntmXM5T6zuxvKMEqNDjvLFAXC7F0f9/a
        YHmv0C1Z0PCn3bGjQjfe9ImCQYl57mM2COAAHDzsQ0SZg8hYWR+SxfRA7FHG5LbtSXkg33
        mAAnvDwBhctLEzR9Ol0mkhkzdKLXRec=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-4eQ6spkdNQGboMk5ceYO0w-1; Mon, 11 Apr 2022 13:50:34 -0400
X-MC-Unique: 4eQ6spkdNQGboMk5ceYO0w-1
Received: by mail-qv1-f72.google.com with SMTP id p3-20020a05621421e300b0044427d0ab90so8008318qvj.17
        for <linux-block@vger.kernel.org>; Mon, 11 Apr 2022 10:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZr8+/3dMtuPdhdci07RfqKq5wNhW11aZAga7dGt9wM=;
        b=Ato+XRPvO1C1cEh+19u1kp+MwBroyEx9wAe72tOK1sGBwkjYA/lrOTflHDJU/HlE2P
         Vc88DOo5Q5vghkn4o9Ajum0m9nwPDCmWOomsPJOCzyMWlatLGX7vmvHPEkxV1tmxoeo+
         4/UrT96XIwJU3oh7QlOoCC+LrP2Uqk4/P3FAHMzF8f7qcXnQ+Fy6k72gIYj2W4hSV6XZ
         voL7LkI+JaQZMh2I0tnV5LI2CMwlD4LT5XG7YvfWSfpIPq8Zg4kwx05ikHgnnz+PQS2n
         32p8u/KYEgwhXZkjxftUEVZyzFH3SRqNpazSm20mKuKZDuS3hD3zUU5xagI9CeHNRFOV
         kqEA==
X-Gm-Message-State: AOAM5300h1FDzyPtiCjQZXd/LaoAD7t2SI6R4Al++WLIr1IY50uPgZbM
        fpYI2uK5PfJ2mrWvaILYG3DHjz+CaHQGPEl7ffH+Mr88fJKL7fPCHo+ZxQS8B4Gky/mW5hEXBDn
        DOfIEjdvSaIgKlhT3ZBNhTcs=
X-Received: by 2002:a05:620a:2944:b0:67e:c9bf:3f9b with SMTP id n4-20020a05620a294400b0067ec9bf3f9bmr421908qkp.144.1649699434293;
        Mon, 11 Apr 2022 10:50:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzia1Yr5YPgHPUPuyWMsagB0zFBS5Py6/T1HccII27aP7kxWSF8b6jjxJdrdf6VFG6mwt4eeg==
X-Received: by 2002:a05:620a:2944:b0:67e:c9bf:3f9b with SMTP id n4-20020a05620a294400b0067ec9bf3f9bmr421892qkp.144.1649699434061;
        Mon, 11 Apr 2022 10:50:34 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a24-20020a05620a067800b0069c233fa524sm1987715qkh.1.2022.04.11.10.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 10:50:33 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     tim@cyberelk.net, axboe@kernel.dk, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] pcd: do not leak information in ioctl
Date:   Mon, 11 Apr 2022 13:50:26 -0400
Message-Id: <20220411175026.2961880-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

clang static analysis reports this representative issue
pcd.c:832:22: warning: Assigned value is garbage
  or undefined
  tochdr->cdth_trk0 = buffer[2];
                    ^ ~~~~~~~~~

If the call to pcd_atapi fails, buffer is an unknown
state.  Passing an unknown buffer back to the user
can leak information and is a security risk.

Check before returning this buffer to the user.

The per-case variables cmd and buffer are common.
Change their scope to function level.
Change colliding parameter name cmd to request.

Cleanup whitespace
Additionally initialize the buffer to zero.

This problem can be seen in the 2.4.0 kernel
However this scm only goes back as far as 2.6.12

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: split from combined scsi,pcd patch

 drivers/block/paride/pcd.c | 87 +++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 49 deletions(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index f462ad67931a..2315918e3647 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -810,67 +810,56 @@ static void do_pcd_read_drq(void)
 
 /* the audio_ioctl stuff is adapted from sr_ioctl.c */
 
-static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void *arg)
+static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int request, void *arg)
 {
 	struct pcd_unit *cd = cdi->handle;
+	char cmd[12] = { GPCMD_READ_TOC_PMA_ATIP, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0 };
+	char buffer[32] = {};
 
-	switch (cmd) {
-
+	switch (request) {
 	case CDROMREADTOCHDR:
+	{
+		struct cdrom_tochdr *tochdr =
+			(struct cdrom_tochdr *) arg;
 
-		{
-			char cmd[12] =
-			    { GPCMD_READ_TOC_PMA_ATIP, 0, 0, 0, 0, 0, 0, 0, 12,
-			 0, 0, 0 };
-			struct cdrom_tochdr *tochdr =
-			    (struct cdrom_tochdr *) arg;
-			char buffer[32];
-			int r;
-
-			r = pcd_atapi(cd, cmd, 12, buffer, "read toc header");
+		if (pcd_atapi(cd, cmd, 12, buffer, "read toc header"))
+			return -EIO;
 
-			tochdr->cdth_trk0 = buffer[2];
-			tochdr->cdth_trk1 = buffer[3];
+		tochdr->cdth_trk0 = buffer[2];
+		tochdr->cdth_trk1 = buffer[3];
 
-			return r ? -EIO : 0;
-		}
+		return 0;
+	}
 
 	case CDROMREADTOCENTRY:
-
-		{
-			char cmd[12] =
-			    { GPCMD_READ_TOC_PMA_ATIP, 0, 0, 0, 0, 0, 0, 0, 12,
-			 0, 0, 0 };
-
-			struct cdrom_tocentry *tocentry =
-			    (struct cdrom_tocentry *) arg;
-			unsigned char buffer[32];
-			int r;
-
-			cmd[1] =
-			    (tocentry->cdte_format == CDROM_MSF ? 0x02 : 0);
-			cmd[6] = tocentry->cdte_track;
-
-			r = pcd_atapi(cd, cmd, 12, buffer, "read toc entry");
-
-			tocentry->cdte_ctrl = buffer[5] & 0xf;
-			tocentry->cdte_adr = buffer[5] >> 4;
-			tocentry->cdte_datamode =
-			    (tocentry->cdte_ctrl & 0x04) ? 1 : 0;
-			if (tocentry->cdte_format == CDROM_MSF) {
-				tocentry->cdte_addr.msf.minute = buffer[9];
-				tocentry->cdte_addr.msf.second = buffer[10];
-				tocentry->cdte_addr.msf.frame = buffer[11];
-			} else
-				tocentry->cdte_addr.lba =
-				    (((((buffer[8] << 8) + buffer[9]) << 8)
-				      + buffer[10]) << 8) + buffer[11];
-
-			return r ? -EIO : 0;
+	{
+		struct cdrom_tocentry *tocentry =
+			(struct cdrom_tocentry *) arg;
+
+		cmd[1] = (tocentry->cdte_format == CDROM_MSF ? 0x02 : 0);
+		cmd[6] = tocentry->cdte_track;
+
+		if (pcd_atapi(cd, cmd, 12, buffer, "read toc entry"))
+			return -EIO;
+
+		tocentry->cdte_ctrl = buffer[5] & 0xf;
+		tocentry->cdte_adr = buffer[5] >> 4;
+		tocentry->cdte_datamode =
+			(tocentry->cdte_ctrl & 0x04) ? 1 : 0;
+		if (tocentry->cdte_format == CDROM_MSF) {
+			tocentry->cdte_addr.msf.minute = buffer[9];
+			tocentry->cdte_addr.msf.second = buffer[10];
+			tocentry->cdte_addr.msf.frame = buffer[11];
+		} else {
+			tocentry->cdte_addr.lba =
+				(((((buffer[8] << 8) + buffer[9]) << 8)
+				  + buffer[10]) << 8) + buffer[11];
 		}
 
-	default:
+		return 0;
+	}
 
+	default:
 		return -ENOSYS;
 	}
 }
-- 
2.27.0

