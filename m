Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE07D44D01F
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109417; cv=none; b=RVmeaPpA54RpNDYEsn589PhsvffG6SjHjElwNNgGr4BEMcick27kr6eSxMoD4Rd8cAZkeBacsuzKNdo4lomv9yfh/ZoyLjYO68qJaCtYstI9ZcWLt+q5907dAJ7MNeq1gXenunsYZIPvsMsBhK/CU+RP2Qj9hsrDQQ/YMUFCVtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109417; c=relaxed/simple;
	bh=yE4CHMQIUtF6+r+hvFjz6O1zIkW6RzcsEEtlrbhHGPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H28+c1za+68vQdSghAchyxNec1TO8gvJWgT1rD25jYEjZ9wOm/SodVN/PnWFhepKqNkJRRzCuzgw98WOXZRtfMst6x5uCP4Zm1Yj/tVX4MaEZCusnNl0aIYsK0dNuVuYm1m1O6FD9XmefrEGYq5skCRjmYS9qoAooqDKxK8VK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JTdHUir1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6oU8YxnV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JTdHUir1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6oU8YxnV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JTdHUir1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6oU8YxnV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JTdHUir1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6oU8YxnV"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B267672D4;
	Mon, 18 May 2026 13:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779109414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vEzAx8oAOdGhbrtapAhwTP0oz+pKIk8gOMfPuvDdiaY=;
	b=JTdHUir1xyt6R4h3O0+WypUzNUGu1BmendR5vnYg+6n12vKECO/2V0Lw7MPbT/qW/Skz1S
	w/3mZxuSjVCWYzP/l14hMYA/XoK7GtKM+SW4ehem0ad4Sr+K1CR6Q1xDS9poki60RgfPF+
	j/uaKMXJ/h5rcnN+HHo2KjgQ/IHptTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779109414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vEzAx8oAOdGhbrtapAhwTP0oz+pKIk8gOMfPuvDdiaY=;
	b=6oU8YxnVLWluicvjHtdSkG3CQ22jmQA9u5tfve2/ZLuOnGo2vEhKlpJgPHsJWu09+iEVww
	xzVy8NRUadZstUCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JTdHUir1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6oU8YxnV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779109414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vEzAx8oAOdGhbrtapAhwTP0oz+pKIk8gOMfPuvDdiaY=;
	b=JTdHUir1xyt6R4h3O0+WypUzNUGu1BmendR5vnYg+6n12vKECO/2V0Lw7MPbT/qW/Skz1S
	w/3mZxuSjVCWYzP/l14hMYA/XoK7GtKM+SW4ehem0ad4Sr+K1CR6Q1xDS9poki60RgfPF+
	j/uaKMXJ/h5rcnN+HHo2KjgQ/IHptTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779109414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vEzAx8oAOdGhbrtapAhwTP0oz+pKIk8gOMfPuvDdiaY=;
	b=6oU8YxnVLWluicvjHtdSkG3CQ22jmQA9u5tfve2/ZLuOnGo2vEhKlpJgPHsJWu09+iEVww
	xzVy8NRUadZstUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21B54593A8;
	Mon, 18 May 2026 13:03:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rsQuCCYOC2pLNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 May 2026 13:03:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 37701A0A90; Mon, 18 May 2026 15:03:29 +0200 (CEST)
Date: Mon, 18 May 2026 15:03:29 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: don't set BIO_QUIET for BLK_STS_AGAIN
Message-ID: <sw5zffcmk66gcihpt55gxnr4lvmp3qbxhm6l6uo6y2qpmxp77x@wtnwreneuu3i>
References: <20260518063336.507369-1-hch@lst.de>
 <20260518063336.507369-3-hch@lst.de>
 <4j3y4zm2vsbyxlpmyktz4g3sbfwucw64h7p5t3hos3bvtinax4@j5dj3aeahnwa>
 <20260518125109.GA5286@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518125109.GA5286@lst.de>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 2B267672D4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Mon 18-05-26 14:51:09, Christoph Hellwig wrote:
> On Mon, May 18, 2026 at 02:34:49PM +0200, Jan Kara wrote:
> > > Commit abb30460bda2 ("block: mark bio_wouldblock_error() bio with
> > > BIO_QUIET") added this to suppress buffer_head warnings, but neither
> > > when this commit was added nor now any buffer_head using code actually
> > > ever sets REQ_NOWAIT which can lead to BLK_STS_AGAIN.
> > > 
> > > Remove the special handling for now.  If we ever plan to use REQ_NOWAIT
> > > for buffer_head based I/O we're better off handling BLK_STS_AGAIN in
> > > the completion handler as it actually needs to retry the I/O as well.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > So I agree about the bh argument but bio_wouldblock_error() is not specific
> > to bh path in any way, is it? So do we expect all bi_end_io handlers to
> > check for BLK_STS_AGAIN and avoid complaining to logs in case of that? Not
> > that all of them would be currently checking for BIO_QUIET either so I'm
> > mostly trying to figure out what's the expected handling.
> 
> File system would need special handling for BLK_STS_AGAIN were we to wire
> it up again (in upstream we have the dead direct-io code removed in
> patch 1, and an incorrect use in iomap polled I/O I sent a separate patch
> for), because simply bubbling it up as -EAGAIN will generally do the
> wrong thing.  We ran into file system corruption last time we did it due
> to non-idempotency of writes and general locking issues with just
> retrying at a higher level.
> 
> Thus the rough consensus was that If we want to support fs-issued
> REQ_NOWAIT I/O we'd first need to add infrastructure to retry them from
> a blocking context at the bio-level, preferably in the block layer
> itself.

OK, fair. Thanks for explanation. So this flagging with quiet is indeed
pointless. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
