Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED1B4E9C29;
	Wed, 14 Oct 2026 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981994; cv=none; b=KLAhWs4BNND3g80ZRYIoaODBA0IzA2BLdnzY4uzyoEhtj8XyAfClGaJdz5APSzgV+WXWLhieQ8s0ntvHmjn8aQkHNHpuXzTUOvOVWOGiez4MFEorJ0lvJf+bNe7CEwHNAVYqLaq1mBrAZj79/yYDVJjLwxGX4Jvw1Q2EHwzBe/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981994; c=relaxed/simple;
	bh=lraDbSUwAu7Z6xHj08mL74wjdccsueS4o1yJiXkADz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTARN4E+elCM4MIvjRC29WYjFjQyueKgKckVbKJAFaumAb7SK44bEw9jw6dT9YIBlmtcscsfVj7tL8zratvQUL4isz3or1FAsTm2nYXPub5k+h2YU0Z8JQ6yGdoeiB2ThMGCkJQxHYD4G4oVyJW83V/2D7pNV5mJwhmfwxBBjMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y8wy5yfd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Yrj976DB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y8wy5yfd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Yrj976DB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y8wy5yfd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Yrj976DB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y8wy5yfd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Yrj976DB"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E1441FB60;
	Wed, 14 Oct 2026 12:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791981976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4yChObc0Pr5+TH+wCOECBsU64iiuVGH1brRjSQo7/o=;
	b=Y8wy5yfdVq86Q5k04TxfBS38OWfohfpK1BVq6eZQXND0tTrbWUnl8uHBfdrIHynssv7VJb
	XIjQoRX+rRrnYYdB3mgqtIvomogrpVaVtKH+XnUmG2/T9Bjp+SsXS802R83YO7y9otUgld
	THgJSEN6Urr5x8gPNY50lA/E8DVa8bY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791981976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4yChObc0Pr5+TH+wCOECBsU64iiuVGH1brRjSQo7/o=;
	b=Yrj976DB4rU9pA3E8wU7wCw9IFFFaX7mPxnvh4eSK1s8LcxoMa7Hr9f0zX43R9fT6qi6bV
	SWCSnsNkOTIbH9BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791981976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4yChObc0Pr5+TH+wCOECBsU64iiuVGH1brRjSQo7/o=;
	b=Y8wy5yfdVq86Q5k04TxfBS38OWfohfpK1BVq6eZQXND0tTrbWUnl8uHBfdrIHynssv7VJb
	XIjQoRX+rRrnYYdB3mgqtIvomogrpVaVtKH+XnUmG2/T9Bjp+SsXS802R83YO7y9otUgld
	THgJSEN6Urr5x8gPNY50lA/E8DVa8bY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791981976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4yChObc0Pr5+TH+wCOECBsU64iiuVGH1brRjSQo7/o=;
	b=Yrj976DB4rU9pA3E8wU7wCw9IFFFaX7mPxnvh4eSK1s8LcxoMa7Hr9f0zX43R9fT6qi6bV
	SWCSnsNkOTIbH9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6D6A1368E;
	Wed, 14 Oct 2026 12:46:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4fQEGJd5z2oXDQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Oct 2026 12:46:15 +0000
Date: Wed, 14 Oct 2026 14:46:10 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>, 
	Surabhi Gogte <sgogte@purestorage.com>, Hannes Reinecke <hare@kernel.org>, 
	Nilay Shroff <nilay@linux.ibm.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>, Maurizio Lombardi <mlombard@redhat.com>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH 1/5] nvme-tcp: initialize pf_cache_lock when allocating
 the controller
Message-ID: <93fdde74-b362-4b06-a08e-c5027bd5619d@flourine.local>
References: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
 <20261014-nvme-fabrics-isolcpu-v1-1-355156be27b2@kernel.org>
 <20261014110804.VsqI0ZaP@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014110804.VsqI0ZaP@linutronix.de>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,infradead.org:url]
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, Oct 14, 2026 at 01:08:04PM +0200, Sebastian Andrzej Siewior wrote:
> > Initialize pf_cache_lock for all queues when allocating the controller
> > and keep it for the lifetime of the controller.
> > 
> > Fixes: 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation and startup")
> 
> I only see 2a8513091d2f0 ("nvme-rdma: parallelize I/O queue allocation
> and startup"). That tcp commit is not in next-20261013.

The commit is in

https://git.infradead.org/?p=nvme.git;a=shortlog;h=refs/heads/nvme-7.4

but I missed the nvme-rdma version of it. It's about time to merge this
into common code.

Thanks,
Daniel
