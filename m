Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806DA2EE5FD
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458990; cv=none; b=KanGZzkXTBRSbJWYxpiuBo0h1P/yY5k+rqief7G3iyzg/GlO+h5Zg+XpZngjIXgJZAi4LA842gL7reWjmfHiI8oGH7YiTQZDpT195DwoWmeqiGSuxR5Q6O3XFMlTc5mRDsuzGY4igrhxEQFGRMOUH/iL8BReF3hfxpldsBs9YlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458990; c=relaxed/simple;
	bh=1f2ZzkAR9ZMQnt70qBivWPhRWRzywK3smgxP3aL0ewg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a42FOIeiel2TkZ7iPJB5Krv7MSUFyVf7RICgDgSk7JFp4uXnRW8F/AHpM2dwaCk0SFoM7xAcPKE3e6IcdosiZlKLEf3dnLPZw6ayvH3bRVJmJBYUYl8sRZ2G6Jz00PDOdb31TRfCkL9TJ76NBv+RYxr8gOlz5DY0HuETVVomFYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ecbnwqra; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z7hZO1AJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ecbnwqra; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z7hZO1AJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ecbnwqra";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z7hZO1AJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ecbnwqra";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z7hZO1AJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D36921190;
	Fri, 25 Jul 2025 15:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753458986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sJST4cvcq+qixBTeJx2qKpB5Sr7AvkRTvOWP3IPB3Us=;
	b=ecbnwqra3hFqMYgHDVagfetyQl4eCriHWLR1x11F/lHdWed/WB/ep5P3xOmV6TbRYCvk/Z
	ijLxxUQy+ZZvUX8RG/Hd48ZbNtx1EGq1J6Fii2L9U0QGAzDn7M2Yb3GBIHVReNSf6AIFxt
	rXiwz/08YS2ocFL52olKn4CwcNEzvsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753458986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sJST4cvcq+qixBTeJx2qKpB5Sr7AvkRTvOWP3IPB3Us=;
	b=Z7hZO1AJMfXpoIGxAJxblLjooQWAUYbO2f8xIAL12kMWbte/ogE99qrH0YU8Bif095zcaI
	sf3hAwf2UeH2INCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ecbnwqra;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Z7hZO1AJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753458986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sJST4cvcq+qixBTeJx2qKpB5Sr7AvkRTvOWP3IPB3Us=;
	b=ecbnwqra3hFqMYgHDVagfetyQl4eCriHWLR1x11F/lHdWed/WB/ep5P3xOmV6TbRYCvk/Z
	ijLxxUQy+ZZvUX8RG/Hd48ZbNtx1EGq1J6Fii2L9U0QGAzDn7M2Yb3GBIHVReNSf6AIFxt
	rXiwz/08YS2ocFL52olKn4CwcNEzvsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753458986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sJST4cvcq+qixBTeJx2qKpB5Sr7AvkRTvOWP3IPB3Us=;
	b=Z7hZO1AJMfXpoIGxAJxblLjooQWAUYbO2f8xIAL12kMWbte/ogE99qrH0YU8Bif095zcaI
	sf3hAwf2UeH2INCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 742421373A;
	Fri, 25 Jul 2025 15:56:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /elSHCqpg2hBbgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 25 Jul 2025 15:56:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 05881A29BE; Fri, 25 Jul 2025 17:56:21 +0200 (CEST)
Date: Fri, 25 Jul 2025 17:56:21 +0200
From: Jan Kara <jack@suse.cz>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: axboe@kernel.dk, hch@lst.de, jack@suse.cz, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tangyeechou@gmail.com
Subject: Re: [PATCH 1/3] blk-wbt: Optimize wbt_done() for non-throttled writes
Message-ID: <k7g33ohjbc7tuo3vzhsdl4qzmbjafxncnvfduxggilmdb53mxc@3y37mw7jqw4z>
References: <20250724083001.362882-1-yizhou.tang@shopee.com>
 <20250724083001.362882-2-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724083001.362882-2-yizhou.tang@shopee.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8D36921190
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,lst.de,suse.cz,vger.kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,shopee.com:email,suse.cz:dkim,suse.cz:email]
X-Spam-Score: -4.01

On Thu 24-07-25 16:29:59, Tang Yizhou wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> In the current implementation, the sync_cookie and last_cookie members of
> struct rq_wb are used only by read requests and not by non-throttled write
> requests. Based on this, we can optimize wbt_done() by removing one if
> condition check for non-throttled write requests.
> 
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>

Nah, I'm undecided if this is actually worth it. But it looks correct and
doesn't make the code harder to follow so I guess feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-wbt.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index a50d4cd55f41..30886d44f6cd 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -248,13 +248,14 @@ static void wbt_done(struct rq_qos *rqos, struct request *rq)
>  	struct rq_wb *rwb = RQWB(rqos);
>  
>  	if (!wbt_is_tracked(rq)) {
> -		if (rwb->sync_cookie == rq) {
> -			rwb->sync_issue = 0;
> -			rwb->sync_cookie = NULL;
> -		}
> +		if (wbt_is_read(rq)) {
> +			if (rwb->sync_cookie == rq) {
> +				rwb->sync_issue = 0;
> +				rwb->sync_cookie = NULL;
> +			}
>  
> -		if (wbt_is_read(rq))
>  			wb_timestamp(rwb, &rwb->last_comp);
> +		}
>  	} else {
>  		WARN_ON_ONCE(rq == rwb->sync_cookie);
>  		__wbt_done(rqos, wbt_flags(rq));
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
