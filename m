Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C32AC433FE
	for <linux-block@archiver.kernel.org>; Thu,  6 Oct 2022 12:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiJFMW3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Oct 2022 08:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiJFMWW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2022 08:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123059E0D3
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665058938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f4FcB3FE0QSiF1o1I/AAbf5Q+pSSTlAAyOWClq2LzM8=;
        b=G4I7hMgqs18gldrd5WbSIW3Pn239hbI9WXBHEtCW9maInU4hBac/KgSujQd2IFuRdPswqT
        wffzr2otTgXERG2Lrsly6spS/9J8L87rZyYj9Ln5fzBcSHcWF7Km7H+ei+jwEZqgemRBzi
        91P2dhAWNWC1mJcrGfAJpngez5sSeYA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-222-fUcg-duiNDuwXAm-eEWwUw-1; Thu, 06 Oct 2022 08:22:14 -0400
X-MC-Unique: fUcg-duiNDuwXAm-eEWwUw-1
Received: by mail-wr1-f69.google.com with SMTP id d22-20020adfa356000000b0022e224b21c0so466482wrb.9
        for <linux-block@vger.kernel.org>; Thu, 06 Oct 2022 05:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4FcB3FE0QSiF1o1I/AAbf5Q+pSSTlAAyOWClq2LzM8=;
        b=fy2KYzYbrMDKwku1rb0PH1n7ER9IMb1sCn87xlyPBIaLOIFGGrOkrFI0zQx6+XzIh2
         zBc0t8QUWLMrUiPmEASEzx+T0xHKxR7VAXvwzuwEWKHAWakgU9gtst0kXQhMsdik76xy
         ogVVuLg2ksS/cvF2w3DoqltVWcc/WSFemeI3hlftbBGTWdD90KKqIEBQ75rVWnThC455
         Ktnybp0dYXDJAEC3gwTGv17NYOevzpYxSockzFyIXxBCyidgl+6tGAYm+HXOJnewaz7Y
         EFb6YbxxB1GOnwqGuXLYQtjENdp0W8PTb4JEBf5Dr4GF/OVrdNaDyMUXcqMFZgczEuFB
         TK7Q==
X-Gm-Message-State: ACrzQf03ku85F0LlsC1ckATSj4+ikRrWJTbyAalQFn0vb3h24CS3kx5O
        sG71RkYO6ZOn5Z3nv+r3gjBJnErkmVeKoaL+euAvQT2CIUqXIN3BhUnPFC7ZUM0gtXRoKuifO6R
        EEWun8OxqE/fEMcDZJFnJp8FEku5MyeoMfjibUaSEFRzVYbAaAXYEerdyqevfU3Zyfp50v8igiJ
        s=
X-Received: by 2002:adf:ec83:0:b0:22e:51e2:7fc7 with SMTP id z3-20020adfec83000000b0022e51e27fc7mr2889045wrn.229.1665058931990;
        Thu, 06 Oct 2022 05:22:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5gzmhI49Qj0vN4kOxPftSNmbMO1JiOhVBd+9Ah9pQSqVNkyp/EMjaNKytALAzdnMHBZZV+Vw==
X-Received: by 2002:adf:ec83:0:b0:22e:51e2:7fc7 with SMTP id z3-20020adfec83000000b0022e51e27fc7mr2889031wrn.229.1665058931748;
        Thu, 06 Oct 2022 05:22:11 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003bdd2add8fcsm5004841wmq.24.2022.10.06.05.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:22:10 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH bitmap-for-next 1/4] lib/cpumask: Generate cpumask_next_wrap() body with a macro
Date:   Thu,  6 Oct 2022 13:21:09 +0100
Message-Id: <20221006122112.663119-2-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221006122112.663119-1-vschneid@redhat.com>
References: <20221006122112.663119-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation of introducing cpumask_next_and_wrap(), gather the
would-be-boiler-plate logic into a macro, as was done in

e79864f3164c ("lib/find_bit: optimize find_next_bit() functions")

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 lib/cpumask.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index c7c392514fd3..6e576485c84f 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -7,8 +7,27 @@
 #include <linux/memblock.h>
 #include <linux/numa.h>
 
+#define CPUMASK_NEXT_WRAP(FETCH_NEXT, n, start, wrap)			\
+({									\
+	unsigned int next;						\
+									\
+again:									\
+	next = (FETCH_NEXT);						\
+									\
+	if (wrap && n < start && next >= start) {			\
+		next = nr_cpumask_bits;					\
+	} else if (next >= nr_cpumask_bits) {				\
+		wrap = true;						\
+		n = -1;							\
+		goto again;						\
+	}								\
+									\
+	next;								\
+})
+
 /**
- * cpumask_next_wrap - helper to implement for_each_cpu_wrap
+ * cpumask_next_wrap - Get the next CPU in a mask, starting from a given
+ *                     position and wrapping around to visit all CPUs.
  * @n: the cpu prior to the place to search
  * @mask: the cpumask pointer
  * @start: the start point of the iteration
@@ -21,21 +40,7 @@
  */
 unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
 {
-	unsigned int next;
-
-again:
-	next = cpumask_next(n, mask);
-
-	if (wrap && n < start && next >= start) {
-		return nr_cpumask_bits;
-
-	} else if (next >= nr_cpumask_bits) {
-		wrap = true;
-		n = -1;
-		goto again;
-	}
-
-	return next;
+	return CPUMASK_NEXT_WRAP(cpumask_next(n, mask), n, start, wrap);
 }
 EXPORT_SYMBOL(cpumask_next_wrap);
 
-- 
2.31.1

