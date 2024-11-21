Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AE51ABEB0
	for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 22:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732227999; cv=none; b=BAjVMVZMqSkJRS714rOyuR18EFDaGWQwuMwPutFancgEfeGODsGh5x1ho5lmpCdoZsJhCVlNwOcuFV+FrmicOM6TG4vGTtjf+E6u6QJzd1h/2xBSoYjYqAnBDG4rY23mfThM6zIHZdFoOTW+sWVwGQ2dV45vAiEusXVUAGwcGJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732227999; c=relaxed/simple;
	bh=E2LdAEWxZEQPoTCg5UwJe0V4hxYf0LhZnWfqs1pvwOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F8wwSHF38GXPC7DF0fKf+0PAF6ac39YojOtonDt7fb8DbvarR87rp+HqkGI+H/eRfOL1rodMdWdBMjuPE1jU4bsic+QM4hb9oM1xyKrZW6PcMqqPnV1LXlZ0VlZ/Qt9mXH8AE7FRNhfJ/O0JpUd9GAyq65QH/KloSC88oNpdzro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZA8/awG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZA8/awG"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2128383b86eso14641415ad.2
        for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 14:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732227997; x=1732832797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZAV40eLukdAUm3AIOVig1F6aMrQYsyjN2fkwd6I2Qs=;
        b=ZZA8/awGzqG/HEXWV6kn0geRJcPaA5n7UHVUg2b+VfK0MssxL+fnWdDf4+yUOrxFJQ
         U4pgMbv2DSexq8zSdpkL6EsTl0mWPROnyA21sXNbgalFzR7+I//kcNm+9a/WS5g8Tk3f
         YzaH3hF9kLpmkjMnGzgu76tOzUKTb70tnxMuA/hPzJKuKeSU0eNLpucEjdlxKBeHWdhT
         fRYdZT4xLv9Pl9WadZFopqkGW8pqtRD2CbnMMKAA1uehRFBXD7a9CbO2DPrAnUnLXpau
         6zTciC43lopnxp4+2jpr+i1/3wKNXaGoqN9B2zy0mnTKfu5gnhKmHNCqBjVkWTL2IFpl
         czLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732227997; x=1732832797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZAV40eLukdAUm3AIOVig1F6aMrQYsyjN2fkwd6I2Qs=;
        b=bbR41KLLOIRsbro5gvl8EoIvGSsHQJbkkZ7Csv21vh3LL4nQJxt+Dh1u3YDyxqev30
         lL1R4R7paUvlxbINurWRuyd1BD5Rtfi3nsWz0O0mExL3lzUUOR/CuzlcWx6Y/ejYfT5z
         S6/GwNbySW2aah3HOCWQWzexx+87VNHIr97DUIN2BABYjfFRAv4lhr0ghNtNJWeb6xTW
         xxCzcqYRuKhSxPikGi64AzYeb8FzmD51dUR9vWD70DOS6BtN/Jc3ULc30iaL2oLFRYBA
         XxgL9gkcSbdzuMjrVaigxUqfxSdC0IWiQ2oAUfrjmXAvaB4CbfzinEgMJ7OXb5VtUSXj
         iLqA==
X-Forwarded-Encrypted: i=1; AJvYcCVY/IGM9VNB/ljN5q83sKRD1S97nwUlGaQeyp2kTDWZqMBKSWS8Zmq6nC3MhyY5yllJ7DgH72iSSx9jyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ9GV+ZRsHE46tGEqbhNAXs6VZF8/7wA3ImxVAn5kH6lhD5W9N
	Oy1m1cU8IIgXmqTAcahYtbC4Gy/RbUWdSXtvvJ77dQdPaaNaVH0C
X-Gm-Gg: ASbGncvStpNzsIu8et1Wn44WHtEqke9KvQzsHVOV7GmOxpJvVmuXCYP9k5MXWFrbG1A
	ujsvu6TmYN2zsbQn3bn7p0vR2zzs7LKgPs+z74m+B9BjClP4ZpmSExLkSXmT7z4uik1F4BmxqJ+
	Z18HDZaDxBXy5RIrOrScAbPAW/d9JJU8BOQgDYijw9cJHRlHSVZ07Hn48Yl4mm+tRa8rHjzXIyW
	GKMr0s1fjmF+ntb9ukmQpA51JON3k8px/R/xyeV+Vn6fNZoBDppnoVpdZ+oLYxndhNlTfhU
X-Google-Smtp-Source: AGHT+IFk8IcOaVtDODSKrSa6m+UG9KLonALKh/GnCgbMtgcUZBCu3HpUQkp54L4Z2yATbp/3yYDCjw==
X-Received: by 2002:a17:903:244b:b0:211:f6e4:d68e with SMTP id d9443c01a7336-2129fce2e23mr6801055ad.10.1732227996748;
        Thu, 21 Nov 2024 14:26:36 -0800 (PST)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:9d64:b0ba:faf2:680e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba22f4sm3334745ad.100.2024.11.21.14.26.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 21 Nov 2024 14:26:36 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: axboe@kernel.dk,
	bala.seshasayee@linux.intel.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	kanchana.p.sridhar@intel.com,
	kasong@tencent.com,
	linux-block@vger.kernel.org,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	senozhatsky@chromium.org,
	surenb@google.com,
	terrelln@fb.com,
	usamaarif642@gmail.com,
	v-songbaohua@oppo.com,
	wajdi.k.feghali@intel.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	zhengtangquan@oppo.com,
	zhouchengming@bytedance.com,
	Chuanhua Han <chuanhuahan@gmail.com>
Subject: [PATCH RFC v3 4/4] mm: fall back to four small folios if mTHP allocation fails
Date: Fri, 22 Nov 2024 11:25:21 +1300
Message-Id: <20241121222521.83458-5-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241121222521.83458-1-21cnbao@gmail.com>
References: <20241121222521.83458-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The swapfile can compress/decompress at 4 * PAGES granularity, reducing
CPU usage and improving the compression ratio. However, if allocating an
mTHP fails and we fall back to a single small folio, the entire large
block must still be decompressed. This results in a 16 KiB area requiring
4 page faults, where each fault decompresses 16 KiB but retrieves only
4 KiB of data from the block. To address this inefficiency, we instead
fall back to 4 small folios, ensuring that each decompression occurs
only once.

Allowing swap_read_folio() to decompress and read into an array of
4 folios would be extremely complex, requiring extensive changes
throughout the stack, including swap_read_folio, zeromap,
zswap, and final swap implementations like zRAM. In contrast,
having these components fill a large folio with 4 subpages is much
simpler.

To avoid a full-stack modification, we introduce a per-CPU order-2
large folio as a buffer. This buffer is used for swap_read_folio(),
after which the data is copied into the 4 small folios. Finally, in
do_swap_page(), all these small folios are mapped.

Co-developed-by: Chuanhua Han <chuanhuahan@gmail.com>
Signed-off-by: Chuanhua Han <chuanhuahan@gmail.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 203 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 192 insertions(+), 11 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 209885a4134f..e551570c1425 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4042,6 +4042,15 @@ static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
 	return folio;
 }
 
+#define BATCH_SWPIN_ORDER 2
+#define BATCH_SWPIN_COUNT (1 << BATCH_SWPIN_ORDER)
+#define BATCH_SWPIN_SIZE (PAGE_SIZE << BATCH_SWPIN_ORDER)
+
+struct batch_swpin_buffer {
+	struct folio *folio;
+	struct mutex mutex;
+};
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
 {
@@ -4120,7 +4129,101 @@ static inline unsigned long thp_swap_suitable_orders(pgoff_t swp_offset,
 	return orders;
 }
 
-static struct folio *alloc_swap_folio(struct vm_fault *vmf)
+static DEFINE_PER_CPU(struct batch_swpin_buffer, swp_buf);
+
+static int __init batch_swpin_buffer_init(void)
+{
+	int ret, cpu;
+	struct batch_swpin_buffer *buf;
+
+	for_each_possible_cpu(cpu) {
+		buf = per_cpu_ptr(&swp_buf, cpu);
+		buf->folio = (struct folio *)alloc_pages_node(cpu_to_node(cpu),
+				GFP_KERNEL | __GFP_COMP, BATCH_SWPIN_ORDER);
+		if (!buf->folio) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		mutex_init(&buf->mutex);
+	}
+	return 0;
+
+err:
+	for_each_possible_cpu(cpu) {
+		buf = per_cpu_ptr(&swp_buf, cpu);
+		if (buf->folio) {
+			folio_put(buf->folio);
+			buf->folio = NULL;
+		}
+	}
+	return ret;
+}
+core_initcall(batch_swpin_buffer_init);
+
+static struct folio *alloc_batched_swap_folios(struct vm_fault *vmf,
+		struct batch_swpin_buffer **buf, struct folio **folios,
+		swp_entry_t entry)
+{
+	unsigned long haddr = ALIGN_DOWN(vmf->address, BATCH_SWPIN_SIZE);
+	struct batch_swpin_buffer *sbuf = raw_cpu_ptr(&swp_buf);
+	struct folio *folio = sbuf->folio;
+	unsigned long addr;
+	int i;
+
+	if (unlikely(!folio))
+		return NULL;
+
+	for (i = 0; i < BATCH_SWPIN_COUNT; i++) {
+		addr = haddr + i * PAGE_SIZE;
+		folios[i] = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vmf->vma, addr);
+		if (!folios[i])
+			goto err;
+		if (mem_cgroup_swapin_charge_folio(folios[i], vmf->vma->vm_mm,
+					GFP_KERNEL, entry))
+			goto err;
+	}
+
+	mutex_lock(&sbuf->mutex);
+	*buf = sbuf;
+#ifdef CONFIG_MEMCG
+	folio->memcg_data = (*folios)->memcg_data;
+#endif
+	return folio;
+
+err:
+	for (i--; i >= 0; i--)
+		folio_put(folios[i]);
+	return NULL;
+}
+
+static void fill_batched_swap_folios(struct vm_fault *vmf,
+		void *shadow, struct batch_swpin_buffer *buf,
+		struct folio *folio, struct folio **folios)
+{
+	unsigned long haddr = ALIGN_DOWN(vmf->address, BATCH_SWPIN_SIZE);
+	unsigned long addr;
+	int i;
+
+	for (i = 0; i < BATCH_SWPIN_COUNT; i++) {
+		addr = haddr + i * PAGE_SIZE;
+		__folio_set_locked(folios[i]);
+		__folio_set_swapbacked(folios[i]);
+		if (shadow)
+			workingset_refault(folios[i], shadow);
+		folio_add_lru(folios[i]);
+		copy_user_highpage(&folios[i]->page, folio_page(folio, i),
+				addr, vmf->vma);
+		if (folio_test_uptodate(folio))
+			folio_mark_uptodate(folios[i]);
+	}
+
+	folio->flags &= ~(PAGE_FLAGS_CHECK_AT_PREP & ~(1UL << PG_head));
+	mutex_unlock(&buf->mutex);
+}
+
+static struct folio *alloc_swap_folio(struct vm_fault *vmf,
+		struct batch_swpin_buffer **buf,
+		struct folio **folios)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long orders;
@@ -4180,6 +4283,9 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 
 	pte_unmap_unlock(pte, ptl);
 
+	if (!orders)
+		goto fallback;
+
 	/* Try allocating the highest of the remaining orders. */
 	gfp = vma_thp_gfp_mask(vma);
 	while (orders) {
@@ -4194,14 +4300,29 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 		order = next_order(&orders, order);
 	}
 
+	/*
+	 * During swap-out, a THP might have been compressed into multiple
+	 * order-2 blocks to optimize CPU usage and compression ratio.
+	 * Attempt to batch swap-in 4 smaller folios to ensure they are
+	 * decompressed together as a single unit only once.
+	 */
+	return alloc_batched_swap_folios(vmf, buf, folios, entry);
+
 fallback:
 	return __alloc_swap_folio(vmf);
 }
 #else /* !CONFIG_TRANSPARENT_HUGEPAGE */
-static struct folio *alloc_swap_folio(struct vm_fault *vmf)
+static struct folio *alloc_swap_folio(struct vm_fault *vmf,
+		struct batch_swpin_buffer **buf,
+		struct folio **folios)
 {
 	return __alloc_swap_folio(vmf);
 }
+static inline void fill_batched_swap_folios(struct vm_fault *vmf,
+		void *shadow, struct batch_swpin_buffer *buf,
+		struct folio *folio, struct folio **folios)
+{
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static DECLARE_WAIT_QUEUE_HEAD(swapcache_wq);
@@ -4216,6 +4337,8 @@ static DECLARE_WAIT_QUEUE_HEAD(swapcache_wq);
  */
 vm_fault_t do_swap_page(struct vm_fault *vmf)
 {
+	struct folio *folios[BATCH_SWPIN_COUNT] = { NULL };
+	struct batch_swpin_buffer *buf = NULL;
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *swapcache, *folio = NULL;
 	DECLARE_WAITQUEUE(wait, current);
@@ -4228,7 +4351,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	pte_t pte;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
-	int nr_pages;
+	int nr_pages, i;
 	unsigned long page_idx;
 	unsigned long address;
 	pte_t *ptep;
@@ -4296,7 +4419,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
 			/* skip swapcache */
-			folio = alloc_swap_folio(vmf);
+			folio = alloc_swap_folio(vmf, &buf, folios);
 			if (folio) {
 				__folio_set_locked(folio);
 				__folio_set_swapbacked(folio);
@@ -4327,10 +4450,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				mem_cgroup_swapin_uncharge_swap(entry, nr_pages);
 
 				shadow = get_shadow_from_swap_cache(entry);
-				if (shadow)
+				if (shadow && !buf)
 					workingset_refault(folio, shadow);
-
-				folio_add_lru(folio);
+				if (!buf)
+					folio_add_lru(folio);
 
 				/* To provide entry to swap_read_folio() */
 				folio->swap = entry;
@@ -4361,6 +4484,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		count_vm_event(PGMAJFAULT);
 		count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
 		page = folio_file_page(folio, swp_offset(entry));
+		/*
+		 * Copy data into batched small folios from the large
+		 * folio buffer
+		 */
+		if (buf) {
+			fill_batched_swap_folios(vmf, shadow, buf, folio, folios);
+			folio = folios[0];
+			page = &folios[0]->page;
+			goto do_map;
+		}
 	} else if (PageHWPoison(page)) {
 		/*
 		 * hwpoisoned dirty swapcache pages are kept for killing
@@ -4415,6 +4548,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			lru_add_drain();
 	}
 
+do_map:
 	folio_throttle_swaprate(folio, GFP_KERNEL);
 
 	/*
@@ -4431,8 +4565,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	/* allocated large folios for SWP_SYNCHRONOUS_IO */
-	if (folio_test_large(folio) && !folio_test_swapcache(folio)) {
-		unsigned long nr = folio_nr_pages(folio);
+	if ((folio_test_large(folio) || buf) && !folio_test_swapcache(folio)) {
+		unsigned long nr = buf ? BATCH_SWPIN_COUNT : folio_nr_pages(folio);
 		unsigned long folio_start = ALIGN_DOWN(vmf->address, nr * PAGE_SIZE);
 		unsigned long idx = (vmf->address - folio_start) / PAGE_SIZE;
 		pte_t *folio_ptep = vmf->pte - idx;
@@ -4527,6 +4661,42 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		}
 	}
 
+	/* Batched mapping of allocated small folios for SWP_SYNCHRONOUS_IO */
+	if (buf) {
+		for (i = 0; i < nr_pages; i++)
+			arch_swap_restore(swp_entry(swp_type(entry),
+				swp_offset(entry) + i), folios[i]);
+		swap_free_nr(entry, nr_pages);
+		add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
+		add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
+		rmap_flags |= RMAP_EXCLUSIVE;
+		for (i = 0; i < nr_pages; i++) {
+			unsigned long addr = address + i * PAGE_SIZE;
+
+			pte = mk_pte(&folios[i]->page, vma->vm_page_prot);
+			if (pte_swp_soft_dirty(vmf->orig_pte))
+				pte = pte_mksoft_dirty(pte);
+			if (pte_swp_uffd_wp(vmf->orig_pte))
+				pte = pte_mkuffd_wp(pte);
+			if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
+			    !pte_needs_soft_dirty_wp(vma, pte)) {
+				pte = pte_mkwrite(pte, vma);
+				if ((vmf->flags & FAULT_FLAG_WRITE) && (i == page_idx)) {
+					pte = pte_mkdirty(pte);
+					vmf->flags &= ~FAULT_FLAG_WRITE;
+				}
+			}
+			flush_icache_page(vma, &folios[i]->page);
+			folio_add_new_anon_rmap(folios[i], vma, addr, rmap_flags);
+			set_pte_at(vma->vm_mm, addr, ptep + i, pte);
+			arch_do_swap_page_nr(vma->vm_mm, vma, addr, pte, pte, 1);
+			if (i == page_idx)
+				vmf->orig_pte = pte;
+			folio_unlock(folios[i]);
+		}
+		goto wp_page;
+	}
+
 	/*
 	 * Some architectures may have to restore extra metadata to the page
 	 * when reading from swap. This metadata may be indexed by swap entry
@@ -4612,6 +4782,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_put(swapcache);
 	}
 
+wp_page:
 	if (vmf->flags & FAULT_FLAG_WRITE) {
 		ret |= do_wp_page(vmf);
 		if (ret & VM_FAULT_ERROR)
@@ -4638,9 +4809,19 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 out_page:
-	folio_unlock(folio);
+	if (!buf) {
+		folio_unlock(folio);
+	} else {
+		for (i = 0; i < BATCH_SWPIN_COUNT; i++)
+			folio_unlock(folios[i]);
+	}
 out_release:
-	folio_put(folio);
+	if (!buf) {
+		folio_put(folio);
+	} else {
+		for (i = 0; i < BATCH_SWPIN_COUNT; i++)
+			folio_put(folios[i]);
+	}
 	if (folio != swapcache && swapcache) {
 		folio_unlock(swapcache);
 		folio_put(swapcache);
-- 
2.39.3 (Apple Git-146)

