Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BF23346A0
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 04:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788321918; cv=none; b=sR1Gp4Gx1/jgdJknF8+45NGERWyXVbh2zYHCS/ZuoGm9vlw4Yu6TWhHy5y8kChCfDhP0FMDYg0gFiGx+qZC+7KoHrImuXafKxbkgbwZ2kciWThOwS/f1Y5LyTIhFkdj7KrkRTrmr2uT/ayBThmzXewjpY6EfBK1qrF/X+rfolPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788321918; c=relaxed/simple;
	bh=GbeRlDFB/Ojrth/vw1XdAvxwKBOubQN4yOMhkl5AS1k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eBBGXHFug/6jXEajVXVvwTgaUy35EhuRBeFNqxFIzP3hCP8yh832yLSJwR0DwDjbiPGcbtI6mkRH5TP0KOd1ivjW4BI3tUNlVOI5CwR1Z4zjobr3yS0bgTaPeoG7ihMoS656MoqzBqLhz+2X0IIglLvDpyWhc/vng62j3Yzk91g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FI1wlYKf; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FI1wlYKf"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-85aa9c1308dso7267237b3.3
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2026 21:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788321916; x=1788926716; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sggsj0swIY6SNlhR5Rlr4w6l9mVN7Mj25L4G93WgJu0=;
        b=FI1wlYKfN53Wio/ApNAn6RfhcbQCUb768joMa8jOJ+HJPQ8RjAdwiRahHvsdBOjYju
         zPai/FrDdx3Uv2DmDheUcM6HK6tw4AhxRfYCNQsLuKUsWh4XpfATHslFGihpSUnK12Xu
         jx8huc+ICZiM3+rhqETzjaMC4Nh3C+8rtRHsLmbaLVfPQZR0WGMWGZx8Se7VebJfFVa5
         89xdiNPdDG+g82ijxefNi6+Feer43rQU6knkf71KihgxgHrknnS3TsMkmRvMU9dtmBKn
         bUI6M5EX/lw5WsICBGpk7MWrXsuqxzKhi71D0XfugOTD6brie6V8iIrqS5zz/RnZgjT6
         WRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788321916; x=1788926716;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sggsj0swIY6SNlhR5Rlr4w6l9mVN7Mj25L4G93WgJu0=;
        b=Dz+AybetfPdbeAtqK6MDRkDkvwuB5wssv50HSadD4pJuh9RbI/HrBDdkG5njOszCu1
         WmKuIXMr5/NGZZGoN9F10aZ4CRKSiejSRGFNc5y/3KckInEMVIrEGc2z0yOZcE0WKZ4d
         3TDtRVuUF5H4qH169o0Bit4TSmltyv7Uk1VVgQ2AtERuloPSlUPS+ImRkRYs2K+0wpe6
         ugvn7QJTuDPvwDR/2msEIp2ku5VQwRurWKq+pWOZpJPU51Lsx+7XLwi7UidAzULKpCaU
         WcAWYXcms5j0di55GFpxGK+ygfI8Z4TCLl3ImeQHeFwdt8I+JrIu8Dh8m+foCKThrUcZ
         fI0g==
X-Forwarded-Encrypted: i=1; AKwUvBwV1elbO0B6XEmW1cv6JCpkFe7DMnTWBE7sF4G08UW+ZboZfQUCEgJscPhYXGqcGlghf5RXaiK6wr/rtg==@vger.kernel.org
X-Gm-Message-State: AFuF++n6YwWhV+u+/9fEz65/zpjAbxpVtb36ikDPnOuyRaZY6Q6eMMM6
	SZcKQgkLWJsAZettKg6qQ1cQRImYpfmHKmL+vyuDHHmBoZPQzh1uSuBtHUnXBnMWJQ==
X-Gm-Gg: AYBFou1u2AIrPStqwuJMzsAqxUCw438oIkecL8+fniOAW3gbTpvQCxraDM2ouGg1i+1
	xWa1X/xRXyuQNtRNh323akVBtquRsk++T9jzNvvqkSTMa6bZw5NAERZwMA1hhbZH7elTlBOZ6My
	TX3ZffuixOZfx0/Ta8siRoDAqxshcdGoE9xCZfOVo6Hfb3iL+XeZUmWwxFx9I7tlQuVzO3qgAGd
	zxHpeRxqDhHI0yQ1Yd09im/8J9pjCT7ChKPkKkmyJJN60dUxiei5ESD/CscpVbMI0kAZA46VDxA
	12kSj6GORZrne/la1FGuPgF+Q5rK1KtchOrIV8kxqoyQ0Okld6sKpGF32vZ3EnWo73IJ+k8XGr1
	WjSSlrYNkj50xAx2gDcUhAPisuBOJtZlzGVymgGv7vl/1cyD6TnWFpMl3PwD9V5Dhy+UOwghhII
	swJf+3tB3E8YlrVNGG3xjFpHd6Ibdbkk7iplTJJbdW7FwbAOppn8gGEoBRrbql5JoDJ0Z7lebKT
	j47jnooNFlgXZ452AbQOySGgdtm2l53CKnpjDHW1jDsQ+Dr
X-Received: by 2002:a05:690c:81:b0:80b:9f4e:a70 with SMTP id 00721157ae682-86c526f66dfmr8698707b3.26.1788321915018;
        Tue, 01 Sep 2026 21:05:15 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c1975dd91sm8720547b3.49.2026.09.01.21.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 21:05:14 -0700 (PDT)
Date: Tue, 1 Sep 2026 21:05:09 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
    Leonardo Bras <leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
    Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 04/25] mm/fbatch: lru bit set, no extra ref, while folio
 on per-cpu fbatch
In-Reply-To: <e0887417-85a7-453e-e733-561dc11db08f@google.com>
Message-ID: <04101fb5-a723-1fe0-37ee-5e62b5fbb9d7@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com> <e0887417-85a7-453e-e733-561dc11db08f@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 24 Aug 2026, Hugh Dickins wrote:
...
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -343,6 +343,23 @@ static inline void folio_migrate_refs(struct folio *new, const struct folio *old
>  }
>  #endif /* CONFIG_LRU_GEN */
>  
> +enum {
> +	LRU_NEXT_NEVER_TAIL = 0,	/* Used by a tail's compound_head */
> +	LRU_NEXT_BATCHED = 1,		/* Not used by any aligned pointer */
> +	NR_LRU_NEXT_FLAGS
> +};
> +
> +static __always_inline
> +bool lru_add_del_folio(struct folio *folio)
> +{
> +	/* BUG_ON(folio_test_lru(folio)); */

That was a good statement of intent, but clearly I never booted
a system with that BUG_ON uncommented: it actually needs to say
	/* BUG_ON(folio_test_lru(folio) && folio_ref_count(folio)); */
because once the refcount is 0, __page_cache_release() chooses to
lruvec_del_folio() before non-atomically clearing lru flags.
To be fixed when respun.

> +	if (!(folio->lru_next & BIT(LRU_NEXT_BATCHED)))
> +		return false;
> +	folio->lru.next = LIST_POISON1;
> +	/* BUG_ON(folio->lru_next & BIT(LRU_NEXT_BATCHED)); */
> +	return true;
> +}
...
