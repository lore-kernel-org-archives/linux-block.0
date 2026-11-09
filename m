Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218327;
	b=h9tQsFIC/4hqwkoBgLRmoaUQs+Kz2RiFrTr6TN38/ieS2uBHMlDutR4t6XOaDQEVZ8fH
	 eAyQICb6VQUuUTSCe8YHkRFthUFFQMDj/gVHiof4ATjO21QeYAOGlM3iLkcyrwjMdYctS
	 C+tPJbVXWPekjffsHWl4Gw0+PZ/531YrNesWmcGq5kmbkaAcxrujQHsAp1jI3dOl4q9By
	 k7HEwplOELZp8697x7m/f2Lj7VYY3WULIKVOdTgqc1VCLIiXXeXjivYClbXtChv9PrmAF
	 WX2phgLTmgS5sLm1zVQ+sBPr7DWC5cIQvrg3Kc5jJvtZ6+E5SeLPoW8d7GSDStmHn1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218327;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=9YqeSUwdUI+ewo9U6HDew1v5EKdGFa3Vpg/7xfVnlmo=;
	b=EOMl1T1y9+r7xQr0P16AY8WFo/urbmNuZR7NEJ/XZiRJVBl5U4TmYAEZ5BkyfIVFv+vc
	 V0yHruA7anqpqqywEs5N2vCLi7AJuUrUoBUII48Tu1nvAWArGMOjoYzF/y4pAVT36KgwQ
	 9ai4a0fDORLFuFl6IOkLl0ft23mEbGOmn94nZcq+/DkclWQklRAtCZB3+2FBD1eivoFXA
	 PWsIXg8v5veSGZRLpCp5aiyVxqPORint/Jjy0UotubOVIoZDGnQLmW7ZYOtF4xoDeMKHm
	 DSAS0Jt5EII1QpyEN73q2CVt+096LOZPtr4jHO9HTBJ4FYP2faYVQ13aNDvs8EkfUQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=G7CRuED6;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=recl9Zt6;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=G7CRuED6;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=recl9Zt6;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4B6606EE98;
	Mon,  9 Nov 2026 09:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA4B6606EE98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=G7CRuED6;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=recl9Zt6;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=G7CRuED6;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=recl9Zt6
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7FDBD21ED1;
	Mon,  9 Nov 2026 09:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794218324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YqeSUwdUI+ewo9U6HDew1v5EKdGFa3Vpg/7xfVnlmo=;
	b=G7CRuED6NzzdVt7L5gKNNsG/Jmnoev6NtThl9kEVfWK/2/+rb/TksLeG93lrFto59BSskc
	tUV5XK2e62heEW+kBIuM6+Pc0iqjkEEIMEj0WHBH1B3yMuSUcKYCfhH0HQf62SFf+gP9c5
	vF94vb5EdlVdf1S3UamAszCm67Rnbec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794218324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YqeSUwdUI+ewo9U6HDew1v5EKdGFa3Vpg/7xfVnlmo=;
	b=recl9Zt6rDMQiYnaOHiXv3tKpLuIQ0i3v7iw5narrceerKWXtcn5gVnPcrnO+5lP6WKaED
	ptMslHoHdl0Eb9Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G7CRuED6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=recl9Zt6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794218324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YqeSUwdUI+ewo9U6HDew1v5EKdGFa3Vpg/7xfVnlmo=;
	b=G7CRuED6NzzdVt7L5gKNNsG/Jmnoev6NtThl9kEVfWK/2/+rb/TksLeG93lrFto59BSskc
	tUV5XK2e62heEW+kBIuM6+Pc0iqjkEEIMEj0WHBH1B3yMuSUcKYCfhH0HQf62SFf+gP9c5
	vF94vb5EdlVdf1S3UamAszCm67Rnbec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794218324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YqeSUwdUI+ewo9U6HDew1v5EKdGFa3Vpg/7xfVnlmo=;
	b=recl9Zt6rDMQiYnaOHiXv3tKpLuIQ0i3v7iw5narrceerKWXtcn5gVnPcrnO+5lP6WKaED
	ptMslHoHdl0Eb9Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5233013302;
	Mon,  9 Nov 2026 09:58:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id boGKC1SZ8Wr9SQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Nov 2026 09:58:44 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id D6B9E21D88; Mon, 09 Nov 2026 10:58:43 +0100 (CET)
Date: Mon, 9 Nov 2026 10:58:43 +0100
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
Message-ID: <wepk7b6hw44k7aodwmk24mt4ied25jl5zzdyd5dfx3pjop6omq@bvld6lyzbetm>
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
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 7FDBD21ED1

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

This looks as a good base but see my comments for individual conversions.
Some smaller comments below:

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
> +		if (ret == INO_ITER_RET_ABORT)
> +			break;
> +	}
> +	spin_unlock(&sb->s_inode_list_lock);
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
> +/**
> + * super_iter_inodes - iterate all the cached inodes on a superblock
> + * @sb: superblock to iterate
> + * @iter_fn: callback to run on every inode found
> + * @private_data: private data to pass to @iter_fn
> + * @flags: inode iteration control flags
> + *
> + * This function iterates all cached inodes on a superblock that are not in
> + * the process of being initialised or torn down. It will run @iter_fn() with
> + * a valid, referenced inode, so it is safe for the caller to do anything it
> + * wants with the inode except drop the reference the iterator holds.
> + *
> + * If @flags has %INO_ITER_F_REFERENCED set, inodes with a zero refcount are
> + * skipped as well, so that they are not needlessly bounced through
> + * __iget()/iput() (which would evict them from the inode cache).
> + *
> + * If @flags has %INO_ITER_F_UNSAFE set, the inodes are iterated without
> + * taking a reference and @iter_fn is run in an atomic context that must not
> + * block; %INO_ITER_F_REFERENCED is ignored in this mode. This is for internal
> + * VFS operations only and almost certainly not what the caller wants.
> + *
> + * Return: %INO_ITER_RET_DONE on completion, a negative errno if @iter_fn()
> + * returned an error (safe iteration only), or %INO_ITER_RET_ABORT if the
> + * unsafe iteration was aborted early.
> + */
> +int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
> +		      void *private_data, int flags)
> +{
> +	if (flags & INO_ITER_F_UNSAFE)
> +		return generic_iter_inodes_unsafe(sb, iter_fn, private_data);

Since unsafe iteration is a separate function anyway and we advertise it as
an "internal VFS" function (which I agree with), I'd just have
super_iter_inodes() for the normal iteration and super_iter_inodes_unsafe()
for the unsafe iteration which won't be exported to modules (so we really
get the message across this should be VFS internal function). 

> +
> +	return generic_iter_inodes(sb, iter_fn, private_data, flags);
> +}
> +EXPORT_SYMBOL_GPL(super_iter_inodes);
> +

...
> +/* Inode iteration callback return values */
> +#define INO_ITER_RET_DONE		0

Maybe INO_ITER_RET_NEXT? DONE looks too much like the loop should finish.

> +#define INO_ITER_RET_ABORT		1
> +
> +/* Inode iteration control flags */
> +/* Iterate without taking a reference; @iter_fn must not block. */
> +#define INO_ITER_F_UNSAFE		(1U << 1)
> +/* Only iterate inodes that still have a reference. */
> +#define INO_ITER_F_REFERENCED		(1U << 2)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
