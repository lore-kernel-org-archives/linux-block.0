Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C6EC05027
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 23:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjBIXBq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 18:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjBIXBo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 18:01:44 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2557EEE
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 15:01:43 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id u9so4609641plr.9
        for <linux-block@vger.kernel.org>; Thu, 09 Feb 2023 15:01:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsoJBcPOtEbVblkphgVRBPSm8oYIqlJ0jiZODV70ln4=;
        b=Hj6nN5oSIqiJLMp9E95DPudSBAm2j5wNH1OuqLezEMSnfAksg6LuOdBsDRWvuYxKtZ
         LGCk2g12Q4UrUDdrf97Zw6xnAkLKmonEut26R1cXNZBvcwCa7DxPGNiTu/xvZZI4I0mb
         4eIZx0teLeRPw+3oxww69ZFUF4SoNQaQnrSxgqCvbucBOFHJtFdtFzagSBIwxqiI6LG+
         cDMNFFVFszsqa968Pb3J4CCwucfYAyP7JN508djmEwxGAStnoCp2Z/Av+RakBinlUqXy
         orhO4c49xSGnL8NcK6gI/3K9eFWhthx4oY2Fhy9l2tUZXmVw4QpwvWE9FfvvQFHxOnQW
         QrWw==
X-Gm-Message-State: AO0yUKXeXYR0V+SawAizfB3AgtOHfaKDiJzZ4QeuztjTQtoWD7mK8yDn
        lAfFJxKcPM/ampGp8lAWNXU=
X-Google-Smtp-Source: AK7set8+TJJklmFv/N0iXgDNB+Crqz/ld4eKa2EI+J19kImtO2ZFsOxvUM3zZk8GHjPpWJUwHNZQRQ==
X-Received: by 2002:a17:90b:4b07:b0:22b:efa5:d05 with SMTP id lx7-20020a17090b4b0700b0022befa50d05mr14357821pjb.40.1675983703324;
        Thu, 09 Feb 2023 15:01:43 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:15f5:48f5:6861:f3f6])
        by smtp.gmail.com with ESMTPSA id k14-20020a17090a39ce00b00231156a7da1sm1639758pjf.4.2023.02.09.15.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 15:01:42 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH] block: Remove the ALLOC_CACHE_SLACK constant
Date:   Thu,  9 Feb 2023 15:01:35 -0800
Message-Id: <20230209230135.3475829-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit b99182c501c3 ("bio: add pcpu caching for non-polling bio_put")
removed the code that uses this constant. Hence also remove the constant
itself.

Cc: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 7447302141b7..88cd3f67a3af 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -26,7 +26,6 @@
 #include "blk-cgroup.h"
 
 #define ALLOC_CACHE_THRESHOLD	16
-#define ALLOC_CACHE_SLACK	64
 #define ALLOC_CACHE_MAX		256
 
 struct bio_alloc_cache {
