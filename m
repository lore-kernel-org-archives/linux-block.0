Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795768132;
	b=xcAVPwAnv/bBsvux/0JXTB1tsP720iyr6o7jiIwwPa/rsbhJs8/eutGz3y9jRSyuVjbM
	 vHqCoyh1EWoYea3wzOhAzipZdszAKQ1JjH7iAc+TdG/2jL28HB33/pwQ+n9foY4OJADoh
	 vgsyVH5SA0Y9FkdkMksb+m13740nIy2+zcN+xwVv7gaPo65B0GKk6N9G9Aa5kCe5eowtq
	 y5WAx9gdBTUyqcked3H7iBQYaY4pWDJXyLO6Svvl152N6w8CuxwBoeDp79sSU6kbrLOhu
	 gdljjUruA1B+X95HX87e2Inmk2Mjo0gh5ZnQL7FxJk3p83AEeUs6rOGGla4hr7tgl2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795768132;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=iqNLEUfWhmOMSL23MOtwNVURYUmPLn8/4sm98DvyXcM=;
	b=f8NrWdqMrD+XrN81j5ccp7cL0JbV6OVLXpGoCxAJ1LKeZfgUacCeXICxSWOZkZCPSvjq
	 71BlNDQ+zRZ8qaouZFUhQTvmo6ANRJUPdUw8QmaYNc0hC+jqmOUWOgcEo0RsTuQG97C9d
	 1L3ZiRlLlvLg5r/aWAIClwiFxp7B4SqGmjOiBhyo5Atoz1jLN3huRSLZRmFX7HOBHxJHZ
	 ux8ai001YYsQCViePCT773URzEHXKZ2sZz/7BUTsBwmJPz6JAsgIUUSK9WoCgRzoFgI9m
	 36RpXirv4YcSoX5sUaeWj+C4RYGTm3I74MPG3nnqpA+bbeitqG7STwWD2XOz8Vlt56A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=xiaomi.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=WpohgH3S;
	arc=none smtp.remote-ip=117.135.210.9
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2D7606A31C;
	Fri, 27 Nov 2026 08:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB2D7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=WpohgH3S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=iq
	NLEUfWhmOMSL23MOtwNVURYUmPLn8/4sm98DvyXcM=; b=WpohgH3S/haZ3aKn/R
	Geq+08eDOGjhRJ3okZ33fPuxeTvb017d/H/tEglI8MeA2dh330MvSanbz6VIjvYq
	A2+b2hVbPZd/4hJHIpPuwbObxFZdZmLPErxCXaYPDehGsrtjMRKmXtFMCXSwD3JM
	IefMcfBCsBVtvbj5u9mR9OCvs=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3F6fFPglrbVuREA--.44951S2;
	Fri, 27 Nov 2026 16:26:47 +0800 (CST)
From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: sashiko-bot@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Usama Arif <usama.arif@linux.dev>,
	Yosry Ahmed <yosry@kernel.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Ying Huang <ying.huang@intel.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Wajdi K Feghali <wajdi.k.feghali@intel.com>,
	Bala Seshasayee <bala.seshasayee@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo56@xiaomi.com>,
	sashiko-reviews@lists.linux.dev
Subject: Re: [RFC PATCH v4 2/4] zram: support compression at the granularity of multi-pages
Date: Fri, 27 Nov 2026 16:26:41 +0800
Message-ID: <20261127082645.3623843-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-216089@kernel.org>
References: <20261115024455.1465726-1-zhaonanzhe@xiaomi.com> <20261115024455.1465726-3-zhaonanzhe@xiaomi.com> <sashiko-outbox-216089@kernel.org>
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
X-CM-TRANSID:_____wD3F6fFPglrbVuREA--.44951S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtrWUCrW3Kw4DurWrKF18uFg_yoW7AF1kpF
	4Ut390y3yrJrW8Cr17CFn3ur1Sy3ykCayUAFWxGw1Yqr93tF9Y9FyvyFy7CFnrGr1xCa9a
	vrZ8A345XF1YvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U9XocUUUUU=
Sender: nzzhao@126.com
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsQfdrWsJPsdFgQAA3Z

> If an unaligned write bio with bv_len >= ZCOMP_MULTI_PAGES_SIZE or a multi-bvec
> bio enters the multi-page path

In __swap_writeout(), folios are added via bvec_set_folio(&sio->bvecs[...],
folio, folio_size(folio), 0), which always starts at the folio-aligned base
(offset 0) and covers the entire folio. Therefore, there are no unaligned
writes, nor can a single folio be split across multiple bvecs.

> and lands on a head slot that holds a single-page (PAGE_SIZE) object

Swap cluster allocation for large folios (__swap_cluster_alloc_entries())
only allocates naturally order-aligned slots from high-order clusters, so a
large folio swapout cannot land unaligned on a single-page slot.

> When a single-page bio (bv_len == PAGE_SIZE) writes a subpage belonging to
> a large folio

Swap always writes a whole folio at once, so a bv_len == PAGE_SIZE bio can
only be a whole order-0 folio, never a subpage of a large folio.

> [Severity: Critical]
> Does zram_read_partial_from_zspool() ignore bvec->bv_len and
> bvec->bv_offset?
>
> zram_bvec_read_multi_pages_partial() passes only bvec->bv_page and the
> slot offset to zram_read_partial_from_zspool(), and all three branches
> above always write PAGE_SIZE bytes to offset 0 of page.  When a partial
> multi-page read has bv.bv_len > PAGE_SIZE (for example, 2 or 3 pages) or a
> non-zero bvec->bv_offset, zram_bio_read_multi_pages() still advances the
> bio iterator by bv.bv_len, writing to the wrong offset of bv_page or
> leaving the remaining pages of the read uninitialized.

Agreed. zram_read_partial_from_zspool() should respect bvec->bv_len and
bvec->bv_offset instead of hardcoding PAGE_SIZE and offset 0. I will
pass struct bio_vec *bvec and use its length and offset:

--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2872,8 +2872,8 @@ static inline bool is_multi_pages_partial_io(struct bio_vec *bvec)
 	return bvec->bv_len != ZCOMP_MULTI_PAGES_SIZE;
 }
 
-static int zram_read_partial_from_zspool(struct zram *zram, struct page *page,
-					unsigned long index, int offset)
+static int zram_read_partial_from_zspool(struct zram *zram, struct bio_vec *bvec,
+					unsigned long index, int offset)
 {
 	struct zs_handle *handle = &zram->table[index].handle;
 	struct zcomp_dstrm *zstrm;
@@ -2889,7 +2889,8 @@ static int zram_read_partial_from_zspool(struct zram *zram, struct page *page,
 		void *mem;
 
-		mem = kmap_local_page(page);
-		zram_fill_page(mem, PAGE_SIZE, zram->table[index].element);
+		mem = kmap_local_page(bvec->bv_page);
+		zram_fill_page(mem + bvec->bv_offset, bvec->bv_len,
+			       zram->table[index].element);
 		kunmap_local(mem);
 		return 0;
 	}
@@ -2900,8 +2901,8 @@ static int zram_read_partial_from_zspool(struct zram *zram, struct page *page,
 	if (size == page_size) {
 		src = kmap_local_page(sg_page(sg));
-		dst = kmap_local_page(page);
-		memcpy(dst, src + offset, PAGE_SIZE);
+		dst = kmap_local_page(bvec->bv_page);
+		memcpy(dst + bvec->bv_offset, src + offset, bvec->bv_len);
 		kunmap_local(dst);
 		kunmap_local(src);
 		ret = 0;
@@ -2917,8 +2918,8 @@ static int zram_read_partial_from_zspool(struct zram *zram, struct page *page,
 				       zstrm->decomp_buf, page_size);
 		if (!ret) {
-			dst = kmap_local_page(page);
-			memcpy(dst, zstrm->decomp_buf + offset, PAGE_SIZE);
+			dst = kmap_local_page(bvec->bv_page);
+			memcpy(dst + bvec->bv_offset, zstrm->decomp_buf + offset,
+			       bvec->bv_len);
 			kunmap_local(dst);
 		}
@@ -2937,8 +2938,8 @@ static int zram_bvec_read_multi_pages_partial(struct zram *zram,
 	slot_lock(zram, index);
 	if (!test_slot_flag(zram, index, ZRAM_WB)) {
-		ret = zram_read_partial_from_zspool(zram, bvec->bv_page,
+		ret = zram_read_partial_from_zspool(zram, bvec,
 						    index, offset);
 		slot_unlock(zram, index);

> [Severity: Critical]
> Does using mp_bvec_iter_page() in multi_pages_bvec_iter_bvec() keep
> .bv_page stuck at the first page of a large folio across iterations?
>
> Unlike bvec_iter_page(), mp_bvec_iter_page(bvec, iter) always returns
> bvec[iter.bi_idx].bv_page without adding mp_bvec_iter_page_idx(bvec,
> iter), while multi_pages_bvec_iter_offset() wraps .bv_offset modulo
> ZCOMP_MULTI_PAGES_SIZE.  When a folio larger than ZCOMP_MULTI_PAGES_SIZE
> (such as a 64KiB or 128KiB folio in a single multi-page bvec) is read or
> written, every iteration of zram_bio_write_multi_pages() and
> zram_bio_read_multi_pages() accesses subpage 0 of the folio, repeatedly
> compressing or overwriting the first ZCOMP_MULTI_PAGES_SIZE bytes and
> leaving the rest of the folio unread or unwritten.

Agreed. For multi-page bvecs spanning multiple compression windows,
multi_pages_bvec_iter_bvec() needs to advance the subpage and offset.
I will switch to bvec_iter_page() and bvec_iter_offset():

--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -194,5 +194,5 @@
 #define multi_pages_bvec_iter_bvec(bvec, iter)				\
 ((struct bio_vec) {							\
-	.bv_page	= mp_bvec_iter_page((bvec), (iter)),		\
+	.bv_page	= bvec_iter_page((bvec), (iter)),		\
 	.bv_len		= multi_pages_bvec_iter_len((bvec), (iter)),	\
-	.bv_offset	= multi_pages_bvec_iter_offset((bvec), (iter)),	\
+	.bv_offset	= bvec_iter_offset((bvec), (iter)),		\
 })

