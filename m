Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E3DC2D0E4
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 00:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D29223A65
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 00:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWyUhrKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgKUAEg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 19:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgKUAEf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 19:04:35 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C49C061A04;
        Fri, 20 Nov 2020 16:04:35 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 1so12079565wme.3;
        Fri, 20 Nov 2020 16:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8U62WcszabPEjfRiz8PL6bPd6YXedpkQur+ELLcNC4=;
        b=dWyUhrKB2cftTV9R6ZY4W1ouEZ4mrMBqCyJgfYIyUF0gFgTKdE4Px68sj52ErRNcQZ
         ZiYy7MBTweHDvI9bELzzsN7aqLwWuJSv/JtW1duYFn2Z9rtfe2flmqHggDQr32PFw54Q
         tgrhodXZ67uj3x2ZVgulw/hCe2Var45F/EmJjMcym5uBrwARWV7mc2fZUxOA3bq+ER+T
         +vN9aDcwAQ4J4nDTLDI3PC7AzrzsN23tKQe2Nd8NkwxeUI4rch/W7iVY+8yhETcMWz87
         DmxSfCJjv4NiyKlxizl5eQtVe5/TCnsi/5kEWqcLJmyP/cb4eRJm2m8hKnA3UJ2sgC2W
         qhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8U62WcszabPEjfRiz8PL6bPd6YXedpkQur+ELLcNC4=;
        b=VqMpPI37bASBNtOY8EXTsK74x2heobGc1/itaByJ/uiNI69SiUU0hKTmgEmTKu9BYZ
         allwg6Q8tu1hpZh3QsBCp7U8fVRyDKHRxrIc7rC1b4qYV1O0APYIG8xfeM4nUm/cT9vG
         /V8uHi0R/Mya0UjWK88y2J3Rv8D03UosFXnTqgx8+zhR1RWOzioGO6w1EfvGAS/4rqhS
         S8xswvMek6XHWZ01+fkDbw0B9jacCIOQf0r7PCnLMbUkGwBq0tkeYbdhevs1P8uPfBdA
         MuKTShkukOQQJuZVRhKfppTRRj9CrbP2JFDhziMzsYwn3wK4seb48xFx9cgJXbpMQPHs
         3bYQ==
X-Gm-Message-State: AOAM530zUWaFjJKizY6V3eFvLMb7CbAW/VXP+XW6nQLobwZSIiKAjPoX
        QldW1MCh9wgufSENRFDB3AU3vz5VRuw=
X-Google-Smtp-Source: ABdhPJw4FnGisGN+PCv2bPrnHld1JjJGWhuUDS7LLmsbjAai+/qdqUw4QuNHBpcpi1wVm0yNWpGxqQ==
X-Received: by 2002:a1c:4086:: with SMTP id n128mr12588662wma.68.1605917073885;
        Fri, 20 Nov 2020 16:04:33 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id d3sm6145518wmb.5.2020.11.20.16.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 16:04:33 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sbitmap: remove swap_lock
Date:   Sat, 21 Nov 2020 00:01:16 +0000
Message-Id: <e903f4b2fa327e4bbe5ad80b4bcffac3de17a780.1605908165.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1605908165.git.asml.silence@gmail.com>
References: <cover.1605908165.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

map->swap_lock serialises concurrent calls to sbitmap_deferred_clear(),
however that function is already works in atomic fashion and guarantees
to not loose bits while applying map->cleared bitmask.

Remove spinlocking in sbitmap_deferred_clear(). For a one-threaded
tag allocation heavy test on top of nullblk it yields ~1.0-1.5% t-put
increase, and according to perf 3% -> 1.5% cycle reduction of
sbitmap_get().

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
index 49afb34e8340..238d9849f24b 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -16,13 +16,9 @@ static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
 {
 	struct sbitmap_word *map = &sb->map[index];
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
@@ -36,10 +32,7 @@ static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
 		val = map->word;
 	} while (cmpxchg(&map->word, val, val & ~mask) != val);
 
-	ret = true;
-out_unlock:
-	spin_unlock_irqrestore(&map->swap_lock, flags);
-	return ret;
+	return true;
 }
 
 int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
@@ -81,7 +74,6 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 	for (i = 0; i < sb->map_nr; i++) {
 		sb->map[i].depth = min(depth, bits_per_word);
 		depth -= sb->map[i].depth;
-		spin_lock_init(&sb->map[i].swap_lock);
 	}
 	return 0;
 }
-- 
2.24.0

