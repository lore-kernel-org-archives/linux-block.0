Return-Path: <SRS0=8/B6=VF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729DFC606C7
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 19:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E77217D8
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 19:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbfGHT6C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:58:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33156 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfGHT6C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jul 2019 15:58:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so8802376plo.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jul 2019 12:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WLDD912jzjrPwKAt7lEbrz9vTRGFlir5odRKcjtKCfE=;
        b=DhXqiLr1S+kFVoQ17mYyBm8eNUZfNxwtVghMgkBgN3fBUDPN8rfWRgGH+j0JW1z2+T
         nRdZ5XzhV9YXH5weq+R0etwAkahzLbkpScr5TuKLIAVt0vHeO+8JnEj7zqJwjYhXB0Zw
         8PwKIKTNcbWekTTJI292NCcM9pxTkMfs6S/Wjpo0BNy9lvLw5eWchNSKmOvChzX31sOx
         jVWzH6RMzEhL58Y6fQaS5CtK0Houe6cnNR7GG6dvD6S5sxmCOKzmM5t6vqOVpP0rzWo3
         dkDJ19ThU3/Uh8ndY3GtjWPtBEkpIx0xzBJIeBjaYW3QC6MH5MnnjS2LwhUy2tl0tAR3
         Qvnw==
X-Gm-Message-State: APjAAAUD8xtvXqlMl0bzp6GDL/hi6Ezynw/FX/YmBKqm/ymKpinRkNO6
        7ig2Wz7z4P/SRXJw2opI/h3oBT3Y
X-Google-Smtp-Source: APXvYqxiCpxFdJZmWdjmJZj0PI6jSE4SO3IZQ3flph7Kpc/9rvBdao7MUsudE9fulQBusIQrm57EPA==
X-Received: by 2002:a17:902:1081:: with SMTP id c1mr27441475pla.200.1562615881916;
        Mon, 08 Jul 2019 12:58:01 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t8sm298043pji.24.2019.07.08.12.58.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 12:58:01 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH liburing 3/4] Change __x86_64 into __x86_64__
Date:   Mon,  8 Jul 2019 12:57:49 -0700
Message-Id: <20190708195750.223103-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190708195750.223103-1-bvanassche@acm.org>
References: <20190708195750.223103-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch improves consistency with the Linux kernel source code.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 src/barrier.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/barrier.h b/src/barrier.h
index e1a407fccde2..eb8ee1ec9d34 100644
--- a/src/barrier.h
+++ b/src/barrier.h
@@ -31,7 +31,7 @@ after the acquire operation executes. This is implemented using
 #define READ_ONCE(var) (*((volatile typeof(var) *)(&(var))))
 
 
-#if defined(__x86_64) || defined(__i386__)
+#if defined(__x86_64__) || defined(__i386__)
 /* From tools/arch/x86/include/asm/barrier.h */
 #if defined(__i386__)
 /*
@@ -64,14 +64,14 @@ do {						\
 	___p1;					\
 })
 #endif /* defined(__x86_64__) */
-#else
+#else /* defined(__x86_64__) || defined(__i386__) */
 /*
  * Add arch appropriate definitions. Be safe and use full barriers for
  * archs we don't have support for.
  */
 #define smp_rmb()	__sync_synchronize()
 #define smp_wmb()	__sync_synchronize()
-#endif
+#endif /* defined(__x86_64__) || defined(__i386__) */
 
 /* From tools/include/asm/barrier.h */
 
@@ -92,4 +92,4 @@ do {						\
 })
 #endif
 
-#endif
+#endif /* defined(LIBURING_BARRIER_H) */
-- 
2.22.0.410.gd8fdbe21b5-goog

