Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E8164A9F
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457840; cv=none; b=Opy4LN3Z8xP/miRJ0a33JDodLQBbUxOZGxP5P7vdFCf4kGU+I0XoF/b4ouSsNdvpvirOeI4GGhNEEB164eyrN/wdc1CcG49SWIG6T1acta5QorFznNFjp93hLCSwSAk+8g3k49o/gu/tozW4+02sBODbXpt29yqqzOq5cupBKp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457840; c=relaxed/simple;
	bh=X4Sn+Ji5RYTTBmrJEvr5G7vX/WA6/h2K6W5uumloRcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aep6vyPjfKSuOKFds2D7sg21y2cKCaVRwK0BjvJLPrnivmlJgZBT4Azw3V712flsE1dhFQDGgoORFfePDdFVg9w+ODY5YhiqoajgeeXtu/WBgJwp8C3KSzeYjmQgKusifZVzIQqOpcQ7lpIeZP6SRYdPAJR0oZVf49WR0fGwb3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lmY3QUjQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SJxB7YAX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lmY3QUjQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SJxB7YAX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lmY3QUjQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SJxB7YAX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lmY3QUjQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SJxB7YAX"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2086D37BFB;
	Tue, 26 Mar 2024 12:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711457836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Y324XKHx8TmrRge2LPwQsMuxtlSPgulhco40KkeEh4=;
	b=lmY3QUjQloAHPeR86ssextfLZ6qKa4Y/AFw8pndg/V7FDnnvKF8iGJh1ORVvZYu0la3jiK
	E7FdlTxJcQPt98tR7ers+IMrxW5JU9KrwtBLDn65BTUVJZAsjJNZpQKtRWdCevAZoytexX
	lIScPiHVM+hZGxA07v1SkJvJuT39BbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711457836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Y324XKHx8TmrRge2LPwQsMuxtlSPgulhco40KkeEh4=;
	b=SJxB7YAXV4g72DFei5/9U+95Bu402U1jNrWHlxqa6fg+SMXK7RS4dte3Ox8P6YZo1IQhlq
	plVaZgdm5qYz/6AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711457836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Y324XKHx8TmrRge2LPwQsMuxtlSPgulhco40KkeEh4=;
	b=lmY3QUjQloAHPeR86ssextfLZ6qKa4Y/AFw8pndg/V7FDnnvKF8iGJh1ORVvZYu0la3jiK
	E7FdlTxJcQPt98tR7ers+IMrxW5JU9KrwtBLDn65BTUVJZAsjJNZpQKtRWdCevAZoytexX
	lIScPiHVM+hZGxA07v1SkJvJuT39BbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711457836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Y324XKHx8TmrRge2LPwQsMuxtlSPgulhco40KkeEh4=;
	b=SJxB7YAXV4g72DFei5/9U+95Bu402U1jNrWHlxqa6fg+SMXK7RS4dte3Ox8P6YZo1IQhlq
	plVaZgdm5qYz/6AA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 12C0113215;
	Tue, 26 Mar 2024 12:57:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id kOWOBCzGAmaAMgAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 26 Mar 2024 12:57:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B5B96A0812; Tue, 26 Mar 2024 13:57:15 +0100 (CET)
Date: Tue, 26 Mar 2024 13:57:15 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
Message-ID: <20240326125715.i23eo6sh5223tdmc@quack3>
References: <20240323-seide-erbrachten-5c60873fadc1@brauner>
 <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lmY3QUjQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SJxB7YAX
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 2086D37BFB
X-Spam-Flag: NO

On Sat 23-03-24 17:11:19, Christian Brauner wrote:
> Last kernel release we introduce CONFIG_BLK_DEV_WRITE_MOUNTED. By
> default this option is set. When it is set the long-standing behavior
> of being able to write to mounted block devices is enabled.
> 
> But in order to guard against unintended corruption by writing to the
> block device buffer cache CONFIG_BLK_DEV_WRITE_MOUNTED can be turned
> off. In that case it isn't possible to write to mounted block devices
> anymore.
> 
> A filesystem may open its block devices with BLK_OPEN_RESTRICT_WRITES
> which disallows concurrent BLK_OPEN_WRITE access. When we still had the
> bdev handle around we could recognize BLK_OPEN_RESTRICT_WRITES because
> the mode was passed around. Since we managed to get rid of the bdev
> handle we changed that logic to recognize BLK_OPEN_RESTRICT_WRITES based
> on whether the file was opened writable and writes to that block device
> are blocked. That logic doesn't work because we do allow
> BLK_OPEN_RESTRICT_WRITES to be specified without BLK_OPEN_WRITE.
> 
> So fix the detection logic. Use O_EXCL as an indicator that
> BLK_OPEN_RESTRICT_WRITES has been requested. We do the exact same thing
> for pidfds where O_EXCL means that this is a pidfd that refers to a
> thread. For userspace open paths O_EXCL will never be retained but for
> internal opens where we open files that are never installed into a file
> descriptor table this is fine.
> 
> Note that BLK_OPEN_RESTRICT_WRITES is an internal only flag that cannot
> directly be raised by userspace. It is implicitly raised during
> mounting.
> 
> Passes xftests and blktests with CONFIG_BLK_DEV_WRITE_MOUNTED set and
> unset.
> 
> Fixes: 321de651fa56 ("block: don't rely on BLK_OPEN_RESTRICT_WRITES when yielding write access")
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Link: https://lore.kernel.org/r/ZfyyEwu9Uq5Pgb94@casper.infradead.org
> Signed-off-by: Christian Brauner <brauner@kernel.org>

The fix looks correct but admittedly it looks a bit hacky. I'd prefer
storing the needed information in some other flag, preferably one that does
not already have a special meaning with block devices. But FMODE_ space is
exhausted and don't see another easy solution. So I guess:

Reviewed-by: Jan Kara <jack@suse.cz>

Thanks for looking into this!

								Honza

> ---
>  block/bdev.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 7a5f611c3d2e..f819f3086905 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -821,13 +821,12 @@ static void bdev_yield_write_access(struct file *bdev_file)
>  		return;
>  
>  	bdev = file_bdev(bdev_file);
> -	/* Yield exclusive or shared write access. */
> -	if (bdev_file->f_mode & FMODE_WRITE) {
> -		if (bdev_writes_blocked(bdev))
> -			bdev_unblock_writes(bdev);
> -		else
> -			bdev->bd_writers--;
> -	}
> +
> +	/* O_EXCL is only set for internal BLK_OPEN_RESTRICT_WRITES. */
> +	if (bdev_file->f_flags & O_EXCL)
> +		bdev_unblock_writes(bdev);
> +	else if (bdev_file->f_mode & FMODE_WRITE)
> +		bdev->bd_writers--;
>  }
>  
>  /**
> @@ -946,6 +945,13 @@ static unsigned blk_to_file_flags(blk_mode_t mode)
>  	else
>  		WARN_ON_ONCE(true);
>  
> +	/*
> +	 * BLK_OPEN_RESTRICT_WRITES is never set from userspace and
> +	 * O_EXCL is stripped from userspace.
> +	 */
> +	if (mode & BLK_OPEN_RESTRICT_WRITES)
> +		flags |= O_EXCL;
> +
>  	if (mode & BLK_OPEN_NDELAY)
>  		flags |= O_NDELAY;
>  
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
