Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289744;
	b=FSVQpFGSa0cShQt+09Pa7dV09T4IeCOGsHOaf7MuZh4+TS05xOOj+YwlR2v61BNNse67
	 2vRslE7d9sqMUagfrKsfHFDfX171slf0GCffCOSxKuT0pdVDRSWL5GnRP9c6kv8OhAqcP
	 mjfWnWrULX6BZsaSt7JUF32P9Tq9wDsEU15vWs7a9nZxjJAQD//a4rZUqHNkVxO46IUIp
	 v0PXI2IOi8/y8+SvOeBIDiCYKMuxG9WZRnuluRK1MwRs+IRGQQOMJgxCyMcZPHM5Z2HLD
	 11qu+PJYJNzv4oXJmgjP1NcgqCtCj9PpyxhsveBC3SYE8mNP/QfRvPGJL4gVE0H9n9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=X7J8W8iGMlxVtygfltgHoQnyuGwmlkD+WN19PoJbqGw=;
	b=HmCeZRmzllqTNSkx08SmeDcca5eq5W/ATWjbwJyRWO8Hhc9mBFTe9+R7RNQ6/wFEqwYg
	 jKptaQoMppaqEBoQDPZYc7pRHjXhBIHqp+sWRrk0rveU2PR3lyJ3RLYNL6ayQEJt6XZun
	 PkEe21861XSTpo09KO5MZuE26Uo57mm0vCG6lMkKndFlMnZ0Jf1VBA3/KrzXrJCWgL034
	 7MPBYtoIA4DRgiSvc3ur9mxfiMikn6dE1FMBNeveUuGyunGm2N5PpgAhBKPbvXfVfxa51
	 Y7F6hj+Lf61HbUkje0wiYRcMiySggF0MrP54ZId44hArr0T1Lhr1MD7n/aOnw4w3Oig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="G7j/r8SO";
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC74606A339
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 05:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CC74606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=G7j/r8SO
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b5efadd183so746027b3a.1
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 21:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794289743; x=1794894543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X7J8W8iGMlxVtygfltgHoQnyuGwmlkD+WN19PoJbqGw=;
        b=G7j/r8SO31RG6om+dY6mnb8eRzQMnVKt7r2QX9BCG96JNErEc1129q/wu2KssUcyu5
         xsTjEPbXa4v4/zfw3eQRQfzBywB0P1c1TXVTcTFbnHNEG8ROELdMsWWFSR4YaSb/7WrD
         k5N5NUo7Gxw0EuCcQOEcgjxT4cUmAFzSRTR2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289743; x=1794894543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X7J8W8iGMlxVtygfltgHoQnyuGwmlkD+WN19PoJbqGw=;
        b=HGeYHmJgiRbUGxeBeQr+0/txxnxMJfqbsw5ULYYudGMBolQ+JLsA3a/nInu8YDJ1Cl
         xXcVYreVmuo5SV0eGbAgISp4Hpx4uaafDD5e3iAiyWwMAqCNuyLgit9sEMX6YniGnEqa
         T4FEJtUHTdDwEs88mz60a9jRNmk8zyEt9+tVJb7qEYcj/9npaJQXRSkYLvPcafpGbD0m
         RXZUcZuaZDbXyvTgWSepAV4L3aWe0OKoK1vZRQsBP2igqVkk4tE3gxPeuuPdKC70H+Kb
         t2oh5P0/IwsTy82Mv1UimwtC0bbTSnn8AlYPBQELcafF0BdwZq9uUekuaedDg6Yeiat1
         J4mA==
X-Forwarded-Encrypted: i=1; AL+hErGI/EiLQwddgAY4V4UrIe2zuXsgUvcgEN7e8Iq2Yf4icm3qlGsGmsZdpcNeDzuOtMJvNrr3nJKBE0FYSg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/84dDW2ZFXolUPkKRCdfzidOFu5Fb1upBt02aCoGnHn2e2hwpx
	+fiCubgE7bRESlS0wFvDfmkS+x/vqgU3+pOqpGFDcxsiG2CT2UEGGuC/1j2TuIpqE21SseuVapA
	yl7I=
X-Gm-Gg: AYBFou35Mwf17vZ5TsHIz+8EQbnz9AXcebdb6IxQU+IsAgq3lh2X1TkeEOmi9gyzD2x
	UZS7SVeFYRiuA7FAm5Sz9N1qgQndK+tPRinyEUfkTnDvb2apsnadRkV19NpL+OzgXZvqqKGhK2p
	VDVJ38EYs2KUKrCNnGlKSTykWhv/mAuRQxMvTvB144miYrg6FY1lDHUVnPO1fLsMe/Xkw9p/fcu
	Wt5FhHOkeXYQsx6DipsqiH1bP6x3BMqWAB3lA7P+lwYCslgq7xRPEPwaWF96gS42lSEFWlzVFaO
	mCv0J4aX/ftfc9qrcPmSh254jOj0IpyF5nOqzVTN5oVxCzQ/Jt31Fv9zFKFhcNUQJ+uaOKqLqBI
	lNVM8ruMvhPt5aQUVTg1fcRI77GyKzn4xK55+es+5CJOjf0SOnsZJWFjoi3kq8105NFl/NdZZvx
	g3Lh2nhpuqE0U90Kla6EN41KojVMHDlHkNoHEU80Pl93kmCIQ+807ZuExWtXm8e3dNOlQ7n7Cet
	StY1k4a00ISi8j4fjAfvcF61Lr44rlaukfvMDFKVFwSEzB3cxrp77XV1x4v9LmwcHe0vaDw8WcT
	2rGJs0V4O8AaW8MreukAeIp8ElEbUBU2O9PQjdK7TyQdeRh8vzHVhFGql2SfScxCoKhAqaBbmWy
	PUGdJFQxSfRJ1wvLTvg==
X-Received: by 2002:a05:6a20:2447:b0:3e2:2a4b:1bfb with SMTP id adf61e73a8af0-3f173738e45mr1398876637.29.1794289743309;
        Mon, 09 Nov 2026 21:49:03 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67e53asm444634a12.5.2026.11.09.21.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:49:02 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2 06/11] zram: allocate zsmalloc object under slot lock
Date: Tue, 10 Nov 2026 14:48:11 +0900
Message-ID: <20261110054836.1515030-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261110054836.1515030-1-senozhatsky@chromium.org>
References: <20261110054836.1515030-1-senozhatsky@chromium.org>
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

zram_write_page() and write_incompressible_page() allocate and
write zsmalloc object first and take slot lock only to free the
old slot data and set the new handle.  A subsequent patch makes
zsmalloc store object location directly in zram table entry, so
we need to free the slot before we allocate a new object for it.

Free the slot and allocate the object under slot lock.
recompress_slot() already allocates objects under it, and
GFP_NOIO reclaim cannot re-enter zram write path.

mem_limit is checked before slot_free() (previous patch), so hitting
the limit keeps the old slot data.  zs_malloc() can still fail after
slot_free(), e.g. when we write from reclaim (PF_MEMALLOC), which is
swap-out, so the old slot data (if any) is stale anyway, or when the
writer is an OOM victim that has no reserves left.  The slot is left
empty then, matching standard block write-failure semantics.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d38b20a22595..aa3ab88f1259 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2259,11 +2259,15 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	struct zs_handle *handle;
 	void *src;
 
+	slot_lock(zram, index);
+	slot_free(zram, index);
 	handle = zs_malloc(zram->mem_pool, PAGE_SIZE,
 			   GFP_NOIO | __GFP_NOWARN |
 			   __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
-	if (IS_ERR(handle))
+	if (IS_ERR(handle)) {
+		slot_unlock(zram, index);
 		return PTR_ERR(handle);
+	}
 
 	update_used_max(zram);
 
@@ -2271,8 +2275,6 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	zs_obj_write(zram->mem_pool, handle, src, PAGE_SIZE);
 	kunmap_local(src);
 
-	slot_lock(zram, index);
-	slot_free(zram, index);
 	set_slot_flag(zram, index, ZRAM_HUGE);
 	zram->table[index].handle = handle;
 	set_slot_size(zram, index, PAGE_SIZE);
@@ -2324,11 +2326,14 @@ static int zram_write_page(struct zram *zram, struct page *page,
 		return write_incompressible_page(zram, page, index);
 	}
 
+	slot_lock(zram, index);
+	slot_free(zram, index);
 	handle = zs_malloc(zram->mem_pool, comp_len,
 			   GFP_NOIO | __GFP_NOWARN |
 			   __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
 	if (IS_ERR(handle)) {
 		zcomp_cstrm_put(zstrm);
+		slot_unlock(zram, index);
 		return PTR_ERR(handle);
 	}
 
@@ -2337,8 +2342,6 @@ static int zram_write_page(struct zram *zram, struct page *page,
 	zs_obj_write(zram->mem_pool, handle, zstrm->buffer, comp_len);
 	zcomp_cstrm_put(zstrm);
 
-	slot_lock(zram, index);
-	slot_free(zram, index);
 	zram->table[index].handle = handle;
 	set_slot_size(zram, index, comp_len);
 	mark_slot_accessed(zram, index);
-- 
2.56.0.506.g506a7eabc5-goog

