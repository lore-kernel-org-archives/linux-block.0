Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D62C5519F
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 12:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356002080A
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 12:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKXKsq7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgKVM0a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Nov 2020 07:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgKVM0a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Nov 2020 07:26:30 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE2DC0613CF
        for <linux-block@vger.kernel.org>; Sun, 22 Nov 2020 04:26:28 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 64so2273049wra.11
        for <linux-block@vger.kernel.org>; Sun, 22 Nov 2020 04:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=zWUVBjBnXAWbcQW+qiVt5P8OemrERs2tznHq1t9VptI=;
        b=FKXKsq7h0fMnHFWDsyD5ZTEvRckU8BOdO81UrfzGN5gmoV5jsTNWWu2k7s4ipcDgmw
         M59JlPFB8JkpNxRuEBAHa1RXt0ttaJa8D+QyP9/nHv2b0KSb1h8sS+e9YDRWeLLczuky
         digem/RAXUP6W3XclSfAYQzvla2/M6+AG1plv+m7Zkgq60MB1KL8QEXHFfeAqRyi8bKI
         ZRmmP8F854fpnocq7f3D3q5Hfg7otGpKoHGaPaSW2zE0gpaPavAEmAw25tLzLLrXUEGQ
         Tl+tGRnnSdRM2KrVOaL0cRyDewbEUzEHuF19CFmsZcIUT/xiCs/a/BX6idDauWJ22uDr
         9wMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zWUVBjBnXAWbcQW+qiVt5P8OemrERs2tznHq1t9VptI=;
        b=U1X6+amiXOJ9oTOGsdnPmS9+8QynDBeS20NQG03oyyrw721uwlDw2LMWVHr0d2S9gc
         gDIg1ZiX5Yac1Ms/tqmnmQlSNq5z0jspIWEViQShb6LOG3t+wtvu5j67f96Psz/rC99F
         a7CQa1Sb1fA+a8wRxR6QIHixLGN6ud0GR0xYedx1sf2Ep58tOak+CZvRnKG/bGoVJIED
         ogY1GMymGwd8cDKHRveVMgcK5CsRH2NIP87nsYxvC0XMwS3T1QRH/+JiAkfK9uhQKnQi
         CvMl6Vp0pL/ZY6ZyZewrpRtjBT44EEW7mS33QyefuTNPS/i+z+JhhqP6vYrvDUC6lg78
         bwhA==
X-Gm-Message-State: AOAM531W3luTmq3V5TO9obmuzQ5yhP0RRfrGolRfe6d5sGUh2t4PHpH5
        +J2V6nsKcGFgtQg6NEN4d88TAckkYw==
X-Google-Smtp-Source: ABdhPJyDTbATVkTnd64Y2qh+Jna9R747KdGB4gMSKXy4QdqbyM+9MnvT1RkJrWeJp+KfvlLiXd8jFw==
X-Received: by 2002:adf:f5c8:: with SMTP id k8mr26775169wrp.2.1606047986847;
        Sun, 22 Nov 2020 04:26:26 -0800 (PST)
Received: from localhost.localdomain ([46.53.251.228])
        by smtp.gmail.com with ESMTPSA id 2sm173026wrq.87.2020.11.22.04.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 04:26:26 -0800 (PST)
Date:   Sun, 22 Nov 2020 15:26:24 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: cleanup kstrto*() usage
Message-ID: <20201122122624.GA92364@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

kstrto*() can ship return value directly if no additional
checks are to be done.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 block/blk-sysfs.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -33,11 +33,11 @@ queue_var_show(unsigned long var, char *page)
 static ssize_t
 queue_var_store(unsigned long *var, const char *page, size_t count)
 {
+	unsigned int v;
 	int err;
-	unsigned long v;
 
-	err = kstrtoul(page, 10, &v);
-	if (err || v > UINT_MAX)
+	err = kstrtouint(page, 10, &v);
+	if (err)
 		return -EINVAL;
 
 	*var = v;
@@ -47,15 +47,7 @@ queue_var_store(unsigned long *var, const char *page, size_t count)
 
 static ssize_t queue_var_store64(s64 *var, const char *page)
 {
-	int err;
-	s64 v;
-
-	err = kstrtos64(page, 10, &v);
-	if (err < 0)
-		return err;
-
-	*var = v;
-	return 0;
+	return kstrtos64(page, 10, var);
 }
 
 static ssize_t queue_requests_show(struct request_queue *q, char *page)
