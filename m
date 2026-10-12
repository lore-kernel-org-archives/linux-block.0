Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD19488231;
	Mon, 12 Oct 2026 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814288; cv=none; b=Kc06ALBPtZAmEagxnRuGYQe1iYOj/fW/uGxKxWolMleZpnJ/532FIUrPLYl+3IhQ11fQCCY/Bta1sPwUmiW51QQ4OxHL2Ei2hxNWPMfJeY3oWCK8hInzIuirnVmjyrrDrwvLmqkYzQggtC7gBYUJMlvUGfjLIe2PaHwX3Dfckkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814288; c=relaxed/simple;
	bh=O/sYz3hEDtYzWeOz8YVEvIUVPQJcn4FymHOI0/mQ3Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTH3tqi0P7XffYd6TNafWZrKroflepXKi0XG8FMnrYyJexbrkcaoDJEpzzQJg3EDx1j7NNMZi/Jn+fs/bf5qdPCvEIMEWjflB1LrSUOGYI3P26FOsnT/WErI9kTGjN1gPdV1VhvENMo5Px1VJMqL+6b2gOgDEXx8QbISJlDbIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q/ItDqlP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LRIAU1qp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q/ItDqlP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LRIAU1qp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q/ItDqlP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LRIAU1qp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q/ItDqlP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LRIAU1qp"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F38631F38C;
	Mon, 12 Oct 2026 14:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791814284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPswPjxS+qpu6i6zUA1Kx2e7xk6K1phiFUxlGK+8LzY=;
	b=Q/ItDqlP4+w6WAkwfX1k0X6ujm7G5QavPCe48S224sz6BsucbPMJNtLmPOqv7Iw1sey5dp
	HztsPyQnoX2GdkoGZJjnTzxEzFj1wb6Q9Ul4k04zOj38m0UWtk/PDuaFk9ML5xEJUxkqxc
	qXo4ZqYGAGyU1KkQ1CnYcNqJ7pdJz+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791814284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPswPjxS+qpu6i6zUA1Kx2e7xk6K1phiFUxlGK+8LzY=;
	b=LRIAU1qpo+jKKhvV0DnAfTof5Tws0j22vsCLRZkQC8mjOBkp6Z2hipd8JsI89ugai94uMv
	zISIs3YOUTzdbABQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Q/ItDqlP";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LRIAU1qp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791814284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPswPjxS+qpu6i6zUA1Kx2e7xk6K1phiFUxlGK+8LzY=;
	b=Q/ItDqlP4+w6WAkwfX1k0X6ujm7G5QavPCe48S224sz6BsucbPMJNtLmPOqv7Iw1sey5dp
	HztsPyQnoX2GdkoGZJjnTzxEzFj1wb6Q9Ul4k04zOj38m0UWtk/PDuaFk9ML5xEJUxkqxc
	qXo4ZqYGAGyU1KkQ1CnYcNqJ7pdJz+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791814284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPswPjxS+qpu6i6zUA1Kx2e7xk6K1phiFUxlGK+8LzY=;
	b=LRIAU1qpo+jKKhvV0DnAfTof5Tws0j22vsCLRZkQC8mjOBkp6Z2hipd8JsI89ugai94uMv
	zISIs3YOUTzdbABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA4DB13314;
	Mon, 12 Oct 2026 14:11:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mJoYKYvqzGrFHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 Oct 2026 14:11:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 55267A1407; Mon, 12 Oct 2026 16:11:23 +0200 (CEST)
Date: Mon, 12 Oct 2026 16:11:23 +0200
From: Jan Kara <jack@suse.cz>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: axboe@kernel.dk, willy@infradead.org, jack@suse.cz, 
	akpm@linux-foundation.org, linux-block@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+e0624b5bf72b99131402@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] mm/filemap: annotate lockless reads of
 mapping->nrpages
Message-ID: <zzneb5ezerl2353crj7xzivjbpdv5vgvqqvxkbvg77nwhdmldn@fenjftsskl34>
References: <20261012120636.16106-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012120636.16106-1-ngocthang2710.1999@gmail.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F38631F38C
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[e0624b5bf72b99131402];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,syzkaller.appspot.com:url,appspotmail.com:email,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Mon 12-10-26 19:06:36, Nguyen Ngoc Thang wrote:
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
> harmless invalidate/flush pass. Mark the two lockless readers with
> data_race().
> 
> Reported-by: syzbot+e0624b5bf72b99131402@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e0624b5bf72b99131402
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

...

> diff --git a/mm/filemap.c b/mm/filemap.c
> index 00fd89cf6f55..4c9d98efb7fb 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -631,7 +631,8 @@ EXPORT_SYMBOL(filemap_fdatawait_keep_errors);
>  /* Returns true if writeback might be needed or already in progress. */
>  static bool mapping_needs_writeback(struct address_space *mapping)
>  {
> -	return mapping->nrpages;
> +	/* Lockless hint; a stale value is harmless */
> +	return data_race(mapping->nrpages);
>  }

Rather than annotating inside mapping_needs_writeback() it would be more
future-proof to annotate the two callers of mapping_needs_writeback(). Just
in case some user which require reliable answer appears in the future...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
