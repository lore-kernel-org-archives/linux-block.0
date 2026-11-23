Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795412876;
	b=4py4OB3MplpmaQ5WKL5O2764U2ZsOsotlRdCpsTz47ohznxOEPEGzr/DhOrzkF4L5aKA
	 Fn3DX7GfuScLz+LTycT4NPTAqWl6w6z/QezS+/Iju1p5td4VeG7ajGsQkLVTh97fny9cn
	 Mh2MzSXj+d0nL5WI/f/AuXlHDHNzERvV19IitF0B9DhlcoeMAWESPn4+1a9JWW9Eg0Sgc
	 pNMFX1bsnv2whk9h3oRmiIOIY69YgAEFZGm8imCqy3BriEpO3VefAm+Za0E805BrjbJgp
	 4+1ZBy7tVSXMU9zw83Y9FltkVyJ6kUMSg5IBT0smKSa8EZAoTLQqBzLvX7lElCWju7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KnMxzhHOEHpbsDB95jN4ZokxNKIXrj2a5/W65iB8kpI=;
	b=GogO7+CBy12WnlGpfBkWeJxITGnkKjN0F7j4jfwZEI6Ti+U/WY11oxcgmyasj8W3beAS
	 5n+zCYw9IckgNuZ2zao4JvQ/VgFBSe2fq/p/cfpZkl42jiXUVeKGqaa8eXXIKJByMEKxz
	 C11woiGYsg2W0ddeXXAQ7bYdBfcdKBIska6sA2rixunprG5y963fRxmgVxGW9j07Ytta9
	 XGzVhu0ivHwhc5qNSoz3qik5Jt/oTbexCwfdJcS6eAd87JczTYcqq6PAfP1lWUU50jG96
	 u33ENvg5HIBIcwzboKBW2aDsposedD8vpef/SLz7+J/hXCea0Qt244XKtwbBhQA6h6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=SuKnBF04;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B42B606A335
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 05:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B42B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=SuKnBF04
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdba1bbde0bso1098094a12.2
        for <linux-block@vger.kernel.org>; Sun, 22 Nov 2026 21:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795412875; x=1796017675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KnMxzhHOEHpbsDB95jN4ZokxNKIXrj2a5/W65iB8kpI=;
        b=SuKnBF04Inopcx81Wt0h0PDp8wyaQDzpDWTE8Wz7JjCu1Q4qdNQ8x9zaSN4XfC+9Cd
         ax+hJPpgQUCCtQuprcaXuT4ecPJqQ1j30188HeB8QsivXQqPjDCzEoTFkNl3MMsNvQXT
         G2BTu4jjA+DsRpegdwgMMrlOO37N25OPX2qnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795412875; x=1796017675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KnMxzhHOEHpbsDB95jN4ZokxNKIXrj2a5/W65iB8kpI=;
        b=Ac2kbtu+pKgeGAalJiWtJuAwj11YrjwmQmXkxE+uzaii3pVYsW7kPthuanxnjjBVyG
         ZzK4CKPSTx4xtHI0k9EEOzedn8IJgx7CGhE+x86c4IJ25+eazxYqfjYAEFkDfcU5f9Pc
         w4Y3lT2iJPGVCvohYkNxsnTf9gJz3EIxBzF0YZncUjWgKo/41ksa/Ro2s6sAoE5o+rx3
         W3KejavjP3GnnMcjV1QEPlCyheYnS8oPnR+RWueVhPTgr5XszgApXmOnUkaQOejakPCh
         /bftLOvl7poj6zVO5gEeZ9Ew+UissWEmuLi5rJrlmXiqjYNrbejSHl05NMv8iDV/7H+U
         widQ==
X-Forwarded-Encrypted: i=1; AL+hErEwvAOPAESWhNzDxvibgxmr7HXJtnfecu/LjSpz07TZG1pskv7E25bk9oWAKs+QaGxXPE9tYyGsrhsiqQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/DehMKV/+X9BQZkJGHsXggiOT9AlAXMkNHiR/iGTxY2kZrn95x
	LCRmFzgutqzmJpPqRyyiwZhjA17vKfb+H4lIeojKjn81Jiu3/3lqodIkTGGGsBe3xw==
X-Gm-Gg: AZFdTZcB/pA6uVTPSCY+AXFRLH+o5pfoFd80CAMGHA2Sb35aOqjpvRh8k9z4shrP/e+
	jmnWJcrr9wezB+NXVpJ3oXxNZ4ltxemw+OaU5X/nIEItk56BoBL6T1bV9f3fWfdgqFpv34QRSxX
	Kco9cMySpj4u0U1kGK1EwJOozul87EY79iw3m+R2Ro7zxlilnJqpD43o65b8osUJX2cmuwPq2pK
	4OfAh4Vx8DXj6MThlOcu2yil7+zWF42OBL2fVVhUFGn75aRB1x3dS71FuLBMZaAs1Ct6L9afIQc
	GK+nujvWvJXcD7I0BEcsw88TZ754DzXy9yOu/G+OHLYPFsylEGdqB+2Y0dTQooJAgawGLZiN9LC
	27EnV3MU/a3kEINoidMirQCUdV1x3TKBVbZpVOv68QYptw/JI0P9e19GC5yCw/ZqB9dcJGC06bP
	UEd1Xe1LMzhhbalJcVZrOXurYRG8dyk01RsAApywrVDmsoS6sAHGEqNArS3fVFXKajTyaJKztD5
	pQeIu75vNl0M+aBUTpEQeyFOMhCAPY5Wc4YI8bKXxDQWfV7ZtuzKbI8KVKClqGHEDveDHaeCeS4
	HYvDlIKNVXUs4RlhG5Ur8DJiGDSA78l+1QdBtScWiXmzmzfQW7LoL/CLcpkfbqY8aNFOyr44OP9
	T8pNo7cSshMtUpS81mg==
X-Received: by 2002:a17:90b:3f0e:b0:3ab:1481:69e5 with SMTP id 98e67ed59e1d1-3b41c8ffb06mr9953948a91.11.1795412875450;
        Sun, 22 Nov 2026 21:47:55 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:d8fa:c511:e415:e0d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c07sm16240267a91.13.2026.11.22.21.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 21:47:55 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Hongfeng Chen <hongfengchen@xiaomi.com>,
	Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 1/2] zsmalloc: free a zspage's pages in one batch
Date: Mon, 23 Nov 2026 14:47:36 +0900
Message-ID: <20261123054746.2579253-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123054746.2579253-1-senozhatsky@chromium.org>
References: <20261123054746.2579253-1-senozhatsky@chromium.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__free_frozen_pages() and dec_zone_page_state() take about 22% of the
profile [1].

Collect the pages of a multi-page zspage in a folio_batch and free
them with folios_put(), which takes the pcp lock once per run of
same-zone pages, and update NR_ZSPAGES once per such run as well
A zspage never has more pages than a folio_batch holds.

Single-page zspages, incompressible or power of 2 size classes, use
the current inline path.  There is nothing to batch there, and
folio_batch is not free, hence the batch path lives in its own
noinline function.

munmap() test:
                    next-20261119      v7.4-rc3
  256 MiB           -2.0% .. -4.1%     -4.4%
  1 GiB             -2.8% .. -4.4%     -3.8%

[1] https://lore.kernel.org/20261109105957.2577351-1-chenhongfeng0212@gmail.com

Reported-by: Hongfeng Chen <hongfengchen@xiaomi.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 52 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index d5f313754934..a1b6161fd237 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -37,6 +37,7 @@
 #include <linux/debugfs.h>
 #include <linux/zsmalloc.h>
 #include <linux/fs.h>
+#include <linux/folio_batch.h>
 #include <linux/workqueue.h>
 #include "zpdesc.h"
 
@@ -837,6 +838,44 @@ static int trylock_zspage(struct zspage *zspage)
 	return 0;
 }
 
+/*
+ * Free the pages of a multi-page zspage in one go, see folios_put().
+ * Not inlined, so that the folio_batch is only set up (and, with
+ * CONFIG_INIT_STACK_ALL_ZERO, zero-filled) when there is something
+ * to batch.
+ */
+static noinline void free_page_chain(struct zpdesc *zpdesc)
+{
+	struct zone *zone = zpdesc_zone(zpdesc);
+	struct folio_batch fbatch;
+	int nr = 0;
+
+	static_assert(ZS_MAX_PAGES_PER_ZSPAGE <= FOLIO_BATCH_SIZE);
+
+	folio_batch_init(&fbatch);
+	do {
+		struct zpdesc *next = get_next_zpdesc(zpdesc);
+
+		VM_BUG_ON_PAGE(!zpdesc_is_locked(zpdesc), zpdesc_page(zpdesc));
+		reset_zpdesc(zpdesc);
+		zpdesc_unlock(zpdesc);
+
+		/* NR_ZSPAGES is per zone: one update per same-zone run */
+		if (unlikely(zpdesc_zone(zpdesc) != zone)) {
+			mod_zone_page_state(zone, NR_ZSPAGES, -nr);
+			zone = zpdesc_zone(zpdesc);
+			nr = 0;
+		}
+		nr++;
+
+		folio_batch_add(&fbatch, zpdesc_folio(zpdesc));
+		zpdesc = next;
+	} while (zpdesc);
+
+	mod_zone_page_state(zone, NR_ZSPAGES, -nr);
+	folios_put(&fbatch);
+}
+
 /*
  * Three free helpers, kept apart here:
  *
@@ -855,21 +894,22 @@ static int trylock_zspage(struct zspage *zspage)
  */
 static inline void __free_zspage_lockless(struct zspage *zspage)
 {
-	struct zpdesc *zpdesc, *next;
+	struct zpdesc *zpdesc;
 
 	VM_BUG_ON(get_zspage_inuse(zspage));
 	VM_BUG_ON(zspage->fullness != ZS_INUSE_RATIO_0);
 
-	next = zpdesc = get_first_zpdesc(zspage);
-	do {
+	zpdesc = get_first_zpdesc(zspage);
+	if (get_next_zpdesc(zpdesc)) {
+		free_page_chain(zpdesc);
+	} else {
+		/* Single-page zspage, e.g. a huge object: nothing to batch */
 		VM_BUG_ON_PAGE(!zpdesc_is_locked(zpdesc), zpdesc_page(zpdesc));
-		next = get_next_zpdesc(zpdesc);
 		reset_zpdesc(zpdesc);
 		zpdesc_unlock(zpdesc);
 		zpdesc_dec_zone_page_state(zpdesc);
 		zpdesc_put(zpdesc);
-		zpdesc = next;
-	} while (zpdesc != NULL);
+	}
 
 	cache_free_zspage(zspage);
 }
-- 
2.56.1.750.gf70dc682cf-goog

