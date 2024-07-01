Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A481B809;
	Mon,  1 Jul 2024 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817717; cv=none; b=bgZ1ozoqyf2gY0ke45z55uiuG5sEuX9BquHnMc1JOaj6DJY9wzYyQCkMeajj9cmuCOzTI4HoptVPVhEUJKeUx4n8hPFsatTyBejRf9/bFmpG7/zx84jo2fbczCQiM7JgmTc6JqnVPch6Mbo3O4OB3WjUHTPAdHUb6ROdQNzs2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817717; c=relaxed/simple;
	bh=+RBA+bxcKCV/cba6P0TZGmcfGLj7aKzCzFFVRDMAVYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dh9xbxVpgvuMpErmUL9450qGGvP6jof4ra9Inmtf+ebUZFqaN7+Lu+olXTRX4fh9ULxyU9KnCxkA+OuSiWe1ANClFSShqVXYQhcw49pVneiQ6Tf/A4Pi0vF8QOi2tyY5wZ6+31O8LooEHp67PFTjdr2Nfsyjk/C8cBx2pqn/lsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E5D/5lA3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yAHt4jjO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E5D/5lA3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yAHt4jjO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E5D/5lA3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yAHt4jjO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E5D/5lA3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yAHt4jjO"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 758D81FD10;
	Mon,  1 Jul 2024 07:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719817713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mf2P1vKclwSkkHmlpVTjjIq7zNNr2YdrgwLcDz6LPLA=;
	b=E5D/5lA3GPdQFrm+DcB4lsbtZLBdLeBM+lNrcmDidhzEaUD1nAPrI6mkx4k8UDnqQ+RNcN
	N107auTvzRLKpKS89GFAldnYPZiwfiSK0XGA6trhJ5OtmT38wPUO6qY8zs4TlRko3hIKiU
	1rkvu1dE7fygT626EnUUn9ADQgKaXo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719817713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mf2P1vKclwSkkHmlpVTjjIq7zNNr2YdrgwLcDz6LPLA=;
	b=yAHt4jjOMQ/N2PreKfsA3TRswfX1942nBBDfwFEYV3G30JmdIwg4pK3PrfHvpSXDyAbHQ/
	dgcATWCOD160+5DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719817713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mf2P1vKclwSkkHmlpVTjjIq7zNNr2YdrgwLcDz6LPLA=;
	b=E5D/5lA3GPdQFrm+DcB4lsbtZLBdLeBM+lNrcmDidhzEaUD1nAPrI6mkx4k8UDnqQ+RNcN
	N107auTvzRLKpKS89GFAldnYPZiwfiSK0XGA6trhJ5OtmT38wPUO6qY8zs4TlRko3hIKiU
	1rkvu1dE7fygT626EnUUn9ADQgKaXo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719817713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mf2P1vKclwSkkHmlpVTjjIq7zNNr2YdrgwLcDz6LPLA=;
	b=yAHt4jjOMQ/N2PreKfsA3TRswfX1942nBBDfwFEYV3G30JmdIwg4pK3PrfHvpSXDyAbHQ/
	dgcATWCOD160+5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53CF4139C2;
	Mon,  1 Jul 2024 07:08:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GrByE/FVgmbqaQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 01 Jul 2024 07:08:33 +0000
Date: Mon, 1 Jul 2024 09:08:32 +0200
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
Message-ID: <b2ncik6c7xicsnzihhwfjjqood2yys52tzotohjnxj6o2mapg5@m364yzsjbvs2>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
 <ZoFgLxGXrk4VCR03@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoFgLxGXrk4VCR03@fedora>
X-Spamd-Result: default: False [-2.29 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
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
X-Spam-Score: -2.29
X-Spam-Level: 

On Sun, Jun 30, 2024 at 09:39:59PM GMT, Ming Lei wrote:
> > Make group_cpus_evenly aware of isolcpus configuration and use the
> > housekeeping CPU mask as base for distributing the available CPUs into
> > groups.
> > 
> > Fixes: 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed interrupts")
> 
> isolated CPUs are actually handled when figuring out irq effective mask,
> so not sure how commit 11ea68f553e2 is wrong, and what is fixed in this
> patch from user viewpoint?

IO queues are allocated/spread on the isolated CPUs and if there is an
thread submitting IOs from an isolated CPU it will cause noise on the
isolated CPUs. The question is this a use case you need/want to support?
We have customers who are complaining that even with isolcpus provided
they still see IO noise on the isolated CPUs.
