Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614377;
	b=p/a9tyjKAeU2ULq9GJ1gmCOCZzkPmtz338jrBHbErUWf0WrmQf5pHOzw+Hto0wlqFzYt
	 3KWbwOVxCvbHKkMRS+gaVBSqLnq+GVBMtq6cUGyR7/RNdLnFOd9zd38170D+PZW3LsShU
	 G1fn2J2etJEaIu6pnA7v9wTxtT4XXeysEFt359aHzf7u1Y8zXUwVfYxuXqzmPR1HeFefU
	 oZeanZw9W8qmnZ8YL3FXQI3sjrCMgqxFSZ21APdj8aItD8+8yw2qTLgCYAHbfHsl2EmTX
	 LfpROyT2IWuDNCnUmpBrGtawRmki74d3uab/6nQnNlJszHEV8UkZOXUTCVdYtWtcxdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614377;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=AIUHPAAXt1s3tQmTRgQTWCI8t2dy2mHDfBJvoW1CIRU=;
	b=NKnUrNJ+ZrU8c9k1+trR9xSRJUKJ4/8UIjV7joqCWm6y7CVBaWQpgX5iphCGsnR08AUy
	 m1dYrtDi/WAIzN2X16PZP/unBXTA3Z4khfHilwgb3/v0SwuzJcvDG9xaq22F4eZXG7Ewk
	 26XF2vhRHo6RfTR/H0AIPGcms7+AAE6Xzbs0xnvoX+BDN+XJeZOCm6EENdL/Dmh3ICu+c
	 E+MKfdldhQSklaCV/kRKWaqfUV5g7Xjm0r0jBKv19AG4jUH5FW33oCiDEFQpDaKlDNSDQ
	 GEPRS1quYsS/vJTTKWSA/fLuNZV0A9o0YYGZWGk4wIkP/Uzm2ONiswkOCTFVJj0Vyug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=gNFkVet7;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9C606A324;
	Mon,  2 Nov 2026 10:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9C9C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=gNFkVet7
Received: from [192.168.1.71] (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6D7E04DC;
	Mon,  2 Nov 2026 11:10:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793614231;
	bh=Pbr7FqwHE7e4DKrbewizP5BIUnE5HZeSzQe6zlBuXgc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gNFkVet7a8YNgqKKfUattiD324ptZXZOwCs2ElXrPuQU7AEkmyGg5A9iUdpWCq4Zw
	 n3Ag9IzEx8qDyTSIvwUgNi6XIZEQ9M9OPU17+kQcdYSQC8OD5QURTc/RfUc8aM907v
	 EzbRU+ChlB6Zx8WxwMUhohSq1WiSg+C9Ivq9Tk/I=
Message-ID: <4898b6a7-1824-412a-aef0-ae6bde021e38@ideasonboard.com>
Date: Mon, 2 Nov 2026 10:12:42 +0000
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/26] mm/fbatch: no lru_cache_disable() in
 __alloc_contig_migrate_range()
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Ackerley Tng <ackerleytng@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Binbin Wu <binbin.wu@linux.intel.com>, Christian Brauner
 <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Christoph Lameter <cl@gentwo.org>, Claudio Imbrenda
 <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 JP Kobryn <jp.kobryn@linux.dev>, Jan Kara <jack@suse.cz>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Kairui Song <ryncsn@gmail.com>, Kiryl Shutsemau <kas@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Leonardo Bras <leobras.c@gmail.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Mel Gorman <mgorman@techsingularity.net>, Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Qi Zheng <qi.zheng@linux.dev>,
 Rik van Riel <riel@surriel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>,
 Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
 <84ed3bf8-da32-3447-0577-052c5d1a56b2@google.com>
Content-Language: en-GB
From: Alen Karnil <alen.karnil@ideasonboard.com>
Autocrypt: addr=alen.karnil@ideasonboard.com; keydata=
 xjMEafxhCxYJKwYBBAHaRw8BAQdAXswEEnvxYiHXb8Q8GsSAuaLuXqJFs3kmsMI7EWF9EuDN
 NUFsZW4gS2FybmlsIChXb3JrIElvQikgPGFsZW4ua2FybmlsQGlkZWFzb25ib2FyZC5jb20+
 wpkEExYKAEEWIQT0whyXpTyoVtApVAlRzoJ78NRPngUCagGrrgIbAwUJBaOagAULCQgHAgIi
 AgYVCgkICwIEFgIDAQIeBwIXgAAKCRBRzoJ78NRPnkpDAP4kmtHsMfTtV6BC1z7GTb86BL2g
 9FC1EarGJDDzcafMGQEA6clsoXvRYjHPJexVebjmkI4bq1QM0X/L9Ffe0PfpdQbOOARp/GEL
 EgorBgEEAZdVAQUBAQdAsVoGZ4IK0EgJ8HU05PQKzK15jaCi/IEA/7Cw9ZzcBmwDAQgHwn4E
 GBYKACYWIQT0whyXpTyoVtApVAlRzoJ78NRPngUCafxhCwIbDAUJBaOagAAKCRBRzoJ78NRP
 nqYcAP0eh3LahCDsfNa8zsiK+8QzeujWPKhc5zDcIqrDI6xufwD+Mu9e202It54rNZb8UWEy
 V5OzTEy0JlsQfO6DYWIORwI=
In-Reply-To: <84ed3bf8-da32-3447-0577-052c5d1a56b2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hugh,

I've come across your series because of a usecase I have, namely this patch.

Not to bore you with details, I got an IMX8MPlus with some cameras.
Due to the cameras (and other associated HW), it ends up allocating 
multiple framebuffers using CMA (currently 16 per camera)
which is quite slow (~200ms for a single camera).

I've spent some time profiling and found that the biggest
stall is when lru_cache_disable() is called. Just applying the patch on 
its own, I saw greatly improved performance (cutting the delay almost 5x).

This is on a 7.2 kernel.

On 09/09/2026 11:16, Hugh Dickins wrote:
> Remove lru_cache_disable() from __alloc_contig_migrate_range(). It does
> not now benefit from lru_add_drain_all() first; and gains little benefit
> from invalidating buffer head LRUs first, since 5.0 commit 80409c65e2c6
> ("mm: migrate: make buffer_migrate_page_norefs() actually succeed").
> 
> This will be more controversial. lru_cache_disable()+lru_cache_enable()
> were brought in for CMA page migration, see 5.13 commit d479960e44f2
> ("mm: disable LRU pagevec during the migration temporarily") through
> 8cc621d2f45d ("mm: fs: invalidate BH LRU during page migration") - I
> guess the testing there must have been on a 4.19-based Android kernel,
> without 5.0's buffer_migrate_page_norefs().
> 
> It's possible that invalidating BH LRUs perhaps 0 times, perhaps N
> times, will average out worse than invalidating 1 time and stopping
> everyone else; or that folio_test_clear_lru() failures manifest more
> than before (note how folio migration has retries on raised refcount,
> but isolate_migratepages_block() no retry on failed test_clear_lru).
> But let's give this a try and look out for regressions.
> 
> Don't delete lru_cache_disable() yet: leaving stale folio pointers in
> the per-cpu fbatches, with folio_try_get() yet to come on them, would be
> bad for memory hotremoval: the lru_cache_disable() in offline_pages()
> protects from that.
>
Can the patch stand on its own?> Signed-off-by: Hugh Dickins 
<hughd@google.com>
> ---
>   mm/page_alloc.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 12fac9084c48..3e085a25a776 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7147,8 +7147,6 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>   		.reason = MR_CONTIG_RANGE,
>   	};
>   
> -	lru_cache_disable();
> -
>   	while (pfn < end || !list_empty(&cc->migratepages)) {
>   		if (fatal_signal_pending(current)) {
>   			ret = -EINTR;
> @@ -7182,7 +7180,6 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>   			break;
>   	}
>   
> -	lru_cache_enable();
>   	if (ret < 0) {
>   		if (!(cc->gfp_mask & __GFP_NOWARN) && ret == -EBUSY)
>   			alloc_contig_dump_pages(&cc->migratepages);

-- 
Thanks,
Alen Karnil

