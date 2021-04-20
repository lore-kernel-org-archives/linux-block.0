Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6571C433B4
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 11:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADBD9613AE
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 11:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhDTLVT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 07:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhDTLVN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 07:21:13 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA1AC06138A;
        Tue, 20 Apr 2021 04:20:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 10so16439379pfl.1;
        Tue, 20 Apr 2021 04:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qyBuZeZX6dtvZpGO9NcSkjgX81PiW8wDc10wk8ErfMI=;
        b=NU0gWB3bLQ/YvHQsoTXeQe3pmYJZZl1J/jfFrLtU2wvFbkpH3hXsng9vbM/vRpqXG3
         OiUkRcwNMKrHCRqai8Sl1pD4hzAE9dOpESZHBiusyaT12PTasOqQPYpinnRENhqCX9nh
         6bcXJVi0szFfSL3VLc2QGi4RWOTQJXCNP0ALeoYq2nTe23olNwdAVu7osIYlmbWRvH5h
         uWWqPhk1Y+XnjoOopFweN/nxn59T9yIm84UDOtuc7ubZjO6+15bCokaZvdxguOaxQA5W
         YJUkEHv4FsoqqO+WzwO4kF+zDfJrp/pmdjLvAfBGHPeZO4nAju/CHGMWjh/d04ne743X
         s42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qyBuZeZX6dtvZpGO9NcSkjgX81PiW8wDc10wk8ErfMI=;
        b=uFguUPFyXGQRz8PUoLdaimVkafybe/YvaG8enHnAqmsi3rA1ypKE6JdWE2qs9lfK0r
         +cc2NmdrbFzBvVDMUY49ElhfB+OL03y1+co7Bj6jk5iKZzO1sJ09RHdyzRfNceAPtTjC
         43vK0ccBHmDodxlmSASb/Vi8oOSpSK7ouUHf1/73EG+K4htjvWpfWraF3rB5nHalhHNg
         vqlMriCypP7o6ueWC/9yqsfRfHaDbjdWrWzYPgLecuXTWr2Wc3JhZdxRRPS/NGwhoKaN
         Oog3MHQjwgGY8WB3sOOV+OuX7UUO4GGAF5ULsugliiUO6PzawICBoasWN7XYRMHp+Bzx
         mNVQ==
X-Gm-Message-State: AOAM531F5k9PCQaeJpRtR1ocgKPmfiPxdaAsYXfncXL3F0qS7XUDQxCz
        3wRtfOu1022gRNDnVgWC0cI=
X-Google-Smtp-Source: ABdhPJwhOxy0VK8F9MrLulaJA9BdFiF57r0Uaq1SQynmOi1loZJ5nVr1scbbkEP5nCfAKKwNFD6Oig==
X-Received: by 2002:a63:d552:: with SMTP id v18mr16318729pgi.313.1618917639488;
        Tue, 20 Apr 2021 04:20:39 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id s40sm14187367pfw.100.2021.04.20.04.20.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Apr 2021 04:20:39 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] bfq: remove unnecessary BFQ_DEFAULT_GRP_IOPRIO
Date:   Tue, 20 Apr 2021 19:20:25 +0800
Message-Id: <86124148b8364995021f8c53737c68b04b524421.1618916839.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

BFQ_DEFAULT_GRP_IOPRIO seems to be unused, maybe we can remove it.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index da636a8..91c8654 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -22,7 +22,6 @@
 #define BFQ_DEFAULT_QUEUE_IOPRIO	4
 
 #define BFQ_WEIGHT_LEGACY_DFL	100
-#define BFQ_DEFAULT_GRP_IOPRIO	0
 #define BFQ_DEFAULT_GRP_CLASS	IOPRIO_CLASS_BE
 
 #define MAX_PID_STR_LENGTH 12
-- 
1.8.3.1

