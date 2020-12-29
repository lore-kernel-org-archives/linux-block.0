Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A59C433E0
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 15:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D1F207C8
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 15:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgL2P2B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Dec 2020 10:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgL2P2B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Dec 2020 10:28:01 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B17C0613D6
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 07:27:20 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id i7so9387625pgc.8
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 07:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yrdUQ8kkK1UypFQQ6afocjo4OKsUS0sg56s7QZ/rzgs=;
        b=Pj6SpPZWwwHwM0ragN369phMqDFiM+kGZLmS6fbr6iwyJyvYbv/4AD0XvHsENVaI+o
         ZOnzfN2e86vRdUkqJYURI+ex4Q8F9GXsrqd//mQg24BlszYAWLaGqe8TB/UGCoSVWYW/
         2ptGJYwrurIdind8cKJnLDUaxjsbp+U9FI9ahRACKKJMlqj9D70zp6bw/xGRCX+G/xM9
         XQ8u8FFkW67iHybyKhO3Xh2Vzkr7zP6TgB7pYyqrAdfG5uQmLG/WrV9Y8U5rECRY86Di
         fVArN62qAdpWFquZfzQGUUA965WSU0D8DDVwUvvGRmD2anV8B0Gcj4pmeXw0MMoxi4jC
         LhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yrdUQ8kkK1UypFQQ6afocjo4OKsUS0sg56s7QZ/rzgs=;
        b=bCdlexambC7Q/G19ZgCId1vfMQ/F9qEzo705qkh6ES1PnSJkCTuqZGfT/GVijMmFpE
         3luVKuFyi+2/lUjsMtoUqmIyTNnW0tyrtA7QV1UmxkKVy6isbaYyN0DNimN63a4uSlMX
         GGYlcyhgMlLyzEx+dYNFLB9EJSv+ieO+P/hGwkspzTaPfev1kZAXks6PMhmoVHsOob5R
         9cEPq5ltJ7EECKqe3szxShh8VNL6ZaENK1sqjxBBfnxr11exJUx0c1toyaCNwABTh9LC
         r6Voa1QybenuSKdel+Y6MRjYQ2zrLmd7V1np/2Foo+9bLUx5h/OSrgqfyiRHOP9aWhis
         uBLA==
X-Gm-Message-State: AOAM532U3DYBYfR4wF91jzmhtinMStcU4dU+cSZLS2D9pWNxcp8mvDyz
        eomdIGIK3UQvXvAWq5cqO/8=
X-Google-Smtp-Source: ABdhPJx7uloueHyYSIWDwkCy5TocYPtXHr+lzqHhmPYZaOJhFIfOXMBQLQFfip1EPfVnHUsDBUdGyA==
X-Received: by 2002:a63:3549:: with SMTP id c70mr37164362pga.361.1609255640408;
        Tue, 29 Dec 2020 07:27:20 -0800 (PST)
Received: from archlinux.. ([161.81.68.216])
        by smtp.gmail.com with ESMTPSA id u68sm3231221pfb.70.2020.12.29.07.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 07:27:19 -0800 (PST)
From:   Tom Yan <tom.ty89@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH] block: avoid fragmented discard splits
Date:   Tue, 29 Dec 2020 23:27:13 +0800
Message-Id: <20201229152713.7269-1-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make bio_aligned_discard max_sectors() return value that is divisible by
the max_discard_sectors queue limit to avoid fragmented discard splits.

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
---
 block/blk.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 7550364c326c..e87324a227c6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -268,8 +268,12 @@ static inline unsigned int bio_allowed_max_sectors(struct request_queue *q)
 static inline unsigned int bio_aligned_discard_max_sectors(
 					struct request_queue *q)
 {
-	return round_down(UINT_MAX, q->limits.discard_granularity) >>
-			SECTOR_SHIFT;
+	unsigned int badms = round_down(UINT_MAX,
+					q->limits.discard_granularity) >>
+				SECTOR_SHIFT;
+	if (badms > q->limits.max_discard_sectors)
+		badms = round_down(badms, q->limits.max_discard_sectors);
+	return badms;
 }
 
 /*
-- 
2.29.2

