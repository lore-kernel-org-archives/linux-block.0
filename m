Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ACF40FDBC
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107697; cv=none; b=FJs7NJBfz7mURezsNonpRXgeQWLXCzLLToCXHN6w/R1SP86IGd68fH3xDlTdOsZdcTzZU354ZULtMnQqbczdyQp1MM7rtNGXCQLgB9VrF4zANQY3C+k1M4vHmW1+rWaimZTIbcu6qhIfs4EEIHaN5kjrzGArbeAxtHlHihdrS9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107697; c=relaxed/simple;
	bh=pUb8ZM2kb9xJdW4kH7kICmyAv4d0bsKi4WpK4pN7X8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK/UHVe7mD6y5VxWIKSDv9i0hy09s9/pMLbdx6AOSCBDY9fEt/V2F7f8UyxAVkcUlzrwdEnpkmF9KbHs5rv029pofImlw5mU0JQPoS8gCzifYDXB+3xBYuZPzwupgIyEWFiuTN7/Dkhbd3pLP6rPVrYH/QYH9tq0JdT2xXEa9Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CkNARp7T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cr5We3il; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CkNARp7T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cr5We3il; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CkNARp7T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cr5We3il";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CkNARp7T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cr5We3il"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F9866C43E;
	Mon, 18 May 2026 12:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779107694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ/Vkapm1kFTZ3/WnyC17Mni9bTlnfVV88YD+wZtLdQ=;
	b=CkNARp7Ta83RwaU7NuySLSYJ8Z2QHRld5kheR1B3gIYwPcjjl+EqzeaafqGnl+/el4qleZ
	FKAoZ+vsotpQxjgP7db0IPzvSzWvnl5m0qHJztclJGQHXrdInpuxV2z97zggyIqTQzdpiA
	PN9Cwrd6X9LJjjD/5pgCOUKN0JLVq6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779107694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ/Vkapm1kFTZ3/WnyC17Mni9bTlnfVV88YD+wZtLdQ=;
	b=Cr5We3ilBR5t0cUE26ud6sLtU0F5Ucp+ndq/q5olPbkL8B0lzkZEdJ6wIhnPY7uYGTRLad
	MnKkC0LhotzvTXAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CkNARp7T;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Cr5We3il
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779107694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ/Vkapm1kFTZ3/WnyC17Mni9bTlnfVV88YD+wZtLdQ=;
	b=CkNARp7Ta83RwaU7NuySLSYJ8Z2QHRld5kheR1B3gIYwPcjjl+EqzeaafqGnl+/el4qleZ
	FKAoZ+vsotpQxjgP7db0IPzvSzWvnl5m0qHJztclJGQHXrdInpuxV2z97zggyIqTQzdpiA
	PN9Cwrd6X9LJjjD/5pgCOUKN0JLVq6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779107694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ/Vkapm1kFTZ3/WnyC17Mni9bTlnfVV88YD+wZtLdQ=;
	b=Cr5We3ilBR5t0cUE26ud6sLtU0F5Ucp+ndq/q5olPbkL8B0lzkZEdJ6wIhnPY7uYGTRLad
	MnKkC0LhotzvTXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57D6E593A8;
	Mon, 18 May 2026 12:34:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OM9mFW4HC2rCGgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 May 2026 12:34:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1F9D8A0A90; Mon, 18 May 2026 14:34:49 +0200 (CEST)
Date: Mon, 18 May 2026 14:34:49 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: don't set BIO_QUIET for BLK_STS_AGAIN
Message-ID: <4j3y4zm2vsbyxlpmyktz4g3sbfwucw64h7p5t3hos3bvtinax4@j5dj3aeahnwa>
References: <20260518063336.507369-1-hch@lst.de>
 <20260518063336.507369-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518063336.507369-3-hch@lst.de>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5F9866C43E
X-Spam-Level: 

On Mon 18-05-26 08:33:30, Christoph Hellwig wrote:
> Commit abb30460bda2 ("block: mark bio_wouldblock_error() bio with
> BIO_QUIET") added this to suppress buffer_head warnings, but neither
> when this commit was added nor now any buffer_head using code actually
> ever sets REQ_NOWAIT which can lead to BLK_STS_AGAIN.
> 
> Remove the special handling for now.  If we ever plan to use REQ_NOWAIT
> for buffer_head based I/O we're better off handling BLK_STS_AGAIN in
> the completion handler as it actually needs to retry the I/O as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

So I agree about the bh argument but bio_wouldblock_error() is not specific
to bh path in any way, is it? So do we expect all bi_end_io handlers to
check for BLK_STS_AGAIN and avoid complaining to logs in case of that? Not
that all of them would be currently checking for BIO_QUIET either so I'm
mostly trying to figure out what's the expected handling.

								Honza

> ---
>  include/linux/bio.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 85463981d0f5..7597ae4dc52b 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -379,7 +379,6 @@ static inline void bio_io_error(struct bio *bio)
>  
>  static inline void bio_wouldblock_error(struct bio *bio)
>  {
> -	bio_set_flag(bio, BIO_QUIET);
>  	bio->bi_status = BLK_STS_AGAIN;
>  	bio_endio(bio);
>  }
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
