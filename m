Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A52B372ECA;
	Mon, 12 Oct 2026 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799538; cv=none; b=D4K+SfqZrNINr6ssw/CxgIJu/C4jahDyBoFcJ8cyyZUJqZP8Xq6TyvP/HvhKqkNLbn2+1enbFzoChsOYdK8/7bDDhxOoBalpGQDgD3CBBODITGepWfm4KHi8OFOPLEwwwiCrENCF4aDTJyBatC4xBNN4YhHUx3k9J2++PX/8pCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799538; c=relaxed/simple;
	bh=wbf/unsUpddvcemFJWU2NI1acSCN6KRJR1ye7ZGjUDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c339w3Uj10EP0PH4Ryq7UI0EdXa44BKM3WWuR4NTDFJp4O892wPyEfDIkUkskbTJl60q99kYFhZsDaYxjBfXbL4yWJ1y0BU9tHA8tEwPuLfSO4egP9fvRvShgS6MrUF9SKfVrg0ATWoBgaGaKA4M4bupNoV5Q37A6nS/uSqTKjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r1q0whWV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oDfm5WoF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r1q0whWV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oDfm5WoF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r1q0whWV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oDfm5WoF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r1q0whWV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oDfm5WoF"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A5E41F76C;
	Mon, 12 Oct 2026 10:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791799534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I87OenGAaFJnkdPMc0Xbllbvz4ou1kPWUAGZPj9a3zA=;
	b=r1q0whWVMl8ij6FoM8TFSzQ29tEvBKGilCKDf2s7GKOQBH9ojsmgGW8fEnGafxn0G7oegd
	30Hkz3oe6lchrA7DnSGyz/goTqes+dhSABldmeAEutxExa+BY1j2GCw74hh7hYzPfFLfGK
	XZXq+ndDB6c0DMYA5ujyrRQIBkdyBo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791799534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I87OenGAaFJnkdPMc0Xbllbvz4ou1kPWUAGZPj9a3zA=;
	b=oDfm5WoFEyBhtLQb32f150ZS2FgTd3I4sGkIipKcBQeMshmC0V8JitB6yhcWDoUvztrrCh
	HCC2ymsTaMsB8rBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791799534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I87OenGAaFJnkdPMc0Xbllbvz4ou1kPWUAGZPj9a3zA=;
	b=r1q0whWVMl8ij6FoM8TFSzQ29tEvBKGilCKDf2s7GKOQBH9ojsmgGW8fEnGafxn0G7oegd
	30Hkz3oe6lchrA7DnSGyz/goTqes+dhSABldmeAEutxExa+BY1j2GCw74hh7hYzPfFLfGK
	XZXq+ndDB6c0DMYA5ujyrRQIBkdyBo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791799534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I87OenGAaFJnkdPMc0Xbllbvz4ou1kPWUAGZPj9a3zA=;
	b=oDfm5WoFEyBhtLQb32f150ZS2FgTd3I4sGkIipKcBQeMshmC0V8JitB6yhcWDoUvztrrCh
	HCC2ymsTaMsB8rBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11D4C13314;
	Mon, 12 Oct 2026 10:05:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bq/KOe2wzGphEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 Oct 2026 10:05:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9F8BFA1403; Mon, 12 Oct 2026 12:05:33 +0200 (CEST)
Date: Mon, 12 Oct 2026 12:05:33 +0200
From: Jan Kara <jack@suse.cz>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+e0624b5bf72b99131402@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/filemap: mark lockless accesses to mapping->nrpages
Message-ID: <u6yseen7xlqfudkps37rizde44u4yhfiqsoe4vvse734fsgrg4@mdfdypi2xgd6>
References: <20261011112940.455497-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011112940.455497-1-ngocthang2710.1999@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[e0624b5bf72b99131402];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Sun 11-10-26 18:29:40, Nguyen Ngoc Thang wrote:
> mapping->nrpages is updated under the i_pages lock but is read locklessly
> as a cheap "anything cached?" hint, e.g. in invalidate_bdev() and
> mapping_needs_writeback(). KCSAN reports the race:
> 
>   BUG: KCSAN: data-race in __filemap_add_folio / invalidate_bdev
> 
>   read-write to 0xffff8881004c4178 of 8 bytes by task 3600 on cpu 0:
>    __filemap_add_folio+0x6b7/0x910 mm/filemap.c:919
>    filemap_add_folio+0x1cd/0x380
>    page_cache_ra_unbounded+0x1a4/0x3a0
>    ...
>    blkdev_read_iter+0x21e/0x2d0
>   read to 0xffff8881004c4178 of 8 bytes by task 3601 on cpu 1:
>    invalidate_bdev+0x25/0x70 block/bdev.c:98
>    ext4_fill_super+0x2ccb/0x37b0
> 
> The same counter also races with filemap_write_and_wait_range() through
> mapping_needs_writeback().
> 
> The race is benign: a stale value only makes the caller do or skip a
> harmless invalidate/flush pass. Annotate the readers with READ_ONCE() and
> the writers in filemap with WRITE_ONCE().
> 
> Reported-by: syzbot+e0624b5bf72b99131402@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e0624b5bf72b99131402
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

I think in this case the proper fix is to annotate the problematic read
with data_race() to silence the checker. As you mentioned there's no real
bug to fix so no reason to convolute the code with READ_ONCE() and
WRITE_ONCE().

								Honza

> ---
>  block/bdev.c | 2 +-
>  mm/filemap.c | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index cd8323083740..d97071160e86 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -95,7 +95,7 @@ void invalidate_bdev(struct block_device *bdev)
>  {
>  	struct address_space *mapping = bdev->bd_mapping;
>  
> -	if (mapping->nrpages) {
> +	if (READ_ONCE(mapping->nrpages)) {
>  		invalidate_bh_lrus();
>  		lru_add_drain_all();	/* make sure all lru add caches are flushed */
>  		invalidate_mapping_pages(mapping, 0, -1);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 00fd89cf6f55..007fe10b2e1d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -144,7 +144,7 @@ static void page_cache_delete(struct address_space *mapping,
>  
>  	folio->mapping = NULL;
>  	/* Leave folio->index set: truncation lookup relies upon it */
> -	mapping->nrpages -= nr;
> +	WRITE_ONCE(mapping->nrpages, mapping->nrpages - nr);
>  }
>  
>  static void filemap_unaccount_folio(struct address_space *mapping,
> @@ -314,7 +314,7 @@ static void page_cache_delete_batch(struct address_space *mapping,
>  		xas_store(&xas, NULL);
>  		total_pages += folio_nr_pages(folio);
>  	}
> -	mapping->nrpages -= total_pages;
> +	WRITE_ONCE(mapping->nrpages, mapping->nrpages - total_pages);
>  }
>  
>  void delete_from_page_cache_batch(struct address_space *mapping,
> @@ -631,7 +631,7 @@ EXPORT_SYMBOL(filemap_fdatawait_keep_errors);
>  /* Returns true if writeback might be needed or already in progress. */
>  static bool mapping_needs_writeback(struct address_space *mapping)
>  {
> -	return mapping->nrpages;
> +	return READ_ONCE(mapping->nrpages);
>  }
>  
>  bool filemap_range_has_writeback(struct address_space *mapping,
> @@ -916,7 +916,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>  		if (xas_error(&xas))
>  			goto unlock;
>  
> -		mapping->nrpages += nr;
> +		WRITE_ONCE(mapping->nrpages, mapping->nrpages + nr);
>  
>  		/* hugetlb pages do not participate in page cache accounting */
>  		if (!huge) {
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
