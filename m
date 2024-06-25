Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2313A252;
	Tue, 25 Jun 2024 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305874; cv=none; b=qpIGkFS4aQlPCyT1G3HMzWBw2s4BI6dfE5iyORQH+CfA8Lvg5xaohb0XbnFlnxOaWYdDnXU5VGLm8q4GuvtS0AhB90wdjdirPqwIXKZb7cxoIxJPJThjNB6be1fZW/ZJpLxIv78s2KlthIRKoSOkKvos0ugcNTd+VFpkIpMtl2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305874; c=relaxed/simple;
	bh=Bt44MWjSmQh4ybu+gQWRv0eFpTA9/ta5LwmLPJcuEg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC+qJizlVCve8lynUxrKwv+zh9/0TirtuFfdoz7jo9GON+lyttUhAnwjKfvNJcc4R5yfnNAGgHAZYAYmztQVL60BOWmwXfO+dtxZBox88va2yb/Q5B/W9ysTccrDGepaM4oI2zPB+YINy6zAZrIYWR57EjFxnqHGy8vhqBX6brs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EvB9fFdk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kJDBYi6x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lLGWY32y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fCDG/Nxf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EvB9fFdk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kJDBYi6x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lLGWY32y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fCDG/Nxf"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E39CC1F7D3;
	Tue, 25 Jun 2024 08:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719305871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgrnSv7iTsORqiBqIbgAFanma+OLSb36OJTxyTfWs8A=;
	b=EvB9fFdkD+Sop+gsGm20VvTbFcL5U04T+3ULHB8KIUL95RbBbEApOMewpM2Xc8Z9zK6HQS
	vnrNa6FUw+e+1ew3LREZZaUJNo7BXVc2GBXiRMNBNfnX7rZfUW0+kdQPjqCDiKAt0R5ZdS
	PbpiaxpmL4dGGMkN4MX/ua2z6xf6md8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719305871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgrnSv7iTsORqiBqIbgAFanma+OLSb36OJTxyTfWs8A=;
	b=kJDBYi6xqWkn4x42bKVzxW2FGnKTdDUWAS4g4TG4+5w031jEP7umiactHn/TtywgGUqjXA
	35bOGL24O+zUdaAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719305870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgrnSv7iTsORqiBqIbgAFanma+OLSb36OJTxyTfWs8A=;
	b=lLGWY32yF5j0kwO7OBOonfkM6oIZB1LQW2hrc1oBvuf28zUkLAPHj9YfdoETurlqVKx8uB
	hjrntORUK2oSHu9nAE9xPwQ/Pv+72vDSD5oXsAy3KWjw0RCn2KjMzMsJmhEuw8pgMjygek
	mxtxTJq/6kr3+8jTKY4Bv+6/HEs7+/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719305870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgrnSv7iTsORqiBqIbgAFanma+OLSb36OJTxyTfWs8A=;
	b=fCDG/Nxf5Riz7Jnv5fCpd+9O/F2i8/BTJ1xbRptUXcGq6fzEe+L71oCEXFo886mXYMVKJR
	SW7Reb6ZWhSXCaBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3D391384C;
	Tue, 25 Jun 2024 08:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4RoVM46Gema8PQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 25 Jun 2024 08:57:50 +0000
Date: Tue, 25 Jun 2024 10:57:42 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Frederic Weisbecker <fweisbecker@suse.com>, 
	Mel Gorman <mgorman@suse.de>, Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
	"brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] sched/isolation: Add io_queue housekeeping option
Message-ID: <rk2ywo6y3ppki2gfogter2p2p2b556kmawqsuqrif3xcalsc2m@aosprmhypcav>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
 <20240621-isolcpus-io-queues-v1-1-8b169bf41083@suse.de>
 <20240622051156.GA11303@lst.de>
 <x2mjbnluozxykdtqns47f37ssdkziovkdzchon5zkcadgkuuif@qloym5wjwomm>
 <20240624084705.GA20292@lst.de>
 <sjna556zvxyyj6as5pk6bbgmdwoiybl4gubqnlrxyfdvhbnlma@ewka5cxxowr7>
 <55315fc9-4439-43b0-a4d2-89ab4ea598f0@suse.de>
 <878qyt7b65.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qyt7b65.ffs@tglx>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,lst.de,kernel.dk,kernel.org,grimberg.me,suse.com,parallelwireless.com,gmail.com,vger.kernel.org,lists.infradead.org,linutronix.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Tue, Jun 25, 2024 at 09:07:30AM GMT, Thomas Gleixner wrote:
> On Tue, Jun 25 2024 at 08:37, Hannes Reinecke wrote:
> > On 6/24/24 11:00, Daniel Wagner wrote:
> >> On Mon, Jun 24, 2024 at 10:47:05AM GMT, Christoph Hellwig wrote:
> >>>> Do you think we should introduce a new type or just use the existing
> >>>> managed_irq for this?
> >>>
> >>> No idea really.  What was the reason for adding a new one?
> >> 
> >> I've added the new type so that the current behavior of spreading the
> >> queues over to the isolated CPUs is still possible. I don't know if this
> >> a valid use case or not. I just didn't wanted to kill this feature it
> >> without having discussed it before.
> >> 
> >> But if we agree this doesn't really makes sense with isolcpus, then I
> >> think we should use the managed_irq one as nvme-pci is using the managed
> >> IRQ API.
> >> 
> > I'm in favour in expanding/modifying the managed irq case.
> > For managed irqs the driver will be running on the housekeeping CPUs 
> > only, and has no way of even installing irq handlers for the isolcpus.
> 
> Yes, that's preferred, but please double check with the people who
> introduced that in the first place.

The relevant code was added by Ming:

11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed
interrupts")

    [...] it can happen that a managed interrupt whose affinity
    mask contains both isolated and housekeeping CPUs is routed to an isolated
    CPU. As a consequence IO submitted on a housekeeping CPU causes interrupts
    on the isolated CPU.

    Add a new sub-parameter 'managed_irq' for 'isolcpus' and the corresponding
    logic in the interrupt affinity selection code.

    The subparameter indicates to the interrupt affinity selection logic that
    it should try to avoid the above scenario.
    [...]

From the commit message I read the original indent is that managed_irq
should avoid speading queues on isolcated CPUs.

Ming, do you agree to use the managed_irq mask to limit the queue
spreading on isolated CPUs? It would make the io_queue option obsolete.
