Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907942882D7
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781804; cv=none; b=jJZcZdV0SOluRjMRvOWyenuXBDTZ/UB6UFSTI89bQZQ5OZ2oXqux3Neiwi9aBEtwnpdzG0QkusygP1qGlGKCyRxb1eNz69FC9sup2JCHO3vAtOC/Mak3/DMfGHWSU8apoT+/lZcHT/w7Jz85FYYN8P4KQh+Vmo8g28wLqcAKp4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781804; c=relaxed/simple;
	bh=DuAbRRv9kc3Deu0AUF7znCphoC717RIQ8RRgw2z/PlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPVMCmSN/3HSnd1sW5KSL7pZm9D4zm1nEoJ9eeqb2AaV3uIA0mInWeLIx0+eh1f/2dt6WlPRhJ6XVDdt2F2K45K2pK25Lo/z4TF8Uw6P86A3u5X0Z5mvm9R1vRKEGNHNekCRreg9BRvTfC2dn0uO+RQsbEi0HpAlBRTv4gctmzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UZGjITMI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m+TqFMyY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UZGjITMI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m+TqFMyY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UZGjITMI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m+TqFMyY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UZGjITMI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m+TqFMyY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BCD681F80D;
	Tue, 29 Jul 2025 09:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753781800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QEUEQVt1tsWkPcOhFfI8Q7ebr0VCJyXIT5oiKANCDJs=;
	b=UZGjITMISS6w9wHqdddQ83ZRmaMhLHDeryPT3QG41bbrUacYYn+wKc6Bo1TC0/B0iXXV2S
	AIWj5iJVh19DSIGaKnKhIxNp0dFBHD8MP76Nv1OK5yhFGATCXCXj9QQ9AsRfnjNp7C9jtG
	2fx/+5jUn5ZhkY1ViC4ZSdS8JJr5PyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753781800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QEUEQVt1tsWkPcOhFfI8Q7ebr0VCJyXIT5oiKANCDJs=;
	b=m+TqFMyYehf1xQNLh1BE98ep9xbvDjCX5VHbr3uScqC/5YDitkDW2CxGxpkn/5V7R0gRL5
	ZK6EqWjrFyvbbgBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753781800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QEUEQVt1tsWkPcOhFfI8Q7ebr0VCJyXIT5oiKANCDJs=;
	b=UZGjITMISS6w9wHqdddQ83ZRmaMhLHDeryPT3QG41bbrUacYYn+wKc6Bo1TC0/B0iXXV2S
	AIWj5iJVh19DSIGaKnKhIxNp0dFBHD8MP76Nv1OK5yhFGATCXCXj9QQ9AsRfnjNp7C9jtG
	2fx/+5jUn5ZhkY1ViC4ZSdS8JJr5PyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753781800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QEUEQVt1tsWkPcOhFfI8Q7ebr0VCJyXIT5oiKANCDJs=;
	b=m+TqFMyYehf1xQNLh1BE98ep9xbvDjCX5VHbr3uScqC/5YDitkDW2CxGxpkn/5V7R0gRL5
	ZK6EqWjrFyvbbgBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE24813876;
	Tue, 29 Jul 2025 09:36:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nPd/KiiWiGiNUgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 29 Jul 2025 09:36:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 32571A09DE; Tue, 29 Jul 2025 11:36:40 +0200 (CEST)
Date: Tue, 29 Jul 2025 11:36:40 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, axboe@kernel.dk, akpm@linux-foundation.org, 
	yang.yang@vivo.com, dlemoal@kernel.org, ming.lei@redhat.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH v2 2/2] lib/sbitmap: make sbitmap_get_shallow() static
Message-ID: <44uujjsiacvtswckacusnt3blcbmfvyrzzuu77lejmua5nulrx@lmovehtaw6hb>
References: <20250729031906.3615228-1-yukuai1@huaweicloud.com>
 <20250729031906.3615228-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729031906.3615228-3-yukuai1@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Tue 29-07-25 11:19:06, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Because it is only used in sbitmap.c
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Indeed. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/sbitmap.h | 17 -----------------
>  lib/sbitmap.c           | 18 ++++++++++++++++--
>  2 files changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index 4adf4b364fcd..ffb9907c7070 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -209,23 +209,6 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth);
>   */
>  int sbitmap_get(struct sbitmap *sb);
>  
> -/**
> - * sbitmap_get_shallow() - Try to allocate a free bit from a &struct sbitmap,
> - * limiting the depth used from each word.
> - * @sb: Bitmap to allocate from.
> - * @shallow_depth: The maximum number of bits to allocate from the bitmap.
> - *
> - * This rather specific operation allows for having multiple users with
> - * different allocation limits. E.g., there can be a high-priority class that
> - * uses sbitmap_get() and a low-priority class that uses sbitmap_get_shallow()
> - * with a @shallow_depth of (sb->depth >> 1). Then, the low-priority
> - * class can only allocate half of the total bits in the bitmap, preventing it
> - * from starving out the high-priority class.
> - *
> - * Return: Non-negative allocated bit number if successful, -1 otherwise.
> - */
> -int sbitmap_get_shallow(struct sbitmap *sb, unsigned long shallow_depth);
> -
>  /**
>   * sbitmap_any_bit_set() - Check for a set bit in a &struct sbitmap.
>   * @sb: Bitmap to check.
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index f2e90ac6b56e..5e3c35086253 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -306,7 +306,22 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
>  	return sbitmap_find_bit(sb, shallow_depth, index, alloc_hint, true);
>  }
>  
> -int sbitmap_get_shallow(struct sbitmap *sb, unsigned long shallow_depth)
> +/**
> + * sbitmap_get_shallow() - Try to allocate a free bit from a &struct sbitmap,
> + * limiting the depth used from each word.
> + * @sb: Bitmap to allocate from.
> + * @shallow_depth: The maximum number of bits to allocate from the bitmap.
> + *
> + * This rather specific operation allows for having multiple users with
> + * different allocation limits. E.g., there can be a high-priority class that
> + * uses sbitmap_get() and a low-priority class that uses sbitmap_get_shallow()
> + * with a @shallow_depth of (sb->depth >> 1). Then, the low-priority
> + * class can only allocate half of the total bits in the bitmap, preventing it
> + * from starving out the high-priority class.
> + *
> + * Return: Non-negative allocated bit number if successful, -1 otherwise.
> + */
> +static int sbitmap_get_shallow(struct sbitmap *sb, unsigned long shallow_depth)
>  {
>  	int nr;
>  	unsigned int hint, depth;
> @@ -321,7 +336,6 @@ int sbitmap_get_shallow(struct sbitmap *sb, unsigned long shallow_depth)
>  
>  	return nr;
>  }
> -EXPORT_SYMBOL_GPL(sbitmap_get_shallow);
>  
>  bool sbitmap_any_bit_set(const struct sbitmap *sb)
>  {
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
