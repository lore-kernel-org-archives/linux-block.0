Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F4DC7EE25
	for <linux-block@archiver.kernel.org>; Thu, 11 May 2023 09:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjEKJAL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 May 2023 05:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbjEKJAI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2023 05:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A7E26B7
        for <linux-block@vger.kernel.org>; Thu, 11 May 2023 01:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683795565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4sCGS8g+MdKX57yXJGIoLC1S6g4uvx8ZDn5dLzJJFmk=;
        b=T0xWzBNcPGShQGV3lMZAXPKf69PMXZ0DS2LP1iTbrXmtxvHwISAWuUyMhLlzLzQg+NCmQG
        +TK/MNeQRdBgyr7s0PQ7QW42ud9oauYgiZKcBpoBT05I1cSgvmGAYW99yX2pCpCmWI74+J
        B3mSmRRE0KPKbGaCN/GQiX072vHxWD0=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-QHc3kSJXPaiZ3GIoLRF1PQ-1; Thu, 11 May 2023 04:59:24 -0400
X-MC-Unique: QHc3kSJXPaiZ3GIoLRF1PQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6ab0b03e2f5so3181304a34.1
        for <linux-block@vger.kernel.org>; Thu, 11 May 2023 01:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683795564; x=1686387564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sCGS8g+MdKX57yXJGIoLC1S6g4uvx8ZDn5dLzJJFmk=;
        b=T3QIpwhhLA+3/LbsiXJItB9PVcEpFqHyRN8Dq1hyDz23rFuxXD076NfdcWkzwd20bL
         1FYPAVuSKZLQ33MlpWcboWNQEUUt+Sc7WVgQnu3P61P0aNASs2OwgCJCrZdPaSghPBBs
         puB7jD4M9LwnzBet8pUVk2UYHzmFRrG8CJODxmMjpNaabREqdcHkbR6X+H/el3Do7KT9
         5AbMrp3HEmm54vuEqcGhDXH2MGcoQVDmMrtDsEqTX48bI6yZFDMVURAoF2yWmcyRzkdB
         kk1ToYwSQdMKEqt2u+y9CwQmkR9cw+PHWDwGgWY71nFP+7N0jROl8xPFVSpQaGwk/wTe
         aI4Q==
X-Gm-Message-State: AC+VfDxdhHbcgly+58E/90d9EhRZhR12xTBomA3AdcLRDHPMsQZub977
        Ba0QbQhgXoONHPS4Xd1xuVIf10A9+JV3f/Lpuhb5N53Jn6v3XcKy9HB81CbmNMdt6pP2fmt5Gou
        koVw9arVoqMHWlC3cp7O3YV4=
X-Received: by 2002:a9d:6253:0:b0:6ab:2a4e:164d with SMTP id i19-20020a9d6253000000b006ab2a4e164dmr2972809otk.4.1683795564075;
        Thu, 11 May 2023 01:59:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5K7n/kGTL09SDaGzXNLPi5EchgQfhVFLgmK4OjwoScZX8Az3coqnQpGqPw2Qy2DCKRtGbUnA==
X-Received: by 2002:a9d:6253:0:b0:6ab:2a4e:164d with SMTP id i19-20020a9d6253000000b006ab2a4e164dmr2972805otk.4.1683795563887;
        Thu, 11 May 2023 01:59:23 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a803:3602:abec:117:3c19:43b8])
        by smtp.gmail.com with ESMTPSA id d1-20020a056830004100b006a42e87aee4sm1039300otp.32.2023.05.11.01.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 01:59:23 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Leonardo Bras <leobras@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] smp: Change signatures to use call_single_data_t
Date:   Thu, 11 May 2023 05:58:38 -0300
Message-Id: <20230511085836.579679-2-leobras@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511085836.579679-1-leobras@redhat.com>
References: <20230511085836.579679-1-leobras@redhat.com>
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
 kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
 
-- 
2.40.1

