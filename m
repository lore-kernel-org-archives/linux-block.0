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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCAAC5519F
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40F6120727
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 15:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVfSAHc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgKVPjI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Nov 2020 10:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKVPjI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Nov 2020 10:39:08 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01B5C0613CF;
        Sun, 22 Nov 2020 07:39:07 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id l5so14513871edq.11;
        Sun, 22 Nov 2020 07:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LLyBQQxzTUvx0SP9ZpRqeAeAOBvzcvUPKIXIwPCTeyk=;
        b=iVfSAHc1H9CV77pfjvfc2M51745vfVMqC1BNMpV7rs02iO6woKtZ4/l+Rc8W+/UvcR
         mlXP3F8+M78HXArx6mxnxilEU794c5aorXUI2ylqwYsJd7SusnLF28NeLD9hZai22o9k
         N1duXM6iKDCsPdDLRGpl+nQhZIU2zsoVBbWL1Sn81XnZ59BKF9lz/CVva8rPFL6KL9iy
         mpKTfeWnCV8QeWHf5BnnK7TeO6C5cD0Yuxm7AbkjQiIkkp3tia97dby5WN8jiJ8w6grU
         nONmBF7S4Y+80jS6veNK7gqqvwL+IXwtaYxDb5bySLFWi3en9lb1Bqf8m/CnorHYsyhU
         0tqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LLyBQQxzTUvx0SP9ZpRqeAeAOBvzcvUPKIXIwPCTeyk=;
        b=B0i6/TbrOCIkvG1eecLQSAR4HyZSopsCeMjJGkdKCjSu1+eAr7D8M1ByqurwHKivLL
         qbS4UTN1zeLPSSFIEV7A++/rtCAD56C6Q2VUGCMoBry65oJA7ElhS/G3xMbCFHbBYtSA
         5gNRMFjmcoseX0JjACQCX3dCFZrxTzQvytatE2P6NZyzEyzSMM7oSPSnt7R+gBatBDbV
         10ll9hiiL2WoFTQjzYQxSYPcRfYMc/F8T4YntieBpvqXZk5qH3saHUkGHcnSezrI2zCA
         nrkm/mSQByrI6BCu9Bmu9JcSwJjsHkc3M636Kp/w4UvBk8KRbCib4HUT0JdO4i7D1vQP
         62JA==
X-Gm-Message-State: AOAM532oI1DGre6FD3eFUjZ6inhbf1iIWaNeGarU1KQYxZVmi2hCvXlh
        qSCGSGFLIXJIWX754xkDnLq7xKUig9hWjw==
X-Google-Smtp-Source: ABdhPJyebL7zIQqA01s/GGvRTBnKNRzSk2yReIcnpgmnn8zZbYu0c6VwxeDiINHFefts9hjy0S6IQg==
X-Received: by 2002:aa7:ca57:: with SMTP id j23mr19873066edt.292.1606059546594;
        Sun, 22 Nov 2020 07:39:06 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id q19sm3693742ejz.90.2020.11.22.07.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 07:39:06 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] sbitmap: optimise sbitmap_deferred_clear()
Date:   Sun, 22 Nov 2020 15:35:45 +0000
Message-Id: <ddfa166d93f38e812751b6ff986fd5403b7893b7.1606058975.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1606058975.git.asml.silence@gmail.com>
References: <cover.1606058975.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Because of spinlocks and atomics sbitmap_deferred_clear() have to reload
&sb->map[index] on each access even though the map address won't change.
Pass in sbitmap_word instead of {sb, index}, so it's cached in a
variable. It also improves code generation of
sbitmap_find_bit_in_index().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 lib/sbitmap.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 267aa7709416..c1c8a4e69325 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -12,32 +12,32 @@
 /*
  * See if we have deferred clears that we can batch move
  */
-static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
+static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
 {
 	unsigned long mask, val;
 	bool ret = false;
 	unsigned long flags;
 
-	spin_lock_irqsave(&sb->map[index].swap_lock, flags);
+	spin_lock_irqsave(&map->swap_lock, flags);
 
-	if (!sb->map[index].cleared)
+	if (!map->cleared)
 		goto out_unlock;
 
 	/*
 	 * First get a stable cleared mask, setting the old mask to 0.
 	 */
-	mask = xchg(&sb->map[index].cleared, 0);
+	mask = xchg(&map->cleared, 0);
 
 	/*
 	 * Now clear the masked bits in our free word
 	 */
 	do {
-		val = sb->map[index].word;
-	} while (cmpxchg(&sb->map[index].word, val, val & ~mask) != val);
+		val = map->word;
+	} while (cmpxchg(&map->word, val, val & ~mask) != val);
 
 	ret = true;
 out_unlock:
-	spin_unlock_irqrestore(&sb->map[index].swap_lock, flags);
+	spin_unlock_irqrestore(&map->swap_lock, flags);
 	return ret;
 }
 
@@ -92,7 +92,7 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
 	unsigned int i;
 
 	for (i = 0; i < sb->map_nr; i++)
-		sbitmap_deferred_clear(sb, i);
+		sbitmap_deferred_clear(&sb->map[i]);
 
 	sb->depth = depth;
 	sb->map_nr = DIV_ROUND_UP(sb->depth, bits_per_word);
@@ -139,15 +139,15 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 static int sbitmap_find_bit_in_index(struct sbitmap *sb, int index,
 				     unsigned int alloc_hint, bool round_robin)
 {
+	struct sbitmap_word *map = &sb->map[index];
 	int nr;
 
 	do {
-		nr = __sbitmap_get_word(&sb->map[index].word,
-					sb->map[index].depth, alloc_hint,
+		nr = __sbitmap_get_word(&map->word, map->depth, alloc_hint,
 					!round_robin);
 		if (nr != -1)
 			break;
-		if (!sbitmap_deferred_clear(sb, index))
+		if (!sbitmap_deferred_clear(map))
 			break;
 	} while (1);
 
@@ -207,7 +207,7 @@ int sbitmap_get_shallow(struct sbitmap *sb, unsigned int alloc_hint,
 			break;
 		}
 
-		if (sbitmap_deferred_clear(sb, index))
+		if (sbitmap_deferred_clear(&sb->map[index]))
 			goto again;
 
 		/* Jump to next index. */
-- 
2.24.0

