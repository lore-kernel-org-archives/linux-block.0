Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795403489;
	b=U8b4ilSpgk6Chr8wy6LSyTCairbEygVMgYZScqpQi3BbAiahKEdgKhmhH3TncObEfASd
	 jgxe8FBZmpeu3fwN+vswq8fWhdP6uj4w6PRfXRc+d4aocmA+PfI66lCA6622zWc120UA6
	 28eEhQgvU2FwITIQfED++Km8NWoVSx1SCbAXWPzt45XaxpqB9/kLnTrRaHaMuL++AyOcb
	 OmnT95WvxJFiisHPmcx9gfv/ehS+YRknP5410Ef4tuBTqbL0Hy8J8HXnFL6wTfdR096kh
	 EAQfdSnHdLEurIviNzEjOUSVG/2fjfZR+9kJ9WR4W42mTRypcf4/jRdjwEvU8kw3U1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795403489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5xwbvs9dbFOKA8I/2QnQJ3qTyNUOhR9OO7JyO6aGPgk=;
	b=GWdQm8esukt72AA8gEo7/YOUqyedjwOvP7xWJhIFDKiUBsQI3OL+nOqvSejABmihYbcR
	 BezOxr9yzJn84LggjYiZsiIYPTMERfzratQ+XHsPBUmH1vHBr67lWVL02hTX+JAtUuIEf
	 9Yp8+3j/6oP+8VjwSBrOXYFOjkygm26NZbFs3zEE4XDG8lgHDgJzA3lplWEG44mDea4z+
	 C2VjDK1g61OxJjDcmFossO69RW1AEoznIFLM5DN048956z2xsNkTNwOGc07y8auAZOYAe
	 DRrkKdJZczdFmlgpKEqgyJyenlYe9BjSgivcWTCPpIU3WrXpUZK9ATw35VaIgB1QoUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=clSNMRH0;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A209606A327
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 03:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A209606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=clSNMRH0
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b40d23e1adso2034564a91.0
        for <linux-block@vger.kernel.org>; Sun, 22 Nov 2026 19:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795403488; x=1796008288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5xwbvs9dbFOKA8I/2QnQJ3qTyNUOhR9OO7JyO6aGPgk=;
        b=clSNMRH05ChsMPIodcRhLgP9oQRrpoI20hpxFngJSARyXR92jQHY7oDGUXafan9KWs
         epgNa84iSki2LQZf25tJIUYft4gYjVLzLAKOmew1OjK7e9TNvOmkdwIJCCfAhYn1mV4n
         /R+flvn1Rf6iS+jWn5C6DuFzJzH62qwCOhsTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795403488; x=1796008288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5xwbvs9dbFOKA8I/2QnQJ3qTyNUOhR9OO7JyO6aGPgk=;
        b=oUxwOyhbJS1Opxy/IdEXGaNMEPob9ckvO+C81djwKsFSw3GcoUYJIUFatp2gkXbKEr
         qJFQT1+FqJnEpXfg7SfqQj4byhfUYU0PuEx2GfGOO0qQqto2ceVeMahu7WXdVp+GeQNn
         9J5s7gMa3TEWablStgmAlGWmMz2bbTJ/jEo9Q/mwtR1oLbrm0gEEHEu0i2ugYL3Sr7pq
         M537dJR5Nf7Lp0cnEIQsL6IMtJLRo91FNzettKanlqId1nvcVQb9Cjycpb5dvsadMm8d
         jXCHbZVhni5tKPThxE6iGPWJ3zDfF8zdBEZAC71tOjsF943cYvM9Za+22t3JcOAul2FB
         lFnQ==
X-Forwarded-Encrypted: i=1; AL+hErG4DfnQ9E2TRx5+f8lSjGSPGvS3aZI3P0VJoeJX+kgQzzbmfwC6O93CwBFMZQfSfLt/49MGArAUXo2aaQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/2FjBwQ/QCtYXPyJc75DRF/N4XTezpv262Y7gy6a/dBaGk/neg
	6nEgVGxDBPicvEdlvO2samlwCNTRq32gIPo1SeNrMpE2VWs+FdEw9jY7m52lofBS4A==
X-Gm-Gg: AZFdTZfgiZcpZ7yhAgcSIodXIcJLa3dqNRtkK/D/paDkUBkTwhPNDCfuF/U6LaRxpKj
	cxkdUxaxyZ6GR8EypQAvMbFiZ4sYgK/jq8SXzPTLz90/HNJLZEGaD2Cv7BDHBN34pidRfPggXoi
	yTrQxRKXv7P6BIL2GCFncBEkgTKD8qK35uEyxategiEcfD7xxCEbTfcq4ZR8l/KNzAehYqhQSvo
	OvekxgEW1SzShTQ3ircXIb7t7Y7VOOvgdtetI1T6n3t4aH3G14JmpP7mbaeaOXq7BjKQgX9AO8G
	1W1yNMlosntK5crxON3/pYO3SQ4/lS5iDrhON9xFO0FVPehqvNWF+3NZ0lbk3izIPtBbAAgIhJe
	8h3R8IvchNHh0pGFGnLnKznbybAw7QraPHllNVQLMAf8+z3gfB1ij01z9yQQuJBjcJblbqBvVbo
	Ufmpuv4uavp7TiN4hobbT1nmV5WCHiddTCBmve54nTMWprShmtf5ZntwgeYPcdBwKhzSkxYmcSR
	JinVvT3VGPG/GRsH8LnwnKv/HyF3apSSObQk/DTVmyQKeqwXQZWnCPGq2hKp2KrrKHm8pHYBF+Z
	+rTjBNNn6mYxuuTYZL5SrBOddlYa3K7W9dxVyvf1wqaVeABugH1Zr9Odm6zxTlfbz+XV9mJZQ6u
	KQDms+CgDjUTLXJTYMg==
X-Received: by 2002:a17:90b:3b52:b0:3b3:b9e4:e3f5 with SMTP id 98e67ed59e1d1-3b41c92a524mr9488083a91.30.1795403487780;
        Sun, 22 Nov 2026 19:11:27 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:d8fa:c511:e415:e0d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c13sm15330240a91.14.2026.11.22.19.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 19:11:27 -0800 (PST)
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
Subject: [PATCH 1/2] zsmalloc: free a zspage's pages in one batch
Date: Mon, 23 Nov 2026 12:10:58 +0900
Message-ID: <5666c1c8c04998784c81fc8fe751e35aa40af578.1795403342.git.senozhatsky@chromium.org>
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
folio_batch is not free.  The batch lives in its own noinline
function, which also keeps.

munmap() test:
                    next-20261119      v7.4-rc3
  256 MiB           -2.0% .. -4.1%     -4.4%
  1 GiB             -2.8% .. -4.4%     -3.8%

Link: https://lore.kernel.org/20261109105957.2577351-1-chenhongfeng0212@gmail.com
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 52 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index f571b3c9e9ca..9dcd1549c2fb 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -37,6 +37,7 @@
 #include <linux/debugfs.h>
 #include <linux/zsmalloc.h>
 #include <linux/fs.h>
+#include <linux/folio_batch.h>
 #include <linux/workqueue.h>
 #include "zpdesc.h"
 
@@ -866,6 +867,44 @@ static int trylock_zspage(struct zspage *zspage)
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
@@ -884,21 +923,22 @@ static int trylock_zspage(struct zspage *zspage)
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

