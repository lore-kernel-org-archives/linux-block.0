Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E476C432C3
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 10:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118F664FDC
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 10:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhCLKz6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 05:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbhCLKzj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 05:55:39 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48933C061574
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 02:55:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so4343084wma.0
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 02:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTDdaTycGYlNA/lyonpjEoSlsLiRrWvU/OfIN0f1xg4=;
        b=ERbKKB4/+jTtG9cxQCI6ys1C2lW4tUaNJdMui+/oWeXE0HsW6DNJRDpnpLOoJZqG0c
         q/pOK+PWJGTFd8jFRLH9zGHgjPEFavi2IYR4k4+Idhx6YPwn/rp+WCdB0OGFv2TQQ6QC
         r4O3cad/oKkNIC/0CFfazs3nN/6O3Geh/pOdj9I5in5kIzD6IyLwgDdn7B1b13yE5KJA
         RmAKA8Qas52QlZP1QXMSDfm9vPfp0l0i/LCI5PgJb4IsLPDiT/goCdDhzArJVbXqjMGc
         f7juz1rKAoMY+aUOBma/t299ym1GFGKBUu0ra3mWr0vJi5mlw7J63BC9Aziq6waqvas2
         p9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTDdaTycGYlNA/lyonpjEoSlsLiRrWvU/OfIN0f1xg4=;
        b=ku2nSX0owpShIJcvPQVxGGa2oNfkWRrnKlByCjX1ON1TIx4FgQmlEtV8eHSFKB8gn7
         QNM1+Nnt1EewVNSoZFBJa139S5Vrssam0eztGjaxef1jY+viAHdv4hH+oSuU5oXjMSOZ
         0kxHZXRy6y3gM1aX9ECVyLrzlIwxkQqKdebkhm8rrL5o//2dYZxUJW/r0a1FlPHvQH9b
         5QXWPlpMJjyikmECtN0AYIZxzSt+Q+uz6A3yYTN/voAXlEdouYm+xjDdCOyO549MtT34
         vP676vBPPjzogVMoG57gi1ZMTb90NC8egSIKkwPB4RO6UPwVmbELUlgSzNpnlwwKh+qR
         OSGw==
X-Gm-Message-State: AOAM530nnKT8jaguvFzQ+eO57dEZUItcGNT/E8mfvQ2cLFFEoz0rQNxj
        0Jn1cPO60DZu0x8a4VovF5wPfw==
X-Google-Smtp-Source: ABdhPJyBSWReAMX3zAKD9jX8PV62DEBUVoL14DbaG+qxxdzW1KCswtemO46FdCsHks6M611re71JtA==
X-Received: by 2002:a1c:7704:: with SMTP id t4mr12256371wmi.159.1615546538048;
        Fri, 12 Mar 2021 02:55:38 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id q15sm7264962wrr.58.2021.03.12.02.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:55:37 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH 03/11] block: mtip32xx: mtip32xx: Mark debugging variable 'start' as __maybe_unused
Date:   Fri, 12 Mar 2021 10:55:22 +0000
Message-Id: <20210312105530.2219008-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/block/mtip32xx/mtip32xx.c: In function ‘mtip_standby_immediate’:
 drivers/block/mtip32xx/mtip32xx.c:1216:16: warning: variable ‘start’ set but not used [-Wunused-but-set-variable]

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/block/mtip32xx/mtip32xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 3be0dbc674bd0..bc485f1623361 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -1213,7 +1213,7 @@ static int mtip_standby_immediate(struct mtip_port *port)
 {
 	int rv;
 	struct host_to_dev_fis	fis;
-	unsigned long start;
+	unsigned long __maybe_unused start;
 	unsigned int timeout;
 
 	/* Build the FIS. */
-- 
2.27.0

