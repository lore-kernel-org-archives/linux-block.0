Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F0C7FD;
	Mon, 24 Jun 2024 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219643; cv=none; b=Fy0npXWt/DkUX+a3oCpuqpiHgRgrQsQx/NuVguFPoh4C2SypRwSOiMpB9fMGMM6rqlabgbbRG/3qwJTkBJ/15fGy7ZmruFzxcGzxffJIAwvv7re84F4XpYt4xs0+duPkZzTqCeZ3GrTepl8HF0V84pEWYraw+hkqosBYDM5RVe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219643; c=relaxed/simple;
	bh=ZdOsRNoOnLORnmEqJ9TflATAsGqPdGXGRYobKZatK3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgt2OOClFF/aI95bqgHEQ6Lxkk4Ws4vWCPPQezS4LkKN+wJ3XdUjB3/wckD4aEWc4jY5TQ4OKynxrNwdR59WCm3eP3rBI6k/YQB7uH/3zArcShaH3N5POm67U87Ou4diaLgF5clfXpJHye/AtnUfjIh9ELSTyimOQlhqd4MNkzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k7Qk/8Sh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jjiAQZrz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k7Qk/8Sh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jjiAQZrz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k7Qk/8Sh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jjiAQZrz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k7Qk/8Sh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jjiAQZrz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A44831F7C8;
	Mon, 24 Jun 2024 09:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719219639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3M+xqiHVsLRWv+q0oA21UzkBuskfOH8bxd3bGy+CgE=;
	b=k7Qk/8ShYPG+fcdLhpx3bcl8CQQhf00EixuPOB4iv6OCCnCQd7gcp++92E4Z9qVIPwG+ja
	z0P7ShT02tylVOT6os6EQhB5d9nw1VkTw1lCJnOyeyOEsrenofo3Y9L4HAnHYoD04koRpz
	dmSmU0F4NGBQW1P5s98Vuuv0U0qAuUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719219639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3M+xqiHVsLRWv+q0oA21UzkBuskfOH8bxd3bGy+CgE=;
	b=jjiAQZrzj0zI0Jpk+uolyyMZU6YW6Z+l/YEn+heltlaX2PV0pJQ4wy7ZN5aKypV9OcQ9SH
	ZdsWCOwsyzA6NzBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="k7Qk/8Sh";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jjiAQZrz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719219639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3M+xqiHVsLRWv+q0oA21UzkBuskfOH8bxd3bGy+CgE=;
	b=k7Qk/8ShYPG+fcdLhpx3bcl8CQQhf00EixuPOB4iv6OCCnCQd7gcp++92E4Z9qVIPwG+ja
	z0P7ShT02tylVOT6os6EQhB5d9nw1VkTw1lCJnOyeyOEsrenofo3Y9L4HAnHYoD04koRpz
	dmSmU0F4NGBQW1P5s98Vuuv0U0qAuUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719219639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3M+xqiHVsLRWv+q0oA21UzkBuskfOH8bxd3bGy+CgE=;
	b=jjiAQZrzj0zI0Jpk+uolyyMZU6YW6Z+l/YEn+heltlaX2PV0pJQ4wy7ZN5aKypV9OcQ9SH
	ZdsWCOwsyzA6NzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 983F313ACD;
	Mon, 24 Jun 2024 09:00:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5mUnJbc1eWY7HAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 24 Jun 2024 09:00:39 +0000
Date: Mon, 24 Jun 2024 11:00:39 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Frederic Weisbecker <fweisbecker@suse.com>, Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
	Sridhar Balaraman <sbalaraman@parallelwireless.com>, "brookxu.cn" <brookxu.cn@gmail.com>, 
	Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] sched/isolation: Add io_queue housekeeping option
Message-ID: <sjna556zvxyyj6as5pk6bbgmdwoiybl4gubqnlrxyfdvhbnlma@ewka5cxxowr7>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
 <20240621-isolcpus-io-queues-v1-1-8b169bf41083@suse.de>
 <20240622051156.GA11303@lst.de>
 <x2mjbnluozxykdtqns47f37ssdkziovkdzchon5zkcadgkuuif@qloym5wjwomm>
 <20240624084705.GA20292@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624084705.GA20292@lst.de>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,grimberg.me,linutronix.de,suse.com,suse.de,parallelwireless.com,gmail.com,redhat.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A44831F7C8
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 

On Mon, Jun 24, 2024 at 10:47:05AM GMT, Christoph Hellwig wrote:
> > Do you think we should introduce a new type or just use the existing
> > managed_irq for this?
> 
> No idea really.  What was the reason for adding a new one?

I've added the new type so that the current behavior of spreading the
queues over to the isolated CPUs is still possible. I don't know if this
a valid use case or not. I just didn't wanted to kill this feature it
without having discussed it before.

But if we agree this doesn't really makes sense with isolcpus, then I
think we should use the managed_irq one as nvme-pci is using the managed
IRQ API.
