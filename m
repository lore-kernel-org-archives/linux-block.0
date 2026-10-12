Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B3149BD82;
	Mon, 12 Oct 2026 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822291; cv=none; b=jrvFxJzDasS3y9KJyG1a/0/a+C1mjzIo4WyZzbv9edb2qhEKL3Zyxk+XHPLbBv4PIfQuteh/llerT9UbzfriB7z1qhJEndsZb+1OBV6iC7C/eu61jZuj4l8loBhFnw5jAilmECU37IhoeIXC7sjyAhZzeJt6kzhU2bxafRBspxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822291; c=relaxed/simple;
	bh=hza5XxPJ98qufWEqHPknPSz39nXV8UYj++KJEJKTnns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIQCWJ/yUM+tyteo1LfzDDVdlf0Zok3qLieSLBfxcyA2q/6w89QjrPIUPKx8PrkZD1IORTHOEGaUVbgYXEFNR0b8SFHqfUetY1Sz0jXXop0vR5uUGzfYp28G5xPnh45eCTv+Tfl83VEd9b//xJy9l1HlXRhLE252yD4whuly418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QJ4RfaWF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pgnCnEIV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l+WQ+Eks; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lgbjzvSb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QJ4RfaWF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pgnCnEIV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l+WQ+Eks";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lgbjzvSb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 994ED1F391;
	Mon, 12 Oct 2026 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791822287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pcc0K1tU8VYaYGCB04LjAl4+hE6yspZu5PMHTGHHbVA=;
	b=QJ4RfaWFbTqSr18K2OQ4jQfAV5YHEJQyOQavvQJqWF8xTF9Iuv5UIjUUvRcXM/ZF8et/+q
	JZGRRBwUqS/9elC1XFKQ1zUCcTZnyy5YdHCQVNqpqHz0f/MTxmubKHJ3urpOYY40MQkeKG
	f8Zi5GqB+/7FIgNrlGefXA/o+vriefY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791822287;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pcc0K1tU8VYaYGCB04LjAl4+hE6yspZu5PMHTGHHbVA=;
	b=pgnCnEIVoIrGIyZEWolk7/SSq4ugBo1wuT53iEY96I5vlnn0hHDEVeNLa8CELElQw54hHu
	BxO6cjmoxvn0HlCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791822286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pcc0K1tU8VYaYGCB04LjAl4+hE6yspZu5PMHTGHHbVA=;
	b=l+WQ+EksmllPpEJlz3vP+B7DDfM98YIBgILa/yhS6DwJjhQhzwbGE6YZS/5NJC+JKBj3aJ
	uMoU7mMksZuYcUrAYiyyUB8JxqsTtJo6R4XFlVn1AP9qajRNYHdSYPqaQQ+5tbdHQsngxw
	L0VQYi6+ORuERDJB/EpYfxtobPYFU+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791822286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pcc0K1tU8VYaYGCB04LjAl4+hE6yspZu5PMHTGHHbVA=;
	b=lgbjzvSbuT2abpAcooVITaYyY4upHIm4g2YMifYz64YXqKhwu7S42phkFxS3UZWqlKuZ5V
	k8rXKzdHjCuzjJDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FA2F13314;
	Mon, 12 Oct 2026 16:24:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gSNCE84JzWrJOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 Oct 2026 16:24:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F0405A1405; Mon, 12 Oct 2026 18:24:45 +0200 (CEST)
Date: Mon, 12 Oct 2026 18:24:45 +0200
From: Jan Kara <jack@suse.cz>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+e0624b5bf72b99131402@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] mm/filemap: annotate lockless reads of
 mapping->nrpages
Message-ID: <lp3734pwy5uxmjyblon4m4fij2pngztite3plyc5urhfje6t7v@pju2csdvtjmy>
References: <20261012143921.283806-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012143921.283806-1-ngocthang2710.1999@gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,appspotmail.com:email]

On Mon 12-10-26 21:39:21, Nguyen Ngoc Thang wrote:
> mapping->nrpages is updated under the i_pages lock but is read locklessly
> as a cheap "anything cached?" hint, e.g. in invalidate_bdev() and
> filemap_write_and_wait_range(). KCSAN reports the race:
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
> harmless invalidate/flush pass. Mark the lockless reads with data_race()
> in invalidate_bdev() and in the two callers of mapping_needs_writeback(),
> rather than inside the helper, so a future user needing a reliable answer
> is not silently covered.
> 
> Reported-by: syzbot+e0624b5bf72b99131402@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e0624b5bf72b99131402
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v3: move data_race() from mapping_needs_writeback() to its two callers (Jan)
> v2: use data_race() on the readers instead of READ_ONCE()/WRITE_ONCE() (Jan)
> 
>  block/bdev.c | 3 ++-
>  mm/filemap.c | 6 ++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index cd8323083740..233750f87e6d 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -95,7 +95,8 @@ void invalidate_bdev(struct block_device *bdev)
>  {
>  	struct address_space *mapping = bdev->bd_mapping;
>  
> -	if (mapping->nrpages) {
> +	/* Lockless hint; a stale value only costs or skips a harmless pass */
> +	if (data_race(mapping->nrpages)) {
>  		invalidate_bh_lrus();
>  		lru_add_drain_all();	/* make sure all lru add caches are flushed */
>  		invalidate_mapping_pages(mapping, 0, -1);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 00fd89cf6f55..ff10ac8f56b3 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -680,7 +680,8 @@ int filemap_write_and_wait_range(struct address_space *mapping,
>  	if (lend < lstart)
>  		return 0;
>  
> -	if (mapping_needs_writeback(mapping)) {
> +	/* Lockless hint; a stale value is harmless */
> +	if (data_race(mapping_needs_writeback(mapping))) {
>  		err = filemap_fdatawrite_range(mapping, lstart, lend);
>  		/*
>  		 * Even if the above returned error, the pages may be
> @@ -782,7 +783,8 @@ int file_write_and_wait_range(struct file *file, loff_t lstart, loff_t lend)
>  	if (lend < lstart)
>  		return 0;
>  
> -	if (mapping_needs_writeback(mapping)) {
> +	/* Lockless hint; a stale value is harmless */
> +	if (data_race(mapping_needs_writeback(mapping))) {
>  		err = filemap_fdatawrite_range(mapping, lstart, lend);
>  		/* See comment of filemap_write_and_wait() */
>  		if (err != -EIO)
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
