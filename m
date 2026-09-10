Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D348EC71;
	Thu, 10 Sep 2026 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062459; cv=none; b=CaTFKCu5saGI2S6fP9rGcQy1VYg+RJIHeLW+yRstruoccuO6Yd0eeI+mbRZGLY9W73gMHusIwR7zwptPCizLWzGTpcGodcWwiSkgWoRVpX3PKFwzQCKe2Fd8D8y/pBghKRkc5PmUcZogAtXfAISBYuxf4n7P2UIUBBKgc37X4V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062459; c=relaxed/simple;
	bh=QOq5J+PTN+J4T+/mwREANb1jZTAlu+Z6SlN6eMKJkjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ol6lgm+oorJdeJaQzhMBaic4kiWSHpvASLNrgROHDrthMujDDzEK2J+ptVZK1p51u3HO1nrxXLOhr6nGknj9+CaIvNgJWtUU63YtSr8kJq3OYGXhidLM6lqqPvgo6Yugm5avPw0wSnbe/BPTZtibbF5JjbBu09iOM8tQcSjfQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fxZvYsp8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=22MoBoiE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dpK0/yh3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HKhtMRBc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fxZvYsp8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="22MoBoiE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dpK0/yh3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HKhtMRBc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4D0A1FE51;
	Thu, 10 Sep 2026 17:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789062447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ISIH/uEjqjWH5kHVocayOZ340pSFabdJJRtKoM61f50=;
	b=fxZvYsp8y8Ji8dEqt5jvjgs8OO9a1Kzx/o/rz6ka1DnFqIk2eCPnkj8XesEQQFOirv3r8Z
	dthhtqKtTybiMD9SzirMHsAQb4WrCDmXWpZ0b6VxdjyAIMRYc1C1SnhPE8O9KBWxezzV9r
	fl7P6naf84kzVQZayxf2aghrmAKCvnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789062447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ISIH/uEjqjWH5kHVocayOZ340pSFabdJJRtKoM61f50=;
	b=22MoBoiEEYeDtwO5UvHoXMX838oqFHZElzAEeos3IWTI5yR50RNnbgOmWppv2W0hDE2vR6
	mOYB7BSBGyUcBBCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="dpK0/yh3";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HKhtMRBc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789062442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ISIH/uEjqjWH5kHVocayOZ340pSFabdJJRtKoM61f50=;
	b=dpK0/yh3x603zPmL55NdDuNgAJanmdCgFpb0NhJ0SN88zEQX6wBZT0Ary96vHLpCAw6pTR
	cJ8vLMg4/I7Y75sclLSvGdoA487jMINIURSGzMeazvqBiXU/KfasXuBlKVjcBTU9jRiJsi
	2iRvzAlDKFfeUAJuftqT9ZYrH2d9xCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789062442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ISIH/uEjqjWH5kHVocayOZ340pSFabdJJRtKoM61f50=;
	b=HKhtMRBcZhzvn+vymyjoqBgVg20cbnZVdC2bDyoBzt7ZoMD47/kM7gQpUDXOAGKvbHg//0
	ZNFNGvGUMTbqAvAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A73E51326D;
	Thu, 10 Sep 2026 17:47:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SbVMKCrtomoPIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 10 Sep 2026 17:47:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 34311A12EA; Thu, 10 Sep 2026 19:47:22 +0200 (CEST)
Date: Thu, 10 Sep 2026 19:47:22 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org, jack@suse.cz, 
	agruenba@redhat.com, mic@digikod.net, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, aleksa@amutable.com, legion@kernel.org, 
	djwong@kernel.org, ebiggers@kernel.org, sandeen@redhat.com
Subject: Re: [PATCH 2/7] fs: introduce sb_for_each_inodes().
Message-ID: <yhfoyto6skszguj447a7ifajl2r6qiwj5japcg2zsj2ooshi4r@tgkq5fadmyto>
References: <20260909090112.790006-1-sunjunchao@bytedance.com>
 <20260909090112.790006-3-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909090112.790006-3-sunjunchao@bytedance.com>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: D4D0A1FE51
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO

On Wed 09-09-26 17:01:07, Julian Sun wrote:
> Add sb_for_each_inodes() to share s_inodes traversal and preserve its
> position while s_inode_list_lock is dropped.
> 
> Track active iterators on sb->s_inodes_iters and advance their saved
> positions before unlinking an inode. Callbacks manage inode references
> and per-inode work, allowing both normal walks and eviction to use the
> same interface.
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

So I'm not generally opposed the to a superblock inode iterator idea but
what you have looks more complex than I'd expect. Also we shouldn't tie
that to the fix of the lockup in evict_inodes(). So first I'd just
concentrate on fixing that lockup, then we can have a look at the iterator
idea.

You can take some inspiration about inode iteration API from the Dave
Chinner's patch set [1]. That looked more like what I'd expect although
Christoph had some comments on it too.

Regarding the fix I'd just make evict_inodes() do what all other inode
iterators do when they decide to drop s_inode_list_lock - pin an inode in
the list by grabbing refcount and then resume from it.

								Honza

[1] https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.com/

> ---
>  fs/inode.c                     | 93 ++++++++++++++++++++++++++++++++++
>  fs/super.c                     |  1 +
>  include/linux/fs.h             | 15 ++++++
>  include/linux/fs/super_types.h |  3 +-
>  4 files changed, 111 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index ba7da39be4a3..b4279063a5dd 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -69,6 +69,15 @@ const struct address_space_operations empty_aops = {
>  };
>  EXPORT_SYMBOL(empty_aops);
>  
> +struct inode_iter {
> +	struct list_head	iters_node;	/* sb->s_inodes_iters */
> +	struct list_head	*next;		/* next node going to iterate */
> +	unsigned int flags;
> +	inode_iter_cb func;
> +	void *data;
> +	int ret;
> +};
> +
>  static DEFINE_PER_CPU(unsigned long, nr_inodes);
>  static DEFINE_PER_CPU(unsigned long, nr_unused);
>  
> @@ -641,12 +650,96 @@ void inode_sb_list_add(struct inode *inode)
>  }
>  EXPORT_SYMBOL_GPL(inode_sb_list_add);
>  
> +static void inode_sb_iter_start(struct super_block *sb, struct inode_iter *it,
> +				unsigned int flags, inode_iter_cb fn, void *data)
> +{
> +	it->flags = flags;
> +	it->func = fn;
> +	it->data = data;
> +	it->ret = 0;
> +	spin_lock(&sb->s_inode_list_lock);
> +	it->next = sb->s_inodes.next;
> +	list_add(&it->iters_node, &sb->s_inodes_iters);
> +}
> +
> +static void inode_sb_iter_end(struct inode_iter *it, struct super_block *sb)
> +{
> +	list_del(&it->iters_node);
> +	spin_unlock(&sb->s_inode_list_lock);
> +}
> +
> +static bool inode_sb_iter_next(struct inode_iter *it, struct super_block *sb)
> +{
> +	struct inode *inode = NULL;
> +	int ret;
> +
> +	while (!inode && it->next != &sb->s_inodes) {
> +		inode = list_entry(it->next, struct inode, i_sb_list);
> +		if (it->flags & INODE_ITER_UNUSED) {
> +			if (icount_read_once(inode)) {
> +				it->next = it->next->next;
> +				continue;
> +			}
> +
> +			spin_lock(&inode->i_lock);
> +			if (icount_read(inode)) {
> +				spin_unlock(&inode->i_lock);
> +				it->next = it->next->next;
> +				continue;
> +			}
> +		} else {
> +			spin_lock(&inode->i_lock);
> +		}
> +
> +		if ((it->flags & INODE_ITER_NORMAL) &&
> +		    (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE))) {
> +			spin_unlock(&inode->i_lock);
> +			it->next = it->next->next;
> +			continue;
> +		}
> +
> +		it->next = it->next->next;
> +		ret = it->func(inode, it->data);
> +		if (ret) {
> +			it->ret = ret;
> +			return false;
> +		}
> +
> +		if (need_resched()) {
> +			spin_unlock(&sb->s_inode_list_lock);
> +			cond_resched();
> +			spin_lock(&sb->s_inode_list_lock);
> +		}
> +	}
> +
> +	return it->next == &sb->s_inodes ? false : true;
> +}
> +
> +int sb_for_each_inodes(struct super_block *sb, unsigned int flags,
> +		       inode_iter_cb fn, void *data)
> +{
> +	struct inode_iter it;
> +
> +	inode_sb_iter_start(sb, &it, flags, fn, data);
> +	while (inode_sb_iter_next(&it, sb))
> +		;
> +	inode_sb_iter_end(&it, sb);
> +
> +	return it.ret;
> +}
> +EXPORT_SYMBOL(sb_for_each_inodes);
> +
>  static inline void inode_sb_list_del(struct inode *inode)
>  {
>  	struct super_block *sb = inode->i_sb;
> +	struct inode_iter *it;
>  
>  	if (!list_empty(&inode->i_sb_list)) {
>  		spin_lock(&sb->s_inode_list_lock);
> +		list_for_each_entry(it, &sb->s_inodes_iters, iters_node) {
> +			if (it->next == &inode->i_sb_list)
> +				it->next = inode->i_sb_list.next;
> +		}
>  		list_del_init(&inode->i_sb_list);
>  		spin_unlock(&sb->s_inode_list_lock);
>  	}
> diff --git a/fs/super.c b/fs/super.c
> index 05e443173038..3e069150c544 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -382,6 +382,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>  	spin_lock_init(&s->s_roots_lock);
>  	mutex_init(&s->s_sync_lock);
>  	INIT_LIST_HEAD(&s->s_inodes);
> +	INIT_LIST_HEAD(&s->s_inodes_iters);
>  	spin_lock_init(&s->s_inode_list_lock);
>  	INIT_LIST_HEAD(&s->s_inodes_wb);
>  	spin_lock_init(&s->s_inode_wblist_lock);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 09c4db5e9ae0..f3176ab10e65 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -870,6 +870,21 @@ struct inode {
>  	void			*i_private; /* fs or device private pointer */
>  } __randomize_layout;
>  
> +enum inode_iter_flags_enum {
> +	INODE_ITER_NORMAL = (1U << 1),  /* Exclude inodes with (I_NEW | I_FREEING | I_WILL_FREE). */
> +	INODE_ITER_UNUSED = (1U << 2),  /* Only return inodes with (i_count == 0). */
> +};
> +
> +/*
> + *                             start          end
> + *  inode->i_lock              locked         unlocked
> + *  sb->s_inode_list_lock      locked         locked
> + */
> +typedef int (*inode_iter_cb) (struct inode *, void *);
> +
> +int sb_for_each_inodes(struct super_block *sb, unsigned int flags,
> +		       inode_iter_cb fn, void *data);
> +
>  /*
>   * i_state handling
>   *
> diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
> index ecd96aeb1cee..1f81cc219b8e 100644
> --- a/include/linux/fs/super_types.h
> +++ b/include/linux/fs/super_types.h
> @@ -269,9 +269,10 @@ struct super_block {
>  	 */
>  	int s_stack_depth;
>  
> -	/* s_inode_list_lock protects s_inodes */
> +	/* s_inode_list_lock protects s_inodes and s_inodes_iters */
>  	spinlock_t				s_inode_list_lock ____cacheline_aligned_in_smp;
>  	struct list_head			s_inodes;	/* all inodes */
> +	struct list_head			s_inodes_iters; /* all iterators */
>  
>  	spinlock_t				s_inode_wblist_lock;
>  	struct list_head			s_inodes_wb;	/* writeback inodes */
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
