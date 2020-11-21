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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1F7C6379D
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 00:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6559022470
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 00:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tlmfXEe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgKUAEk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 19:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgKUAEg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 19:04:36 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3296DC0613CF;
        Fri, 20 Nov 2020 16:04:34 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id b6so12633383wrt.4;
        Fri, 20 Nov 2020 16:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nLnJQH0E0C7l5lcYS8gWKVR7TD7aW3JoBdngAU0UscA=;
        b=tlmfXEe0CPnh4SkvdOsVi69o4CZ42w+AAEuBUFeMOFPwAm7dCta9SWzVpGlEfEaBuf
         Cyzp8xY9cWFcv+pncxJRZDJDPh5qCi877gOelq2yNhHDwGaFD5iV0OhcrDQ6wwdbgQv6
         5Gc9e1gcxuFBPyRzpJm2zkOO8XgENmRWNm2bqjIBuZVK3aGrkn40F7Z24rdJeuLf9q5j
         EXzT8Az9nF4lwI503qeS0GUmxSNCFHYN0uvaW2nmL74EYuymxuf+5QL61h20kXDaG7Os
         AZkTKvlTcEf+8iEz9Z1u7ZOZhlMJ3FTLjybr49QyINN1S51MN0I5Vj7MylRfGZdjPM3O
         ZAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nLnJQH0E0C7l5lcYS8gWKVR7TD7aW3JoBdngAU0UscA=;
        b=nJgpra/3F5+bFlRLEtC5If13WY9Y85uy4U9CgX9mN6JEblVEMXvAqaaSfzOmvVg9P2
         rAYUaDtZ3djUikIMDrGionmLNVrbTSHOFGH4ywL0T4IhbhCCuyyZAhtQYRz85vINaUUN
         ZXIkfYBjDBh1mUKOxnEkAFDhd0irl5T9MNQ5pXWKyQJ7VNJWxEZ+OgGixxd15TeESCT0
         5CDTV3IwyCcUVlBgAgInuusZBT+BRX/DbT0Z1jCcMuTbeowzu89EHwDyz4/4qtLvsRgW
         A4cdEALv+WCFeq2cjetxeVgaWH/1yp/pNDieaND9n0OVLzriRx/MFAovr7+m4NakFz6K
         c6ZA==
X-Gm-Message-State: AOAM530qfYCoD/Y9V5XWrEkkED5myU3QAxuvqgeUZ0Rm5dmb4xK+UF89
        9x2rKlmE4nQxHobl8nO1G6BXg2C+448=
X-Google-Smtp-Source: ABdhPJxYImrkFubhC5IzJzob31RzRpVGqL/Cc5x/Qr5KBr1Pag6olnXxVYoCqL/bsR0+a8kg6eLwAw==
X-Received: by 2002:adf:82f5:: with SMTP id 108mr19073426wrc.269.1605917072924;
        Fri, 20 Nov 2020 16:04:32 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id d3sm6145518wmb.5.2020.11.20.16.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 16:04:32 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sbitmap: optimise sbitmap_deferred_clear()
Date:   Sat, 21 Nov 2020 00:01:15 +0000
Message-Id: <9b17f6db792526413e368dbb72bf7aca12b327d3.1605908165.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1605908165.git.asml.silence@gmail.com>
References: <cover.1605908165.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Because of spinlocks and atomics sbitmap_deferred_clear() have to reload
&sb->map[index] on each access even though the map address won't change.
Hint it by explicitly caching it in a variable.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 lib/sbitmap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 267aa7709416..49afb34e8340 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -14,30 +14,31 @@
  */
 static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
 {
+	struct sbitmap_word *map = &sb->map[index];
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
 
-- 
2.24.0

