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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A96C6379F
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 15:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3597E20781
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 15:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhebEEN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgKVPjK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Nov 2020 10:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKVPjJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Nov 2020 10:39:09 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B226CC0613D3;
        Sun, 22 Nov 2020 07:39:08 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id oq3so19792059ejb.7;
        Sun, 22 Nov 2020 07:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dLNpQoSRr9iK3S6Fw6tI1eE1E/khRsaWGUWRPRmH1yI=;
        b=LhebEEN3u1hRCFIyVbHk1ufMBKXxVarWm7ctpvx3YlEWPUQoXm4Kvu7NsS/iy1Z/ug
         4MIYE9VN03lgb7DWw3PijIpltHFbxDwjoyv9CDl576zwuCCyTqmjJX6AZWiW+8mMc4g3
         GKTQ023PwGMYbixYdcAJ9T+tFw0KxWzBpp86kQhhPVlEFI/KgH7bcUafdseB4UQMMj9Q
         yDNGyXSh8WfQXFduMQcRX6YYGTWfiPxr511BL1ey+iJWS58+eanyn3H/XEtDgEyJTaRj
         Esb4HfCFwVaf6vIC9QmnX8N7BjWzAMIOVvEG5M0gzRQpOnR3lbVGP244vslfNgVTQpEr
         i/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dLNpQoSRr9iK3S6Fw6tI1eE1E/khRsaWGUWRPRmH1yI=;
        b=HNiTBXDwrbKW3hlmPYh1qg7XOklm8I/jbjNR0UzE8z8aXEIqw9eDZhM1v9Iwoovt+H
         B2LFmY+XZ8WFlJ9r2nwZj3XnZ+L0fgKdEmSTtjr7/jij2MNnSWpw1mR3pxv7LW+/5tyU
         hmWKiX8L42qboTH3lv5xl9ST0TzvpjX7+MfHh+XoG3PdwNEuplU/SU9peHUXxffMpgpj
         e2M3/PXWVhgYO8xMCQHqXs7xCC+Zgrf3TrKUBuUp1W3fCtopOGMzt7jGSsnTNxXSg8fI
         ulQUpOx5FGtFdnT1i+GpeL/IchpTg3omqvRmHkydmrcFYby63D83qiJWacjIR6N2PYsr
         5umQ==
X-Gm-Message-State: AOAM531l9zKjumN/oaqIe1xjuAF0wfQhlvlUbjt0hPJfd3ges/3Q/hHG
        LB3S7ckq+cM6gWzjWEE1B6U=
X-Google-Smtp-Source: ABdhPJwcQCyO9nlMXYJcQGNDq6WXtwyRPZHNIePeRwwCEz9RkGB8EgeUqHKzbqi9LybMbyKzTpEQhA==
X-Received: by 2002:a17:906:268c:: with SMTP id t12mr40737027ejc.91.1606059547406;
        Sun, 22 Nov 2020 07:39:07 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id q19sm3693742ejz.90.2020.11.22.07.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 07:39:07 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] sbitmap: remove swap_lock
Date:   Sun, 22 Nov 2020 15:35:46 +0000
Message-Id: <488177c02dccda60c5e8af2e53156c42b7f1acc0.1606058975.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1606058975.git.asml.silence@gmail.com>
References: <cover.1606058975.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

map->swap_lock protects map->cleared from concurrent modification,
however sbitmap_deferred_clear() is already atomically drains it, so
it's guaranteed to not loose bits on concurrent
sbitmap_deferred_clear().

A one threaded tag heavy test on top of nullbk showed ~1.5% t-put
increase, and 3% -> 1% cycle reduction of sbitmap_get() according to perf.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/sbitmap.h |  5 -----
 lib/sbitmap.c           | 14 +++-----------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index e40d019c3d9d..74cc6384715e 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -32,11 +32,6 @@ struct sbitmap_word {
 	 * @cleared: word holding cleared bits
 	 */
 	unsigned long cleared ____cacheline_aligned_in_smp;
-
-	/**
-	 * @swap_lock: Held while swapping word <-> cleared
-	 */
-	spinlock_t swap_lock;
 } ____cacheline_aligned_in_smp;
 
 /**
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index c1c8a4e69325..4fd877048ba8 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -15,13 +15,9 @@
 static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
 {
 	unsigned long mask, val;
-	bool ret = false;
-	unsigned long flags;
 
-	spin_lock_irqsave(&map->swap_lock, flags);
-
-	if (!map->cleared)
-		goto out_unlock;
+	if (!READ_ONCE(map->cleared))
+		return false;
 
 	/*
 	 * First get a stable cleared mask, setting the old mask to 0.
@@ -35,10 +31,7 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
 		val = map->word;
 	} while (cmpxchg(&map->word, val, val & ~mask) != val);
 
-	ret = true;
-out_unlock:
-	spin_unlock_irqrestore(&map->swap_lock, flags);
-	return ret;
+	return true;
 }
 
 int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
@@ -80,7 +73,6 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 	for (i = 0; i < sb->map_nr; i++) {
 		sb->map[i].depth = min(depth, bits_per_word);
 		depth -= sb->map[i].depth;
-		spin_lock_init(&sb->map[i].swap_lock);
 	}
 	return 0;
 }
-- 
2.24.0

