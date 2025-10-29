Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A5233468F
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730595; cv=none; b=QZWU0IKMZki1UQM05MckrpJF/9+I0FGFkHqDT4KvsAm0PK6LqBj+EJ4E0WXnNU+B8ddyeTLDmaJGMUuwOVcJfDBV4evRa+OEJHYtle2Gmg6L+Urw8GJXPu0nEtG0E5ZXCmXAtKqrnH8TCKQoJZ0nBY6mKWLzDoM60u98iE9pOQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730595; c=relaxed/simple;
	bh=JU7QrsZLf15J+89iNKo+w3/EF36mGD83dag6eMRh0jc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WdlM/0jzE1F27e32iOQ89PphHsf4TY0VL+6hHB7hr6T09xM0qI8cFXjHWDPNj3q6LQx/y1BPQ1abDmwRRZa7kBsrmlE3uIgg5FfITKFCCTBx0ybMuctn6ChUq0PkjoUb4HjhOvlHYhy7GdY4GY9x3/woLTjbFcAatLqW0y4U/9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CbKk1HhJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CbKk1HhJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CbKk1HhJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CbKk1HhJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 110FA204C5;
	Wed, 29 Oct 2025 09:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761730591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JU7QrsZLf15J+89iNKo+w3/EF36mGD83dag6eMRh0jc=;
	b=CbKk1HhJU0lQhBkXUpLz9SZniyQpCoT+aihpdi+Wt15tYs8pTdE8XbDeNMCKprMBr3ZTNC
	rZKzcHc0SDNr3yU/U76QpGQKn3YFr4aYXJfqMZrp8LbbNy/KP+A7gxMzKBFx6eWfhrzxAO
	bxgJAPGLdd5dT+c7UBDljHj7gCUlOpA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=CbKk1HhJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761730591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JU7QrsZLf15J+89iNKo+w3/EF36mGD83dag6eMRh0jc=;
	b=CbKk1HhJU0lQhBkXUpLz9SZniyQpCoT+aihpdi+Wt15tYs8pTdE8XbDeNMCKprMBr3ZTNC
	rZKzcHc0SDNr3yU/U76QpGQKn3YFr4aYXJfqMZrp8LbbNy/KP+A7gxMzKBFx6eWfhrzxAO
	bxgJAPGLdd5dT+c7UBDljHj7gCUlOpA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC7E31396A;
	Wed, 29 Oct 2025 09:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tKW1NB7gAWkZCQAAD6G6ig
	(envelope-from <mwilck@suse.com>); Wed, 29 Oct 2025 09:36:30 +0000
Message-ID: <91b583c2fad9f1e72ed5dc794a709289de363a39.camel@suse.com>
Subject: Re: [PATCH 0/3] Fix a deadlock related to modifying queue attributes
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, Benjamin Marzinski <bmarzins@redhat.com>,
 Hannes Reinecke <hare@suse.com>
Date: Wed, 29 Oct 2025 10:36:30 +0100
In-Reply-To: <20251029085810.GA32474@lst.de>
References: <20250702182430.3764163-1-bvanassche@acm.org>
	 <20250703090906.GG4757@lst.de>
	 <918963a5-a349-433a-80a8-6d06c609f20e@acm.org>
	 <20250708095707.GA28737@lst.de>
	 <b23c05be-2bde-424a-a275-811ccc01567c@acm.org>
	 <20250710080341.GA8622@lst.de>
	 <563ef9b02d49fa05418c7a1b0b384d898819e0e9.camel@suse.com>
	 <20251029085810.GA32474@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 110FA204C5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid]
X-Spam-Score: -4.51

On Wed, 2025-10-29 at 09:58 +0100, Christoph Hellwig wrote:
> On Mon, Oct 27, 2025 at 03:43:50PM +0100, Martin Wilck wrote:
> > As Bart's patch only addresses the regression introduced by
> > b07a889e8335 ("block: move q->sysfs_lock and queue-freeze under
> > show/store method"), can we perhaps leave non-sysfs users of queue
> > freezing aside in this context?
> >=20
> > As far as sysfs users are concerned, what problem do you see with
> > Bart's approach to introduce a timeout for freezing the queues, and
> > returning an error to user space if this timeout is exceeded?
> >=20
> > Would you be willing to accept the set if we'd use the timeout
> > approach
> > for all affected sysfs attributes?
>=20
> Maybe it's because the discussion, but I have no idea what you are
> trying to advocate for.=C2=A0 But a timeout for a locking operation is
> not an option to work around deadlocks.

Consider it a "trylock" type of operation, which is a valid method to
avoid deadlocks, AFAIK.

When we need to freeze a queue for changing a sysfs attribute, we try
to freeze it, and fail (releasing the limits_lock) if we can't. IMO
failing in this use case is totally legitimate, and obviously better
than the "deadlock" situation described by Bart.=C2=A0User space can
implement retries in situations like this if it really needs to modify
the attribute.

Technically, the "trylock" must be implemented using a timeout, because
freezing a queue isn't an atomic operation as is taking a lock.

Regards,
Martin
