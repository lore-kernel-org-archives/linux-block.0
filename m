Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B80CC433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 07:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E569A611EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 07:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhJUHsk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 03:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhJUHsj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 03:48:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116DDC06161C
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 00:46:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d13so1116432wrf.11
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 00:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OFxG7H2XkVGDNIM4fIf0RwwhxzRcHsMeQTOyNmycang=;
        b=dZd6JvyRQxgTXKsRPLaKr5kCTAjEOccjY+3rjqnYKICAc7J4yQlBOyOiF14y6YKpYk
         ysQNqFA92nDLuX1Qspy0rg+5dSnbgTUYLwszkUH4ku2eDG6IsjAVaNGWikYjihBybmqa
         a5o4tGIHpeuUSCvrxgqlVmvkBVmORP5QI4uilmV1NHmV6FneSe9bqQkGvmZhgEpuhf3x
         E+PtdiPbnHUXaDTUrbw+8evTWhRRO9ZkY1zyIOLFYKJv29RsFHhzJD2knL0dPjF7wtq6
         E0VHnB6ecW9BxyYq6jRtNvuaVEyoZs3GIH2j4vATVgUeZbdovpr9pCBXspjc7y2l/hKw
         S4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OFxG7H2XkVGDNIM4fIf0RwwhxzRcHsMeQTOyNmycang=;
        b=qXMGTKw0QgNQzQPw4wltUsbEMrNTAmeDqU3R629yvbBvfonHQZr14NT8TxkCpEgxhr
         06JxDAfA+o+0EKgcOrOoqgBUEf+T54To0ndkm2PmAC0fb/BrbGLrBaXBVAmzN2xXa1my
         OKcJYK+SL/CR1Mmlbzu6jAAALKhJAcNd9jEJ/8vUJARN0xVjhVc6Al/wHwaQraSLKD5a
         0bV9UJqmYHt1Q+GQMSs9RtPIzXLkT99Mp4TFupt6J7/7jq9PeLHhFBurDP49lUzdSFpC
         9vQRyGCgXekURphJR4sHrJhn4HzWbdpwZdSc0Gz4cgZsfffi126eMXiZfvZpb2CRNanm
         Tl6w==
X-Gm-Message-State: AOAM533IWRf9cUkKRpr1yealqg+Kip0GCgSlR+YnQ8ZhsBcVNOw4kgmF
        NQ79jN2SJOKjqmiBmGEkT5gKfg==
X-Google-Smtp-Source: ABdhPJx0hiVclVy/CHK12YvRkmywk0iZVbfrTxovvmQxA0vLS67qFUYCjrVBbat5W0iWk9CerDTREg==
X-Received: by 2002:adf:dc0d:: with SMTP id t13mr5258808wri.158.1634802382686;
        Thu, 21 Oct 2021 00:46:22 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id l20sm7923492wmq.42.2021.10.21.00.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 00:46:22 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] cdrom: Remove redundant variable and its assignment
Date:   Thu, 21 Oct 2021 08:46:21 +0100
Message-Id: <20211021074621.901-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

Variable is not used in functions, and its assignment is redundant too.
So it should be deleted. Also the inner-most set of parentheses is no
longer needed.

The clang_analyzer complains as follows:

drivers/cdrom/cdrom.c:877: warning:

Although the value stored to 'ret' is used in the enclosing expression,
the value is never actually read from 'ret'.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
Link: https://lore.kernel.org/all/20211020024229.1036219-1-luo.penghao@zte.com.cn
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/cdrom/cdrom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 89a68457820a..9877e413fce3 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -871,7 +871,7 @@ static void cdrom_mmc3_profile(struct cdrom_device_info *cdi)
 {
 	struct packet_command cgc;
 	char buffer[32];
-	int ret, mmc3_profile;
+	int mmc3_profile;
 
 	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
 
@@ -881,7 +881,7 @@ static void cdrom_mmc3_profile(struct cdrom_device_info *cdi)
 	cgc.cmd[8] = sizeof(buffer);		/* Allocation Length */
 	cgc.quiet = 1;
 
-	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
+	if (cdi->ops->generic_packet(cdi, &cgc))
 		mmc3_profile = 0xffff;
 	else
 		mmc3_profile = (buffer[6] << 8) | buffer[7];
-- 
2.31.1

