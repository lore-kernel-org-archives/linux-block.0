Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795037824;
	b=aL07MxBGh+FMdvRR535xiH7NLzOlCiwp57jm+FQzC+NM29nBesYqlbre+dJFThiarnoa
	 nvxumEeffXnUwMXIY8DG9BD2pIh647Al1/EQk0oz0sZF2JUOoL6AZbYwQ1eB8XIQ0Q0eB
	 2DNwSuyGePEOIudNuGn/PPBkMxiuQXeOLATPJisB9pR/Bj7Rt41V8jjL1rZaKLUTMUY0z
	 krY8hE6YjTAR8FK4y3SBc2W5u418tJgJEBhCh03k55shSFxSPRzXEvtt1fXYezj1MWwBw
	 vtNe7BVcoQ6hUUdMAqPDsiWCORHaPosGupNk8Ux/cbByWhrSalJUNVSpok2f3GO9lyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795037824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0UBwsLS/EBzbzU7QpPz3uyEft8mQKTdSfQyTUVJf5Oc=;
	b=cfqqPfLApza9rUC0ck4p7rP3CiEe1kfK+xUfluu1tHtky083uDSlSPi35rFprEv1NNUY
	 1VNEXMi4pTlrNZ+nsGkxGKrPEad702ZOfjk8PtXoshQmXPzMvt0hvWiKofzqSHKQhnFMX
	 iobEsY7EOLuYUtlGrVuk5XQ2cqiTOAPB58mtiZhdj6pGx59ZgtvvNrSFYyYreVrQ4A5bm
	 ef611pwSvPMZU9mYT2t8odxvf92St8cjr1WcG6F2Mx9uTZ+R5WPYSPWip7sx394NZBc3m
	 oF7tO6HQYm5bwTtlOyMHaq1LUzTQ6lcVNbmEhRvINThHYgTqmyQW4D5HOkcnZf6lf7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UKBR2IqG;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C017606A325
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 21:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C017606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UKBR2IqG
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b4d6981c67so9714307b3.1
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 13:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795037823; x=1795642623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0UBwsLS/EBzbzU7QpPz3uyEft8mQKTdSfQyTUVJf5Oc=;
        b=UKBR2IqGEDpQuvzVKoXUAv4Gr2vaLysiy8NOyCVVcxpAuSHut/Ldcc4JxuU9Hcfmcc
         A5rgJsbFOp0m7V5xsBo0tqNa62Jpuy8Ldv6pUVzwWXKn1P7dxeWb4erGpeRwtr8gr1kE
         KGrYvtgKwc3wh1/2eDFNl/GzlQXvDyexpGidjkPiPWKEbgELAKOeIwwTOdof3RszhmTj
         v7RtqH1J4AoK0QozI8ncxSs94cosYu6nEwIrOljdfVmw0mWj8WY3csQk+C4fKhFh4G4Y
         +u+LrAoD8hKitsTD5GwRppCsMhoRau0UDrFm9K1Hr3ocQAqOyGVa6pjTB23B7a13TBgY
         TA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795037823; x=1795642623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0UBwsLS/EBzbzU7QpPz3uyEft8mQKTdSfQyTUVJf5Oc=;
        b=crVFGkWDwKd75RDoUdvJ23Ue0Zp8QdpC8t33ukCaIBW4/+soqGE79mOEnxKKiPi5Tx
         AIt0Oi8rKhLaeUzhSFOGjsdUKIuNv2mPyGdnEih1E0nOSzQjnSYjQiOT4LtPysanwr23
         0Mi4ekJa5UDWLabzHqDXzkqioE9mWbqlkOx2p85jbPzy23375cGufzq7CnQyAXqeFrgN
         HiK3/geZjVxzccEmaqF9e6tlJvM6ixs1+0Rf2LZDN8ZhoFxaenxROWWGVztKp0KsjNOb
         IDCpCd3noaO1/jIcWxB+ZqPfhUHFnwijJ/jsp2ERwZDN17yJEg+YJXBzepOn+ImD4vus
         fCGw==
X-Forwarded-Encrypted: i=1; AL+hErH6H/Lxryyvq5qrVsjt6Fwhi8RmGuyUGnNC3fs486CtltVD/7GPtFA7Nn+ntutjgZBfS+IcNcLJ2AWffA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9bHTPRaCt4EwDywZXK8MyoMphPVqNRpXfydfY7+uGAJAXW9Pz5
	TgtK+b+2yadEFm1ftnU5Cbv1rQsGj8aL5jjCQSV/bKmBWRwDBcuok3Fj
X-Gm-Gg: AZFdTZfnOko/RcVgGiWLDgULxCH9zy+mjC7yKpoe3l82zEEKFN9EppfpzTO+K94ei7d
	jESu2w68oSOE6tc3PJRWyMmJCOH6Vn1r6wgFpgNhaROjnGbcebyr8sF4FhSEGwro8Ww2WHr2114
	gZ6airKLIrPNrefOUMiCUZsosR/SPWdmAtFxx5LGICwdHIdnTsjk/7iKRbgYvwY5d/XfGhMyYK+
	MBiJmZ5ZlA/ycFxLpBaBrMV7ER0n5Smq5W/BvXdPhj2PrkjxB6CjNQQO49N6jtN94a5j4uwPCiK
	8USGamNBDJQM0SOAR9fQVJgb3GyBnka+99X8JwM66f5bCJGZEBfjsFNm2cuGtEoTILBfHsCvMqK
	BBIctCcVJNdP7OlOT8E205ptMrV1NOyysLrmiixPEI3iXw8qPFv9C07HQuUIRSdMYY0aL6KSMNv
	YyY6laxA6EvUgX5/xLxHNZdwTkJeIdo9sja9LE1lsIZ6F4OLpwgG18DgM49kMNPYuhyZ2zCIPwp
	+OkmE1n3Hl9tCccya69fxPjyiN7Hn3UGh0dEYgSLZcRkl1ShvAVG99bgvd5o4LdHtN0dg7E3UAR
	1UtJYGyM4eqye0CYy+C4c01godE0XWjTfOpcIWoRRivsTbq83wS9SvM=
X-Received: by 2002:a05:690c:34c9:b0:8b0:cc41:a124 with SMTP id 00721157ae682-8b4fed8df52mr15909757b3.49.1795037823316;
        Wed, 18 Nov 2026 13:37:03 -0800 (PST)
Received: from 5163NRD-SPrabh2.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fe030be2sm24565697b3.10.2026.11.18.13.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:37:03 -0800 (PST)
From: Swarna Prabhu <sw.prabhu6@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	viro@zeniv.linux.org.uk
Cc: linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dave@stgolabs.net,
	riel@surriel.com,
	yeoreum.yun@arm.com,
	hch@lst.de,
	Swarna Prabhu <s.prabhu@samsung.com>
Subject: [PATCH 3/5] mm/gup: make the GUP-fast walkers record into struct gup_out
Date: Wed, 18 Nov 2026 13:34:56 -0800
Message-ID: <20261118213458.377258-4-sw.prabhu6@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118213458.377258-1-sw.prabhu6@gmail.com>
References: <20261118213458.377258-1-sw.prabhu6@gmail.com>
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

From: Swarna Prabhu <s.prabhu@samsung.com>

Pass 'struct gup_out' down the GUP-fast walkers and record acquired
pages through 'gup_out_add_range()' replacing pages array indexing and
pointer advancement. Record each existing PTE batch with one append.

Retain the walker's page-count return value so that callers can detect
short walks. Have gup_fast() obtain its result from the descriptor and
reset the count after releasing pins when a concurrent fork is detected.

Move fallback handling into gup_fast_fallback_out(), sharing the
descriptor with the slow path so recording continues after the pages
acquired by GUP-fast. Keep gup_fast_fallback() as an array-based wrapper
that initializes an empty descriptor.

No functional change.

Signed-off-by: Swarna Prabhu <s.prabhu@samsung.com>
Assisted-by: LLM
---
 mm/gup.c | 94 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 56 insertions(+), 38 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 0b8dd3fde06b..43b92058a213 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3146,7 +3146,7 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
  */
 static unsigned long gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp,
 		unsigned long addr, unsigned long end,
-		unsigned int flags, struct page **pages)
+		unsigned int flags, struct gup_out *out)
 {
 	unsigned long nr_pages = 0, nr_batch;
 	struct folio *folio = NULL;
@@ -3158,7 +3158,6 @@ static unsigned long gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp,
 	do {
 		pte_t pte = ptep_get_lockless(ptep);
 		struct page *page;
-		unsigned long i;
 
 		nr_batch = 1;
 
@@ -3229,8 +3228,7 @@ static unsigned long gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp,
 			nr_batch = 1;
 
 		folio_set_referenced(folio);
-		for (i = 0; i < nr_batch; i++)
-			pages[nr_pages + i] = page + i;
+		gup_out_add_range(out, folio, page, nr_batch);
 		nr_pages += nr_batch;
 		folio = NULL;
 	} while (ptep += nr_batch, addr += nr_batch * PAGE_SIZE, addr != end);
@@ -3254,7 +3252,7 @@ static unsigned long gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp,
  */
 static unsigned long gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp,
 		unsigned long addr, unsigned long end,
-		unsigned int flags, struct page **pages)
+		unsigned int flags, struct gup_out *out)
 {
 	return 0;
 }
@@ -3262,11 +3260,11 @@ static unsigned long gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp,
 
 static unsigned long gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp,
 		unsigned long addr, unsigned long end,
-		unsigned int flags, struct page **pages)
+		unsigned int flags, struct gup_out *out)
 {
 	struct page *mapped_page, *page;
 	struct folio *folio;
-	unsigned long nr_pages, i;
+	unsigned long nr_pages;
 
 	/* See gup_fast_pte_range() */
 	if (pmd_protnone(orig))
@@ -3301,19 +3299,18 @@ static unsigned long gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp,
 		return 0;
 	}
 
-	for (i = 0; i < nr_pages; i++)
-		*(pages++) = page++;
+	gup_out_add_range(out, folio, page, nr_pages);
 	folio_set_referenced(folio);
 	return nr_pages;
 }
 
 static unsigned long gup_fast_pud_leaf(pud_t orig, pud_t *pudp,
 		unsigned long addr, unsigned long end,
-		unsigned int flags, struct page **pages)
+		unsigned int flags, struct gup_out *out)
 {
 	struct page *mapped_page, *page;
 	struct folio *folio;
-	unsigned long nr_pages, i;
+	unsigned long nr_pages;
 
 	if (!pud_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
@@ -3345,15 +3342,14 @@ static unsigned long gup_fast_pud_leaf(pud_t orig, pud_t *pudp,
 		return 0;
 	}
 
-	for (i = 0; i < nr_pages; i++)
-		*(pages++) = page++;
+	gup_out_add_range(out, folio, page, nr_pages);
 	folio_set_referenced(folio);
 	return nr_pages;
 }
 
 static unsigned long gup_fast_pmd_range(pud_t *pudp, pud_t pud,
 		unsigned long addr, unsigned long end,
-		unsigned int flags, struct page **pages)
+		unsigned int flags, struct gup_out *out)
 {
 	unsigned long next, nr_pages = 0, chunk_nr_pages;
 	pmd_t *pmdp;
@@ -3369,12 +3365,12 @@ static unsigned long gup_fast_pmd_range(pud_t *pudp, pud_t pud,
 		if (unlikely(pmd_leaf(pmd))) {
 			chunk_nr_pages = gup_fast_pmd_leaf(pmd, pmdp, addr,
 							   next, flags,
-							   &pages[nr_pages]);
+							   out);
 
 		} else
 			chunk_nr_pages = gup_fast_pte_range(pmd, pmdp, addr,
 							    next, flags,
-							    &pages[nr_pages]);
+							    out);
 		nr_pages += chunk_nr_pages;
 		if (chunk_nr_pages != (next - addr) >> PAGE_SHIFT)
 			break;
@@ -3385,7 +3381,7 @@ static unsigned long gup_fast_pmd_range(pud_t *pudp, pud_t pud,
 
 static unsigned long gup_fast_pud_range(p4d_t *p4dp, p4d_t p4d,
 		unsigned long addr, unsigned long end,
-		unsigned int flags, struct page **pages)
+		unsigned int flags, struct gup_out *out)
 {
 	unsigned long next, nr_pages = 0, chunk_nr_pages;
 	pud_t *pudp;
@@ -3400,11 +3396,11 @@ static unsigned long gup_fast_pud_range(p4d_t *p4dp, p4d_t p4d,
 		if (unlikely(pud_leaf(pud)))
 			chunk_nr_pages = gup_fast_pud_leaf(pud, pudp, addr,
 							   next, flags,
-							   &pages[nr_pages]);
+							   out);
 		else
 			chunk_nr_pages = gup_fast_pmd_range(pudp, pud, addr,
 							    next, flags,
-							    &pages[nr_pages]);
+							    out);
 		nr_pages += chunk_nr_pages;
 		if (chunk_nr_pages != (next - addr) >> PAGE_SHIFT)
 			break;
@@ -3414,7 +3410,7 @@ static unsigned long gup_fast_pud_range(p4d_t *p4dp, p4d_t p4d,
 }
 
 static unsigned long gup_fast_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages)
+		unsigned long end, unsigned int flags, struct gup_out *out)
 {
 	unsigned long next, nr_pages = 0, chunk_nr_pages;
 	p4d_t *p4dp;
@@ -3428,7 +3424,7 @@ static unsigned long gup_fast_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long ad
 			break;
 		BUILD_BUG_ON(p4d_leaf(p4d));
 		chunk_nr_pages = gup_fast_pud_range(p4dp, p4d, addr, next,
-						    flags, &pages[nr_pages]);
+						    flags, out);
 		nr_pages += chunk_nr_pages;
 		if (chunk_nr_pages != (next - addr) >> PAGE_SHIFT)
 			break;
@@ -3439,7 +3435,7 @@ static unsigned long gup_fast_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long ad
 
 static unsigned long gup_fast_pgd_range(unsigned long addr,
 		unsigned long end, unsigned int flags,
-		struct page **pages)
+		struct gup_out *out)
 {
 	unsigned long next, nr_pages = 0, chunk_nr_pages;
 	pgd_t *pgdp;
@@ -3453,7 +3449,7 @@ static unsigned long gup_fast_pgd_range(unsigned long addr,
 			break;
 		BUILD_BUG_ON(pgd_leaf(pgd));
 		chunk_nr_pages = gup_fast_p4d_range(pgdp, pgd, addr, next,
-						    flags, &pages[nr_pages]);
+						    flags, out);
 		nr_pages += chunk_nr_pages;
 		if (chunk_nr_pages != (next - addr) >> PAGE_SHIFT)
 			break;
@@ -3464,7 +3460,7 @@ static unsigned long gup_fast_pgd_range(unsigned long addr,
 #else
 static inline unsigned long gup_fast_pgd_range(unsigned long addr,
 		unsigned long end, unsigned int flags,
-		struct page **pages)
+		struct gup_out *out)
 {
 	return 0;
 }
@@ -3481,12 +3477,27 @@ static bool gup_fast_permitted(unsigned long start, unsigned long end)
 }
 #endif
 
+/*
+ * Undo what GUP-fast recorded in @out.
+ *
+ * Don't perform any sanity checks because we might have raced with fork() and
+ * some anonymous pages might now actually be shared -- which is why we're
+ * unpinning after all.
+ */
+static void gup_fast_unpin(struct gup_out *out)
+{
+	gup_fast_unpin_user_pages(out->pages, out->nr_pages);
+	out->nr_pages = 0;
+}
+
 static unsigned long gup_fast(unsigned long start, unsigned long end,
-		unsigned int gup_flags, struct page **pages)
+		unsigned int gup_flags, struct gup_out *out)
 {
-	unsigned long flags, nr_pinned;
+	unsigned long flags;
 	unsigned seq;
 
+	VM_WARN_ON_ONCE(out->nr_pages);
+
 	if (!IS_ENABLED(CONFIG_HAVE_GUP_FAST) ||
 	    !gup_fast_permitted(start, end))
 		return 0;
@@ -3508,7 +3519,7 @@ static unsigned long gup_fast(unsigned long start, unsigned long end,
 	 * that come from callers of tlb_remove_table_sync_one().
 	 */
 	local_irq_save(flags);
-	nr_pinned = gup_fast_pgd_range(start, end, gup_flags, pages);
+	gup_fast_pgd_range(start, end, gup_flags, out);
 	local_irq_restore(flags);
 
 	/*
@@ -3517,22 +3528,22 @@ static unsigned long gup_fast(unsigned long start, unsigned long end,
 	 */
 	if (gup_flags & FOLL_PIN) {
 		if (read_seqcount_retry(&current->mm->write_protect_seq, seq)) {
-			gup_fast_unpin_user_pages(pages, nr_pinned);
+			gup_fast_unpin(out);
 			return 0;
 		} else {
-			sanity_check_pinned_pages(pages, nr_pinned);
+			sanity_check_pinned_pages(out->pages, out->nr_pages);
 		}
 	}
-	return nr_pinned;
+	return out->nr_pages;
 }
 
-static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
-		unsigned int gup_flags, struct page **pages)
+static long gup_fast_fallback_out(unsigned long start, unsigned long nr_pages,
+		unsigned int gup_flags, struct gup_out *out)
 {
 	unsigned long len, end;
 	unsigned long nr_pinned;
 	int locked = 0;
-	int ret;
+	long ret;
 
 	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
 				       FOLL_FORCE | FOLL_PIN | FOLL_GET |
@@ -3553,16 +3564,15 @@ static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
 	if (end > TASK_SIZE_MAX)
 		return -EFAULT;
 
-	nr_pinned = gup_fast(start, end, gup_flags, pages);
+	nr_pinned = gup_fast(start, end, gup_flags, out);
 	if (nr_pinned == nr_pages || gup_flags & FOLL_FAST_ONLY)
 		return nr_pinned;
 
 	/* Slow path: try to get the remaining pages with get_user_pages */
 	start += nr_pinned << PAGE_SHIFT;
-	pages += nr_pinned;
-	ret = __gup_longterm_locked(current->mm, start, nr_pages - nr_pinned,
-				    pages, &locked,
-				    gup_flags | FOLL_TOUCH | FOLL_UNLOCKABLE);
+	ret = __gup_longterm_locked_out(current->mm, start,
+					nr_pages - nr_pinned, out, &locked,
+					gup_flags | FOLL_TOUCH | FOLL_UNLOCKABLE);
 	if (ret < 0) {
 		/*
 		 * The caller has to unpin the pages we already pinned so
@@ -3575,6 +3585,14 @@ static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
 	return ret + nr_pinned;
 }
 
+static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
+		unsigned int gup_flags, struct page **pages)
+{
+	struct gup_out out = GUP_OUT_PAGES(pages);
+
+	return gup_fast_fallback_out(start, nr_pages, gup_flags, &out);
+}
+
 /**
  * get_user_pages_fast_only() - pin user pages in memory
  * @start:      starting user address
-- 
2.53.0

