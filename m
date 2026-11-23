Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795412203;
	b=WS+jI33Qk2CS0QTCnDws0edI/9shpWmLaHxzfDRmFSgb8h7WUhaPqOR4Tq49u/CwmzJj
	 zmH6NxrLX8o0nP+PWY2PISQtVIJBtDhbWRsDlSt4Tl7R7/JqxKmMAEixQMoZIULfwtH8W
	 gfqwVS95yA9tG+crArwC4JehSlB+t6YN8dkjTlM6TovlJ2W7vHGmWyV72/qadLzxi6FnO
	 r6+BrUxFo4XPg4NHSwE1SG+nvDynqiq33porivztT0cjWR/8UHpLa8v8bhwf7ObO585in
	 JnBDkphIOkfhcZoP0MFE415ofITzaMkB2SHk/NhPfDFHHvMI38YNn15KlsxLrcVRsDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KnMxzhHOEHpbsDB95jN4ZokxNKIXrj2a5/W65iB8kpI=;
	b=ZIcTwNfKzaWXP1wI2Mkt/guy7txk3pk5QuPiGiiZ4whrqs1mmRjJETZGFOvzuKNS6cyg
	 UFX5NHpsGRQSDUl/BweCyob49UblSFnqtn41Y34frOQ9pOGeIpt8ojAmIttpFE62HqknI
	 Pd23ZO2ciYSloza1u7aK7YP0m26qcivTYAPvx5jdlANfA3O9EYz/JQw3SrWKE34cgKKuP
	 7AAcb1xMI/e3Xrlxq/g/wVYIH7twBK0qMziGOxAJ8ho6MbrISsI7BMS1R9xfEWHtBS8e/
	 P9n+59VVEveDyxmkkd2Po5kx8JByinevi4ID14DwZG3nZ+AHtFOEb3ThijclAMKkLhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="FROH/d5A";
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935C606A331
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 05:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2935C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FROH/d5A
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f04fab527eso20024255ad.0
        for <linux-block@vger.kernel.org>; Sun, 22 Nov 2026 21:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795412202; x=1796017002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KnMxzhHOEHpbsDB95jN4ZokxNKIXrj2a5/W65iB8kpI=;
        b=FROH/d5A+4MWwKPhgc4NmbqjIc79nO2WpJllGoHK7iggmMjxoUyYnoA0XBG8fe3xGF
         Fghk099M5QeK6zVC0ZudIgN9uAjy5EQAYw5M8fTpwFRLNVFfWyd56IkZJLmU5m4JzLLH
         UUsBUFUaviJVCY66UwyoHBRbh5ljO8W8GiMmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795412202; x=1796017002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KnMxzhHOEHpbsDB95jN4ZokxNKIXrj2a5/W65iB8kpI=;
        b=e/kpEsCKrxys9vkjp9RWx0Yeug02MNNWu1KAc2ekh0iD1LPb8CnXOmrvYHHKbeIHkH
         Uj9+74ZJdjUbZHl3EyTkhQobfxW7erv6FDj32n5PPs5fMDTR+pORHeHHd8hFGYtYTh69
         DMvwoSnrlcVkZv5mB/Vy06U7XC27Ytyex05zXEEwK19RxMuDahpSZBQkCPAW4epbd5LJ
         aJXgTIPhNknZZhJIp33V2APuEhAi7EWdIfdAQ4frf6mM6x4ZPr+UnfFKGai3m0/+q1sK
         wBlHtvcC5vOCktOdkd2M8i7m9Wh2M5L5PFouFycla3H8VwJAdOtKJaJmzwuimRvVKbKH
         RZCQ==
X-Forwarded-Encrypted: i=1; AL+hErGMvGFzwDedVzgE+Q1vEf5r/QCdQvHO8mbwfEKanBgjFcKaAMENQ6KKrtWOvzkmIoFuf9yHPjC1+JQuFA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+8va2FLIodTEPFUDC9SA/8x53O2IFmvgyi8f5+wFC6AkTE0BqI
	BiVbnEeksZ9L4LAu2Uzem6jBhh6SK9qXMdCl8xf/nn/HhChD3duv8bImCStaU7ZqDg==
X-Gm-Gg: AZFdTZd6QTmgff/NegkosdXSUCrB3vISxZ/uyZpvbp7BpmHJzDzip1CO4yaZ3IJG24x
	Yx/bdvdxBDk9J8n8gr06i56P9JE8+kEkL9gXEsP0kqrwXcozLm2UmYVZ+lffNg6ZRHY4O7BTWiJ
	KRG4az+hSUFweiCrrwi1wancQr6IhUhpVG+XXwfjLp9vZ0QWkgq7FFN3PtQRM4Db4BmP4RflYzX
	D2kHnyhOAFvClThyRQe9yMg4D87ujnAhtJTdd4dPi3c9xROYy6VLh6GGGol2ZggtqGumDMMILNa
	DKAjKzLAkp0Zt5LDNLeiwV+Xz5xKBmWgXA4JhdpDmxYLrIGbpa+FCTWjps2pypKuT79g9Smfjgk
	iKgbjLOOP9JPK6EtMVIiW7V8Fsl6myP61H3LviFMRSkN9OyIn6gPO45qTrIEpv9lkrd5SXt0o/r
	FPgw3fzomI4EBCKm959FoQnkcSyFiZ97Zfyw9TQ9omFdJVbWfZ6DHwsX0io1MF/jOXrwsc9Qh14
	1XsJlGDDwv4UhfxO+yR2DNrIp+fQLG6wAkwCLlYJhhqSvKSU9McW+NV8RIr9T10b/bxqcWkK1Mi
	YOO6ixrpZeMxqHz+HSdKfC+HCKa90wHPMmL+D4Fy9iBH3qIiO7bmqFZPLCkd7a266aZ0x1rD0Jj
	tzWnLQgsjbpjhtK19GA==
X-Received: by 2002:a17:90b:442c:b0:3b4:12a9:2e9 with SMTP id 98e67ed59e1d1-3b41c7d17e4mr9833343a91.6.1795412202399;
        Sun, 22 Nov 2026 21:36:42 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:d8fa:c511:e415:e0d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c38sm4636531a12.2.2026.11.22.21.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 21:36:41 -0800 (PST)
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
Subject: [PATCH v2 1/2] zsmalloc: free a zspage's pages in one batch
Date: Mon, 23 Nov 2026 14:36:24 +0900
Message-ID: <a74aca7a3d27333972782b29786c7b33861a56f1.1795412161.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
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

