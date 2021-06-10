Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27FAC47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 07:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8CFA61403
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 07:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFJHZx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 03:25:53 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:41896 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhFJHZq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 03:25:46 -0400
Received: by mail-pf1-f179.google.com with SMTP id x73so856144pfc.8;
        Thu, 10 Jun 2021 00:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qyBuZeZX6dtvZpGO9NcSkjgX81PiW8wDc10wk8ErfMI=;
        b=ay27z07UJe5f99aVc8Wm6XMU5pD0Jyj8cc4G0sB201LrbK836nLaI/nJ6vTIcrTV6+
         zCRIwCx8iscVMv1YvCToeLtpzrxtG4j33C8mQBQdGctaQ7KDqIYlj1kmSL/VTylxODqi
         t51YJEvWHzw3VGX0cFavm4z35he9sup955uSR35EBDhJPGC2FzVMxA0T5aGVmFSV5+9i
         KLV42J5hJ1/cyG4P+RrNY0rrd9cWATHly+0B2yKbTcWuEDe3CMU3c83b2OGW4qjkkWrg
         o+Cc1sF19JEBDewlajdjGLIqblmdtgS0Y7LRwlVz76DyAOnGbsnesiSlWNmPUy+oHi33
         j+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qyBuZeZX6dtvZpGO9NcSkjgX81PiW8wDc10wk8ErfMI=;
        b=oLEzF5ru328zjF3mIfMA7+Tj7VLMlt9T6mKntWtTKuk5Odql+Kc8UynQz85oe3sXq8
         jjubbOm1i9P50pN5StJEHDbLvgQpXGw3u2gpc1YOMDbQHzziOjsK85uVP7VRIndu/pt5
         gndAwid44yul1pOzk7p2OPKoULaWz9Y4as3d3VLvjkYUqSJv9iYINwX94qF4rDuzSa0a
         qA+Q/cfr7WYutj6E5UDUG7Dgz4kdZ8xDZoC0tTiHTi4451X2mJPgUqkTtJbOIR5IYV0Q
         LBWz8+B09lX2rBt4yBTfAzyd1FKwTRMDa5GvC4Lo4w7NPhcWszvJcyZ4K/wQ4OOYBQ5r
         w7CQ==
X-Gm-Message-State: AOAM532/mSaQD7J2+Ysr97/LWPxJaX5OgADgmRQy+t5Z/SpF8uAvlALA
        GDtKMPxwzlAx5qCxtO4hJ2/g5VSB0g9ieoF0
X-Google-Smtp-Source: ABdhPJwpg1/G8MUkz24RDJhbvkoYfMyl+Op63ZYE1k330yDigifdf9MVazAJzeRZnU0rUEzXk8pHqA==
X-Received: by 2002:a63:b30f:: with SMTP id i15mr3700331pgf.62.1623309770098;
        Thu, 10 Jun 2021 00:22:50 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id u24sm1591310pfm.200.2021.06.10.00.22.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jun 2021 00:22:49 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 8/8] bfq: remove unnecessary BFQ_DEFAULT_GRP_IOPRIO
Date:   Thu, 10 Jun 2021 15:22:37 +0800
Message-ID: <86124148b8364995021f8c53737c68b04b524421.1618916839.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1ce935f1bb10e0c7ecea7b79b826ff4cfc89acf0.1618916839.git.brookxu@tencent.com>
References: <1ce935f1bb10e0c7ecea7b79b826ff4cfc89acf0.1618916839.git.brookxu@tencent.com>
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
Message-ID: <20210610072237.sotLrN_JL3-p3tRmnRWNn4wE38SWpAOkgon9dlbQ3OA@z>

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

