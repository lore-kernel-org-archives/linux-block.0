Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218883;
	b=pGmk2wevTC4ZkEBPF1F0qS2gWaKluK+s/K8MacppKGOkB1FZBwJ/vdqrllcPFFeoj2/h
	 Cu56CMZ5IsYS/RatJUiNRyZC9ubBvTfsEYHIehCP8FJUC+lURYay4jHYFxP6AXxaWcN0Z
	 xvdqHfSGaYu+RvVrN8s3XpD3aOJ8KT4v9hr1syAKgwefsc+UkvkZMMZnPCAOOTYvgBpYQ
	 oWqQDXpYrNBxFF4sxcmgNcCB+BfxL4AIytgLLrUrHexf3vHu4C/G2L91pfzPMiNzlS4KZ
	 o4PAl5e+6YskRvgXOXYCof9GJhW/H6PxDx+KXndECIXO4mRkqb/OkFgm7nh6pZdHXOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218883;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=sw/f5GlzICZ1r0CANGG48giNMmXdtQkOipmXnIllfFQ=;
	b=GiLb2XLLlZiLFDgex8VPgnwdq4lmA9VUk257WSiHYCbjc4SleL6FjuO93kICrOilxSWJ
	 wzpL5vY2w6GJu2/OCUmuz5UN5RGXzr+PgAd/K/okXImJ7KIXQwX9b1xMaiE7js0he3pDc
	 Uh8v9DGKUOKE6TnXcPqAwzS8ZgT4F3l2boBXgG8gN4qRQpEmegKEq4h9yxkxgIAUjG4FE
	 d+VaUJFH5mswmvWRFKS68z8AMfpDH64jdp8yJzjaelFjgiV7NJId4/BFO/IhjsVnIpaFW
	 65UfBK6sdpYzSh2f9QJMZSAxwqIjjOfIqzPunv+VyVt4uqWjegXCiZ8gC/LRSn4mXiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=QWaXdQQW;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s0EzP3j0;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=QWaXdQQW;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s0EzP3j0;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B7606A322;
	Mon,  9 Nov 2026 10:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D5B7606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=QWaXdQQW;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s0EzP3j0;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=QWaXdQQW;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s0EzP3j0
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B1551F74A;
	Mon,  9 Nov 2026 10:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794218881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sw/f5GlzICZ1r0CANGG48giNMmXdtQkOipmXnIllfFQ=;
	b=QWaXdQQW1r1nrM62iLrb+RQM7Ueufr7NQ7IaaGdQ9pR+YB58vawugW0c658XusB5Y70+6X
	EuBxgVviu2JUonEAN7Nx/Fyq6Qypwt2yuPNINUXVcL7dal+MDAscd8vMEcAI/v3VpXGp7N
	15y6DLOTJO5EY8ganfwZF1AP/n/sOoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794218881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sw/f5GlzICZ1r0CANGG48giNMmXdtQkOipmXnIllfFQ=;
	b=s0EzP3j0nqhTbKtYE/g6/8DOLk7vC8GsCbavc7CcGDLtaiYmOac7rxS72eI4UrWoeBlh4f
	Mu86Yd5iejshgvDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QWaXdQQW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=s0EzP3j0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794218881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sw/f5GlzICZ1r0CANGG48giNMmXdtQkOipmXnIllfFQ=;
	b=QWaXdQQW1r1nrM62iLrb+RQM7Ueufr7NQ7IaaGdQ9pR+YB58vawugW0c658XusB5Y70+6X
	EuBxgVviu2JUonEAN7Nx/Fyq6Qypwt2yuPNINUXVcL7dal+MDAscd8vMEcAI/v3VpXGp7N
	15y6DLOTJO5EY8ganfwZF1AP/n/sOoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794218881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sw/f5GlzICZ1r0CANGG48giNMmXdtQkOipmXnIllfFQ=;
	b=s0EzP3j0nqhTbKtYE/g6/8DOLk7vC8GsCbavc7CcGDLtaiYmOac7rxS72eI4UrWoeBlh4f
	Mu86Yd5iejshgvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBF1713302;
	Mon,  9 Nov 2026 10:08:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y+LDLYCb8Wo7UwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Nov 2026 10:08:00 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 6D8AD21D90; Mon, 09 Nov 2026 11:08:00 +0100 (CET)
Date: Mon, 9 Nov 2026 11:08:00 +0100
From: Jan Kara <jack@suse.cz>
To: Huang Shijie <huangsj@hygon.cn>
Cc: axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	zhongyuan@hygon.cn, fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, jack@suse.cz, 
	agruenba@redhat.com, mic@digikod.net, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, aleksa@amutable.com, legion@kernel.org, 
	david@kernel.org, sandeen@redhat.com, ebiggers@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org, sunjunchao@bytedance.com
Subject: Re: [PATCH 2/3] vfs: convert inode iterators to the unsafe
 super_iter_inodes()
Message-ID: <phaorzf3wo3qg3dwxwzemtvc3xk644lecgoeeu3th2zx3cv5ml@xzhc2jw7vobi>
References: <20261015093854.2082600-1-huangsj@hygon.cn>
 <20261015093854.2082600-3-huangsj@hygon.cn>
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
In-Reply-To: <20261015093854.2082600-3-huangsj@hygon.cn>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hygon.cn:email,suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 1B1551F74A

On Thu 15-10-26 17:38:53, Huang Shijie wrote:
> Convert VFS internal superblock inode iterators that cannot use
> referenced inodes to super_iter_inodes() with INO_ITER_F_UNSAFE set:
>   - Dquot removal
>   - inode eviction
>   - The nr_blockdev_pages()
>   - generic_shutdown_super()
> 
> Signed-off-by: Huang Shijie <huangsj@hygon.cn>

See some comments below.

> diff --git a/fs/inode.c b/fs/inode.c
> index a9d37be390a1..139c56ee9d11 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -853,8 +853,11 @@ static void evict(struct inode *inode)
>   * Dispose-list gets a local list with local inodes in it, so it doesn't
>   * need to worry about list corruption and SMP locks.
>   */
> -static void dispose_list(struct list_head *head)
> +static bool dispose_list(struct list_head *head)
>  {
> +	if (list_empty(head))
> +		return false;
> +
>  	while (!list_empty(head)) {
>  		struct inode *inode;
>  
> @@ -864,6 +867,29 @@ static void dispose_list(struct list_head *head)
>  		evict(inode);
>  		cond_resched();
>  	}
> +	return true;
> +}
> +
> +static int evict_inode_fn(struct inode *inode, void *data)
> +{
> +	struct list_head *dispose = data;
> +

Here we miss the unlocked check
            if (icount_read_once(inode))
                    continue;
so every inode will now go through the i_lock roundtrip.

> +	spin_lock(&inode->i_lock);
> +	if (icount_read(inode) ||
> +	    (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE))) {
> +		spin_unlock(&inode->i_lock);
> +		return INO_ITER_RET_DONE;
> +	}
> +
> +	inode_state_set(inode, I_FREEING);
> +	inode_lru_list_del(inode);
> +	spin_unlock(&inode->i_lock);
> +	list_add(&inode->i_lru, dispose);
> +
> +	/* Abort so evict_inodes() can dispose of the queued inodes first. */
> +	if (need_resched())
> +		return INO_ITER_RET_ABORT;
> +	return INO_ITER_RET_DONE;
>  }

The need_resched() handling needs more thought here. The way you've done it
will just abort the iteration, evict gathered inodes and then restart the
whole iteration (which will then have to skip again all the inodes we could
not evict). Which is not what evict_inodes() does today and we really had
to resort to those tricks to avoid softlockups under certain loads.
Frankly, this iteration is so special that I'd be willing to leave it
unconverted for now rather than trying to bend the general iterator for its
needs.

> @@ -877,44 +903,16 @@ static void dispose_list(struct list_head *head)
>   */
>  void evict_inodes(struct super_block *sb)
>  {
> -	struct inode *inode;
>  	LIST_HEAD(dispose);
>  
> -	spin_lock(&sb->s_inode_list_lock);
> -	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> -		if (icount_read_once(inode))
> -			continue;
> -
> -		spin_lock(&inode->i_lock);
> -		if (icount_read(inode)) {
> -			spin_unlock(&inode->i_lock);
> -			continue;
> -		}
> -		if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE)) {
> -			spin_unlock(&inode->i_lock);
> -			continue;
> -		}
> -
> -		inode_state_set(inode, I_FREEING);
> -		inode_lru_list_del(inode);
> -		spin_unlock(&inode->i_lock);
> -
> +	do {
>  		/*
> -		 * Keep this inode out of dispose so it stays on s_inodes while
> -		 * the list lock is dropped. I_FREEING prevents new references
> -		 * and leaves eviction to us, so we can resume the walk from it.
> +		 * Taking references would keep the inodes we are trying to
> +		 * evict alive, so use the unsafe iterator and let
> +		 * evict_inode_fn() do the state checks and queue them.
>  		 */
> -		if (need_resched()) {
> -			spin_unlock(&sb->s_inode_list_lock);
> -			cond_resched();
> -			dispose_list(&dispose);
> -			spin_lock(&sb->s_inode_list_lock);
> -		}
> -		list_add(&inode->i_lru, &dispose);
> -	}
> -	spin_unlock(&sb->s_inode_list_lock);
> -
> -	dispose_list(&dispose);
> +		super_iter_inodes(sb, evict_inode_fn, &dispose, INO_ITER_F_UNSAFE);
> +	} while (dispose_list(&dispose));
>  }
>  EXPORT_SYMBOL_GPL(evict_inodes);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
