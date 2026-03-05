Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013A3148A8
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705433; cv=none; b=gYCCkEHI824TPWbRMiuw4KWbanw+Wtp0WZG2DuMIjS8f6iB++mfT1TQD4vFRwUqlsiax5ijEBPX9ru32XAd4m07LGea4jY4pJ3PEZYSYcoSuamMMsitrrsooemquk/b+zd3Uox5eW1ZIxPkGhtopxix6rDbADHJKmonsDNTaWKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705433; c=relaxed/simple;
	bh=QngJ+1afzrVRPe7A5F61Cd4qznHUxZvJnruSxThwk1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVYKntp2/wckyuSViDvHWfuuFl7tIUAwCgeXBjMGaXHZDOAXfmwrhfjS2hjeNNOq2vEbZJPcr1wZkK+OLzY9v/g5xBDQ2pX/rAykqJ3GHbgScZrwWjsMOi7JAIGCOfl5c7BQUcqcC4Zb1fG5K23vhpMrdXWYhHr+/47eoXnbKLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jQKd1Bzq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=csNdYsSL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jQKd1Bzq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=csNdYsSL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jQKd1Bzq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="csNdYsSL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jQKd1Bzq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="csNdYsSL"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 677E13F74F;
	Thu,  5 Mar 2026 10:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772705430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ep97aMudZmByP1jLbBY+jBixf4Ib9nQwv8VFrdN6DDI=;
	b=jQKd1BzqH9zItN1YZUq9WxKcVWt8rFWK9/vnfjrmpSRWMBrn9eY389N3K1sv8L9iaU3+s4
	octfr6E5rfEDWwR0I7i0JO+XsKHsrxeA19HrI3oUic9XvRy0Z9oT8bOEUQf3QbBtyC/DFZ
	qoMUxKCgGW2bcLAn2bVH1K6ptLjrmrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772705430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ep97aMudZmByP1jLbBY+jBixf4Ib9nQwv8VFrdN6DDI=;
	b=csNdYsSL19VK0OfSzc0EEsr8yEeNR7dacnHJvp/QOFZNhpAceJnNGezXYkZqbHuS3rGFCf
	K8WDYaZcupD09CCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772705430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ep97aMudZmByP1jLbBY+jBixf4Ib9nQwv8VFrdN6DDI=;
	b=jQKd1BzqH9zItN1YZUq9WxKcVWt8rFWK9/vnfjrmpSRWMBrn9eY389N3K1sv8L9iaU3+s4
	octfr6E5rfEDWwR0I7i0JO+XsKHsrxeA19HrI3oUic9XvRy0Z9oT8bOEUQf3QbBtyC/DFZ
	qoMUxKCgGW2bcLAn2bVH1K6ptLjrmrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772705430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ep97aMudZmByP1jLbBY+jBixf4Ib9nQwv8VFrdN6DDI=;
	b=csNdYsSL19VK0OfSzc0EEsr8yEeNR7dacnHJvp/QOFZNhpAceJnNGezXYkZqbHuS3rGFCf
	K8WDYaZcupD09CCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D3533EA68;
	Thu,  5 Mar 2026 10:10:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BvC5FpZWqWnmWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Mar 2026 10:10:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1A1A5A0B35; Thu,  5 Mar 2026 11:10:15 +0100 (CET)
Date: Thu, 5 Mar 2026 11:10:15 +0100
From: Jan Kara <jack@suse.cz>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>, linux-block@vger.kernel.org, 
	Yu Kuai <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 02/14] blk-ioc: Prepare for enabling thread-safety
 analysis
Message-ID: <an6x6or3aceomqwhy4rc4zz5a4kyrnbitoz3v2m2ekkfaaslnu@uuwya3gdk3qp>
References: <20260304194843.760669-1-bvanassche@acm.org>
 <20260304194843.760669-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304194843.760669-3-bvanassche@acm.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,acm.org:email,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 04-03-26 11:48:21, Bart Van Assche wrote:
> The Clang thread-safety analyzer does not support testing return values
> with "< 0". Hence change the "< 0" test into "!= 0". This is fine since
> the radix_tree_maybe_preload() return value is <= 0.
> 
> Cc: Yu Kuai <yukuai3@huawei.com>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Frankly, I dislike changing the idiomatic ways we use in the kernel for
checking for error returns just because some static checker tool is too
dumb... It may make life easier for the tool but it makes it harder for
humans which I don't think is a good tradeoff.

								Honza

> ---
>  block/blk-ioc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index d15918d7fabb..0bf78aebc887 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -364,7 +364,7 @@ static struct io_cq *ioc_create_icq(struct request_queue *q)
>  	if (!icq)
>  		return NULL;
>  
> -	if (radix_tree_maybe_preload(GFP_ATOMIC) < 0) {
> +	if (radix_tree_maybe_preload(GFP_ATOMIC) != 0) {
>  		kmem_cache_free(et->icq_cache, icq);
>  		return NULL;
>  	}
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
