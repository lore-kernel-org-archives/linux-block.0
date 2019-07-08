Return-Path: <SRS0=8/B6=VF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA1FC606C7
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 19:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA98320665
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 19:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfGHT6E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:58:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33159 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404764AbfGHT6E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jul 2019 15:58:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so8802404plo.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jul 2019 12:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U9NfZwKpuw+69CvEMSkySDQ59exe3yo4iukAW/BQ6wc=;
        b=XvgiCSjAugFQsd7+7yHxRnSBudao10RmRokb75QQjflboi4BntNPZDKCsTdioczdkY
         eKnn4dOyXUIcLleRU3g0Ww+XQ9Ps2Ghils5ZjQBb9M4ugM/QV23tgWsjqTANG77q2lJ5
         E7BRa3EWPR7DjEei8xW+g4hnVrOrKRSHLYrjU7ITijyDvDhy4Vw5uShH2bE/5LzX3EdF
         ODONX4iZupajy7BCZNQqp3KUEkHBrC14KPGuH1BNBseuOk95mcG7EkDkks0GY4l6DCz6
         niFcYKhIWPAWWJb9TZZVDqCZNWqXWMNZHKQRo3pOVFwUg4gMKKT45IF2JIwii/HixsMn
         gGVQ==
X-Gm-Message-State: APjAAAWDiBhH1E272cF4XSYhVIONCc6we7Sg+4G9S6aqLO/Xy9DtOOSJ
        san7LXzW/J3PtfEIqdZfaGE=
X-Google-Smtp-Source: APXvYqwz02OHafJKHzGg2IXPiN4N3ViK9/qNEjKVgWjjmxEucipFjuZYXCJcj1RTiavXZfidbAmWGA==
X-Received: by 2002:a17:902:934a:: with SMTP id g10mr27722272plp.18.1562615883305;
        Mon, 08 Jul 2019 12:58:03 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t8sm298043pji.24.2019.07.08.12.58.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 12:58:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Roman Penyaev <rpenyaev@suse.de>
Subject: [PATCH liburing 4/4] Optimize i386 memory barriers
Date:   Mon,  8 Jul 2019 12:57:50 -0700
Message-Id: <20190708195750.223103-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190708195750.223103-1-bvanassche@acm.org>
References: <20190708195750.223103-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use identical memory barrier implementations on 32 and 64 bit Intel CPUs.
In the past the Linux kernel supported 32 bit CPUs that violate the x86
ordering standard. Since io_uring is not supported by these older kernels,
do not support these older CPUs in liburing. See also Linux kernel commit
5927145efd5d ("x86/cpu: Remove the CONFIG_X86_PPRO_FENCE=y quirk") # v4.16.

Cc: Roman Penyaev <rpenyaev@suse.de>
Suggested-by: Roman Penyaev <rpenyaev@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 src/barrier.h | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/src/barrier.h b/src/barrier.h
index eb8ee1ec9d34..e079cf609f26 100644
--- a/src/barrier.h
+++ b/src/barrier.h
@@ -32,25 +32,18 @@ after the acquire operation executes. This is implemented using
 
 
 #if defined(__x86_64__) || defined(__i386__)
-/* From tools/arch/x86/include/asm/barrier.h */
-#if defined(__i386__)
-/*
- * Some non-Intel clones support out of order store. wmb() ceases to be a
- * nop for these.
- */
-#define mb()	asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
-#define rmb()	asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
-#define wmb()	asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
-#elif defined(__x86_64__)
+/* Adapted from arch/x86/include/asm/barrier.h */
 #define mb()	asm volatile("mfence" ::: "memory")
 #define rmb()	asm volatile("lfence" ::: "memory")
 #define wmb()	asm volatile("sfence" ::: "memory")
 #define smp_rmb() barrier()
 #define smp_wmb() barrier()
+#if defined(__i386__)
+#define smp_mb()  asm volatile("lock; addl $0,0(%%esp)" ::: "memory", "cc")
+#else
 #define smp_mb()  asm volatile("lock; addl $0,-132(%%rsp)" ::: "memory", "cc")
 #endif
 
-#if defined(__x86_64__)
 #define smp_store_release(p, v)			\
 do {						\
 	barrier();				\
@@ -63,7 +56,6 @@ do {						\
 	barrier();				\
 	___p1;					\
 })
-#endif /* defined(__x86_64__) */
 #else /* defined(__x86_64__) || defined(__i386__) */
 /*
  * Add arch appropriate definitions. Be safe and use full barriers for
-- 
2.22.0.410.gd8fdbe21b5-goog

