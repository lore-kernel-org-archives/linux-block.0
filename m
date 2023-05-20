Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC9AC77B7A
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 05:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjETFbr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 01:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjETFbp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 01:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E0AE43
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 22:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684560625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5R/eziRcvPt6iSCgjIp0QHa49sOUGI4wJ6ZtOXpi8M=;
        b=JklQXwtzv+rDp6mmJqBLj2/6v6dLzi3Ku9pBL7ZefLZ8cUyx5mDi+1mwdm2ZBWmLQYH6nt
        cuycVqjcxp9SiiMV4PC8q4YiyHOX0yuwgFvvozWLLd8arR4n47JhYcZzNGi53ESqGYnOIN
        /ayTFdWmTpHb43nvY6x5V0mXX0lPrro=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-gVtAb-KJOd6JURXhgNxLBA-1; Sat, 20 May 2023 01:30:24 -0400
X-MC-Unique: gVtAb-KJOd6JURXhgNxLBA-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-54f7c080d4eso2681558eaf.2
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 22:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684560624; x=1687152624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5R/eziRcvPt6iSCgjIp0QHa49sOUGI4wJ6ZtOXpi8M=;
        b=ZUYKgLAPetuifGTI+tPJwZsFOWsVNSgAZXiGdT5U6+oUJT54sCoIUt1ouMVqRuQHa8
         flRtsCLWEx/BlRKNB17LlON2mPx6at/OQ3QyCdL+acSk82u7fuL9S2lmAupSIOpwVO6E
         1rEI/NueiTSgaugPuoTllt9ivL3p1JEjFw2+YUAwExRIAVn6qcuZLZ15EDxwZ2RXaWAx
         5J7Wi7kKJo59UhXTZum7BT6AoGrxs74dc+4pR5/0VejwUy8pmvSnUXL2RZEDORMom0xA
         6qw53BqP2l3rwZD7JmK1HWw5/vryokG2NPQNux6PaaBta65WYD4cbZ9QRslLNXSrL0nc
         NXjg==
X-Gm-Message-State: AC+VfDzwq3vr5JlW1sc1/JrBepibtDK2q+J5xACRN0DqmGGL9SD09ZKu
        HL0bbI4lC5PyE+87INix0jm/GHRFz/VGdtrGIjOQ4RpDfkAIGJAZwYy4aIH+V1Frp1olMrTR0mo
        N9tlwiizUyN12XclTiNLW0Vk=
X-Received: by 2002:a54:4084:0:b0:389:72d5:f16f with SMTP id i4-20020a544084000000b0038972d5f16fmr2408183oii.28.1684560623805;
        Fri, 19 May 2023 22:30:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7A0W4HoYMf/xUd3PGw3uwZk5Jkp2rgdxrbOEmM8UvnmIJl3NhXZog88XAfQsdp6q4b+mgawQ==
X-Received: by 2002:a54:4084:0:b0:389:72d5:f16f with SMTP id i4-20020a544084000000b0038972d5f16fmr2408178oii.28.1684560623624;
        Fri, 19 May 2023 22:30:23 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
        by smtp.gmail.com with ESMTPSA id j14-20020a4ad6ce000000b005524555de56sm365494oot.36.2023.05.19.22.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 22:30:23 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Leonardo Bras <leobras@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/3] smp: Change signatures to use call_single_data_t
Date:   Sat, 20 May 2023 02:29:58 -0300
Message-Id: <20230520052957.798486-4-leobras@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230520052957.798486-1-leobras@redhat.com>
References: <20230520052957.798486-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Every caller of smp_call_function_single_async() now makes use
of call_single_data_t, which is a size-aligned typedef of
struct __call_single_data.

Changing smp_call_function_single_async() csd parameter to
call_single_data_t makes possible to warn future callers if they
are using an unaligned csd, which can cause it to be split between 2
cachelines, which is usually bad for performance.

Also, for the same reason, change generic_exec_single().

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/linux/smp.h | 2 +-
 kernel/smp.c        | 4 ++--
 kernel/up.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 91ea4a67f8ca..e87520dc2959 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -53,7 +53,7 @@ int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask);
 
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd);
+int smp_call_function_single_async(int cpu, call_single_data_t *csd);
 
 /*
  * Cpus stopping functions in panic. All have default weak definitions.
diff --git a/kernel/smp.c b/kernel/smp.c
index ab3e5dad6cfe..919387be6d4e 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -361,7 +361,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
  * for execution on the given CPU. data must already have
  * ->func, ->info, and ->flags set.
  */
-static int generic_exec_single(int cpu, struct __call_single_data *csd)
+static int generic_exec_single(int cpu, call_single_data_t *csd)
 {
 	if (cpu == smp_processor_id()) {
 		smp_call_func_t func = csd->func;
@@ -645,7 +645,7 @@ EXPORT_SYMBOL(smp_call_function_single);
  *
  * Return: %0 on success or negative errno value on error
  */
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
+int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 {
 	int err = 0;
 
diff --git a/kernel/up.c b/kernel/up.c
index a38b8b095251..df50828cc2f0 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -25,7 +25,7 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
+int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 {
 	unsigned long flags;
 
-- 
2.40.1

