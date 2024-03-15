Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AA24F1F8
	for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527229; cv=none; b=fDmHqsLpOZy1GohnCRPHvZtg78FrmEYdPkKLihymzK+Cg6i6AYnl0KgIGMCkfZF8D1WSNDoCiT1+Z1g1w0FlwlcCkuZ4HuWXgq5q2H+7kLh6d8a6lU+a7Cc5UzhbIXraNgKw/ibBpL/vHCriH1P9vgZDlVXkJdpUSaaP2s4VkHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527229; c=relaxed/simple;
	bh=+3P91a6YJLKQ78DxQAocSynqpaP5mzawBLeC6btfyBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLbWUwPC/id1KEFIs1uVdVpD8T1Tn+BGP+KHzR584q2cD98kuiayzIxRbkueHJ8pI0k6OmJOpYifiMD4Saf6uq+NirhmocRWJye1EBM2jYD8Xo4ub0wkUxDrfNQNhm2mzEVFrcZQ8EVnwyx2AjxeO4wXJhkCf6/xLdfSZA3tntQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hefHwerd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V3Hk8GPN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hefHwerd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V3Hk8GPN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hefHwerd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V3Hk8GPN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hefHwerd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V3Hk8GPN"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3AA5D21DF4;
	Fri, 15 Mar 2024 18:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710527222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F39mLGMroywL6C3XW5hd53XHtA0UOkK913HkL0rO37g=;
	b=hefHwerdjopjWLfEOj1vhPJ6Hlh7SZ9tlEKdc6n3FDzZf+4AbM+DJPoKy3OUjrm3LWh9Uv
	T9j5M63Wf4VkpG0119d+1oBxrtNPTEqLPLLrwCucrIu21hvNU0tWzShbnljh4ypDIElgRS
	ibyrTNsmERdz/TRQoQr6fK6pEdJtQKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710527222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F39mLGMroywL6C3XW5hd53XHtA0UOkK913HkL0rO37g=;
	b=V3Hk8GPN+ecWS3hHii6VRY1FDQy+7mXhxJi5e3ViRBrborp6VtxtrYvrfPhzBpKf7c2CcQ
	Pto9plFn3wGlEXBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710527222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F39mLGMroywL6C3XW5hd53XHtA0UOkK913HkL0rO37g=;
	b=hefHwerdjopjWLfEOj1vhPJ6Hlh7SZ9tlEKdc6n3FDzZf+4AbM+DJPoKy3OUjrm3LWh9Uv
	T9j5M63Wf4VkpG0119d+1oBxrtNPTEqLPLLrwCucrIu21hvNU0tWzShbnljh4ypDIElgRS
	ibyrTNsmERdz/TRQoQr6fK6pEdJtQKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710527222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F39mLGMroywL6C3XW5hd53XHtA0UOkK913HkL0rO37g=;
	b=V3Hk8GPN+ecWS3hHii6VRY1FDQy+7mXhxJi5e3ViRBrborp6VtxtrYvrfPhzBpKf7c2CcQ
	Pto9plFn3wGlEXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB1FA13460;
	Fri, 15 Mar 2024 18:27:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lXRpNvWS9GWUCwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 15 Mar 2024 18:27:01 +0000
Message-ID: <b9e5c71d-4d3a-4d1f-8956-68a6d2537e4b@suse.de>
Date: Fri, 15 Mar 2024 19:27:01 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brd: Remove use of page->index
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
References: <20240315181212.2573753-1-willy@infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240315181212.2573753-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.28
X-Spamd-Result: default: False [-4.28 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.938];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,infradead.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On 3/15/24 19:12, Matthew Wilcox (Oracle) wrote:
> This debugging check will become more costly in the future when we shrink
> struct page.  It has not proven to be useful, so simply remove it.
> 
> This lets us use __xa_insert instead of __xa_cmpxchg() as we no longer
> need to know about the page that is currently stored in the XArray.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   drivers/block/brd.c | 40 +++++++++++-----------------------------
>   1 file changed, 11 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index e322cef6596b..b900fe9e0030 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -29,10 +29,7 @@
>   
>   /*
>    * Each block ramdisk device has a xarray brd_pages of pages that stores
> - * the pages containing the block device's contents. A brd page's ->index is
> - * its offset in PAGE_SIZE units. This is similar to, but in no way connected
> - * with, the kernel's pagecache or buffer cache (which sit above our block
> - * device).
> + * the pages containing the block device's contents.
>    */
>   struct brd_device {
>   	int			brd_number;
> @@ -51,15 +48,7 @@ struct brd_device {
>    */
>   static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
>   {
> -	pgoff_t idx;
> -	struct page *page;
> -
> -	idx = sector >> PAGE_SECTORS_SHIFT; /* sector to page index */
> -	page = xa_load(&brd->brd_pages, idx);
> -
> -	BUG_ON(page && page->index != idx);
> -
> -	return page;
> +	return xa_load(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT);
>   }
>   
>   /*
> @@ -67,8 +56,8 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
>    */
>   static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
>   {
> -	pgoff_t idx;
> -	struct page *page, *cur;
> +	pgoff_t idx = sector >> PAGE_SECTORS_SHIFT;
> +	struct page *page;
>   	int ret = 0;
>   
>   	page = brd_lookup_page(brd, sector);
> @@ -80,23 +69,16 @@ static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
>   		return -ENOMEM;
>   
>   	xa_lock(&brd->brd_pages);
> -
> -	idx = sector >> PAGE_SECTORS_SHIFT;
> -	page->index = idx;
> -
> -	cur = __xa_cmpxchg(&brd->brd_pages, idx, NULL, page, gfp);
> -
> -	if (unlikely(cur)) {
> -		__free_page(page);
> -		ret = xa_err(cur);
> -		if (!ret && (cur->index != idx))
> -			ret = -EIO;
> -	} else {
> +	ret = __xa_insert(&brd->brd_pages, idx, page, gfp);
> +	if (!ret)
>   		brd->brd_nr_pages++;
> -	}
> -
>   	xa_unlock(&brd->brd_pages);
>   
> +	if (ret < 0) {
> +		__free_page(page);
> +		if (ret == -EBUSY)
> +			ret = 0;
> +	}
>   	return ret;
>   }
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

