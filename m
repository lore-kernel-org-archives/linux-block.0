Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790362;
	b=SIK2REXyksYDx9BL9TWqb4eEjtnCM/0CiYEh1Q3NKAPODb3GbmgcoU0Y85+B/KTE0sea
	 vJPhGiSnfhL6YEutiBuAvbgje5QBCnKcWrBh+C79N5TLuUlwIS2juduHOV2PUxmCP2PDE
	 0jRsruClyTeqHWW6Ur7MlfqtN/k9qASjkDCqi4y2/1HhPWhX53UFyC1f13W+4AQTf6Bge
	 m1IFrezgT0nxQyFIFYb8+G5NbloCmypE/PkshGxmxClGsa8o9sTtwK2eNTdjukZw5yeyu
	 O+uSINPXf0s+mpBhdC8HZhEtaecHPHnglIdYRj8aLmsEh3n3zPlVWR5Wzb1Yt/IF5mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790362;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=SYlHs8Nv7Z8RF8bQnhdE9EHsHWgPRLraOMWrOS12HEE=;
	b=ttuykFtUjeGrEKnvBq5ZWJ6a4D2wz0CfxpF6QnIXJgUwjTKH8NFIKl+BXnGg0xNEVTN6
	 Zqw4ZJf8ZFb34by/wl28zgkc1zgszO+bO+91clJbQy4N1NDe6R/PRVWUrmBguxT0wU7//
	 hXd7b3OWhP0qrEtHZndc4caEPErpTis9cuo/BNvyFHZ4rDUpgxWJKxDpE4QSy6KvQ+H+8
	 E51WSd/ebvDUyeqmLZlcK7xH3hxnRmp/q7r2l+70REP2XcNbZ2kKEELM3rVaQ23BtNIe0
	 RV/+Q6bopG1a2ycKQFc7rk9lm3VOT87Uc1vX8dLmRC4VoUZ1Mpqrw446F+ukUHTf3JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=VKZ2y8TL;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ru5sHkWd;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=AgrmKHEW;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cLVNsPqV;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A5C606A86F;
	Fri, 27 Nov 2026 14:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4A5C606A86F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=VKZ2y8TL;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ru5sHkWd;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=AgrmKHEW;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cLVNsPqV
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF787229A6;
	Fri, 27 Nov 2026 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795790360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SYlHs8Nv7Z8RF8bQnhdE9EHsHWgPRLraOMWrOS12HEE=;
	b=VKZ2y8TLdNbcG9jkSSrh77gTAUw31/gkqWqHa8PQnHxP1g60+tBWlSOsCWYz4ZCeU/1Z3f
	528x+Pj5QZ7H0K+et7jKMHGtk0VjG34S3vjnbCskn63fi19w0ElxaGgU99maK5boOyhX1E
	sjckOwBUiag6hjc85cnobJ297UN0zRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795790360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SYlHs8Nv7Z8RF8bQnhdE9EHsHWgPRLraOMWrOS12HEE=;
	b=Ru5sHkWd6RysQtT2XX+hx1W4oiGdr+yTI+Ku6WG+fZVhO8xePUuEC8acHjgdf+AAomeCaI
	hv2iFHZGz/DIQbDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AgrmKHEW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cLVNsPqV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795790359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SYlHs8Nv7Z8RF8bQnhdE9EHsHWgPRLraOMWrOS12HEE=;
	b=AgrmKHEWLvzbe79xh/L2Tfs3t/WH24xoUgCSSi8gFqeZ/rlFrURk00IDTGjWEu9afenVry
	1s26Esim4AAl7r48kNjDDFbjdb/IQ05jr+ji91OJndd6YAsYPnUZJjF3WK6KzFCHC4o4Bv
	ZgIcZ8ZxfEPsYazx6I/WfzwXszj8m80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795790359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SYlHs8Nv7Z8RF8bQnhdE9EHsHWgPRLraOMWrOS12HEE=;
	b=cLVNsPqVZgKv4iRerH6vV6ARvIUv8JU3NJjNObkybOmRBt4kNrcqkXZCrkxdrNYy/0Gqr4
	RPIREk91nb5nclAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A860B13432;
	Fri, 27 Nov 2026 14:39:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id APQhIReWCWuzXQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Nov 2026 14:39:19 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 3C95951054; Fri, 27 Nov 2026 15:39:19 +0100 (CET)
Date: Fri, 27 Nov 2026 15:39:19 +0100
From: Jan Kara <jack@suse.cz>
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] block/partitions: lock the mapping while reading a
 partition sector
Message-ID: <hnlbum2fxqy7fztaxepiedgxc6jxb65r6avascrtq5qvfqsflq@fezcrhv4cmq5>
References: <20261127074500.89094-1-zhaogongyi@bytedance.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127074500.89094-1-zhaogongyi@bytedance.com>
X-Rspamd-Queue-Id: DF787229A6
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -13.01

On Fri 27-11-26 15:45:00, Zhao Gongyi wrote:
> A concurrent BLKBSZSET and BLKRRPART reproducer reports
> "Unable to handle kernel NULL pointer dereference" in
> create_empty_buffers(). The relevant call trace is:
> 
>   create_empty_buffers
>   block_read_full_folio
>   blkdev_read_folio
>   read_cache_folio
>   read_part_sector
>   msdos_partition
> 
> read_part_sector() calls read_mapping_folio() without the mapping's
> invalidate_lock. The race can allocate a folio at the old minimum order
> and then create buffer heads using the new block size. When the folio is
> smaller than the block size, create_empty_buffers() dereferences NULL.
> 
> Hold the shared invalidate_lock across the read, pairing with the
> exclusive lock in set_blocksize().
> 
> Fixes: 3c20917120ce ("block/bdev: enable large folio support for large logical block sizes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>

Looks sensible. The partition rereading code tends to get called from
unexpected places at times so I was pondering for a while whether it
doesn't get called in a context where we could not grab invalidate_lock but
I didn't find anything. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Testing (arm64 QEMU/KVM, GCC 8.3, KASAN/KCOV/UBSAN disabled):
>   Unpatched: the reproducer triggered a NULL dereference in
>   create_empty_buffers() in 3/3 runs.
>   Patched: no crash in 5/5 runs with the same reproducer.
> 
>  block/partitions/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index b5c59b79ca7cb..a36eeb235d5e0 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -721,7 +721,9 @@ void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
>  		goto out;
>  	}
>  
> +	filemap_invalidate_lock_shared(mapping);
>  	folio = read_mapping_folio(mapping, n >> PAGE_SECTORS_SHIFT, NULL);
> +	filemap_invalidate_unlock_shared(mapping);
>  	if (IS_ERR(folio))
>  		goto out;
>  
> 
> base-commit: 5a29cfaf51105039d156dd8a61d2783e8b653667
> -- 
> 2.39.5 (Apple Git-154)
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
