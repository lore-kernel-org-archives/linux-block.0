Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAB421422F
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014783; cv=none; b=Va4AmYTnvTraNtAkgcPu6jv/1Zlk9gSYxE+gq67d4qZ9ULOsh3Kk7CVLFCZxy+SSzGkSOWmQuDZmnyqMSN+wmVkDvrARZ0t82w/W8vwt/SYe1tk/0rpzDaNgBN1OmzsAwhn/XZYCUs0akxO7idGd7VOBRRRZ2HqHqkywyok8N/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014783; c=relaxed/simple;
	bh=doLMSBHEdbxJSqg0aReirs2MorfbCN4H6JgIjggMx5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gah+aYrmsFHV6D3EbanRQWQcK08CEMpx9gL42AVtxH33ZQl3yl6rIBMM/opRwzZdRbXZ+JyJ7c2x/apm36N551qFFwGEbdF/G8Ey+ZHa2QlSed6+iCjq1JqY8YZYSpSRfbpTx+/AQDFlS9H+1Sqt1ROMzQ4C7tHNcfB59nglCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MM2IStl0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4ABTQyUG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MM2IStl0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4ABTQyUG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MM2IStl0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4ABTQyUG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MM2IStl0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4ABTQyUG"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 78C8821189;
	Mon,  3 Mar 2025 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741014779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hDyzg2ZIaSEL1bLHsWzXdQZzkglvcop85Oj47qtiMxQ=;
	b=MM2IStl0JxMvdBs4fsT4k7/XLzHBhsk4TM6MxZ2wKj+6vN59l2K4poBq3RNzKk0Ap6yej0
	wIR1WgDWPTsDFRIncZ58T9EXpV+uXNjaEOGkxFKU6F8umvjMVU0u8S1nx+pSjozKuWTwvi
	/zor9qeSS4ZIreLF5uG7h6PU2UlPOew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741014779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hDyzg2ZIaSEL1bLHsWzXdQZzkglvcop85Oj47qtiMxQ=;
	b=4ABTQyUGWQ/q9DfkBMOqap9mMumiGtd1QSow+kYYn6w8jbB+VmEurHQVtGFV4MFxjtbUnr
	9n+L8vLIj5IFG9Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MM2IStl0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4ABTQyUG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741014779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hDyzg2ZIaSEL1bLHsWzXdQZzkglvcop85Oj47qtiMxQ=;
	b=MM2IStl0JxMvdBs4fsT4k7/XLzHBhsk4TM6MxZ2wKj+6vN59l2K4poBq3RNzKk0Ap6yej0
	wIR1WgDWPTsDFRIncZ58T9EXpV+uXNjaEOGkxFKU6F8umvjMVU0u8S1nx+pSjozKuWTwvi
	/zor9qeSS4ZIreLF5uG7h6PU2UlPOew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741014779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hDyzg2ZIaSEL1bLHsWzXdQZzkglvcop85Oj47qtiMxQ=;
	b=4ABTQyUGWQ/q9DfkBMOqap9mMumiGtd1QSow+kYYn6w8jbB+VmEurHQVtGFV4MFxjtbUnr
	9n+L8vLIj5IFG9Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6595813A23;
	Mon,  3 Mar 2025 15:12:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QiB1GPvGxWcoCQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 03 Mar 2025 15:12:59 +0000
Message-ID: <4b3be2df-4d82-45d5-b2ec-b08b2625f9d6@suse.cz>
Date: Mon, 3 Mar 2025 16:12:59 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Hannes Reinecke <hare@suse.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org
References: <08c29e4b-2f71-4b6d-8046-27e407214d8c@suse.com>
 <509dd4d3-85e9-40b2-a967-8c937909a1bf@suse.com>
 <Z8W8OtJYFzr9OQac@casper.infradead.org>
 <Z8W_1l7lCFqMiwXV@casper.infradead.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <Z8W_1l7lCFqMiwXV@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 78C8821189
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 3/3/25 15:42, Matthew Wilcox wrote:
> On Mon, Mar 03, 2025 at 02:27:06PM +0000, Matthew Wilcox wrote:
>> We have a _lot_ of page types available.  We should mark large kmallocs
>> as such.  I'll send a patch to do that.
> 
> Can you try this?  It should fix the crash, at least.  Not sure why the
> frozen patch triggered it.

Having CONFIG_PAGE_OWNER and booting with page_owner=on could make the dump
more useful too, tell you where the dumped page was last allocated and freed.

In addition CONFIG_DEBUG_PAGEALLOC and booting with debug_pagealloc=on could
potentially catch a use-after-free sooner (if something accesses the page
via direct mapping after it's kfree()'d.

But if this is due to a tight race, it could also mask the bug etc.

> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 36d283552f80..df9234e5f478 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -925,14 +925,15 @@ FOLIO_FLAG_FALSE(has_hwpoisoned)
>  enum pagetype {
>  	/* 0x00-0x7f are positive numbers, ie mapcount */
>  	/* Reserve 0x80-0xef for mapcount overflow. */
> -	PGTY_buddy	= 0xf0,
> -	PGTY_offline	= 0xf1,
> -	PGTY_table	= 0xf2,
> -	PGTY_guard	= 0xf3,
> -	PGTY_hugetlb	= 0xf4,
> -	PGTY_slab	= 0xf5,
> -	PGTY_zsmalloc	= 0xf6,
> -	PGTY_unaccepted	= 0xf7,
> +	PGTY_buddy		= 0xf0,
> +	PGTY_offline		= 0xf1,
> +	PGTY_table		= 0xf2,
> +	PGTY_guard		= 0xf3,
> +	PGTY_hugetlb		= 0xf4,
> +	PGTY_slab		= 0xf5,
> +	PGTY_zsmalloc		= 0xf6,
> +	PGTY_unaccepted		= 0xf7,
> +	PGTY_large_kmalloc	= 0xf8,
>  
>  	PGTY_mapcount_underflow = 0xff
>  };
> @@ -1075,6 +1076,7 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
>   * Serialized with zone lock.
>   */
>  PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
> +FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
>  
>  /**
>   * PageHuge - Determine if the page belongs to hugetlbfs
> diff --git a/mm/slub.c b/mm/slub.c
> index 1f50129dcfb3..872e1bab3bd1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4241,6 +4241,7 @@ static void *___kmalloc_large_node(size_t size, gfp_t flags, int node)
>  		ptr = folio_address(folio);
>  		lruvec_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B,
>  				      PAGE_SIZE << order);
> +		__folio_set_large_kmalloc(folio);
>  	}
>  
>  	ptr = kasan_kmalloc_large(ptr, size, flags);
> @@ -4716,6 +4717,11 @@ static void free_large_kmalloc(struct folio *folio, void *object)
>  {
>  	unsigned int order = folio_order(folio);
>  
> +	if (WARN_ON_ONCE(!folio_test_large_kmalloc(folio))) {
> +		dump_page(&folio->page, "Not a kmalloc allocation");
> +		return;
> +	}
> +
>  	if (WARN_ON_ONCE(order == 0))
>  		pr_warn_once("object pointer: 0x%p\n", object);
>  
> @@ -4725,6 +4731,7 @@ static void free_large_kmalloc(struct folio *folio, void *object)
>  
>  	lruvec_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B,
>  			      -(PAGE_SIZE << order));
> +	__folio_clear_large_kmalloc(folio);
>  	folio_put(folio);
>  }
>  

