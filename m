Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85478C433EF
	for <linux-block@archiver.kernel.org>; Fri,  1 Apr 2022 21:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbiDAVUj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Apr 2022 17:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiDAVUi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Apr 2022 17:20:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF4E6353
        for <linux-block@vger.kernel.org>; Fri,  1 Apr 2022 14:18:45 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so4301819wmb.4
        for <linux-block@vger.kernel.org>; Fri, 01 Apr 2022 14:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EfvCDl3Rdap0V2Z2+PN3c4SFuU1aK600Qkf4h040NWs=;
        b=x4i+IO91WwjgpigJfdfoipNTiqAw/cdfPHaogxPNUXAcbyX8BqSdl9hHkMDtCuwjq0
         TXmjYKjgtRvw0SBOpBImd+Y6NK+/QLYaXeC+8JoGXnwp0EZJGQas/QtT/WA9rYq9gYSC
         S5BHtC1ry/TtsvpNJ9WgB2qQmWuusniK87H/xeZAEjwwxUfCcPG8LMpQ7v3pLKNSvO76
         ZKckTvzPyno+OBUbg+8UXO1hVN/h+41V4HqbTVn2FMlKVPvXTZEugh7z4cs1aJpy/zXZ
         LUtSoiEMmv7IpYYeuW1H86+BOBALXXLPIYEstFjYvGofPuuuReyIbAt5a/Z0mUrT9xQ7
         RCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EfvCDl3Rdap0V2Z2+PN3c4SFuU1aK600Qkf4h040NWs=;
        b=CvOvE6HjKUUx4jI9x25E1QZHJqg1JOu6M2b5IYGqACOEymvwpKwt4xl6NLKpY2Qd6E
         ZPJw1SI06BNaH8H9ix2Zfdd05ahVgpG2gZ1AKGNTIHG4qLo8cVBDAPlqKKPJmzxPGfpK
         tOj6G/e2Ni+IIXgP+ZTCMYIjEB9RPUMaec5+8AHXl5JG1M95ZC3rFARYmJB5SruOAqL4
         uxwHF3xlSQ41qKYb7AK/zoosOEmKc+cFL5gNYvRBpa/hN+cGAHsWr+kNKLOu3EGhsyjk
         sHFIM3TZlC1pbu3QP8V2KJAVgWgyhoIIQGEGVZPKhc5bf0zdd6T/Ft+IrVcer3cTHWbL
         +v0w==
X-Gm-Message-State: AOAM532M54S/pA5OO/RvhcP9EMksTq5DsUNHNlf0prXwD5m/gHHHzvR8
        XfAg6BplOaNF6gK7kKpytl50DvuJz1d3mQ==
X-Google-Smtp-Source: ABdhPJyu3YVbb7km6+LXiyGGAz9o9Nt9bwpoTMNK/S1/3y/P/dPWI05HaW+56a48rn7c+8AdC4K9zA==
X-Received: by 2002:a05:600c:2146:b0:38c:ab68:1919 with SMTP id v6-20020a05600c214600b0038cab681919mr10506855wml.52.1648847924062;
        Fri, 01 Apr 2022 14:18:44 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d48d0000000b00205cf199abcsm2944993wrs.46.2022.04.01.14.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 14:18:43 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] cdrom: remove unused variable
Date:   Fri,  1 Apr 2022 22:18:42 +0100
Message-Id: <20220401211842.2088096-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Enze Li <lienze@kylinos.cn>

The clang static analyzer reports the following warning,

File: drivers/cdrom/cdrom.c
Warning: line 1380, column 7
	 Although the value stored to 'status' is used in enclosing
	 expression, the value is never actually read from 'status'

Remove the unused variable to eliminate the warning.

Signed-off-by: Enze Li <lienze@kylinos.cn>
Link: https://lore.kernel.org/all/20220401032623.293666-1-lienze@kylinos.cn
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/cdrom/cdrom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 7bd10d63ddbe..2dc9da683a13 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1365,7 +1365,6 @@ static int cdrom_slot_status(struct cdrom_device_info *cdi, int slot)
  */
 int cdrom_number_of_slots(struct cdrom_device_info *cdi) 
 {
-	int status;
 	int nslots = 1;
 	struct cdrom_changer_info *info;
 
@@ -1377,7 +1376,7 @@ int cdrom_number_of_slots(struct cdrom_device_info *cdi)
 	if (!info)
 		return -ENOMEM;
 
-	if ((status = cdrom_read_mech_status(cdi, info)) == 0)
+	if (cdrom_read_mech_status(cdi, info) == 0)
 		nslots = info->hdr.nslots;
 
 	kfree(info);
-- 
2.35.1

