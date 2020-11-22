Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F768C64E7C
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 15:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5897212CC
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 15:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VosA01iu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgKVPjR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Nov 2020 10:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgKVPjJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Nov 2020 10:39:09 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC84C0613CF;
        Sun, 22 Nov 2020 07:39:09 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id bo9so14038244ejb.13;
        Sun, 22 Nov 2020 07:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nQLCp8kee4CMboEl3huLY3cDgMLf3XHMfMZ5RHWYbWE=;
        b=VosA01iuUvY60bnAzgbI5f6Qy3dP17zZoyNNw+NfIb+i/ggx7GQUDXRwSRhj/5ZjZz
         TKcSA7sc4J39LFSsUtz0L7zG54THPZlbuAe1i9HSY2rFes+/xT7MyX+8ZQDcdIJG3wA2
         Pvg39IHXaewLASwtTPiASI6KA4iaC7kAsjRmNeQtP3t0gQV0zpbypssxLZ8xY8K7Sd81
         ijcPJp10HYfzLXjXwMd+/kpYzZaRU64i+u5rkEkx03lSTBXAtFBbisFnnE7qwEP/lCuT
         IBsg8CUw/zPI6ZAFQ+q/9ap6ynPsJlW85PTcHyojBjMwySy+QfB1NAV1ymuBfYim/Vso
         FzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nQLCp8kee4CMboEl3huLY3cDgMLf3XHMfMZ5RHWYbWE=;
        b=SuquFvTXhY0/3gekuF1aWwuqgpyGE51SxaqyS8C4Nc2yp6gyL8WpoPBsmsBV1Djri8
         8AD3WcNMhfVa1dNjpRTQakr4QbwqpgSp13evB3AgbhScgub+uGO/yXmRXtjoT+aEOSvk
         apzxcUXArXx7KlFUbcy8jdqlsa+CobTtzyg3tOhxglq3molnAwQ7mu+aPHyMWrdr1Tpl
         RamDqgr3LRLbT8gbPf4cConUBSqPG2WVpAd6NrE2eKOhFiB0A0UMzBdaesD1RIsFCLna
         47je9dygrmwggpiMGArTyYLD7cdV6SArXqP3h5hs+eEVt90cL/i2rl+/u1H6TbV5pJHG
         vENQ==
X-Gm-Message-State: AOAM5309ysgwJCNGnCzdNm7W7VO7BU3VSDegjXTTBYVg31AFGR094jKX
        9BrODYq+3ajWSI6ylMQ1t48=
X-Google-Smtp-Source: ABdhPJxAWNxAu1sQTAaKYHc2/PQ2GtrkJyUPEOno6RGB2ExQYrdKdXVW3Zm79WIp71ZzAMsjY5a3ZA==
X-Received: by 2002:a17:906:c41:: with SMTP id t1mr40733350ejf.19.1606059548209;
        Sun, 22 Nov 2020 07:39:08 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id q19sm3693742ejz.90.2020.11.22.07.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 07:39:07 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] sbitmap: replace CAS with atomic and
Date:   Sun, 22 Nov 2020 15:35:47 +0000
Message-Id: <6c9b6664bcd12faa9d1a9969a32774a75d1d316f.1606058975.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1606058975.git.asml.silence@gmail.com>
References: <cover.1606058975.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

sbitmap_deferred_clear() does CAS loop to propagate cleared bits,
replace it with equivalent atomic bitwise and. That's slightly faster
and makes wait-free instead of lock-free as before.

The atomic can be relaxed (i.e. barrier-less) because following
sbitmap_get*() deal with synchronisation, see comments in
sbitmap_queue_clear().

It's ok to cast to atomic_long_t, that's what bitops/lock.h does.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 lib/sbitmap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 4fd877048ba8..c18b518a16ba 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -14,7 +14,7 @@
  */
 static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
 {
-	unsigned long mask, val;
+	unsigned long mask;
 
 	if (!READ_ONCE(map->cleared))
 		return false;
@@ -27,10 +27,8 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
 	/*
 	 * Now clear the masked bits in our free word
 	 */
-	do {
-		val = map->word;
-	} while (cmpxchg(&map->word, val, val & ~mask) != val);
-
+	atomic_long_andnot(mask, (atomic_long_t *)&map->word);
+	BUILD_BUG_ON(sizeof(atomic_long_t) != sizeof(map->word));
 	return true;
 }
 
-- 
2.24.0

