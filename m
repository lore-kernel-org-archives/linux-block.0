Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182B1E529
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734420276; cv=none; b=FOIRFLtBEso4XfjpGCksNs6nmJs40vf+h2VuU8fPa9Ueod4prz5jKKKgxfdJe6S7WLkUoijOx/lX+bAI7mPNpQne+VRYFIdCCoshdGXpEXVYIMER7bkFsIuzAPPw2u//X6fFVhaxJyy5TToT49s+KsdmgRQGfWIIDdTEO6DwXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734420276; c=relaxed/simple;
	bh=Wz3/KeOsg+iB0VTjJcCDS+Odewf+dlqz5WheuccCmVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTy2it9F9ZCCoV9MXPCfNMhYYagmPkVQl5wThuRywMCKUjHF949o716NqktbtYDF9C0PXKdYSY816t+23iRGNk+9xK8ys5kVphTpak+CejbCDDG9JhpR82muuNOXBT7juiYDF1dTiLcEqipWLYz6E4W3F8B+wJUWiIaFa2B45hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HcqyFVjo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GKvJBTI1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SaJTCfEC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HYFaShUu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HcqyFVjo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GKvJBTI1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SaJTCfEC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HYFaShUu"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EA96A2111F;
	Tue, 17 Dec 2024 07:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734420267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6kn7JCWZl5RLmudvDIFBWEKRDhXnYmSObxg9glTzhE=;
	b=HcqyFVjocgJx2L3R8ppio7wEJwOBYatg7GWXKRFox0x9WtCY0gVsjqg4NDE3sbsEu6A2HN
	9mdBjdbUC96f1lfz2GpZz0HK7v3M3Ai2oNS3mGPQ8QHl45XbFm/gBCPxKC98v+p7mRm4l+
	bOiErn0bpXPJVlz7x8Tmi1kGvFw8QZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734420267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6kn7JCWZl5RLmudvDIFBWEKRDhXnYmSObxg9glTzhE=;
	b=GKvJBTI1iqBMD+TGxMtuXCy38FEqMdu0sqEtEmSfwbb3F8+jY+P/pBO6naMhuOPhBb+83R
	nI9NSCPwgSMTlrCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734420266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6kn7JCWZl5RLmudvDIFBWEKRDhXnYmSObxg9glTzhE=;
	b=SaJTCfECKGs5LMKAzq4J2BwsS782kQVSOidh1WvvR4ayKHIn+3yyirHqD/65aWkKS9jrg1
	sS+MuDobR4rmgkdp1yko7EiSK9wtJcnsEfWdr72RLiqVXLphIEEBcFXa/d9FY+CZeGpbY+
	D/tC7xXPONGHqCj15LeVef9cmxmJ/lg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734420266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6kn7JCWZl5RLmudvDIFBWEKRDhXnYmSObxg9glTzhE=;
	b=HYFaShUuGV2Qv/pFmAbT7AP7c24ZdMBNA9nPNfhpV3Beide9PPGCzerTPb0lVk2ETpgLaJ
	uwv8/9b/6SWOCOAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE17113A3C;
	Tue, 17 Dec 2024 07:24:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qylsLConYWcpCAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Dec 2024 07:24:26 +0000
Message-ID: <f5728396-7927-452a-9b39-6eda994485e2@suse.de>
Date: Tue, 17 Dec 2024 08:24:26 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: Remove accesses to page->index
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
References: <20241216160849.31739-1-willy@infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241216160849.31739-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,infradead.org:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 12/16/24 17:08, Matthew Wilcox (Oracle) wrote:
> Use page->private to store the index instead of page->index.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   drivers/block/null_blk/main.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 3c3d8d200abb..825b738119cb 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -899,7 +899,7 @@ static struct nullb_page *null_radix_tree_insert(struct nullb *nullb, u64 idx,
>   	if (radix_tree_insert(root, idx, t_page)) {
>   		null_free_page(t_page);
>   		t_page = radix_tree_lookup(root, idx);
> -		WARN_ON(!t_page || t_page->page->index != idx);
> +		WARN_ON(!t_page || t_page->page->private != idx);
>   	} else if (is_cache)
>   		nullb->dev->curr_cache += PAGE_SIZE;
>   
> @@ -922,7 +922,7 @@ static void null_free_device_storage(struct nullb_device *dev, bool is_cache)
>   				(void **)t_pages, pos, FREE_BATCH);
>   
>   		for (i = 0; i < nr_pages; i++) {
> -			pos = t_pages[i]->page->index;
> +			pos = t_pages[i]->page->private;
>   			ret = radix_tree_delete_item(root, pos, t_pages[i]);
>   			WARN_ON(ret != t_pages[i]);
>   			null_free_page(ret);
> @@ -948,7 +948,7 @@ static struct nullb_page *__null_lookup_page(struct nullb *nullb,
>   
>   	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
>   	t_page = radix_tree_lookup(root, idx);
> -	WARN_ON(t_page && t_page->page->index != idx);
> +	WARN_ON(t_page && t_page->page->private != idx);
>   
>   	if (t_page && (for_write || test_bit(sector_bit, t_page->bitmap)))
>   		return t_page;
> @@ -991,7 +991,7 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
>   
>   	spin_lock_irq(&nullb->lock);
>   	idx = sector >> PAGE_SECTORS_SHIFT;
> -	t_page->page->index = idx;
> +	t_page->page->private = idx;
>   	t_page = null_radix_tree_insert(nullb, idx, t_page, !ignore_cache);
>   	radix_tree_preload_end();
>   
> @@ -1011,7 +1011,7 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
>   	struct nullb_page *t_page, *ret;
>   	void *dst, *src;
>   
> -	idx = c_page->page->index;
> +	idx = c_page->page->private;
>   
>   	t_page = null_insert_page(nullb, idx << PAGE_SECTORS_SHIFT, true);
>   
> @@ -1070,7 +1070,7 @@ static int null_make_cache_space(struct nullb *nullb, unsigned long n)
>   	 * avoid race, we don't allow page free
>   	 */
>   	for (i = 0; i < nr_pages; i++) {
> -		nullb->cache_flush_pos = c_pages[i]->page->index;
> +		nullb->cache_flush_pos = c_pages[i]->page->private;
>   		/*
>   		 * We found the page which is being flushed to disk by other
>   		 * threads
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
