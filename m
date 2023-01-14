Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19D1C3DA78
	for <linux-block@archiver.kernel.org>; Sat, 14 Jan 2023 17:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjANRBe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Jan 2023 12:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjANRBd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Jan 2023 12:01:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652AF35AE
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2023 09:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673715691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UL5uNX54JKFtg06F7nCs9+yy2MAYTYW/oHNsNWT8Z7o=;
        b=LiN8J1UJiCfl9JraHCmJLdteBQLWn+PyWkxLWYlFmmJ8ekIyhai89yNa1dqlZGJ0d+hOZ5
        CmbCTyXtqDseXDiNjLk//wXq87VgiX6Vd07ug/5AzyzrDfIdr8aeVJznx+p/1V+GCaSceM
        Xpj3tOe0uh2dCFZD0EzRQFJ04zyy0+U=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-310-gBhQ8dSENz6rqQCJk3soKg-1; Sat, 14 Jan 2023 12:01:17 -0500
X-MC-Unique: gBhQ8dSENz6rqQCJk3soKg-1
Received: by mail-yb1-f198.google.com with SMTP id k135-20020a25248d000000b007d689f92d6dso432270ybk.22
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2023 09:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UL5uNX54JKFtg06F7nCs9+yy2MAYTYW/oHNsNWT8Z7o=;
        b=fVN9pT8P0eY3CRx7mFSyFVkTYOxsRvOV6tkgzrUX5L9FYDRZmsBy5F3gOyTVB/L6a5
         Dejx/Hmdha/zbGK9p3fr0i7FzPTeDgEotP/bnOoxXCY4zt1tkFtq0FrJf2D+C2etlC64
         IRw95H0blBe2hEIeIXxXyWNx5Kn6bIMNlV+bDRAZtiKCgpVbQpW9dWH4UsjvfFJPYBYI
         LVmFdMacasJyNoqmszGGQuYvhA3/7YNkagvofz11I4J8jBrTRA4hdTxV/DYX2l8utL7i
         2iLPljFP6XIOIzKoySwDAuHo5LgbozEhgyaHrkPdyEXUJ6x06lV4ciQksDa1YVEUSqWt
         J6jQ==
X-Gm-Message-State: AFqh2kqW00RZfny1N3VOoZLtOt3DbwP256rgceE+OnW8zvWqW5ziE7gz
        OmI0LysMmaInZONaxrnaDpUEVE8nNtBpI+i2DdrqxnmIDZagbZobTud35s5feIF4E7XpXX5cv3v
        catpVCErhgJwVRjPiC4vdXaQ=
X-Received: by 2002:a25:e792:0:b0:7d1:d26b:7eaa with SMTP id e140-20020a25e792000000b007d1d26b7eaamr3683917ybh.39.1673715676741;
        Sat, 14 Jan 2023 09:01:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtr8avWN03TzTzhlRuzCN6sYiu2T5Bek5rUhuA0So+cSWahDMdGma5psLhGPToohX8uBWTwcg==
X-Received: by 2002:a25:e792:0:b0:7d1:d26b:7eaa with SMTP id e140-20020a25e792000000b007d1d26b7eaamr3683890ybh.39.1673715676289;
        Sat, 14 Jan 2023 09:01:16 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id bl41-20020a05620a1aa900b007059c5929b8sm14637969qkb.21.2023.01.14.09.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 09:01:15 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     tim@cyberelk.net, axboe@kernel.dk, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] paride/pcd: return earlier when an error happens in pcd_atapi()
Date:   Sat, 14 Jan 2023 12:01:13 -0500
Message-Id: <20230114170113.3985630-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

clang static analysis reports
drivers/block/paride/pcd.c:856:36: warning: The left operand of '&'
  is a garbage value [core.UndefinedBinaryOperatorResult]
  tocentry->cdte_ctrl = buffer[5] & 0xf;
                        ~~~~~~~~~ ^

When the call to pcd_atapi() fails, buffer[] is in an unknown state,
so return early.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/block/paride/pcd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index a5ab40784119..4524d8880463 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -827,12 +827,13 @@ static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void
 			char buffer[32];
 			int r;
 
-			r = pcd_atapi(cd, cmd, 12, buffer, "read toc header");
+			if (pcd_atapi(cd, cmd, 12, buffer, "read toc header"))
+				return -EIO;
 
 			tochdr->cdth_trk0 = buffer[2];
 			tochdr->cdth_trk1 = buffer[3];
 
-			return r ? -EIO : 0;
+			return 0;
 		}
 
 	case CDROMREADTOCENTRY:
@@ -845,13 +846,13 @@ static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void
 			struct cdrom_tocentry *tocentry =
 			    (struct cdrom_tocentry *) arg;
 			unsigned char buffer[32];
-			int r;
 
 			cmd[1] =
 			    (tocentry->cdte_format == CDROM_MSF ? 0x02 : 0);
 			cmd[6] = tocentry->cdte_track;
 
-			r = pcd_atapi(cd, cmd, 12, buffer, "read toc entry");
+			if (pcd_atapi(cd, cmd, 12, buffer, "read toc entry"))
+				return -EIO;
 
 			tocentry->cdte_ctrl = buffer[5] & 0xf;
 			tocentry->cdte_adr = buffer[5] >> 4;
@@ -866,7 +867,7 @@ static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void
 				    (((((buffer[8] << 8) + buffer[9]) << 8)
 				      + buffer[10]) << 8) + buffer[11];
 
-			return r ? -EIO : 0;
+			return 0;
 		}
 
 	default:
-- 
2.27.0

