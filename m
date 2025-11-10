Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23E1C8FBA
	for <linux-block@vger.kernel.org>; Mon, 10 Nov 2025 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780514; cv=none; b=qfQIFRPQ2VRBA8No4rkzRNpDhyrZF5wg0vM2Y4oKpCDsBdxPkHyA5WYfQPTER5FAGLApzf/INoBSshvdCRbzLvtC1a0nwp/mixSuPzgoMGVcfeQB0+WBByB3BEAdMg5tcDX/1qyTvQkxka3JWfuoPwU4lhhz0+a8/4aWPKBC7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780514; c=relaxed/simple;
	bh=UDFAmRjHGjSapaGRPRIM+Nkgi1V7QaMsLubQACwIBvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADwmLBF7xVnK3vO5QkTni+df0a52Bojx8lZl+N9zJjAmoFoeMtk1dtBWD11EBmIsUJ1Wi44YRCKiewuUG7+KgBEAQ3DrsuASIX9HP9lpSgsd1EDLWNoGyeqNYQOMpOsTnxo1uvhmuNWYxJ6X9UtcYQ/HC+f43SSFB91EwHc++Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2oB1tbgc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GY2pZ8lu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2oB1tbgc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GY2pZ8lu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2oB1tbgc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GY2pZ8lu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2oB1tbgc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GY2pZ8lu"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E6F22125B;
	Mon, 10 Nov 2025 13:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762780510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bob9q4zZe78YDc7c7xXVoYI5YSZxt/68IuU4mBqqm28=;
	b=2oB1tbgc5h+N0YnX145fTn8vYrjujiH42wsJ7bKD2yw7OPvMoeLwqfeqRi2rfOitr3kmMe
	5vyN8mNlYxXNbB/oiipJDkZvQRHXB5jwa73jMbHgpdnzOh5dVhlsnOKf190w23HTDNy01K
	hmuDCF4PxRG8C9wv7qgtJ72UPUKlXJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762780510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bob9q4zZe78YDc7c7xXVoYI5YSZxt/68IuU4mBqqm28=;
	b=GY2pZ8luFO/31CQuaFw/H6EzaiG7YGDyQlY7TVA9duLek0vkWfSUaVbDPNvP4gUATaTDI0
	nWVFNZ/985nAYmBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762780510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bob9q4zZe78YDc7c7xXVoYI5YSZxt/68IuU4mBqqm28=;
	b=2oB1tbgc5h+N0YnX145fTn8vYrjujiH42wsJ7bKD2yw7OPvMoeLwqfeqRi2rfOitr3kmMe
	5vyN8mNlYxXNbB/oiipJDkZvQRHXB5jwa73jMbHgpdnzOh5dVhlsnOKf190w23HTDNy01K
	hmuDCF4PxRG8C9wv7qgtJ72UPUKlXJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762780510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bob9q4zZe78YDc7c7xXVoYI5YSZxt/68IuU4mBqqm28=;
	b=GY2pZ8luFO/31CQuaFw/H6EzaiG7YGDyQlY7TVA9duLek0vkWfSUaVbDPNvP4gUATaTDI0
	nWVFNZ/985nAYmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32426143EE;
	Mon, 10 Nov 2025 13:15:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Uk8DF7lEWk5RwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Nov 2025 13:15:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DACB6A28B1; Mon, 10 Nov 2025 14:15:09 +0100 (CET)
Date: Mon, 10 Nov 2025 14:15:09 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	viro@zeniv.linux.org.uk, axboe@kernel.dk, linux-block@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, libaokun1@huawei.com, 
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] bdev: add hint prints in sb_set_blocksize() for LBS
 dependency on THP
Message-ID: <rbrz2e3zilyjejol2azth3z43irzq3fp2sapecgzv4ocio5cjk@uu76dbfmoy3k>
References: <20251110124714.1329978-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110124714.1329978-1-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-0.30 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.30
X-Spam-Level: 

On Mon 10-11-25 20:47:14, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Support for block sizes greater than the page size depends on large
> folios, which in turn require CONFIG_TRANSPARENT_HUGEPAGE to be enabled.
> 
> Because the code is wrapped in multiple layers of abstraction, this
> dependency is rather obscure, so users may not realize it and may be
> unsure how to enable LBS.
> 
> As suggested by Theodore, I have added hint messages in sb_set_blocksize
> so that users can distinguish whether a mount failure with block size
> larger than page size is due to lack of filesystem support or the absence
> of CONFIG_TRANSPARENT_HUGEPAGE.
> 
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Link: https://patch.msgid.link/20251110043226.GD2988753@mit.edu
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bdev.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 810707cca970..4888831acaf5 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -217,9 +217,26 @@ int set_blocksize(struct file *file, int size)
>  
>  EXPORT_SYMBOL(set_blocksize);
>  
> +static int sb_validate_large_blocksize(struct super_block *sb, int size)
> +{
> +	const char *err_str = NULL;
> +
> +	if (!(sb->s_type->fs_flags & FS_LBS))
> +		err_str = "not supported by filesystem";
> +	else if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		err_str = "is only supported with CONFIG_TRANSPARENT_HUGEPAGE";
> +
> +	if (!err_str)
> +		return 0;
> +
> +	pr_warn_ratelimited("%s: block size(%d) > page size(%lu) %s\n",
> +				sb->s_type->name, size, PAGE_SIZE, err_str);
> +	return -EINVAL;
> +}
> +
>  int sb_set_blocksize(struct super_block *sb, int size)
>  {
> -	if (!(sb->s_type->fs_flags & FS_LBS) && size > PAGE_SIZE)
> +	if (size > PAGE_SIZE && sb_validate_large_blocksize(sb, size))
>  		return 0;
>  	if (set_blocksize(sb->s_bdev_file, size))
>  		return 0;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
