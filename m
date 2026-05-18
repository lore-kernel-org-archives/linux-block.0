Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8183FADFD
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106186; cv=none; b=MGxoVOKnONd8323beUpk+e4WfB37XPyMbX4vZuOWwyE7YCrqkan5NOlqwR/SOnt2UAX3akko1xsAp3QnuLR6gw43ei4j9AddBxJMwOldXCpCvl5MhSs5Qr4oWJ1nfqIGveLJeLnWzsLTHuu3H6XLe75k0X7OTRPzxfbaNnaPI5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106186; c=relaxed/simple;
	bh=5l2iLl9ywT5iH5p0mBqT6YdQfS1wNK7KQzhQ4xX3qD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnoCutS8R2H47XoFTylpk+wq+qSHtLmFMuZOIk298OmYItwOlIoL9yztqZUfrCnLjXYg6kZdVaxITkTG24TyeLnakb5mrTnj5sgbidQANPwuTTJVuEyhCgHbv7fM2RYkBmbpev1d+KxgSqkX9JyZqWa9EOhSKRrCSzppIytgx9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tiWRi3VM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lOapnJb8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tiWRi3VM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lOapnJb8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tiWRi3VM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lOapnJb8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tiWRi3VM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lOapnJb8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 49A84674CB;
	Mon, 18 May 2026 12:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779106183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sn2uZB5XpgvcUlQ9RT5UELO7RcBD2xKaK65h8bmoTpM=;
	b=tiWRi3VM6vaCrjo316cn7vZmwy/RZW+c3I3QQaQ4zbYvdNCGObHkRDg+HENRhS2vkfK4u2
	mNqQ4ivLHpcp8uJ/wYPCm+2LKcK1hGC7pKRt2Wl9SeixgRT6azRJHA5GkvLqt9qXdQpr8c
	IFPvqNndD5OSX2tie77uwbXfze9GK3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779106183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sn2uZB5XpgvcUlQ9RT5UELO7RcBD2xKaK65h8bmoTpM=;
	b=lOapnJb8hBZtdhQehFs0VA6n9B65Y22QiYq2UhtVl6pM4N+8gN5OrmJgK1KgRK0WbxEPMI
	TkP77Rvq67+WiICA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779106183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sn2uZB5XpgvcUlQ9RT5UELO7RcBD2xKaK65h8bmoTpM=;
	b=tiWRi3VM6vaCrjo316cn7vZmwy/RZW+c3I3QQaQ4zbYvdNCGObHkRDg+HENRhS2vkfK4u2
	mNqQ4ivLHpcp8uJ/wYPCm+2LKcK1hGC7pKRt2Wl9SeixgRT6azRJHA5GkvLqt9qXdQpr8c
	IFPvqNndD5OSX2tie77uwbXfze9GK3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779106183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sn2uZB5XpgvcUlQ9RT5UELO7RcBD2xKaK65h8bmoTpM=;
	b=lOapnJb8hBZtdhQehFs0VA6n9B65Y22QiYq2UhtVl6pM4N+8gN5OrmJgK1KgRK0WbxEPMI
	TkP77Rvq67+WiICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40C8D593A8;
	Mon, 18 May 2026 12:09:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MmnLD4cBC2qeAQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 May 2026 12:09:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6ED13A0A90; Mon, 18 May 2026 14:09:42 +0200 (CEST)
Date: Mon, 18 May 2026 14:09:42 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] direct-io: remove IOCB_NOWAIT support
Message-ID: <sjd53m6sp3c7nrfvph6hcus3wyba5d56qbmsxr2zdkoutlwtxd@pq4vbj2gwabb>
References: <20260518063336.507369-1-hch@lst.de>
 <20260518063336.507369-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518063336.507369-2-hch@lst.de>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,lst.de:email]
X-Spam-Level: 

On Mon 18-05-26 08:33:29, Christoph Hellwig wrote:
> None of the file systems using the legacy direct I/O code actually sets
> FMODE_NOWAIT, and if they did this would not work, as the write locking
> could not handle the retry.  Remove this dead code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I agree there's no point in bothering with this. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/direct-io.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 2267f5ae7f77..9e4976716985 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -502,12 +502,8 @@ static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
>  	const enum req_op dio_op = dio->opf & REQ_OP_MASK;
>  	bool should_dirty = dio_op == REQ_OP_READ && dio->should_dirty;
>  
> -	if (err) {
> -		if (err == BLK_STS_AGAIN && (bio->bi_opf & REQ_NOWAIT))
> -			dio->io_error = -EAGAIN;
> -		else
> -			dio->io_error = -EIO;
> -	}
> +	if (err)
> +		dio->io_error = -EIO;
>  
>  	if (dio->is_async && should_dirty) {
>  		bio_check_pages_dirty(bio);	/* transfers ownership */
> @@ -1178,13 +1174,10 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  		dio->is_async = true;
>  
>  	dio->inode = inode;
> -	if (iov_iter_rw(iter) == WRITE) {
> +	if (iov_iter_rw(iter) == WRITE)
>  		dio->opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
> -		if (iocb->ki_flags & IOCB_NOWAIT)
> -			dio->opf |= REQ_NOWAIT;
> -	} else {
> +	else
>  		dio->opf = REQ_OP_READ;
> -	}
>  
>  	/*
>  	 * For AIO O_(D)SYNC writes we need to defer completions to a workqueue
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
