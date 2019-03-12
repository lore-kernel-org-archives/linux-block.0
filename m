Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42ACC10F00
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 09:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C2321734
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 09:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ue6lNa/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfCLJAV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:00:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36064 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbfCLJAU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 05:00:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id e16so1583918wme.1
        for <linux-block@vger.kernel.org>; Tue, 12 Mar 2019 02:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aRWEDuQLWzp3URwu3pEoQcxfbAgAvx//BghTXCmLhvY=;
        b=Ue6lNa/IGugqpb8G8XwSn8P7Ea14AkFs7WXIwTTyDArhtqfVLe0x3+HLZ1T0DZ8Eax
         bX96iBvYX9PsZ/0+POi5uuLv3jY2F6mBSw/KOYquh2SAh0cu6KOD70ebJOREmvaT84oZ
         sQbnWzznM8V3rUlztaVZXXoK5f0w5feFoxvisAda+4oE2oZOREV9NEhUbTQtarSNKwiL
         O03BotWBaW0vcvh+ZbkyfSo9RbUyadc1eZT2AubADPr8PJlYnV3xymmFJAfgk8slXdDP
         4lBS0LHpSh1cEjLjI4YscAfY+e1V7MA1Ld3rURKRiBcKMjdg9JqMJOKGa83KTnZYHQPt
         Bh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRWEDuQLWzp3URwu3pEoQcxfbAgAvx//BghTXCmLhvY=;
        b=c76XsLN7dLSWNeHi3s+c14u7imBAMk7+vKKVwTsm+ttic4rgGQfWrm5RaixnxrYMCK
         ef9iIVUxnYbRWEu6gs2M+OlSD2+58SY2k0U8OGxBFAqK9mud02zDXE5KmKRoYd4gQpj/
         Y9GlslRP6rR8MPuOji/TCVhUEj0xT/XQECYlVRcghfcD3iPT0iUyh4sDY5y+U7s/0yYA
         bwKZ4uqUWGI5irNr6lv8jCGUk6Ax5dQ7xM0HTuPeWEr9K97of7oe7bamLOxTnD7cMF6z
         ynfgqut8cPPRbjLLv59R4vx1JWjEgdHbIvIMZU+czS5TqCjni4dd09lRQetp8m+L7Rq0
         tCCA==
X-Gm-Message-State: APjAAAUF0rPGg51mgsfeIVO+svuszFKK1mQcZNn1sMlV9sGQGQ/rHr3Z
        XcD+83YA9l+HIXQFmVAs1he6Ig==
X-Google-Smtp-Source: APXvYqywtnTOoBnMyi9evXjAv4mjAywoKGxROLD64v41L651SZ1Vx1BFCqLajmRwnelI1shMipILYg==
X-Received: by 2002:a7b:cb8e:: with SMTP id m14mr1444020wmi.64.1552381218249;
        Tue, 12 Mar 2019 02:00:18 -0700 (PDT)
Received: from localhost.localdomain ([84.33.65.66])
        by smtp.gmail.com with ESMTPSA id y20sm3953043wmi.34.2019.03.12.02.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 02:00:17 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        alessio.masola@gmail.com, holger@applied-asynchrony.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V3 9/9] doc, block, bfq: add information on bfq execution time
Date:   Tue, 12 Mar 2019 09:59:35 +0100
Message-Id: <20190312085935.11340-10-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312085935.11340-1-paolo.valente@linaro.org>
References: <20190312085935.11340-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The execution time of BFQ has been slightly lowered. Report the new
execution time in BFQ documentation.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 Documentation/block/bfq-iosched.txt | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/Documentation/block/bfq-iosched.txt b/Documentation/block/bfq-iosched.txt
index 98a8dd5ee385..1a0f2ac02eb6 100644
--- a/Documentation/block/bfq-iosched.txt
+++ b/Documentation/block/bfq-iosched.txt
@@ -20,13 +20,26 @@ for that device, by setting low_latency to 0. See Section 3 for
 details on how to configure BFQ for the desired tradeoff between
 latency and throughput, or on how to maximize throughput.
 
-BFQ has a non-null overhead, which limits the maximum IOPS that a CPU
-can process for a device scheduled with BFQ. To give an idea of the
-limits on slow or average CPUs, here are, first, the limits of BFQ for
-three different CPUs, on, respectively, an average laptop, an old
-desktop, and a cheap embedded system, in case full hierarchical
-support is enabled (i.e., CONFIG_BFQ_GROUP_IOSCHED is set), but
-CONFIG_DEBUG_BLK_CGROUP is not set (Section 4-2):
+As every I/O scheduler, BFQ adds some overhead to per-I/O-request
+processing. To give an idea of this overhead, the total,
+single-lock-protected, per-request processing time of BFQ---i.e., the
+sum of the execution times of the request insertion, dispatch and
+completion hooks---is, e.g., 1.9 us on an Intel Core i7-2760QM@2.40GHz
+(dated CPU for notebooks; time measured with simple code
+instrumentation, and using the throughput-sync.sh script of the S
+suite [1], in performance-profiling mode). To put this result into
+context, the total, single-lock-protected, per-request execution time
+of the lightest I/O scheduler available in blk-mq, mq-deadline, is 0.7
+us (mq-deadline is ~800 LOC, against ~10500 LOC for BFQ).
+
+Scheduling overhead further limits the maximum IOPS that a CPU can
+process (already limited by the execution of the rest of the I/O
+stack). To give an idea of the limits with BFQ, on slow or average
+CPUs, here are, first, the limits of BFQ for three different CPUs, on,
+respectively, an average laptop, an old desktop, and a cheap embedded
+system, in case full hierarchical support is enabled (i.e.,
+CONFIG_BFQ_GROUP_IOSCHED is set), but CONFIG_DEBUG_BLK_CGROUP is not
+set (Section 4-2):
 - Intel i7-4850HQ: 400 KIOPS
 - AMD A8-3850: 250 KIOPS
 - ARM CortexTM-A53 Octa-core: 80 KIOPS
@@ -566,3 +579,5 @@ applications. Unset this tunable if you need/want to control weights.
     Slightly extended version:
     http://algogroup.unimore.it/people/paolo/disk_sched/bfq-v1-suite-
 							results.pdf
+
+[3] https://github.com/Algodev-github/S
-- 
2.20.1

