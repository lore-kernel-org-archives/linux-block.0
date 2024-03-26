Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A34C5C61F
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459479; cv=none; b=tKTZOgwLVRHQneEUElssueIrm7vQP5ArMskN968Ge7Hpxhb1/b8th44PDsOAdlRydRiu6QJmqWRm0PsrR3ubW5VmtlfsMa/XzmyTZpio+xK2h4MCrV0AF61/FVLGrFlL0jBshC9gHXTH83tBQzYPxPTmjlIzMBDgXNbvgKbo7js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459479; c=relaxed/simple;
	bh=dF/r3AFgliGcQoxmew5Pble+N+nsgzOXl1hm73O9Uw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rj7X+ndlgQUVbtFdWnoNcE2KHINpUhO7Xdbl9PRgJHJpycKf2dZVAANfERORdBcEscAq1VUaLlgOu48ELytt6dq+VwCZdUCDxQ6slww94zjpXND1WkAbj+XhsVT2b8JFhiP5QtEN+qatMPoepmpaQNIi6nduNoa8bMFfMx6KGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M/wHscwu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nbAYhXzH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M/wHscwu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nbAYhXzH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M/wHscwu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nbAYhXzH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M/wHscwu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nbAYhXzH"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ABC5F37C05;
	Tue, 26 Mar 2024 13:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711459475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Tx+dRQuSj0/FbZD7XhKGt9mJFIClU6HJ9OxLCenixo=;
	b=M/wHscwuMVNXJo9QNz3rD/pvJdiCrSgh6b/pSsGKdUq75941E7BI3ufuNAuJqU37rhzcex
	/J/Kk4cJUDSXAIOjLTVENR8r3rNk8rziLUIgB683KJoqo3vMGNb+VGM/R7qonuykBuk6+D
	vVRbUE5Pjr1jsnKlhlD91e/oeWRzVDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711459475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Tx+dRQuSj0/FbZD7XhKGt9mJFIClU6HJ9OxLCenixo=;
	b=nbAYhXzH2WoBfy4w1eTVgd94ifyNT7honEWVNorTiJTDSHa0BqqiHXvWI5MsSRRlAV5Vn8
	GrT0v8B5CAaaBvDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711459475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Tx+dRQuSj0/FbZD7XhKGt9mJFIClU6HJ9OxLCenixo=;
	b=M/wHscwuMVNXJo9QNz3rD/pvJdiCrSgh6b/pSsGKdUq75941E7BI3ufuNAuJqU37rhzcex
	/J/Kk4cJUDSXAIOjLTVENR8r3rNk8rziLUIgB683KJoqo3vMGNb+VGM/R7qonuykBuk6+D
	vVRbUE5Pjr1jsnKlhlD91e/oeWRzVDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711459475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Tx+dRQuSj0/FbZD7XhKGt9mJFIClU6HJ9OxLCenixo=;
	b=nbAYhXzH2WoBfy4w1eTVgd94ifyNT7honEWVNorTiJTDSHa0BqqiHXvWI5MsSRRlAV5Vn8
	GrT0v8B5CAaaBvDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A0D2913587;
	Tue, 26 Mar 2024 13:24:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tzE+J5PMAmZ3OQAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 26 Mar 2024 13:24:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 45F9BA0812; Tue, 26 Mar 2024 14:24:35 +0100 (CET)
Date: Tue, 26 Mar 2024 14:24:35 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] [RFC]: block: count BLK_OPEN_RESTRICT_WRITES openers
Message-ID: <20240326132435.fy7dh5p6mhagohtw@quack3>
References: <20240323-seide-erbrachten-5c60873fadc1@brauner>
 <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
 <20240323-abtauchen-klauen-c2953810082d@brauner>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323-abtauchen-klauen-c2953810082d@brauner>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On Sat 23-03-24 17:11:20, Christian Brauner wrote:
> The original changes in v6.8 do allow for a block device to be reopened
> with BLK_OPEN_RESTRICT_WRITES provided the same holder is used as per
> bdev_may_open(). I think that may have a bug.
		   		^^^^^^^^ is :)
Also AFAICT this can happen only the the reopen is O_RDONLY which would be
probably good to mention here.

> The first opener @f1 of that block device will set bdev->bd_writers to
> -1. The second opener @f2 using the same holder will pass the check in
> bdev_may_open() that bdev->bd_writers must not be greater than zero.
> 
> The first opener @f1 now closes the block device and in bdev_release()
> will end up calling bdev_yield_write_access() which calls
> bdev_writes_blocked() and sets bdev->bd_writers to 0 again.
> 
> Now @f2 holds a file to that block device which was opened with
> exclusive write access but bdev->bd_writers has been reset to 0.
> 
> So now @f3 comes along and succeeds in opening the block device with
> BLK_OPEN_WRITE betraying @f2's request to have exclusive write access.
> 
> This isn't a practical issue yet because afaict there's no codepath
> inside the kernel that reopenes the same block device with
> BLK_OPEN_RESTRICT_WRITES but it will be if there is.
> 
> If that's right then fix this by counting the number of
> BLK_OPEN_RESTRICT_WRITES openers. So we only allow writes again once all
> BLK_OPEN_RESTRICT_WRITES openers are done.
> 
> Fixes: ed5cc702d311 ("block: Add config option to not allow writing to mounted devices")
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Otherwise looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bdev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index f819f3086905..42f84692404c 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -776,17 +776,17 @@ void blkdev_put_no_open(struct block_device *bdev)
>  
>  static bool bdev_writes_blocked(struct block_device *bdev)
>  {
> -	return bdev->bd_writers == -1;
> +	return bdev->bd_writers < 0;
>  }
>  
>  static void bdev_block_writes(struct block_device *bdev)
>  {
> -	bdev->bd_writers = -1;
> +	bdev->bd_writers--;
>  }
>  
>  static void bdev_unblock_writes(struct block_device *bdev)
>  {
> -	bdev->bd_writers = 0;
> +	bdev->bd_writers++;
>  }
>  
>  static bool bdev_may_open(struct block_device *bdev, blk_mode_t mode)
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
