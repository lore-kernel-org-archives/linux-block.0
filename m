Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221011;
	b=t97pTuMEWobgBvb9f6x6W0KPa7Bp5QYQ3J7GlN7VcGNfThJhpH3pmEd1raNNNsmmIixF
	 tfO2jF2MEt/qdiPmIj3rhDH2a5J7HU3AnotHPcWNf/pL10Zx8Ffu/CClenAVGaLkyDUdy
	 qgVMS64Z6vHs3uMN2P8GvDbIT0P+eE/9kpABAtInQ87lG78ITUGtHASPmDrUBFEUqzTJe
	 FtybK+yuYwLp8T8GzaYPr3Ss1UNW6gp+jPVtI7frlryZE+dEz4VZ2IrbKnCe9EIcz0vms
	 gVH0WpMq+mG8dZLhn04B01AFzuhwVB4hmqVdGS4X5JhspkCVNxQ2qbwul5o/9KHD24A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221011;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=UDca6BQDSujzYN3iXgd+k/sP2oPa3lW0EYEkVXMqZGI=;
	b=BdOGP8MkMRbGOsOWcJMnpsyeXI7/8tsP6ICUdCJU5VSghLR+uvbYHq5ezwYMkI6FgBBP
	 aLvEyt2mE8mNGIqqHa7xbw1B46YKd+a0G5ziRBCFtW356trTkCT5gOVIV/j1Sd+cjsMNP
	 /7SlymzaPEZEpLNEolsRs5buB8v5tu+6vpYIqdKPBr6spEyHZKdQNrFJKPVDELTcwPPIV
	 AnDDD+MIDxJeN2FkMYaGN5E6icnu78Wy0FQvbw9d9g+8oBkNIcptcxYVkLjirbGvK/oyC
	 M/gzzNaNw+ye+92xatvyRUbRlylubkndGtIYc4U4JFgMu7etjuLba7U32QlWErhZpPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="bQZO/4ow";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cju391Pb;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="bQZO/4ow";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cju391Pb;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347A8606A321;
	Mon,  9 Nov 2026 10:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 347A8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=bQZO/4ow;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cju391Pb;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=bQZO/4ow;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cju391Pb
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68CC51F7DC;
	Mon,  9 Nov 2026 10:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794221008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UDca6BQDSujzYN3iXgd+k/sP2oPa3lW0EYEkVXMqZGI=;
	b=bQZO/4ownfo2yOHaR61k0wnNVBUfekWvdGFDswdi15wmEuCR8Z1/p2ZL6dN64g69FEIkRO
	PRKrz4vmmMvnPAsZqEGUjbVs1ChGiH4/NjYgeZ09IW9q6Jhz1ig9kodd9g/i2I5zKjXx5F
	3FFvH4zSFyFct0dpFcx+NtASgf+YDdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794221008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UDca6BQDSujzYN3iXgd+k/sP2oPa3lW0EYEkVXMqZGI=;
	b=cju391PbLRfEBl3XJCGRIWAIkQf+7o/Sl/VZ1cZw2D761PRg10H9FTP02kRQSC/0Gj8nUX
	skSOEkBupJ8pXyBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794221008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UDca6BQDSujzYN3iXgd+k/sP2oPa3lW0EYEkVXMqZGI=;
	b=bQZO/4ownfo2yOHaR61k0wnNVBUfekWvdGFDswdi15wmEuCR8Z1/p2ZL6dN64g69FEIkRO
	PRKrz4vmmMvnPAsZqEGUjbVs1ChGiH4/NjYgeZ09IW9q6Jhz1ig9kodd9g/i2I5zKjXx5F
	3FFvH4zSFyFct0dpFcx+NtASgf+YDdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794221008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UDca6BQDSujzYN3iXgd+k/sP2oPa3lW0EYEkVXMqZGI=;
	b=cju391PbLRfEBl3XJCGRIWAIkQf+7o/Sl/VZ1cZw2D761PRg10H9FTP02kRQSC/0Gj8nUX
	skSOEkBupJ8pXyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1B3313319;
	Mon,  9 Nov 2026 10:43:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BRLeLsuj8WpadwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Nov 2026 10:43:23 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 6B4BD21DA3; Mon, 09 Nov 2026 11:43:19 +0100 (CET)
Date: Mon, 9 Nov 2026 11:43:19 +0100
From: Jan Kara <jack@suse.cz>
To: Huang Shijie <huangsj@hygon.cn>
Cc: axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	zhongyuan@hygon.cn, fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, jack@suse.cz, 
	agruenba@redhat.com, mic@digikod.net, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, aleksa@amutable.com, legion@kernel.org, 
	david@kernel.org, sandeen@redhat.com, ebiggers@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org, sunjunchao@bytedance.com
Subject: Re: [PATCH 1/3] vfs: add inode iteration method super_iter_inodes
Message-ID: <symrqnxn6tkrahynz7rm5b7n3tolkifpbubmwfd3y6q4q2xnt2@vhh7plsok3kh>
References: <20261015093854.2082600-1-huangsj@hygon.cn>
 <20261015093854.2082600-2-huangsj@hygon.cn>
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
In-Reply-To: <20261015093854.2082600-2-huangsj@hygon.cn>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,hygon.cn:email]
X-Spam-Score: -12.80

On Thu 15-10-26 17:38:52, Huang Shijie wrote:
> This will be used to replace the explicit sb->s_inodes iteration,
> with the caller supplying a callback function and a private data
> pointer that is passed to the callback along with each inode that is
> iterated.
> 
> A single iteration function, super_iter_inodes(), is provided, with
> the iteration mode selected by the INO_ITER_F_UNSAFE flag. The
> INO_ITER_F_REFERENCED flag can additionally restrict the iteration to
> inodes that still have a reference.
> 
> Without INO_ITER_F_UNSAFE, the callback is called with a valid,
> unlocked and referenced inode, so any inode operation, including
> blocking operations, is allowed. The iterator is responsible for
> inode lifecycle management, so the callback only needs to implement
> the operation it wants to perform on all inodes.
> 
> With INO_ITER_F_UNSAFE set, the inodes are iterated without taking a
> reference and the callback is run in an atomic context that must not
> block. This mode is for internal VFS use only and runs under a RCU
> read lock so that the VFS inode is not freed from under the callback.
> It is needed for operations that require tight control over the state
> of the inodes they operate on.
> 
> This mechanism allows the existing sb->s_inodes iteration models to
> be maintained, providing a generic implementation for iterating all
> cached inodes on the superblock.
> 
> Signed-off-by: Huang Shijie <huangsj@hygon.cn>

Some more comments after seeing more conversions:

> +static bool super_iter_iget(struct inode *inode, int flags)
> +{
> +	bool ret = false;
> +

Here I'd do a lockless icount_read_once(inode) check if INO_ITER_F_REFERENCED
is set to avoid unnecessary i_lock round trip.

> +	spin_lock(&inode->i_lock);
> +	if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE))
> +		goto out_unlock;
> +
> +	if ((flags & INO_ITER_F_REFERENCED) && !icount_read(inode))
> +		goto out_unlock;
> +
> +	__iget(inode);
> +	ret = true;
> +out_unlock:
> +	spin_unlock(&inode->i_lock);
> +	return ret;
> +}
> +
> +static int generic_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
> +			       void *private_data, int flags)
> +{
> +	struct inode *inode, *old_inode = NULL;
> +	int ret = INO_ITER_RET_DONE;
> +
> +	spin_lock(&sb->s_inode_list_lock);
> +	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> +		if (!super_iter_iget(inode, flags))
> +			continue;
> +
> +		spin_unlock(&sb->s_inode_list_lock);
> +		iput(old_inode);
> +
> +		ret = iter_fn(inode, private_data);
> +
> +		old_inode = inode;
> +		if (ret == INO_ITER_RET_ABORT) {
> +			ret = INO_ITER_RET_DONE;
> +			goto out_loop;
> +		}
> +		if (ret < 0)
> +			goto out_loop;
> +
> +		cond_resched();
> +		spin_lock(&sb->s_inode_list_lock);
> +	}
> +	spin_unlock(&sb->s_inode_list_lock);
> +out_loop:
> +	iput(old_inode);
> +	return ret;
> +}
> +
> +/*
> + * Unsafe iteration for internal VFS use only: @iter_fn runs in atomic
> + * context with only an inode existence guarantee, so it must not block
> + * and must perform its own inode state checks. Return INO_ITER_RET_ABORT
> + * to stop the iteration early.
> + */
> +static int generic_iter_inodes_unsafe(struct super_block *sb, ino_iter_fn iter_fn,
> +				      void *private_data)
> +{
> +	struct inode *inode;
> +	int ret = INO_ITER_RET_DONE;
> +
> +	rcu_read_lock();
> +	spin_lock(&sb->s_inode_list_lock);
> +	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> +		ret = iter_fn(inode, private_data);

After some thought, I'd probably make this function inline in some VFS
internal header. That way the compiler can inline everything and avoid the
extra costs of indirect function calls, etc. These iterators tend to be
rather lightweight so it would avoid performance regressions from the
conversion.

I was considering the same for the generic iterator as well but there I
don't have so strong opinion as the function is already relatively big and
the callbacks are usually more heavy. Might still be worth some more
detailed investigation and performance measurements...

> +		if (ret == INO_ITER_RET_ABORT)
> +			break;
> +	}
> +	spin_unlock(&sb->s_inode_list_lock);
> +	rcu_read_unlock();
> +
> +	return ret;
> +}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
