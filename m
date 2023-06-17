Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A697EB64DB
	for <linux-block@archiver.kernel.org>; Sat, 17 Jun 2023 11:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjFQLid (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 17 Jun 2023 07:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjFQLib (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Jun 2023 07:38:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11F81BD1
        for <linux-block@vger.kernel.org>; Sat, 17 Jun 2023 04:38:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f906d8fca3so1837375e9.1
        for <linux-block@vger.kernel.org>; Sat, 17 Jun 2023 04:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1687001909; x=1689593909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Q8+gY2kqQ88iw+0NkAuK2zJCW88p2PmktzhCB821yI=;
        b=I5irdbNoWp3Y/ERpcHIovdFO/qf7F/u13qaUuKzs3U2JmBguvxlW5+Jr+XSu8CAPqf
         QsaDRIfVzT/BGkWU5Gx9OIAMh3KArfdHuGAC3ilYiBFj0mxisNjjkPmPm6xJ22KcWLQ5
         Yk+djjYaemGw6Lp4S4+5/jRH/p5sX7W0QjTIjZ7DPaew9N6ExCq+UfXYS6UlE1c6JZ1F
         Y0HFnc8H2Qy7M81HSGnMx5zbRv/TH1dWevtmvKrqCo65yF8u4tBWO88W1xoGWw4ABfFY
         lPuLWl/dQKU08lZAbZqG87GR5nXg5CTcrJl0jmXjkzciJ2CaR9jP5mDEPnCQ7wQa2bpA
         Ciwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687001909; x=1689593909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Q8+gY2kqQ88iw+0NkAuK2zJCW88p2PmktzhCB821yI=;
        b=TPNKmjOiG4x6fVhakBc12iOwrzPY3F4jnLcA19tfok6uiBV8ueXVSvIQ8873N0FYIY
         IZK8+e/jAhTu0YQ2AiKfuyNuYMHcSv8vYCDDnGwatHofrEK0F1bNga9IL5XpNtvW6t+4
         UygzgsXKVF078eeqbSk6x+Tvlk/ywRCkxI3MpAdtcBxid/MZHNiaMH/tY6D+7iqdXyUl
         QSriGou969DfZQWjWz1YcYD44/EGubHMuFaLaeEiqiwsGb9z7UpK8K9LLA/RDRhXSfXm
         riTlSOuHgyvjfPS6spMxDfXQRVpPMzgB9TB3LuyLZQqQZX1+PzjSZK3Ko8E9zRCtMENk
         TqDw==
X-Gm-Message-State: AC+VfDzFCYjexhmCHSgIMZbseFg8rfiO5OrIJjLMR+JbMTAZ2SZRWw5W
        NguDA5MfXfpliOHvcOUCdjETiGe5UIsDYl6SG1o=
X-Google-Smtp-Source: ACHHUZ6+hkX9IplZtxMh8+PrQeQf52R5sVql3LuAyN0z2WWwRpvhnublMQGQQfbsm1uEDvbsNmRK1g==
X-Received: by 2002:a7b:cb87:0:b0:3f7:e4d7:4469 with SMTP id m7-20020a7bcb87000000b003f7e4d74469mr3290455wmi.41.1687001909450;
        Sat, 17 Jun 2023 04:38:29 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c26-20020a7bc85a000000b003f7febc8fb8sm4748855wml.34.2023.06.17.04.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 04:38:29 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/1] cdrom: Fix spectre-v1 gadget
Date:   Sat, 17 Jun 2023 12:38:28 +0100
Message-Id: <20230617113828.1230-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230617113828.1230-1-phil@philpotter.co.uk>
References: <20230617113828.1230-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jordy Zomer <jordyzomer@google.com>

This patch fixes a spectre-v1 gadget in cdrom.
The gadget could be triggered by speculatively
bypassing the cdi->capacity check.

Signed-off-by: Jordy Zomer <jordyzomer@google.com>
Link: https://lore.kernel.org/all/20230612110040.849318-2-jordyzomer@google.com
Reviewed-by: Phillip Potter <phil@philpotter.co.uk>
Link: https://lore.kernel.org/all/ZI1+1OG9Ut1MqsUC@equinox
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/cdrom/cdrom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 416f723a2dbb..ecf2b458c108 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -264,6 +264,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/nospec.h>
 #include <linux/slab.h> 
 #include <linux/cdrom.h>
 #include <linux/sysctl.h>
@@ -2329,6 +2330,9 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
 	if (arg >= cdi->capacity)
 		return -EINVAL;
 
+	/* Prevent arg from speculatively bypassing the length check */
+	barrier_nospec();
+
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-- 
2.40.1

