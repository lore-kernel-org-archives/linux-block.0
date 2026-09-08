Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A153B60A;
	Tue,  8 Sep 2026 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869917; cv=none; b=rVOdp5fD1bNJwc4OIlF60yj8QVzQ+O+LzkgGbWPYcWGpfaj9k1bMDau9ne/hirLn1aNi8w920nX9R9mO/nmXf7Hd3to2MW9/rTh8VDmmldYgoxXvmHGJRHf+ytTdtUSUNV3TQoJ/0mjqIdxkWKoY2Wn8ToSchJIZtFiY4k67OcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869917; c=relaxed/simple;
	bh=ZhlmP6DRfiNjxAh6PBzYYJKk+sOFFH5MoTjJDBoHgGw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=smaSBD1FTghgh/dxklTlxhoErArtiwBlt9RuPTFynJFlo+I1fJjFsP/XIwynBKU9t4zgcjarEcF5IosB1RyuTY+V0zBCu55If8UsEGYXUeSJ4NUidNaN7RSg1dz+ZUoN9SQHEqqEsl8Xt2DY2nqfdCiMOQr+aagaXFWJRksTK4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=tLj74R80; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="tLj74R80"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Ymu30IFequ9j8mwpIl1fqgOuunAR0A9gnw/b4W0QRgQ=;
	b=tLj74R80BzjABZm0VutAzoakmtJkuevI6rCYwabEuTFLDXgsbrVrO3rjC1plZB+JxSK5swNTT
	VFuKA0pvqJ+UxMGDZNYm1QOBGAxXScKmM1V7CKO+aMjBPoNiYLtMQSRWq9HJaIG/6sHeAPNT5+K
	8vUnrj07jeUrKI+b/zoFozw=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hfN3m6SW0z1cyVf;
	Tue,  8 Sep 2026 20:07:32 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 07FBD40565;
	Tue,  8 Sep 2026 20:18:26 +0800 (CST)
Received: from [10.173.124.160] (10.173.124.160) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 8 Sep 2026 20:18:21 +0800
Subject: Re: [PATCH 15/25] mm/fbatch: remove shake_folio() shake_page() from
 memory-failure
To: Hugh Dickins <hughd@google.com>
CC: Ackerley Tng <ackerleytng@google.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Baolin Wang <baolin.wang@linux.alibaba.com>, Barry
 Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, Christian
 Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, Christoph
 Lameter <cl@gentwo.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, David
 Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, Jan Kara
	<jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, Johannes Weiner
	<hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, Kiryl Shutsemau
	<kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, Leonardo Bras
	<leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, Marcelo Tosatti
	<mtosatti@redhat.com>, Matthew Wilcox <willy@infradead.org>, Mel Gorman
	<mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, Minchan Kim
	<minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador
	<osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, Qi Zheng
	<qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Shakeel Butt <shakeel.butt@linux.dev>, Suren
 Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, Yang
 Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, Zach O'Keefe
	<zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, <linux-block@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
 <213f92b1-7ac2-189c-4656-ba7d00cc7666@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1563bfbb-0596-1217-b407-2d1504627bef@huawei.com>
Date: Tue, 8 Sep 2026 20:18:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <213f92b1-7ac2-189c-4656-ba7d00cc7666@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemk100004.china.huawei.com (7.152.185.74)

On 2026/8/24 22:27, Hugh Dickins wrote:
> shake_folio()'s lru_add_drain_all() no longer serves a purpose, now that
> the per-cpu fbatch references are gone. Are the retries in get_any_page()
> then still useful? Not obvious, so keep them.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/hwpoison-inject.c |  1 -
>  mm/internal.h        |  1 -
>  mm/memory-failure.c  | 38 +-------------------------------------
>  3 files changed, 1 insertion(+), 39 deletions(-)
> 
> diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
> index a11222572f97..9eab4b7d25b2 100644
> --- a/mm/hwpoison-inject.c
> +++ b/mm/hwpoison-inject.c
> @@ -118,7 +118,6 @@ static int hwpoison_inject(void *data, u64 val)
>  	if (!hwpoison_filter_enable)
>  		goto inject;
>  
> -	shake_folio(folio);
>  	/*
>  	 * This implies unable to support non-LRU pages except free page.
>  	 */
> diff --git a/mm/internal.h b/mm/internal.h
> index ff4bd3a14539..9a25552cbd83 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1140,7 +1140,6 @@ static inline bool node_reclaim_enabled(void)
>   */
>  #ifdef CONFIG_MEMORY_FAILURE
>  int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill);
> -void shake_folio(struct folio *folio);
>  typedef int hwpoison_filter_func_t(struct page *p);
>  void hwpoison_filter_register(hwpoison_filter_func_t *filter);
>  void hwpoison_filter_unregister(void);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index aaf14608b30e..2a6a01e260ed 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -310,30 +310,6 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
>  	return ret;
>  }
>  
> -/*
> - * Unknown page type encountered. Try to check whether it can turn PageLRU by
> - * lru_add_drain_all.
> - */
> -void shake_folio(struct folio *folio)
> -{
> -	if (folio_test_hugetlb(folio))
> -		return;
> -	/*
> -	 * TODO: Could shrink slab caches here if a lightweight range-based
> -	 * shrinker will be available.

I'm not sure whether we should keep above TODO. Anyway, this patch looks good to me.

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
