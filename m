Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220306;
	b=Gj8doFuYaR1juZrDFhFOzlbH7I/ObWfPak67GCdVApOHQTwhcroyj+a3lCWmobeQKFIw
	 QvmPvMKVtkEEaPicwO/SCOQfKHNLahwWGbvXFG93dBZVCo1UkP8Y7Y8Pb1Tt2GgZ4jz9h
	 Izx5SmjFusQUB+IBl2XRyLzFFwvGwsKm6oaW7dT/FBiE6GAzgx4gck8QWSN8/SBdCZbWI
	 0pUYQhrTSqPDUEQ8VLvlgR4YUCaviKMvNjJpub/AZ3tcbr99c9SHl3EBfRJc9oFPl4xvM
	 exAGGfWKmKz5b57swHJWOa1QF5yvG3XWJnHC7LdXSRBd8/aRzIpGnjjzRU0koSX24zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220306;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=PMGJTgU8mvjkAS5YWFNnpC41aKPnUg3SSlpFkRXcdzg=;
	b=grlS1n+TMGCZNPEI05eBo1Ai2HvtlG5Vtks6vOTTu0nX7lQl3GAsEGLkIMYt2+YS+pe8
	 iYi8ylkpJOe8x6hODx7rnwsBodkU1JNq65zPX2t5y3/77hUlis/T+EEzkPfLjpZrLfWQH
	 pYPB+pxCuT2Yd/2gx25UxKtjYHDjOsAxE7M1t87hOkAPYb1dDEKGVufHV9x7xPKcbOP5+
	 5aMCkK+G1IjRgX6iSQfGpPkyoWKlm5uEW9f4knTnuAYD2dn51nIGjqjQabdp3gnXmWYSG
	 XZ7Mi3IjXkt5LVSlPAHjduIhSq2fOCI04XU/sEsW9KEH2gijQ7XDN0MdHaOq4DW+rAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="OfQX/noz";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iDMIGTOx;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=hXszPBEE;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ksA9a2+C;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90327606A325;
	Mon,  9 Nov 2026 10:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90327606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=OfQX/noz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iDMIGTOx;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=hXszPBEE;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ksA9a2+C
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2BD591F7C6;
	Mon,  9 Nov 2026 10:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794220303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PMGJTgU8mvjkAS5YWFNnpC41aKPnUg3SSlpFkRXcdzg=;
	b=OfQX/noziV6DSYx6Ym8MbXcxSZv18FRFVG+5LBizRILh8Q5LKnvKBnlRrp6KMHd9eL5AIK
	TiaSK50xRk6k1p+H3qtOkoWKtvt1wLwE6Xs5gDBB+Rdduo8+kY1E+IJkZ2P3/Acsq4fzvK
	1aQPMDkuKqOPOMEOyyfIS7qQMgmm5P4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794220303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PMGJTgU8mvjkAS5YWFNnpC41aKPnUg3SSlpFkRXcdzg=;
	b=iDMIGTOxp3+L0e8TwmbievMZviBTFhXKn7ln2CNGRyuhxhqFtJfE3wIN8nT/ae5pEp/dec
	t9LT4N03992rH5CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hXszPBEE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ksA9a2+C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794220302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PMGJTgU8mvjkAS5YWFNnpC41aKPnUg3SSlpFkRXcdzg=;
	b=hXszPBEEhIoVLqxSbzpAAyX7Wgaqs6dx8+GHH88JwmD2NC4DtTLCeYQLb+40gqC/sTuUX4
	tjTXIw/N0J4QwfAp9dpnGpEFjnGoE1iAIhDgatrWP0ErTd6Hyo3VtixsNXCcOt1Ed5Eg52
	uqpk9HoTC4wGq+3grbgaxUQ0nH0dwzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794220302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PMGJTgU8mvjkAS5YWFNnpC41aKPnUg3SSlpFkRXcdzg=;
	b=ksA9a2+CxqLGJfMxtNBSyn+ZJ87wQdsUgROJTVSdhfunoxf0kFZPvwqKs8gbQ/TcT+LNfs
	46zR4hI4XlwPpFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F07A513319;
	Mon,  9 Nov 2026 10:31:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lPu7Mg2h8Wo6awAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Nov 2026 10:31:41 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 8228121D9C; Mon, 09 Nov 2026 11:31:41 +0100 (CET)
Date: Mon, 9 Nov 2026 11:31:41 +0100
From: Jan Kara <jack@suse.cz>
To: Huang Shijie <huangsj@hygon.cn>
Cc: axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	zhongyuan@hygon.cn, fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, jack@suse.cz, 
	agruenba@redhat.com, mic@digikod.net, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, aleksa@amutable.com, legion@kernel.org, 
	david@kernel.org, sandeen@redhat.com, ebiggers@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org, sunjunchao@bytedance.com
Subject: Re: [PATCH 3/3] vfs: convert sb->s_inodes iteration to
 super_iter_inodes()
Message-ID: <wrknznlm52ffratfpdoe3otqhkgyd45vgmvtjkixrvurwpplyu@sfpz3yiwhidy>
References: <20261015093854.2082600-1-huangsj@hygon.cn>
 <20261015093854.2082600-4-huangsj@hygon.cn>
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
In-Reply-To: <20261015093854.2082600-4-huangsj@hygon.cn>
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
	RCPT_COUNT_TWELVE(0.00)[25];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hygon.cn:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 2BD591F7C6

On Thu 15-10-26 17:38:54, Huang Shijie wrote:
> Convert all the remaining superblock inode iterators to use
> super_iter_inodes(). These are mostly straight forward conversions
> for the iterations that use referenced inodes:
>  - sync_bdevs
>  - drop_pagecache_sb
>  - gfs2_kill_sb
>  - add_dquot_ref
>  - hook_sb_delete

...
 
> Signed-off-by: Huang Shijie <huangsj@hygon.cn>
> diff --git a/block/bdev.c b/block/bdev.c
> index 18b4423b4e61..b263b566056f 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1340,56 +1340,36 @@ void bdev_mark_dead(struct block_device *bdev, bool surprise)
>   */
>  EXPORT_SYMBOL_GPL(bdev_mark_dead);
>  
> -void sync_bdevs(bool wait)
> +static int sync_bdev_fn(struct inode *inode, void *data)
>  {
> -	struct inode *inode, *old_inode = NULL;
> +	struct block_device *bdev;
> +	bool wait = *(bool *)data;
>  
> -	spin_lock(&blockdev_superblock->s_inode_list_lock);
> -	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list) {
> -		struct address_space *mapping = inode->i_mapping;
> -		struct block_device *bdev;
> +	if (inode->i_mapping->nrpages == 0)

Seeing these various checks iterators are doing before actually paying the
cost of grabbing (and dropping) the inode reference, I'd add a
->elegible(inode) function to the iterator which will get called under
i_lock after other checks pass and can decide inode is not worth bothering
with and put the checks there. If it is NULL, the behavior would be as
currently.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
