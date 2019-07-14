Return-Path: <SRS0=YXNx=VL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B16C73C66
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 05:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0692120896
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 05:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWKL9bHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfGNFeV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Jul 2019 01:34:21 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33822 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfGNFeU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Jul 2019 01:34:20 -0400
Received: by mail-qk1-f195.google.com with SMTP id t8so9408138qkt.1;
        Sat, 13 Jul 2019 22:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/EoMKvA7LMbo/vu4SOb/7kRISG3BgdNOTb3ypybO3Q=;
        b=UWKL9bHCbUvuwHZwmHr7C9W9hoiBDFQ5FZAyDtluL7eQb9IXB34gRxb6B4LMEgWC70
         REA2canvhjACn3+2M++sw1YpCekM8IgEht11H1foWBjAwVKcZ97Y4Kh7eL4eBh4VXZxA
         t76WjJ8iTihZ54eBMrNFJFbOSEsiLA68WDzLEsHqlUtNU2MOH0Bt/2/gcfTL5BfsIjxE
         6VVvtsNygpnxleNbQnwd0yzZ4OAU31GPOB4zmFYU24I3RXzcLGdz4JJ+X339FZHElrgx
         FrvH+R3MSvX8B8ijXVs2THus7PDGuhVqrlUAULKRcd25rUkGdngVi1/zYz8dXH0qVgg7
         EHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/EoMKvA7LMbo/vu4SOb/7kRISG3BgdNOTb3ypybO3Q=;
        b=XRrtQmg3T5dBtnHbXthyBKru1BcKhVZwWfcQHdFtgwRJ/58zIOWmgcbKOYKSRAMza8
         ndHjOLietDowvebM1qc1GALsSVyOn9GAZnsBo/9wb1GD9mGJMkIrKdtq4wcLrTExlgf2
         PMgcEPxr6V0iAatql+973H28NzIO3vThpdMNp4ObiTjc4abF6Xg+lJG0mDFZjSgRF+7y
         EM+Tnh1xFgEL6LL1SKmIEVN3w1dAdcrBluv9S5gd0jnZvm3rlFvB0qv1r0RxqnEzrHji
         6OnZRc14zkKqKMHhkKO5yDASrTDDto1E7OqsoACu/VIomhGnnwl5Fi2XKTECZ/BIIpbN
         c/SA==
X-Gm-Message-State: APjAAAVAEnvETjBi2Ygy8+SryppRhPqFzj599WpWYJrsHnJx3CkF20vY
        i+YF/TZRbMoLo/NAC7cC1gK/N9+Icb143g==
X-Google-Smtp-Source: APXvYqyx8HDiS3VjIeQto3WQVquKpau3BmzLL5QKu7BDJcfWCBtNwY3kmTjL9v6B14SG2TsdV1bsFg==
X-Received: by 2002:a37:a851:: with SMTP id r78mr12238218qke.120.1563082458591;
        Sat, 13 Jul 2019 22:34:18 -0700 (PDT)
Received: from localhost.localdomain ([191.35.237.35])
        by smtp.gmail.com with ESMTPSA id f133sm6308808qke.62.2019.07.13.22.34.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 13 Jul 2019 22:34:17 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/4] kernel-parameters.txt: Remove elevator argument
Date:   Sun, 14 Jul 2019 02:34:51 -0300
Message-Id: <20190714053453.1655-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190714053453.1655-1-marcos.souza.org@gmail.com>
References: <20190714053453.1655-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This argument was not being used since the legacy IO path was removed,
when blk-mq was enabled by default. So removed it from the kernel
parameters documentation.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 099c5a4be95b..2f47b20ee413 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1197,12 +1197,6 @@
 			See comment before function elanfreq_setup() in
 			arch/x86/kernel/cpu/cpufreq/elanfreq.c.
 
-	elevator=	[IOSCHED]
-			Format: { "mq-deadline" | "kyber" | "bfq" }
-			See Documentation/block/deadline-iosched.txt,
-			Documentation/block/kyber-iosched.txt and
-			Documentation/block/bfq-iosched.txt for details.
-
 	elfcorehdr=[size[KMG]@]offset[KMG] [IA64,PPC,SH,X86,S390]
 			Specifies physical address of start of kernel core
 			image elf header and optionally the size. Generally
-- 
2.22.0

