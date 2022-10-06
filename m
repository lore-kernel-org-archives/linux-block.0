Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B122C433F5
	for <linux-block@archiver.kernel.org>; Thu,  6 Oct 2022 12:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiJFMWW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Oct 2022 08:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiJFMWU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2022 08:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63EF9DFA5
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665058937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=curPJ2N237W59qX/Eld5VxS77RbwV2c9wPIACxuEK8E=;
        b=WsctACYGaQb3Jl7W+KUc+Eu9laDxa4mOMGHBVJ0c+ECMem+na7HjttHaXUGR1XViDojYnj
        j++XSY4osOSf8V9KW93F4uieyWK3VZDoqZbZ9OJ+LLlIDWY16ayydNSFCg787gEQqCY+cu
        4FWbo4mMcbiI4Yky2IRcFb1yZMXn/2g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-47-IElWigN9P1yiHkEiMcE1ZQ-1; Thu, 06 Oct 2022 08:22:16 -0400
X-MC-Unique: IElWigN9P1yiHkEiMcE1ZQ-1
Received: by mail-wr1-f72.google.com with SMTP id r4-20020adfbb04000000b0022e5ec02713so469517wrg.18
        for <linux-block@vger.kernel.org>; Thu, 06 Oct 2022 05:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=curPJ2N237W59qX/Eld5VxS77RbwV2c9wPIACxuEK8E=;
        b=mtxHMpiemguEPDf+24HWgAC6q5D88OQsuISPTXkLNkYlHgn2bTb01K+hTvoxb46W+1
         IP1WgQg1yttylSsv/Hnd9hgu0AR6092R1ybU7GaTwwM+w5QYJ3nBLaV2wnLlzM1D/sXz
         TlelNayzB2MsWNOdRm6bZvQTgmWgz3LdMgEJ6AlIllDQ91nyGRtg9R5lsbyNgQwN8K4u
         5E5w3K5ZFEbzZ2pRpyBKQTEuADduH5tYKNvfQBh/0IjKVfgKHWI9ZAFkJWP5cSRso1jm
         g/+83OQsgC1nU+0eyexCCOT0XX0HWIR+PfYo3n9p9QSN4WHCFo+a6yRpkikf3A2w0IHt
         Z2IA==
X-Gm-Message-State: ACrzQf0Hjxy88G567jRVDNC3x3Y+XRZZG0iq0ALQqmA1TdQR1xjAX7pN
        sreWR/lgFItYPe7rIwu24tQTOayQN5sJTVfC6LdFdBB6PksDFKJxfzjr6zBRczxKXslXLApNI5r
        qn/+dliW/NtlEB5FhgXSQLO6UWekXJisAbySSLP50GTX3MlHI9z10Pbh7ZTsJh1cS/UPIjVr+YP
        E=
X-Received: by 2002:a05:6000:982:b0:229:79e5:6a96 with SMTP id by2-20020a056000098200b0022979e56a96mr2935637wrb.469.1665058933714;
        Thu, 06 Oct 2022 05:22:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6cBRqvDWKL6nogwn4jWqQOUP5QiNmUXGk3gstAcZf9U2hKbplHB+q+pomjYcPJEtgFuQ/ajw==
X-Received: by 2002:a05:6000:982:b0:229:79e5:6a96 with SMTP id by2-20020a056000098200b0022979e56a96mr2935618wrb.469.1665058933480;
        Thu, 06 Oct 2022 05:22:13 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003bdd2add8fcsm5004841wmq.24.2022.10.06.05.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:22:12 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH bitmap-for-next 2/4] lib/cpumask: Fix cpumask_check() warning in cpumask_next_wrap*()
Date:   Thu,  6 Oct 2022 13:21:10 +0100
Message-Id: <20221006122112.663119-3-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221006122112.663119-1-vschneid@redhat.com>
References: <20221006122112.663119-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Invoking cpumask_next*() with n==nr_cpu_ids-1 triggers a warning as there
are (obviously) no more valid CPU ids after that. This is however undesired
for the cpumask_next_wrap*() family which needs to wrap around reaching
this condition.

Don't invoke cpumask_next*() when n==nr_cpu_ids, go for the wrapping (if
any) instead.

NOTE: this only fixes the NR_CPUS>1 variants.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 lib/cpumask.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index 6e576485c84f..f8174fa3d752 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -12,11 +12,11 @@
 	unsigned int next;						\
 									\
 again:									\
-	next = (FETCH_NEXT);						\
+	next = n == nr_cpu_ids - 1 ? nr_cpu_ids : (FETCH_NEXT);		\
 									\
 	if (wrap && n < start && next >= start) {			\
-		next = nr_cpumask_bits;					\
-	} else if (next >= nr_cpumask_bits) {				\
+		next = nr_cpu_ids;					\
+	} else if (next >= nr_cpu_ids) {				\
 		wrap = true;						\
 		n = -1;							\
 		goto again;						\
-- 
2.31.1

