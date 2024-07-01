Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC55AF9E6;
	Mon,  1 Jul 2024 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719821969; cv=none; b=jQwXAZbmOefdwSeLuezuGUhyGRx2PuEADXBNpmBNa6ftJO6Vg5TH5Qorha+QNAqAns0RiYQB7EJqsp1r5lpTahzCQIkRVjXGAAyyyuEimMj8AD4PfphTIutgf8bumSh1asfuo//ZATEheAJkKQH3VjWANqnGxcgCmKA4IVgxHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719821969; c=relaxed/simple;
	bh=Zfwgg5urJiTJNYF1K+OAuafUdjK/ushBhJWj8/v0Rf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sM7aWLIquoEfIAYyM2OmbMupquS7qOQvtx4ASS7W/1zRQUe0J++TF4dQ9dVggaPDyfWY92mf25BHMCT8yWKmvtlu8tYXTIiY+bNE0WdqoOo/uMMC0rAFFCPXafbW5D6alQ0Tuem83WIR59dAjYxkupknY9Va/FfzmRu1L/3mHIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iAlJRtBK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ncJjRUcV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iAlJRtBK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ncJjRUcV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iAlJRtBK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ncJjRUcV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iAlJRtBK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ncJjRUcV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B9EE0219DC;
	Mon,  1 Jul 2024 08:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719821965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CRYGLoPAgz4Kckx8H1tNt+H/fOv5Rx00dQoQrq5R2vY=;
	b=iAlJRtBKDdJCzLp4krfRz1Gp3xutLSrvwNCbAVLeLp3+a5jnsBJSSG8yxSotc9Ta3aTd5e
	UpZYtz6lS5d3vV/Pflcw5iOY1Hv6nV4UsOG29QTzScnIh+mpw7l3B5XFrqJDUniR84Wn/0
	1RApYSkWXG5qe+gFfauK4LuQf8vvXYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719821965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CRYGLoPAgz4Kckx8H1tNt+H/fOv5Rx00dQoQrq5R2vY=;
	b=ncJjRUcV9XT0IyhBAswqvNfj0WrsL57g89+QO33bAmgfKE739GJoRooHosGuaGcuJYsKLZ
	goPzb3fsJsp8pzCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719821965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CRYGLoPAgz4Kckx8H1tNt+H/fOv5Rx00dQoQrq5R2vY=;
	b=iAlJRtBKDdJCzLp4krfRz1Gp3xutLSrvwNCbAVLeLp3+a5jnsBJSSG8yxSotc9Ta3aTd5e
	UpZYtz6lS5d3vV/Pflcw5iOY1Hv6nV4UsOG29QTzScnIh+mpw7l3B5XFrqJDUniR84Wn/0
	1RApYSkWXG5qe+gFfauK4LuQf8vvXYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719821965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CRYGLoPAgz4Kckx8H1tNt+H/fOv5Rx00dQoQrq5R2vY=;
	b=ncJjRUcV9XT0IyhBAswqvNfj0WrsL57g89+QO33bAmgfKE739GJoRooHosGuaGcuJYsKLZ
	goPzb3fsJsp8pzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2A9213800;
	Mon,  1 Jul 2024 08:19:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cIlsJ41mgmYCfwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 01 Jul 2024 08:19:25 +0000
Date: Mon, 1 Jul 2024 10:19:25 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Christoph Hellwig <hch@lst.de>, Frederic Weisbecker <fweisbecker@suse.com>, 
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
	Sridhar Balaraman <sbalaraman@parallelwireless.com>, "brookxu.cn" <brookxu.cn@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
Message-ID: <pmnqhamoec7u7ibtt4vccjfecp3ixgdlxzgncelvgczfbt74x5@26rjmpubji6s>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
 <ZoFgLxGXrk4VCR03@fedora>
 <b2ncik6c7xicsnzihhwfjjqood2yys52tzotohjnxj6o2mapg5@m364yzsjbvs2>
 <ZoJY6a1CHCENAZZ8@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoJY6a1CHCENAZZ8@fedora>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,grimberg.me,linutronix.de,lst.de,suse.com,suse.de,parallelwireless.com,gmail.com,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Mon, Jul 01, 2024 at 03:21:13PM GMT, Ming Lei wrote:
> On Mon, Jul 01, 2024 at 09:08:32AM +0200, Daniel Wagner wrote:
> > On Sun, Jun 30, 2024 at 09:39:59PM GMT, Ming Lei wrote:
> > > > Make group_cpus_evenly aware of isolcpus configuration and use the
> > > > housekeeping CPU mask as base for distributing the available CPUs into
> > > > groups.
> > > > 
> > > > Fixes: 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed interrupts")
> > > 
> > > isolated CPUs are actually handled when figuring out irq effective mask,
> > > so not sure how commit 11ea68f553e2 is wrong, and what is fixed in this
> > > patch from user viewpoint?
> > 
> > IO queues are allocated/spread on the isolated CPUs and if there is an
> > thread submitting IOs from an isolated CPU it will cause noise on the
> > isolated CPUs. The question is this a use case you need/want to support?
> 
> I have talked RH Openshift team weeks ago and they have such usage.
> 
> userspace is free to run any application from isolated CPUs via 'taskset
> -c' even though 'isolcpus=' is passed from command line.
>
> Kernel can not add such new constraint on userspace.

Okay, that is why I asked if we need an additional HK type.

> > We have customers who are complaining that even with isolcpus provided
> > they still see IO noise on the isolated CPUs.
> 
> That is another issue, which has been fixed by the following patch:
> 
> a46c27026da1 blk-mq: don't schedule block kworker on isolated CPUs

I've checked our downstream kernels and we don't have this one yet. I'll
ask our customer to test if this patch addressed their issue.

Thanks!
Daniel
