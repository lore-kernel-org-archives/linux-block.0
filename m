Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B74239E6B
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753445035; cv=none; b=HrPlUBgeiSRr6AdlsP6JXqCS3nAb54HCUtHiq+gEpQtoATi3uUhRnUEaK8SR3O4yoTeuYhmvUHMMsv85UJXYW9Zqux3bLvClpJvKsaEAZl7CDgALGAD2PJ112bN1mJA9WmLpTQ9ekRVLo866LFbz9SUsMsM++0StjqXmfpA9GUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753445035; c=relaxed/simple;
	bh=eefAk3MqP+D8xxNIwPCweoehiD+g1bsLUqd9nG1FIb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/rIrc0s71A7pST6Z/MrTo+oru56zccBxpk56LSrAwUMjhRkHypCWjB+YEx8QqDK47cWMvS2hFSEKcRY9irQPKj+O4eZLlpp8Q0iVUeBBb03n2Iq54Q+18Gng+n2IWUHDTD2+iq4GxeLABccwTSORuOzpFNoazUQuhBr/+HGXb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xJnBTG0v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TN2+G7k/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xJnBTG0v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TN2+G7k/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xJnBTG0v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TN2+G7k/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xJnBTG0v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TN2+G7k/"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 255F21F79A;
	Fri, 25 Jul 2025 12:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753445032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tQMTp6swxYnc8K/hMs8JaIeGAceL4YshZHyyeK4FbDw=;
	b=xJnBTG0vqv0zQVEh1oO39sQ11B1bDT+VQuHewDILoYGmQKgNnCu7uDUSakyp/iOocg1TFF
	hWHhTRH54UBnI23B6jOBxnTiJB5vcwZFcpBzV2jX4VJc9PrxtynNY2IyxdXO8lCgXdGO7v
	EcN5/lrqSDA4xuB5OoB45e0L07yrY3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753445032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tQMTp6swxYnc8K/hMs8JaIeGAceL4YshZHyyeK4FbDw=;
	b=TN2+G7k/hYC4Iq8jr5i7bcZ3qk984JeDctnCMO/k4alir23UYiaHt57f2cN14mrscB8JdP
	UgCbMKSgrbEED6BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xJnBTG0v;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="TN2+G7k/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753445032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tQMTp6swxYnc8K/hMs8JaIeGAceL4YshZHyyeK4FbDw=;
	b=xJnBTG0vqv0zQVEh1oO39sQ11B1bDT+VQuHewDILoYGmQKgNnCu7uDUSakyp/iOocg1TFF
	hWHhTRH54UBnI23B6jOBxnTiJB5vcwZFcpBzV2jX4VJc9PrxtynNY2IyxdXO8lCgXdGO7v
	EcN5/lrqSDA4xuB5OoB45e0L07yrY3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753445032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tQMTp6swxYnc8K/hMs8JaIeGAceL4YshZHyyeK4FbDw=;
	b=TN2+G7k/hYC4Iq8jr5i7bcZ3qk984JeDctnCMO/k4alir23UYiaHt57f2cN14mrscB8JdP
	UgCbMKSgrbEED6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A6361373A;
	Fri, 25 Jul 2025 12:03:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id naxqBqhyg2gUJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 25 Jul 2025 12:03:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BC6F4A29BD; Fri, 25 Jul 2025 14:03:46 +0200 (CEST)
Date: Fri, 25 Jul 2025 14:03:46 +0200
From: Jan Kara <jack@suse.cz>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, axboe@kernel.dk, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH 1/3] blk-ioc: add a new helper ioc_lookup_icq_rcu()
Message-ID: <3up6wgkarspq7zo34pe72zd5a5lygdo2sokbstxc63fajrl3gw@tpk3ihmc7k7l>
References: <20250725070547.3953398-1-yukuai1@huaweicloud.com>
 <20250725070547.3953398-2-yukuai1@huaweicloud.com>
 <3653febf-0c36-48ca-9d51-7cf93e5b25f1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3653febf-0c36-48ca-9d51-7cf93e5b25f1@kernel.org>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 255F21F79A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Fri 25-07-25 19:21:06, Damien Le Moal wrote:
> On 7/25/25 16:05, Yu Kuai wrote:
> > From: Yu Kuai <yukuai3@huawei.com>
> > 
> > ioc_lookup_icq() is used by bfq to lookup bfqq from IO path, the helper
> > have to be protected by queue_lock, which is too heavy. Hence add a new
> > helper that is lookless, this is safe because both request_queue and ioc
> > can be pinged by IO that is still issuing.
> > 
> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > ---
> >  block/blk-ioc.c | 34 ++++++++++++++++++++++++++++++++++
> >  block/blk.h     |  1 +
> >  2 files changed, 35 insertions(+)
> > 
> > diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> > index ce82770c72ab..4945b48dfdb6 100644
> > --- a/block/blk-ioc.c
> > +++ b/block/blk-ioc.c
> > @@ -343,6 +343,40 @@ struct io_cq *ioc_lookup_icq(struct request_queue *q)
> >  }
> >  EXPORT_SYMBOL(ioc_lookup_icq);
> >  
> > +/**
> > + * ioc_lookup_icq_rcu - lookup io_cq from ioc in io path
> > + * @q: the associated request_queue
> > + *
> > + * Look up io_cq associated with @ioc - @q pair from @ioc. Must be called from
> > + * io issue path, either return NULL if current issue io to @q for the first
> > + * time, or return a valid icq.
> > + */
> > +struct io_cq *ioc_lookup_icq_rcu(struct request_queue *q)
> > +{
> > +	struct io_context *ioc = current->io_context;
> > +	struct io_cq *icq;
> > +
> > +	WARN_ON_ONCE(percpu_ref_is_zero(&q->q_usage_counter));
> 
> I do not think this is necessary.
> 
> > +
> > +	if (!ioc)
> > +		return NULL;
> > +
> > +	icq = rcu_dereference(ioc->icq_hint);
> > +	if (icq && icq->q == q)
> > +		return icq;
> > +
> > +	icq = radix_tree_lookup(&ioc->icq_tree, q->id);
> > +	if (!icq)
> > +		return NULL;
> > +
> > +	if (WARN_ON_ONCE(icq->q != q))
> > +		return NULL;
> > +
> > +	rcu_assign_pointer(ioc->icq_hint, icq);
> > +	return icq;
> > +}
> > +EXPORT_SYMBOL(ioc_lookup_icq_rcu);
> 
> Patch 2 calls this function with the rcu_read_lock() held. Why not move that rcu
> read lock here inside this function ? That is how ioc_lookup_icq() was doing
> things, with code that is more compact than this.
> 
> And since ioc_lookup_icq() was already using RCU, it seems that the only change
> you need is to remove the "lockdep_assert_held(&q->queue_lock);" from that
> function to endup with the same above functionality. So why all the churn ?

Yes, I agree, just dropping the assert and updating callers should be fine.

> Another question is: is it safe to call radix_tree_lookup() without any lock
> held ? What if this races with a radix tree insertion ? (I may be wrong here as
> I am not familiar with that code).

Yes, radix_tree_lookup() is fine to call with just rcu protection.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
