Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38982305E0A
	for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295451; cv=none; b=Qg2DrtG0MLU4u+xgkUmMLupCOhZzqUO9Bci704N4H3T5WBzN4Nrol67K9UzYJgtFB+0qpKf+cokd7MvkSxCKwLuX8ZxE96bMwIsQId1t/8bVNx1KeNEui7Y9FZw45NTn6UitgMT6ciGpI0UzgDbQhLCntvkot46cytIhcDKDj6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295451; c=relaxed/simple;
	bh=Qizv1kVYHYJhpufhlIK9VZkj6ewigqD9BppPyEb8o8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThSWdxjUrdi1C26yID0PAwdsiYu5SRKXqyaBo2PWGgsy6ooF6RkB4Ck7UJQuX4iFOfbUp8wxWjSEdmJj/skOKyC4b71qIXcvlUP6xGlLMrmfvUwjiO+5/dXSz6urOGcQVqznHzEG4oA/ZJBAuHzbXLRck4t9wnYU6WLYD+c0HDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EzzLbmuL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cL6N5RJ7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D2scbiqy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YPxHSC8d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EzzLbmuL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cL6N5RJ7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D2scbiqy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YPxHSC8d"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A51AB1F45A;
	Fri, 24 Oct 2025 08:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761295104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4ra0u6MQk+rzPvxHAFSyS/W2tCF/Nc+jXjLKRMZLIbU=;
	b=EzzLbmuLEWH4PKQg60Vdyy8P4kf6OdbBLg5Iz5TBuTz6PjiYoeidyS+R0IS+KmGpDn9ky0
	Z1y4WuVYjBRVCfVvU6/Awvp917MgXpGc6BbVjj3VCDDv/xtmLq07cFTgOpIj3qq2JpMB9/
	Kimm8QUfVr6ekqqrCbmchWIlBhqm2fA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761295104;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4ra0u6MQk+rzPvxHAFSyS/W2tCF/Nc+jXjLKRMZLIbU=;
	b=cL6N5RJ7j4WZhXDKn0ZgCkwcNJb1+QnjVwEZNqpoZxGcXcfJuYSMQmWMIUXfcx151ttnHj
	HsU94XVR8u+MNLCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761295100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4ra0u6MQk+rzPvxHAFSyS/W2tCF/Nc+jXjLKRMZLIbU=;
	b=D2scbiqy55+w0WwSNpr3xI0/oFAA6S+YpQj6pa59d3/tbL6KxBv04GNBcTx9klyELKuxJ7
	BqC+e5CoEZTHifldgeZRcBbBkIOQifLssRGSJfQH9SC8Ki5TJwxmxWIhW9ygG5QIrebmgo
	dNiL1auzcf08p+A8VoJ/LM3WNlrrXo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761295100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4ra0u6MQk+rzPvxHAFSyS/W2tCF/Nc+jXjLKRMZLIbU=;
	b=YPxHSC8dVSCO7UNqkt5WIPb3RYWlKN0yxBup/i3v5bjQM2kglK0uBZOEMdbMqi1UzNMnZV
	JKol9W/RrczOVkBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A74713A8E;
	Fri, 24 Oct 2025 08:38:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uD6MHfw6+2jiXwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 24 Oct 2025 08:38:20 +0000
Message-ID: <50e96fd8-114b-4de3-939e-9ba606e64b06@suse.cz>
Date: Fri, 24 Oct 2025 10:38:20 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] slab, block: generalize bvec_alloc_gfp
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
References: <20251023080919.9209-1-hch@lst.de>
 <20251023080919.9209-2-hch@lst.de>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20251023080919.9209-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 10/23/25 10:08, Christoph Hellwig wrote:
> bvec_alloc_gfp is useful for any place that tries to kmalloc first and
> then fall back to a mempool.  Rename it and move it to blk.h to prepare

I wonder if such fall backs are necessary because IIRC mempools try to
allocate from the underlying provider (i.e. kmalloc caches first), and only
give out the reserves when that fails. Is it done for less overhead or
something?

> for using it to allocate the default integrity buffer.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

That says blk.h but you move it to slab.h? Assuming you intended slab.h.
However gfp flags are not slab only so it should be rather
include/linux/gfp.h - added maintainers of that to Cc.

We do have gfp_nested_mask() there which is quite similar but not exactly.
Maybe a canonical macro not for nested, but for opportunistic allocations
(if a one size fits all solution can be found) would be useful too, as
people indeed reinvent those manually in various places with subtle differences.

> ---
>  block/bio.c          | 13 ++-----------
>  include/linux/slab.h | 10 ++++++++++
>  2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index b3a79285c278..4ea5833a7637 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -169,16 +169,6 @@ void bvec_free(mempool_t *pool, struct bio_vec *bv, unsigned short nr_vecs)
>  		kmem_cache_free(biovec_slab(nr_vecs)->slab, bv);
>  }
>  
> -/*
> - * Make the first allocation restricted and don't dump info on allocation
> - * failures, since we'll fall back to the mempool in case of failure.
> - */
> -static inline gfp_t bvec_alloc_gfp(gfp_t gfp)
> -{
> -	return (gfp & ~(__GFP_DIRECT_RECLAIM | __GFP_IO)) |
> -		__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
> -}
> -
>  struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
>  		gfp_t gfp_mask)
>  {
> @@ -201,7 +191,8 @@ struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
>  	if (*nr_vecs < BIO_MAX_VECS) {
>  		struct bio_vec *bvl;
>  
> -		bvl = kmem_cache_alloc(bvs->slab, bvec_alloc_gfp(gfp_mask));
> +		bvl = kmem_cache_alloc(bvs->slab,
> +				try_alloc_gfp(gfp_mask & ~__GFP_IO));
>  		if (likely(bvl) || !(gfp_mask & __GFP_DIRECT_RECLAIM))
>  			return bvl;
>  		*nr_vecs = BIO_MAX_VECS;
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index d5a8ab98035c..a6672cead03e 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -1113,6 +1113,16 @@ void kfree_rcu_scheduler_running(void);
>   */
>  size_t kmalloc_size_roundup(size_t size);
>  
> +/*
> + * Make the first allocation restricted and don't dump info on allocation
> + * failures, for callers that will fall back to a mempool in case of failure.
> + */
> +static inline gfp_t try_alloc_gfp(gfp_t gfp)
> +{
> +	return (gfp & ~__GFP_DIRECT_RECLAIM) |
> +		__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;

Note without __GFP_DIRECT_RECLAIM the __GFP_NORETRY is most likely redundant
(but doesn't hurt).

> +}
> +
>  void __init kmem_cache_init_late(void);
>  void __init kvfree_rcu_init(void);
>  

