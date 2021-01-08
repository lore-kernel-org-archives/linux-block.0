Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E32C433E0
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 14:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF9C223884
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 14:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbhAHOhX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jan 2021 09:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbhAHOhU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jan 2021 09:37:20 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4ADC0612FE
        for <linux-block@vger.kernel.org>; Fri,  8 Jan 2021 06:36:40 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y24so11366401edt.10
        for <linux-block@vger.kernel.org>; Fri, 08 Jan 2021 06:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZdhYqzo7vGHt0kaFItNFL8QlDmgaVS2uhNAqxmjrpdU=;
        b=Q5NkzXOb1zqk1ACAFnCSwmXnUm40Pa2+oS5BVplA3rYKnIzDHYl+p3QZtsJG2MB3U8
         nWVJgwaDbbwi4RoRscdFsrPZc+df8QVYd9JpYh/ZG8ucrO2GkAErpTByh/eBZ/P6PK3J
         nz+YOuA+nD4tFPuFJ2z4imcafvbcnegcgJBWCdQJ3TYY4qav7G6AtmJkX5BKqryA1g9U
         kdda9RfV4yyefxfPvrGXnoLLo8dZpgVuritiTtp7G8lEkIc1xKnsOlG2h2pUj4SeXIDv
         u1mt4Uf1A3C6ktDDHb8EcBdaQra9v/RaJO+ks855eepc4uEYcvxTQVZQEHYlPPuH7lV6
         m+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdhYqzo7vGHt0kaFItNFL8QlDmgaVS2uhNAqxmjrpdU=;
        b=aSoZzcKDstxZjh9A3+khHnKOkTL8vltV41T82le71Yup0jh1Uchjfh2iSrkcO/JcOa
         deWvgqv6mQEslMTb6eRGZ+0YV+oBxvj1YNz5iLMdqNO5NIONW9h2ADAK86cw1qivS5D/
         XAcmFl422ZzkGV10In61ZRYOMGr/cxvS/ObZYtLkMg2HX2VGIV77k7pRt6PsY4LuQc7+
         7EvHo9v9Lfi9rBtaRH0/1bB0nSGQgKDIL8KOEuqw74uoxgDE7atE6/lCYRTeKPrVGw7o
         tVOf7K11QaaoyPxRhBsZcdqJ2b3/kVDwRJZWac5irz/k5Be3TxH9nIKOLHKkCQ76uuPa
         gyxw==
X-Gm-Message-State: AOAM53392T3NtjDCSMr6/zqkADsQaN5obGNjWy3KZFZO7kkJ7S6YV6zq
        PhTUkdGCERGCFUsRA1rilFfpSX5B/wh+WA==
X-Google-Smtp-Source: ABdhPJyh81QCgA8fVsaRaSru1rNwtnMg2jXBG7J9/SANWKKG26wI+YIeI7rJi8A8aXaXfIBQ91Z3pw==
X-Received: by 2002:a50:abc6:: with SMTP id u64mr5546709edc.21.1610116599197;
        Fri, 08 Jan 2021 06:36:39 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4906:c200:31ac:50df:cd1f:f7fc])
        by smtp.gmail.com with ESMTPSA id e25sm3858698edq.24.2021.01.08.06.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 06:36:38 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Swapnil Ingle <ingleswapnil@gmail.com>
Subject: [PATCH for-rc 4/5] block/rnbd: Adding name to the Contributors List
Date:   Fri,  8 Jan 2021 15:36:33 +0100
Message-Id: <20210108143634.175394-5-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108143634.175394-1-jinpu.wang@cloud.ionos.com>
References: <20210108143634.175394-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Swapnil Ingle <ingleswapnil@gmail.com>

Adding name to the Contributors List

Signed-off-by: Swapnil Ingle <ingleswapnil@gmail.com>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Acked-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/README | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rnbd/README b/drivers/block/rnbd/README
index 1773c0aa0bd4..080f58a5400a 100644
--- a/drivers/block/rnbd/README
+++ b/drivers/block/rnbd/README
@@ -90,3 +90,4 @@ Kleber Souza <kleber.souza@profitbricks.com>
 Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
 Milind Dumbare <Milind.dumbare@gmail.com>
 Roman Penyaev <roman.penyaev@profitbricks.com>
+Swapnil Ingle <ingleswapnil@gmail.com>
-- 
2.25.1

