Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EDF135A4B
	for <linux-block@vger.kernel.org>; Fri, 22 Nov 2024 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287265; cv=none; b=QSJJ6EpOLgp/UV/gi/z0uz7Own0MgzkmmICEHhi5gx+0K3bYih350adz+kyGdjDu/6Ck6vMyIJRheN7/HeaqgbxLFwNdp6MHddGsoK12fuxxHlHkleYuU3E4sO4MLAnAZg0x2GpZm+wc4lJ3rNeghbvNxAlVA/cVA3+sbWZZSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287265; c=relaxed/simple;
	bh=dghd1+EAo3lMCefxi6G4QV0G2q5yBa9CzdCqP2k2QI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oP9uV7nOWDYccdipkCm0BrrTCAFbsFCEeFkOy5gqfHwH+QeesU/F3eE8nKZIduTBiWCzPD0NhpuZIFyjhH88s9hzWlvA5POQiktxuUbHHQKCcOWda0pPBPL/WuNR5MoT4negBq1RSu9aqQmw49I2utt5h+7v0zY14k1J+pQOHeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4Zhbbpy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4Zhbbpy"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so19279055e9.3
        for <linux-block@vger.kernel.org>; Fri, 22 Nov 2024 06:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732287261; x=1732892061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zDoPEU+qy2y3UY0TCD/yLS6jfZH/qpzapxYmLFAnUqs=;
        b=Q4Zhbbpypl19b0ShgymGIcaC9eSVyxi87bEaaHlWVxlg6ss1FQ+/7y3ovCQHtdzL10
         ny2Oq3VvqjzNBxr7AnLmInZhqe7nAWJxBatEzyfiY1i4bHEw1eb5NwPuYwiQ+FcGMmk6
         KKLJoofysN9EZH/FvK143uMIVNEP9EDszKxsBcsLvrBQyokO9MjOjDQHreW0m6MABe/T
         FUiPkT+8ddthaTuRL9FwaTfmCCua9HbJA/+YbNK3NEgJESxuwB3UrP4MLN9v+BTNqo/Q
         67DVOvbdj1KR9fuUO/i9d5tnM6vbaOnb5IkoF0WXu5hOaspQgCIa2gVK28jkvwFZWnrN
         IitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732287261; x=1732892061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDoPEU+qy2y3UY0TCD/yLS6jfZH/qpzapxYmLFAnUqs=;
        b=V3hmlWbk+ytGKO4VFb2VBzm/HylOZoeYHWl3MdGUDctXOsVgQEpSEcEykwjHfqErCx
         FM4Cn1vTdOZ0Lgu751MWkFAkMaqHPU/oRx40kz+yimwitandNWvFBh6FuoMII7JL39SY
         KBG1SHr3soYFTsqINwkzEefdfj+IbFDybCo0qCXl0ZnRtWsuDQOvfFfyW/HG4g9MQ98Y
         WveKgUQ6hiiFPXNzBz+E3Ij2MRlhHz6jxSfb7l8cjIbVxvJ/pt0bvm0YXYHzXyedbOUh
         oP5FmRNdURaQdqQH7hrP+i1t5y5foGfad1JHlzqY8w+u7wHXWhiFw58zD1CIRGtE/F71
         cO/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrGq3x8S46Fi/5vJVS5IlyEoSDz8GqkVw3xQ63/PZtPXSpOIGw46EV/0rMVK4Ldr6yqybIQXXAIpE3nA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiA92ZAEkRSCNrH2RUXgWbMxGohM7hoqzPp789weSyvzoxUXRr
	HF2viqD1HYetFd8wBguzOZubxiJUnrgAuUGfvSsXKrOKnfCC9mht
X-Gm-Gg: ASbGncsDyplbok4OJ0rLKqcRHTzSTbfiIunsq4PHJp//g5nhYxKOmHDH5m58I21GhR+
	+rB41C6Og1w/vT9o9yvWJjR6damOxh9OzCeOIi3ZoRRgh9PHC5z0ldWum4cJaPUdJVTXAoenEuB
	kDm6sEHdSCtCJb15lR38LwoG5FqzKF4EMO6EgmeMNzklXUMz22PjMwzifC8/xQyvq9FNF+UchMj
	sPmp8dfPYxvh4ipZxVngX+izLnxhkjKKMrlNrc3bCHpDBOL83+zGoqjzSyPpsP+sd/gHQ8j1Hp8
	gy4478B1WUxVeloyciDHF2HdIR5Z1v6oxgo6y6Gyj5yhGw==
X-Google-Smtp-Source: AGHT+IH+hj4eCK55DLFCsNGc0lVRgg+A1zeMhZw+NXc/fkGzJ8BIvPBk+3PGPj11qSGinQDMo+DaDA==
X-Received: by 2002:a5d:64ec:0:b0:382:4a7a:403e with SMTP id ffacd0b85a97d-38260b4fb58mr2552758f8f.3.1732287260747;
        Fri, 22 Nov 2024 06:54:20 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d751:7400:1074:6f5b:b3c2:6795? ([2a02:6b67:d751:7400:1074:6f5b:b3c2:6795])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b463ab44sm96597825e9.30.2024.11.22.06.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 06:54:20 -0800 (PST)
Message-ID: <24f7d8a0-ab92-4544-91dd-5241062aad23@gmail.com>
Date: Fri, 22 Nov 2024 14:54:19 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 4/4] mm: fall back to four small folios if mTHP
 allocation fails
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: axboe@kernel.dk, bala.seshasayee@linux.intel.com, chrisl@kernel.org,
 david@redhat.com, hannes@cmpxchg.org, kanchana.p.sridhar@intel.com,
 kasong@tencent.com, linux-block@vger.kernel.org, minchan@kernel.org,
 nphamcs@gmail.com, ryan.roberts@arm.com, senozhatsky@chromium.org,
 surenb@google.com, terrelln@fb.com, v-songbaohua@oppo.com,
 wajdi.k.feghali@intel.com, willy@infradead.org, ying.huang@intel.com,
 yosryahmed@google.com, yuzhao@google.com, zhengtangquan@oppo.com,
 zhouchengming@bytedance.com, Chuanhua Han <chuanhuahan@gmail.com>
References: <20241121222521.83458-1-21cnbao@gmail.com>
 <20241121222521.83458-5-21cnbao@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20241121222521.83458-5-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/11/2024 22:25, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> The swapfile can compress/decompress at 4 * PAGES granularity, reducing
> CPU usage and improving the compression ratio. However, if allocating an
> mTHP fails and we fall back to a single small folio, the entire large
> block must still be decompressed. This results in a 16 KiB area requiring
> 4 page faults, where each fault decompresses 16 KiB but retrieves only
> 4 KiB of data from the block. To address this inefficiency, we instead
> fall back to 4 small folios, ensuring that each decompression occurs
> only once.
> 
> Allowing swap_read_folio() to decompress and read into an array of
> 4 folios would be extremely complex, requiring extensive changes
> throughout the stack, including swap_read_folio, zeromap,
> zswap, and final swap implementations like zRAM. In contrast,
> having these components fill a large folio with 4 subpages is much
> simpler.
> 
> To avoid a full-stack modification, we introduce a per-CPU order-2
> large folio as a buffer. This buffer is used for swap_read_folio(),
> after which the data is copied into the 4 small folios. Finally, in
> do_swap_page(), all these small folios are mapped.
> 
> Co-developed-by: Chuanhua Han <chuanhuahan@gmail.com>
> Signed-off-by: Chuanhua Han <chuanhuahan@gmail.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/memory.c | 203 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 192 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 209885a4134f..e551570c1425 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4042,6 +4042,15 @@ static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
>  	return folio;
>  }
>  
> +#define BATCH_SWPIN_ORDER 2

Hi Barry,

Thanks for the series and the numbers in the cover letter.

Just a few things.

Should BATCH_SWPIN_ORDER be ZSMALLOC_MULTI_PAGES_ORDER instead of 2?

Did you check the performance difference with and without patch 4?

I know that it wont help if you have a lot of unmovable pages
scattered everywhere, but were you able to compare the performance
of defrag=always vs patch 4? I feel like if you have space for 4 folios
then hopefully compaction should be able to do its job and you can
directly fill the large folio if the unmovable pages are better placed.
Johannes' series on preventing type mixing [1] would help.

[1] https://lore.kernel.org/all/20240320180429.678181-1-hannes@cmpxchg.org/ 

Thanks,
Usama

> +#define BATCH_SWPIN_COUNT (1 << BATCH_SWPIN_ORDER)
> +#define BATCH_SWPIN_SIZE (PAGE_SIZE << BATCH_SWPIN_ORDER)
> +
> +struct batch_swpin_buffer {
> +	struct folio *folio;
> +	struct mutex mutex;
> +};
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
>  {
> @@ -4120,7 +4129,101 @@ static inline unsigned long thp_swap_suitable_orders(pgoff_t swp_offset,
>  	return orders;
>  }
>  
> -static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> +static DEFINE_PER_CPU(struct batch_swpin_buffer, swp_buf);
> +
> +static int __init batch_swpin_buffer_init(void)
> +{
> +	int ret, cpu;
> +	struct batch_swpin_buffer *buf;
> +
> +	for_each_possible_cpu(cpu) {
> +		buf = per_cpu_ptr(&swp_buf, cpu);
> +		buf->folio = (struct folio *)alloc_pages_node(cpu_to_node(cpu),
> +				GFP_KERNEL | __GFP_COMP, BATCH_SWPIN_ORDER);
> +		if (!buf->folio) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +		mutex_init(&buf->mutex);
> +	}
> +	return 0;
> +
> +err:
> +	for_each_possible_cpu(cpu) {
> +		buf = per_cpu_ptr(&swp_buf, cpu);
> +		if (buf->folio) {
> +			folio_put(buf->folio);
> +			buf->folio = NULL;
> +		}
> +	}
> +	return ret;
> +}
> +core_initcall(batch_swpin_buffer_init);
> +
> +static struct folio *alloc_batched_swap_folios(struct vm_fault *vmf,
> +		struct batch_swpin_buffer **buf, struct folio **folios,
> +		swp_entry_t entry)
> +{
> +	unsigned long haddr = ALIGN_DOWN(vmf->address, BATCH_SWPIN_SIZE);
> +	struct batch_swpin_buffer *sbuf = raw_cpu_ptr(&swp_buf);
> +	struct folio *folio = sbuf->folio;
> +	unsigned long addr;
> +	int i;
> +
> +	if (unlikely(!folio))
> +		return NULL;
> +
> +	for (i = 0; i < BATCH_SWPIN_COUNT; i++) {
> +		addr = haddr + i * PAGE_SIZE;
> +		folios[i] = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vmf->vma, addr);
> +		if (!folios[i])
> +			goto err;
> +		if (mem_cgroup_swapin_charge_folio(folios[i], vmf->vma->vm_mm,
> +					GFP_KERNEL, entry))
> +			goto err;
> +	}
> +
> +	mutex_lock(&sbuf->mutex);
> +	*buf = sbuf;
> +#ifdef CONFIG_MEMCG
> +	folio->memcg_data = (*folios)->memcg_data;
> +#endif
> +	return folio;
> +
> +err:
> +	for (i--; i >= 0; i--)
> +		folio_put(folios[i]);
> +	return NULL;
> +}
> +
> +static void fill_batched_swap_folios(struct vm_fault *vmf,
> +		void *shadow, struct batch_swpin_buffer *buf,
> +		struct folio *folio, struct folio **folios)
> +{
> +	unsigned long haddr = ALIGN_DOWN(vmf->address, BATCH_SWPIN_SIZE);
> +	unsigned long addr;
> +	int i;
> +
> +	for (i = 0; i < BATCH_SWPIN_COUNT; i++) {
> +		addr = haddr + i * PAGE_SIZE;
> +		__folio_set_locked(folios[i]);
> +		__folio_set_swapbacked(folios[i]);
> +		if (shadow)
> +			workingset_refault(folios[i], shadow);
> +		folio_add_lru(folios[i]);
> +		copy_user_highpage(&folios[i]->page, folio_page(folio, i),
> +				addr, vmf->vma);
> +		if (folio_test_uptodate(folio))
> +			folio_mark_uptodate(folios[i]);
> +	}
> +
> +	folio->flags &= ~(PAGE_FLAGS_CHECK_AT_PREP & ~(1UL << PG_head));
> +	mutex_unlock(&buf->mutex);
> +}
> +
> +static struct folio *alloc_swap_folio(struct vm_fault *vmf,
> +		struct batch_swpin_buffer **buf,
> +		struct folio **folios)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	unsigned long orders;
> @@ -4180,6 +4283,9 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>  
>  	pte_unmap_unlock(pte, ptl);
>  
> +	if (!orders)
> +		goto fallback;
> +
>  	/* Try allocating the highest of the remaining orders. */
>  	gfp = vma_thp_gfp_mask(vma);
>  	while (orders) {
> @@ -4194,14 +4300,29 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>  		order = next_order(&orders, order);
>  	}
>  
> +	/*
> +	 * During swap-out, a THP might have been compressed into multiple
> +	 * order-2 blocks to optimize CPU usage and compression ratio.
> +	 * Attempt to batch swap-in 4 smaller folios to ensure they are
> +	 * decompressed together as a single unit only once.
> +	 */
> +	return alloc_batched_swap_folios(vmf, buf, folios, entry);
> +
>  fallback:
>  	return __alloc_swap_folio(vmf);
>  }
>  #else /* !CONFIG_TRANSPARENT_HUGEPAGE */
> -static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> +static struct folio *alloc_swap_folio(struct vm_fault *vmf,
> +		struct batch_swpin_buffer **buf,
> +		struct folio **folios)
>  {
>  	return __alloc_swap_folio(vmf);
>  }
> +static inline void fill_batched_swap_folios(struct vm_fault *vmf,
> +		void *shadow, struct batch_swpin_buffer *buf,
> +		struct folio *folio, struct folio **folios)
> +{
> +}
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
>  static DECLARE_WAIT_QUEUE_HEAD(swapcache_wq);
> @@ -4216,6 +4337,8 @@ static DECLARE_WAIT_QUEUE_HEAD(swapcache_wq);
>   */
>  vm_fault_t do_swap_page(struct vm_fault *vmf)
>  {
> +	struct folio *folios[BATCH_SWPIN_COUNT] = { NULL };
> +	struct batch_swpin_buffer *buf = NULL;
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct folio *swapcache, *folio = NULL;
>  	DECLARE_WAITQUEUE(wait, current);
> @@ -4228,7 +4351,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	pte_t pte;
>  	vm_fault_t ret = 0;
>  	void *shadow = NULL;
> -	int nr_pages;
> +	int nr_pages, i;
>  	unsigned long page_idx;
>  	unsigned long address;
>  	pte_t *ptep;
> @@ -4296,7 +4419,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>  		    __swap_count(entry) == 1) {
>  			/* skip swapcache */
> -			folio = alloc_swap_folio(vmf);
> +			folio = alloc_swap_folio(vmf, &buf, folios);
>  			if (folio) {
>  				__folio_set_locked(folio);
>  				__folio_set_swapbacked(folio);
> @@ -4327,10 +4450,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  				mem_cgroup_swapin_uncharge_swap(entry, nr_pages);
>  
>  				shadow = get_shadow_from_swap_cache(entry);
> -				if (shadow)
> +				if (shadow && !buf)
>  					workingset_refault(folio, shadow);
> -
> -				folio_add_lru(folio);
> +				if (!buf)
> +					folio_add_lru(folio);
>  
>  				/* To provide entry to swap_read_folio() */
>  				folio->swap = entry;
> @@ -4361,6 +4484,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		count_vm_event(PGMAJFAULT);
>  		count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
>  		page = folio_file_page(folio, swp_offset(entry));
> +		/*
> +		 * Copy data into batched small folios from the large
> +		 * folio buffer
> +		 */
> +		if (buf) {
> +			fill_batched_swap_folios(vmf, shadow, buf, folio, folios);
> +			folio = folios[0];
> +			page = &folios[0]->page;
> +			goto do_map;
> +		}
>  	} else if (PageHWPoison(page)) {
>  		/*
>  		 * hwpoisoned dirty swapcache pages are kept for killing
> @@ -4415,6 +4548,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  			lru_add_drain();
>  	}
>  
> +do_map:
>  	folio_throttle_swaprate(folio, GFP_KERNEL);
>  
>  	/*
> @@ -4431,8 +4565,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	}
>  
>  	/* allocated large folios for SWP_SYNCHRONOUS_IO */
> -	if (folio_test_large(folio) && !folio_test_swapcache(folio)) {
> -		unsigned long nr = folio_nr_pages(folio);
> +	if ((folio_test_large(folio) || buf) && !folio_test_swapcache(folio)) {
> +		unsigned long nr = buf ? BATCH_SWPIN_COUNT : folio_nr_pages(folio);
>  		unsigned long folio_start = ALIGN_DOWN(vmf->address, nr * PAGE_SIZE);
>  		unsigned long idx = (vmf->address - folio_start) / PAGE_SIZE;
>  		pte_t *folio_ptep = vmf->pte - idx;
> @@ -4527,6 +4661,42 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		}
>  	}
>  
> +	/* Batched mapping of allocated small folios for SWP_SYNCHRONOUS_IO */
> +	if (buf) {
> +		for (i = 0; i < nr_pages; i++)
> +			arch_swap_restore(swp_entry(swp_type(entry),
> +				swp_offset(entry) + i), folios[i]);
> +		swap_free_nr(entry, nr_pages);
> +		add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> +		add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> +		rmap_flags |= RMAP_EXCLUSIVE;
> +		for (i = 0; i < nr_pages; i++) {
> +			unsigned long addr = address + i * PAGE_SIZE;
> +
> +			pte = mk_pte(&folios[i]->page, vma->vm_page_prot);
> +			if (pte_swp_soft_dirty(vmf->orig_pte))
> +				pte = pte_mksoft_dirty(pte);
> +			if (pte_swp_uffd_wp(vmf->orig_pte))
> +				pte = pte_mkuffd_wp(pte);
> +			if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
> +			    !pte_needs_soft_dirty_wp(vma, pte)) {
> +				pte = pte_mkwrite(pte, vma);
> +				if ((vmf->flags & FAULT_FLAG_WRITE) && (i == page_idx)) {
> +					pte = pte_mkdirty(pte);
> +					vmf->flags &= ~FAULT_FLAG_WRITE;
> +				}
> +			}
> +			flush_icache_page(vma, &folios[i]->page);
> +			folio_add_new_anon_rmap(folios[i], vma, addr, rmap_flags);
> +			set_pte_at(vma->vm_mm, addr, ptep + i, pte);
> +			arch_do_swap_page_nr(vma->vm_mm, vma, addr, pte, pte, 1);
> +			if (i == page_idx)
> +				vmf->orig_pte = pte;
> +			folio_unlock(folios[i]);
> +		}
> +		goto wp_page;
> +	}
> +
>  	/*
>  	 * Some architectures may have to restore extra metadata to the page
>  	 * when reading from swap. This metadata may be indexed by swap entry
> @@ -4612,6 +4782,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		folio_put(swapcache);
>  	}
>  
> +wp_page:
>  	if (vmf->flags & FAULT_FLAG_WRITE) {
>  		ret |= do_wp_page(vmf);
>  		if (ret & VM_FAULT_ERROR)
> @@ -4638,9 +4809,19 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (vmf->pte)
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out_page:
> -	folio_unlock(folio);
> +	if (!buf) {
> +		folio_unlock(folio);
> +	} else {
> +		for (i = 0; i < BATCH_SWPIN_COUNT; i++)
> +			folio_unlock(folios[i]);
> +	}
>  out_release:
> -	folio_put(folio);
> +	if (!buf) {
> +		folio_put(folio);
> +	} else {
> +		for (i = 0; i < BATCH_SWPIN_COUNT; i++)
> +			folio_put(folios[i]);
> +	}
>  	if (folio != swapcache && swapcache) {
>  		folio_unlock(swapcache);
>  		folio_put(swapcache);

