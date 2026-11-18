Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795037830;
	b=jMJropP6om3Ynn2oJQHkZFIwdlFt1f+OhUVo7vyeVr5Rxo8sVP3tu5pBeZSJ5XDRpARV
	 NeO+QYhjSqURLapJBkHSVjGTfOuBAb/9//WGo445FDo4q6LamPGWzOVvq7+Ekd0aKi9Wj
	 aD7GLwR9wD2uGYck2bPUGAlQt5SPti1Fr/YleTkyIjJgO1wU2D0ATNqS0GSOLxO3QktWK
	 utFTXQrzAVeA9iI2VxRaWPr4npzZ288LFZR8gAN4SsFGCMoUBOmGr5viShDnqW4mhIGNB
	 PgRWfflQF0FL0PgWtUpVqmQE8bYH9sIRSrRieeYADnGDWlsBG3/CWm3W9VBYtqE8kdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795037830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i/aRmIhobjsWaZPTD9QJbCbTmGSJhXQ9rQ7Lo1sPRwg=;
	b=I88t3+g4We6d+MPy9iEI3Z23xUZSFZh0XqPKLJVSssA35cjlYlFw8HcWHUgpcwH9HRg9
	 l82D+mwrVtlX4TgC5BlkxW1nT93mcS/OxLKNXIc6DIG8wlGM48Dv+519qtNNmi2+ilcqi
	 6TpGBxsEzVg10hpR8WppHD25mHvs5ErhplgR4R+iVdjsZkibgWAwxyZDuf1caRzUY0z5f
	 gHZG2Zm0XX1Q1wIb04uj2NrJSxVVUcoGIQT/Knz0qUAZtp3Qj2wkPFIwTIs7eVDmoPFYO
	 E4Tut1q+xSdFk9eQW64DeBqfBgVjFeGE/p/FVlrM3g+LmAySOQRn83+GHGNoGcAM7aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c2iDq4iL;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD1C606A333
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 21:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BD1C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c2iDq4iL
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b4c685c751so13113597b3.1
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 13:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795037828; x=1795642628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i/aRmIhobjsWaZPTD9QJbCbTmGSJhXQ9rQ7Lo1sPRwg=;
        b=c2iDq4iL14/6Q6qV/8PSplNifzz+KnQ0wk18bfY1/+0iaSvtOsFj1wICrkzaTMBoxn
         oDCmwyK7pKq46a1008slPbN0E/Fq/V9awXkyZ4GRWfdBXVVNYJxJkYu+m/80k7vO+NEO
         +yMPOZdnq3s6ytfl3+/z9Z8xkuXs0BtfEmmeUFt1jVeHNK7m8EHg5TciegWNBhNfu0hI
         hozEPDJ/NPP6Rqhvu+28pAxr1XnUNCJR7PggGTbcy5oZ3z9pUtn9qmFtrQSp99GsSvJZ
         9G+++hfHHw9Dz1m6is1k3GbuYkK8BE0LslvXQ/Riuz/uy3UUv3PoxokIS8M/tIb+Rkgw
         gIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795037828; x=1795642628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i/aRmIhobjsWaZPTD9QJbCbTmGSJhXQ9rQ7Lo1sPRwg=;
        b=xIYENEZiTyp8pnAp834N2yIIEJdgEr3PQpKR7pA7kZfXUo9Pf/A2soc8KQP/F/ItMr
         TyMoOTR1hT6M5TV8VEShov9UGNbLSQKplqHDjXGjKtFdcsG4U3OQ/N4zaFh2mBNSb4Cw
         kCcGhXZ0Xc0QYQRKFbIqrdl9At5MmyoLbS8rPXtDX0JuBXGqGuY70sQqWuQDGFQt1/pW
         hnB92NNol9ItOYPSr5gOuicga3Np09awXeVs8Mt1JX0B3/ssbICZdVRqFohkn8D4gA2l
         8hDLbrpebK4N+vl3guZAAau/nT55dEAyfP6xfVEi4Q3ZDSiky39uhtmGCR/m/icRU/LX
         4iJQ==
X-Forwarded-Encrypted: i=1; AL+hErEH8Uun+V6ER5wCjmX5w2i09dsnKO3Sln8zbfDV6SL29WN7TZhuJNfLY/exzyfxJKQLCyg6P7N3okdrFg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+dNO4qlE/yYow+Od2uLcAqBkKBs5Pr62wXgKcsrWJ4T+g7awLO
	bYYWKQZUO/s3o8BSiON+oHLHcMZJAHkyifjEcMP7KapnEuOKiSSfZ4Yz
X-Gm-Gg: AZFdTZcBVtdlgWZP9ujU8jEg4W+rAsrc8RGzuD7ox59QubrtuBUmsVwnFSkzusRpmHB
	qdGhLL03F0DN8j36wBRXm79HWs1xmrYEZZ40KhCf3kyAzZViCsO/L4rNIfTK4p+Aa48LCDYU8T/
	Do6ZY0WJPRJ7RScp6MY36ElOxCt5+PPKXKTpgsVsNHODz8UJ71sIcG3L0pAWZ8bKe8Iq4TA+1gp
	/ijNIPjyAEaGmuYctWj8SAEoIKXb2P9Hmiyg5wwNk7tRbDwINKU/TN1Kqpdr12cQu5jth9hrHcI
	4/6DwHYWJhbAtkkAzNQVWFeCOt4Ik+iaXrod11VXC4fJEQ3Vhu517942RYFNKQ/2KlluyR6YX//
	F+4Ahrma/do94zdbtgEerDW0kl0U2rVDxFmoYVwTUMHbTpcU9iKgYl31eH9EmIhzSpZtk1ZS+TO
	FYwgozL+6i75bFaJYCEFRYgYMZdnVkY0JEpMSOebVu5TfaIw9A9gDZvKUZQkd1+LhmgQ1zD868B
	fWuUh2mrQdopN8GdGZ6yTYa47FZNoPbVPS0Vs59zVYXIqNMuD/Um20kyWZ+MjgULG/ltFOw7EXt
	fGY6fu8j4AkSJFekAUZkXvI0kFpiOg+GO9LiqHun2eMn7NxrX3HdmV0+HLIOLvP+Ro93lCEWygQ
	2
X-Received: by 2002:a05:690c:350c:b0:8b3:adf8:c2d9 with SMTP id 00721157ae682-8b4fed76267mr12944277b3.79.1795037827934;
        Wed, 18 Nov 2026 13:37:07 -0800 (PST)
Received: from 5163NRD-SPrabh2.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fe030be2sm24565697b3.10.2026.11.18.13.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:37:07 -0800 (PST)
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
Subject: [PATCH 4/5] mm/gup: return pinned memory as folio ranges
Date: Wed, 18 Nov 2026 13:34:57 -0800
Message-ID: <20261118213458.377258-5-sw.prabhu6@gmail.com>
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

Direct I/O maps user space addresses into the kernel by pinning user
memory and reporting it as an array of pages.  With mTHP, consecutive
pages commonly belong to a single large folio, so everything the caller
does afterwards is repeated PAGE_SIZE at a time for memory that is
contiguous.

Kundan's LPC 2024 talk 'Transitioning get_user_pages to folio' proposed
a struct folio_vec (modeled on bcachefs) that would pass and retrieve
folio_vec_array instead of pages array. Based of that series and
subsequent community discussions, exposing folio ranges through GUP
using struct folio_range:

        struct folio_range {
                struct folio *folio;
                unsigned int idx;
                unsigned int nr_pages;
        };

A range never spans more than one folio, so callers that need pages can
always get them via 'folio_range_page()', while callers that work on folios
can use the folio and 'folio_range_offset()' directly. For folio-range
output, GUP-fast conservatively defers pages with a NULL mapping to the
slow path, except for hugetlb folios. The slow path rejects VM_MIXEDMAP
VMAs with -EOPNOTSUPP if no pages were pinned; otherwise it returns pages
that are pinned successfully. Requests for an array of pages retain their
existing GUP-fast eligibility.

To avoid duplicating the page walkers, use 'struct gup_out' descriptor that
holds either page array or the folio range array, so a single walk serves
both the interfaces. Recording appends to the descriptor, removing the
explicit pages[] pointer previously used in '__get_user_pages_locked()' and
'gup_fast_fallback()'.

Recording can now fail: when the folio range array is full and the run
requires a new folio-range entry. The references or pins acquired is
released and the slow-path helper returns -ENOSPC. '__get_user_pages()'
treats this as a request to stop and returns the number of pages recorded
so far.

'pin_user_folio_ranges_fast()' stops once the caller's range array is
full, so callers can size it independently of the number of pages
requested. FOLL_LONGTERM is not supported as of now.

Signed-off-by: Swarna Prabhu <s.prabhu@samsung.com>
Assisted-by: LLM
---
 include/linux/mm.h       |  37 ++++
 include/linux/mm_types.h |  23 +++
 mm/gup.c                 | 413 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 424 insertions(+), 49 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9f167950926a..d13863ef27f0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -235,6 +235,39 @@ static inline unsigned long folio_page_idx(const struct folio *folio,
 	return page - &folio->page;
 }
 
+/**
+ * folio_range_page - Return the first page of a folio range.
+ * @fr: The folio range.
+ *
+ * Return: The first page described by @fr.
+ */
+static inline struct page *folio_range_page(const struct folio_range *fr)
+{
+	return folio_page(fr->folio, fr->idx);
+}
+
+/**
+ * folio_range_offset - Return the byte offset of a range within its folio.
+ * @fr: The folio range.
+ *
+ * Return: The byte offset into @fr.
+ */
+static inline size_t folio_range_offset(const struct folio_range *fr)
+{
+	return (size_t)fr->idx << PAGE_SHIFT;
+}
+
+/**
+ * folio_range_size - Return the size of a folio range in bytes.
+ * @fr: The folio range.
+ *
+ * Return: The size of the folio range.
+ */
+static inline size_t folio_range_size(const struct folio_range *fr)
+{
+	return (size_t)fr->nr_pages << PAGE_SHIFT;
+}
+
 static inline struct folio *lru_to_folio(struct list_head *head)
 {
 	return list_entry((head)->prev, struct folio, lru);
@@ -3541,6 +3574,10 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages);
 int pin_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages);
+long pin_user_folio_ranges_fast(unsigned long start, unsigned long nr_pages,
+			unsigned int gup_flags, struct folio_range *frs,
+			unsigned int max_frs, unsigned int *nr_frs);
+void unpin_user_folio_ranges(struct folio_range *frs, unsigned int nr_frs);
 void folio_add_pin(struct folio *folio);
 
 int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1ed35d258d2e..1a3b99ac8bbe 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -550,6 +550,29 @@ FOLIO_MATCH(flags, _flags_3);
 FOLIO_MATCH(compound_info, _head_3);
 #undef FOLIO_MATCH
 
+/**
+ * struct folio_range - A range of consecutive pages within a single folio.
+ * @folio: The folio the pages belong to.
+ * @idx: Index of the first page of the range within @folio.
+ * @nr_pages: Number of consecutive pages in the range.
+ *
+ * Describes @nr_pages consecutive pages of @folio, starting at page @idx of
+ * that folio.  All pages of a range are guaranteed to belong to the same
+ * folio, so a range can always be described by a folio + offset + length,
+ * without having to look up the folio of individual pages: something that
+ * will no longer be possible for arbitrary pages once memory descriptors
+ * are split up.
+ *
+ * A range never spans more than one folio: consumers that want the underlying
+ * pages can obtain them with folio_range_page(), consumers that operate on
+ * folios can use @folio together with folio_range_offset() directly.
+ */
+struct folio_range {
+	struct folio *folio;
+	unsigned int idx;
+	unsigned int nr_pages;
+};
+
 /**
  * struct ptdesc -    Memory descriptor for page tables.
  * @pt_flags: enum pt_flags plus zone/node/section.
diff --git a/mm/gup.c b/mm/gup.c
index 43b92058a213..8424cec41719 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -67,6 +67,39 @@ static inline void sanity_check_pinned_pages(struct page **pages,
 	}
 }
 
+/* See sanity_check_pinned_pages(). */
+static inline void sanity_check_pinned_folio_ranges(struct folio_range *frs,
+						    unsigned int nr_frs)
+{
+	unsigned int i, j;
+
+	if (!IS_ENABLED(CONFIG_DEBUG_VM))
+		return;
+
+	for (i = 0; i < nr_frs; i++) {
+		struct folio *folio = frs[i].folio;
+
+		if (is_zero_folio(folio) || !folio_test_anon(folio))
+			continue;
+
+		if (!folio_test_large(folio) || folio_test_hugetlb(folio)) {
+			VM_WARN_ON_ONCE_FOLIO(!PageAnonExclusive(&folio->page),
+					      folio);
+			continue;
+		}
+
+		if (PageAnonExclusive(&folio->page))
+			continue;
+
+		/* A PTE-mapped THP: each page has to be exclusive. */
+		for (j = 0; j < frs[i].nr_pages; j++) {
+			struct page *page = folio_page(folio, frs[i].idx + j);
+
+			VM_WARN_ON_ONCE_PAGE(!PageAnonExclusive(page), page);
+		}
+	}
+}
+
 /*
  * Return the folio with ref appropriately incremented,
  * or NULL if that failed.
@@ -437,6 +470,23 @@ void unpin_user_folio(struct folio *folio, unsigned long npages)
 }
 EXPORT_SYMBOL(unpin_user_folio);
 
+/**
+ * unpin_user_folio_ranges() - release an array of gup-pinned folio ranges
+ * @frs: array of folio ranges to be released
+ * @nr_frs: number of folio ranges in the @frs array
+ *
+ * For each range in the @frs array, release the pins that
+ * pin_user_folio_ranges_fast() took for its pages.
+ */
+void unpin_user_folio_ranges(struct folio_range *frs, unsigned int nr_frs)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr_frs; i++)
+		gup_put_folio(frs[i].folio, frs[i].nr_pages, FOLL_PIN);
+}
+EXPORT_SYMBOL_GPL(unpin_user_folio_ranges);
+
 /**
  * unpin_folios() - release an array of gup-pinned folios.
  * @folios:  array of folios to be marked dirty and released.
@@ -485,20 +535,65 @@ static inline void mm_set_has_pinned_flag(struct mm_struct *mm)
 /*
  * Output descriptor of the GUP page table walkers.
  *
- * GUP hands the memory it grabbed back to the caller as an array of pages
- * (@pages).
+ * GUP hands the memory it grabbed back to the caller either as an array of
+ * pages (@pages), or as an array of folio ranges (@frs), where each range
+ * describes consecutive pages of a single folio.  Exactly one of the two is
+ * set.
  *
- * @nr_pages is the number of pages recorded so far: the walkers simply keep
- * appending to the descriptor, no matter how often they are called for a
- * single GUP request.
+ * @nr_pages is the number of pages recorded so far and is maintained in both
+ * cases: the walkers simply keep appending to the descriptor, no matter how
+ * often they are called for a single GUP request.
  */
 struct gup_out {
 	struct page **pages;
+	struct folio_range *frs;
 	unsigned long nr_pages;
+	unsigned int nr_frs;
+	unsigned int max_frs;
 };
 
 #define GUP_OUT_PAGES(_pages)		((struct gup_out){ .pages = (_pages) })
 
+/*
+ * Whether no further folio range can be recorded.  The @pages array is sized
+ * by the caller to hold all requested pages, so it can never run full.
+ */
+static inline bool gup_out_is_full(struct gup_out *out)
+{
+	return out->frs && out->nr_frs == out->max_frs;
+}
+
+static inline bool gup_out_add_folio_range(struct gup_out *out,
+					   struct folio *folio,
+					   struct page *page,
+					   unsigned long nr_pages)
+{
+	unsigned long idx = folio_page_idx(folio, page);
+	struct folio_range *fr;
+
+	/*
+	 * Ranges are only ever grown by walkers that hold a reference on the
+	 * folio for each page they add, so merging with the previous range
+	 * keeps the reference count of that range consistent.
+	 */
+	if (out->nr_frs) {
+		fr = &out->frs[out->nr_frs - 1];
+		if (fr->folio == folio && fr->idx + fr->nr_pages == idx) {
+			fr->nr_pages += nr_pages;
+			return true;
+		}
+	}
+
+	if (out->nr_frs == out->max_frs)
+		return false;
+
+	fr = &out->frs[out->nr_frs++];
+	fr->folio = folio;
+	fr->idx = idx;
+	fr->nr_pages = nr_pages;
+	return true;
+}
+
 /**
  * gup_out_add_range() - record consecutive pages of a single folio
  * @out: the output descriptor
@@ -508,17 +603,27 @@ struct gup_out {
  *
  * The caller must hold a reference (FOLL_GET) or pin (FOLL_PIN) for each of
  * the @nr_pages pages.
+ *
+ * Return: %true if the pages were recorded.  %false if the folio range array
+ * is full, in which case the caller has to release the references it grabbed
+ * for these pages and stop the walk.
  */
-static inline void gup_out_add_range(struct gup_out *out, struct folio *folio,
+static inline bool gup_out_add_range(struct gup_out *out, struct folio *folio,
 			      struct page *page, unsigned long nr_pages)
 {
-	struct page **pages = out->pages + out->nr_pages;
-	unsigned long i;
+	if (out->frs) {
+		if (!gup_out_add_folio_range(out, folio, page, nr_pages))
+			return false;
+	} else {
+		struct page **pages = out->pages + out->nr_pages;
+		unsigned long i;
 
-	for (i = 0; i < nr_pages; i++)
-		pages[i] = page + i;
+		for (i = 0; i < nr_pages; i++)
+			pages[i] = page + i;
+	}
 
 	out->nr_pages += nr_pages;
+	return true;
 }
 
 #ifdef CONFIG_MMU
@@ -749,16 +854,26 @@ static inline bool gup_must_unshare(struct vm_area_struct *vma,
 	return gup_pages_not_requiring_unshare(vma, flags, folio, page, 1) != 1;
 }
 
-/* Record @nr pages starting at @page in @out, and flush their caches. */
-static void gup_fill_pages(struct vm_area_struct *vma, unsigned long address,
-		struct page *page, unsigned long nr, struct gup_out *out)
+/*
+ * Record @nr pages starting at @page, for which the caller holds references
+ * per @flags, in @out, and flush their caches.  If @out has no room for
+ * another folio range, the references are dropped and -ENOSPC is returned.
+ */
+static int gup_fill_pages(struct vm_area_struct *vma, unsigned long address,
+		struct page *page, unsigned long nr, unsigned int flags,
+		struct gup_out *out)
 {
+	struct folio *folio;
 	unsigned long i;
 
 	if (!out)
-		return;
+		return 0;
 
-	gup_out_add_range(out, page_folio(page), page, nr);
+	folio = page_folio(page);
+	if (!gup_out_add_range(out, folio, page, nr)) {
+		gup_put_folio(folio, nr, flags);
+		return -ENOSPC;
+	}
 
 	for (i = 0; i < nr; i++) {
 		struct page *subpage = page + i;
@@ -766,6 +881,8 @@ static void gup_fill_pages(struct vm_area_struct *vma, unsigned long address,
 		flush_anon_page(vma, subpage, address + i * PAGE_SIZE);
 		flush_dcache_page(subpage);
 	}
+
+	return 0;
 }
 
 /*
@@ -782,6 +899,28 @@ static void gup_flush_pages(struct vm_area_struct *vma, unsigned long address,
 	if (!out)
 		return;
 
+	if (out->frs) {
+		const struct folio_range *fr = &out->frs[out->nr_frs];
+
+		/*
+		 * The first pages may have been merged into a range that was
+		 * recorded earlier, so walk back from the end of the array.
+		 */
+		while (nr) {
+			unsigned long run = min((--fr)->nr_pages, nr);
+			struct page *page = folio_range_page(fr) +
+					    fr->nr_pages - run;
+
+			nr -= run;
+			for (i = 0; i < run; i++) {
+				flush_anon_page(vma, page + i,
+						address + (nr + i) * PAGE_SIZE);
+				flush_dcache_page(page + i);
+			}
+		}
+		return;
+	}
+
 	pages = out->pages + out->nr_pages - nr;
 	for (i = 0; i < nr; i++) {
 		flush_anon_page(vma, pages[i], address + i * PAGE_SIZE);
@@ -997,6 +1136,12 @@ static long gup_grab_folio_pages(struct folio *folio,
 			return ret;
 		}
 	}
+
+	if (out && !gup_out_add_range(out, folio, page, nr)) {
+		gup_put_folio(folio, nr, flags);
+		return -ENOSPC;
+	}
+
 	if (flags & FOLL_TOUCH) {
 		if ((flags & FOLL_WRITE) && !dirty && !folio_test_dirty(folio))
 			folio_mark_dirty(folio);
@@ -1008,9 +1153,6 @@ static long gup_grab_folio_pages(struct folio *folio,
 		folio_mark_accessed(folio);
 	}
 
-	if (out)
-		gup_out_add_range(out, folio, page, nr);
-
 	return 0;
 }
 
@@ -1212,8 +1354,12 @@ static long follow_pmd_mask(struct vm_area_struct *vma,
 	 * The ref is already held, so the page cannot go away: record the
 	 * pages and flush caches without the pmd lock.
 	 */
-	if (ret > 0)
-		gup_fill_pages(vma, address, page, ret, out);
+	if (ret > 0) {
+		int err = gup_fill_pages(vma, address, page, ret, flags, out);
+
+		if (err)
+			return err;
+	}
 
 	return ret;
 }
@@ -1242,8 +1388,13 @@ static long follow_pud_mask(struct vm_area_struct *vma,
 		 * can be up to HPAGE_PUD_NR pages, too long to flush under a
 		 * spinlock.
 		 */
-		if (ret > 0)
-			gup_fill_pages(vma, address, page, ret, out);
+		if (ret > 0) {
+			int err = gup_fill_pages(vma, address, page, ret,
+						 flags, out);
+
+			if (err)
+				return err;
+		}
 		if (ret)
 			return ret;
 		return no_page_table(vma, flags, address);
@@ -1289,9 +1440,9 @@ static long follow_p4d_mask(struct vm_area_struct *vma,
  *
  * Return: the number of contiguous pages starting at @address that were
  * recorded in @out (if non-NULL), which may be fewer than the pages
- * requested via @end; 0 if no mapping exists at @address; or a negative
- * errno for a mapping to something not represented by a page descriptor
- * (see also vm_normal_page()).
+ * requested via @end; 0 if no mapping exists at @address; -ENOSPC if @out
+ * has no room for another folio range; or a negative errno for a mapping to
+ * something not represented by a page descriptor (see also vm_normal_page()).
  */
 static long follow_page_mask(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end,
@@ -1686,7 +1837,12 @@ static long __get_user_pages(struct mm_struct *mm,
 						out ? &page : NULL);
 				if (ret)
 					goto out;
-				gup_fill_pages(vma, start, page, 1, out);
+				if (gup_fill_pages(vma, start, page, 1,
+						   gup_flags, out)) {
+					/* The folio range array is full. */
+					ret = 0;
+					goto out;
+				}
 				i++;
 				start += PAGE_SIZE;
 				nr_pages--;
@@ -1700,6 +1856,10 @@ static long __get_user_pages(struct mm_struct *mm,
 			ret = check_vma_flags(vma, gup_flags);
 			if (ret)
 				goto out;
+			if (out && out->frs && (vma->vm_flags & VM_MIXEDMAP)) {
+				ret = i ? 0 : -EOPNOTSUPP;
+				goto out;
+			}
 		}
 retry:
 		/*
@@ -1743,6 +1903,13 @@ static long __get_user_pages(struct mm_struct *mm,
 				goto out;
 			}
 			nr = 1;
+		} else if (nr == -ENOSPC && out && gup_out_is_full(out)) {
+			/*
+			 * The output can only run out of space when returning
+			 * folio ranges: stop and report what we got so far.
+			 */
+			ret = 0;
+			goto out;
 		} else if (nr < 0) {
 			ret = nr;
 			goto out;
@@ -2294,7 +2461,10 @@ static long __get_user_pages_locked_out(struct mm_struct *mm, unsigned long star
 				err = ret;
 				break;
 			}
-			gup_out_add_range(out, folio, page, 1);
+			if (!gup_out_add_range(out, folio, page, 1)) {
+				gup_put_folio(folio, 1, foll_flags);
+				break;
+			}
 		}
 
 		start = (start + PAGE_SIZE) & PAGE_MASK;
@@ -2739,8 +2909,8 @@ static long check_and_migrate_movable_folios(unsigned long nr_folios,
 #endif /* CONFIG_MIGRATION */
 
 /*
- * __gup_longterm_locked() is a wrapper for __get_user_pages_locked which
- * allows us to process the FOLL_LONGTERM flag.
+ * __gup_longterm_locked_out() is a wrapper for __get_user_pages_locked_out
+ * which allows us to process the FOLL_LONGTERM flag.
  */
 static long __gup_longterm_locked_out(struct mm_struct *mm,
 				  unsigned long start,
@@ -2749,7 +2919,7 @@ static long __gup_longterm_locked_out(struct mm_struct *mm,
 				  int *locked,
 				  unsigned int gup_flags)
 {
-	unsigned long nr_pages_done;
+	unsigned long nr_pages_done, nr_frs_done;
 	unsigned int flags;
 	long rc, nr_pinned_pages;
 
@@ -2757,7 +2927,12 @@ static long __gup_longterm_locked_out(struct mm_struct *mm,
 		return __get_user_pages_locked_out(mm, start, nr_pages, out,
 						   locked, gup_flags);
 
-	if (WARN_ON_ONCE(!out))
+	/*
+	 * check_and_migrate_movable_pages() cannot deal with folio ranges
+	 * yet, which is why pin_user_folio_ranges_fast() rejects
+	 * FOLL_LONGTERM.
+	 */
+	if (WARN_ON_ONCE(!out || out->frs))
 		return -EINVAL;
 
 	/*
@@ -2765,10 +2940,12 @@ static long __gup_longterm_locked_out(struct mm_struct *mm,
 	 * this call has to be discarded again.
 	 */
 	nr_pages_done = out->nr_pages;
+	nr_frs_done = out->nr_frs;
 
 	flags = memalloc_pin_save();
 	do {
 		out->nr_pages = nr_pages_done;
+		out->nr_frs = nr_frs_done;
 
 		nr_pinned_pages = __get_user_pages_locked_out(mm, start,
 							      nr_pages, out,
@@ -2809,8 +2986,8 @@ static long __gup_longterm_locked(struct mm_struct *mm,
  * Check that the given flags are valid for the exported gup/pup interface, and
  * update them with the required flags that the caller must have set.
  */
-static bool is_valid_gup_args(struct page **pages, int *locked,
-			      unsigned int *gup_flags_p, unsigned int to_set)
+static __always_inline bool __is_valid_gup_args(bool has_output, int *locked,
+				unsigned int *gup_flags_p, unsigned int to_set)
 {
 	unsigned int gup_flags = *gup_flags_p;
 
@@ -2842,8 +3019,8 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
 	if (WARN_ON_ONCE(!(gup_flags & FOLL_PIN) && (gup_flags & FOLL_LONGTERM)))
 		return false;
 
-	/* Pages input must be given if using GET/PIN */
-	if (WARN_ON_ONCE((gup_flags & (FOLL_GET | FOLL_PIN)) && !pages))
+	/* An output array must be given if using GET/PIN */
+	if (WARN_ON_ONCE((gup_flags & (FOLL_GET | FOLL_PIN)) && !has_output))
 		return false;
 
 	/* We want to allow the pgmap to be hot-unplugged at all times */
@@ -2855,6 +3032,12 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
 	return true;
 }
 
+static bool is_valid_gup_args(struct page **pages, int *locked,
+			      unsigned int *gup_flags_p, unsigned int to_set)
+{
+	return __is_valid_gup_args(pages != NULL, locked, gup_flags_p, to_set);
+}
+
 #ifdef CONFIG_MMU
 /**
  * get_user_pages_remote() - pin user pages in memory
@@ -3048,7 +3231,15 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
  * in the fast path, so instead we whitelist known good cases and if in doubt,
  * fall back to the slow path.
  */
-static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
+/*
+ * @folio_ranges is set when the caller requests folio-range output. The NULL
+ * mapping check is conservative and defers to slow path which gets checked
+ * against the VMA information. A page without any mapping might not be a
+ * folio at all (e.g. a bare page a driver installed via vm_insert_page()), so
+ * such pages are left to the slow path, which can consult the vma.
+ */
+static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags,
+				   bool folio_ranges)
 {
 	bool reject_file_backed = false;
 	struct address_space *mapping;
@@ -3069,7 +3260,7 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
 	if (IS_ENABLED(CONFIG_SECRETMEM) && !folio_test_large(folio))
 		check_secretmem = true;
 
-	if (!reject_file_backed && !check_secretmem)
+	if (!reject_file_backed && !check_secretmem && !folio_ranges)
 		return true;
 
 	if (WARN_ON_ONCE(folio_test_slab(folio)))
@@ -3104,10 +3295,10 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
 	 * Otherwise, a NULL mapping proves this is not a secretmem folio
 	 * (secretmem folios always have a valid mapping to the secretmem
 	 * inode's address_space), so in that case, we can continue with the
-	 * fast path.
+	 * fast path, unless the caller needs it to be a folio.
 	 */
 	if (!mapping)
-		return !reject_file_backed;
+		return !reject_file_backed && !folio_ranges;
 
 	/* Anonymous folios pose no problem. */
 	mapping_flags = (unsigned long)mapping & FOLIO_MAPPING_FLAGS;
@@ -3181,6 +3372,21 @@ static unsigned long gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp,
 		VM_WARN_ON_ONCE(!pfn_valid(pte_pfn(pte)));
 		page = pte_page(pte);
 
+		if (gup_out_is_full(out)) {
+			struct folio_range *last;
+			unsigned long next_idx;
+
+			if (!out->nr_frs)
+				goto out;
+
+			last = &out->frs[out->nr_frs - 1];
+			next_idx = (unsigned long)last->idx + last->nr_pages;
+
+			if (next_idx >= folio_nr_pages(last->folio) ||
+			    page != folio_page(last->folio, next_idx))
+				goto out;
+		}
+
 		folio = try_grab_folio_fast(page, 1, flags);
 		if (!folio)
 			goto out;
@@ -3197,7 +3403,7 @@ static unsigned long gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp,
 		    unlikely(pte_val(pte) != pte_val(ptep_get_lockless(ptep))))
 			goto out;
 
-		if (!gup_fast_folio_allowed(folio, flags))
+		if (!gup_fast_folio_allowed(folio, flags, out->frs))
 			goto out;
 
 		if (folio_test_large(folio))
@@ -3228,7 +3434,13 @@ static unsigned long gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp,
 			nr_batch = 1;
 
 		folio_set_referenced(folio);
-		gup_out_add_range(out, folio, page, nr_batch);
+
+		/* Only fails if the caller's output array is full. */
+		if (!gup_out_add_range(out, folio, page, nr_batch)) {
+			gup_put_folio(folio, nr_batch, flags);
+			folio = NULL;
+			goto out;
+		}
 		nr_pages += nr_batch;
 		folio = NULL;
 	} while (ptep += nr_batch, addr += nr_batch * PAGE_SIZE, addr != end);
@@ -3289,7 +3501,7 @@ static unsigned long gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp,
 		return 0;
 	}
 
-	if (!gup_fast_folio_allowed(folio, flags)) {
+	if (!gup_fast_folio_allowed(folio, flags, out->frs)) {
 		gup_put_folio(folio, nr_pages, flags);
 		return 0;
 	}
@@ -3299,7 +3511,11 @@ static unsigned long gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp,
 		return 0;
 	}
 
-	gup_out_add_range(out, folio, page, nr_pages);
+	if (!gup_out_add_range(out, folio, page, nr_pages)) {
+		gup_put_folio(folio, nr_pages, flags);
+		return 0;
+	}
+
 	folio_set_referenced(folio);
 	return nr_pages;
 }
@@ -3331,7 +3547,7 @@ static unsigned long gup_fast_pud_leaf(pud_t orig, pud_t *pudp,
 		return 0;
 	}
 
-	if (!gup_fast_folio_allowed(folio, flags)) {
+	if (!gup_fast_folio_allowed(folio, flags, out->frs)) {
 		gup_put_folio(folio, nr_pages, flags);
 		return 0;
 	}
@@ -3342,7 +3558,11 @@ static unsigned long gup_fast_pud_leaf(pud_t orig, pud_t *pudp,
 		return 0;
 	}
 
-	gup_out_add_range(out, folio, page, nr_pages);
+	if (!gup_out_add_range(out, folio, page, nr_pages)) {
+		gup_put_folio(folio, nr_pages, flags);
+		return 0;
+	}
+
 	folio_set_referenced(folio);
 	return nr_pages;
 }
@@ -3486,10 +3706,27 @@ static bool gup_fast_permitted(unsigned long start, unsigned long end)
  */
 static void gup_fast_unpin(struct gup_out *out)
 {
-	gup_fast_unpin_user_pages(out->pages, out->nr_pages);
+	if (out->frs) {
+		unsigned int i;
+
+		for (i = 0; i < out->nr_frs; i++)
+			gup_put_folio(out->frs[i].folio, out->frs[i].nr_pages,
+				      FOLL_PIN);
+		out->nr_frs = 0;
+	} else {
+		gup_fast_unpin_user_pages(out->pages, out->nr_pages);
+	}
 	out->nr_pages = 0;
 }
 
+static void gup_fast_sanity_check(struct gup_out *out)
+{
+	if (out->frs)
+		sanity_check_pinned_folio_ranges(out->frs, out->nr_frs);
+	else
+		sanity_check_pinned_pages(out->pages, out->nr_pages);
+}
+
 static unsigned long gup_fast(unsigned long start, unsigned long end,
 		unsigned int gup_flags, struct gup_out *out)
 {
@@ -3531,7 +3768,7 @@ static unsigned long gup_fast(unsigned long start, unsigned long end,
 			gup_fast_unpin(out);
 			return 0;
 		} else {
-			sanity_check_pinned_pages(out->pages, out->nr_pages);
+			gup_fast_sanity_check(out);
 		}
 	}
 	return out->nr_pages;
@@ -3558,8 +3795,8 @@ static long gup_fast_fallback_out(unsigned long start, unsigned long nr_pages,
 		might_lock_read(&current->mm->mmap_lock);
 
 	start = untagged_addr(start) & PAGE_MASK;
-	len = nr_pages << PAGE_SHIFT;
-	if (check_add_overflow(start, len, &end))
+	if (check_shl_overflow(nr_pages, PAGE_SHIFT, &len) ||
+		check_add_overflow(start, len, &end))
 		return -EOVERFLOW;
 	if (end > TASK_SIZE_MAX)
 		return -EFAULT;
@@ -3568,6 +3805,10 @@ static long gup_fast_fallback_out(unsigned long start, unsigned long nr_pages,
 	if (nr_pinned == nr_pages || gup_flags & FOLL_FAST_ONLY)
 		return nr_pinned;
 
+	/* No room left to report anything the slow path could get us. */
+	if (gup_out_is_full(out))
+		return nr_pinned;
+
 	/* Slow path: try to get the remaining pages with get_user_pages */
 	start += nr_pinned << PAGE_SHIFT;
 	ret = __gup_longterm_locked_out(current->mm, start,
@@ -3688,6 +3929,80 @@ int pin_user_pages_fast(unsigned long start, int nr_pages,
 }
 EXPORT_SYMBOL_GPL(pin_user_pages_fast);
 
+/**
+ * pin_user_folio_ranges_fast() - pin user pages in memory without taking
+ *                                locks, reporting them as folio ranges
+ *
+ * @start:      starting user address
+ * @nr_pages:   number of pages from start to pin
+ * @gup_flags:  flags modifying pin behaviour
+ * @frs:        array that receives the pinned folio ranges
+ * @max_frs:    number of entries in the @frs array
+ * @nr_frs:     receives the number of folio ranges filled into @frs
+ *
+ * Like pin_user_pages_fast(), but instead of reporting each page separately,
+ * consecutive pages of the same folio are reported as a single folio range.
+ * A range never spans more than one folio, so a caller that has to fall back
+ * to per-page processing can always do so via folio_range_page().
+ *
+ * Pinning stops early once @max_frs ranges have been filled, so that the
+ * number of pages pinned can be smaller than @nr_pages even though more pages
+ * are present. Callers that cannot deal with short pins should size @frs to
+ * hold @nr_pages ranges, which is the worst case.
+ *
+ * FOLL_LONGTERM is not supported yet.
+ *
+ * The pins have to be released with unpin_user_folio_ranges(), or per range
+ * with unpin_user_folio(fr->folio, fr->nr_pages).
+ *
+ * Note that if the zero page is amongst the returned ranges, it will not have
+ * pins in it and unpinning will not remove pins from it.
+ *
+ * Memory that is not necessarily backed by folios, such as pages a driver
+ * inserted into a VM_MIXEDMAP vma, cannot be reported as folio ranges: pinning
+ * stops in front of it and -EOPNOTSUPP is returned if it comes first.  Callers
+ * have to fall back to pin_user_pages_fast() for it.
+ *
+ * Return: number of pages pinned, which can be less than @nr_pages. For a zero
+ * page request, returns 0 and sets @nr_frs to 0. If @nr_pages is non-zero and
+ * no pages were pinned, a negative errno is returned. @nr_frs is only valid if
+ * the return value is positive.
+ */
+long pin_user_folio_ranges_fast(unsigned long start, unsigned long nr_pages,
+				unsigned int gup_flags, struct folio_range *frs,
+				unsigned int max_frs, unsigned int *nr_frs)
+{
+	struct gup_out out = {
+		.frs = frs,
+		.max_frs = max_frs,
+	};
+	long ret;
+
+	if (WARN_ON_ONCE(!frs || !max_frs))
+		return -EINVAL;
+
+	/*
+	 * Migrating away from unpinnable memory in the FOLL_LONGTERM case
+	 * still requires an array of pages or folios; until that is sorted
+	 * out, don't pretend we can handle it.
+	 */
+	if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
+		return -EINVAL;
+
+	if (!nr_pages) {
+		*nr_frs = 0;
+		return 0;
+	}
+
+	if (!__is_valid_gup_args(true, NULL, &gup_flags, FOLL_PIN))
+		return -EINVAL;
+
+	ret = gup_fast_fallback_out(start, nr_pages, gup_flags, &out);
+	*nr_frs = out.nr_frs;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pin_user_folio_ranges_fast);
+
 /**
  * pin_user_pages_remote() - pin pages of a remote process
  *
-- 
2.53.0

