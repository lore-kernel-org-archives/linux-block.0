Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C23B3FD133
	for <linux-block@vger.kernel.org>; Mon,  2 Mar 2026 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461657; cv=none; b=EnQTsNYC2C63YmzmXMdsWLg2koTeF1RdOMdKN9ma2UIqifgjGQ0ya6L9XG8zngh2oJ2rAUVNccJhDOjliYQZyQFgSKbQmPWFVLobdLBfJRZiQ8xwArnFUZfExivpm4DRSz6+0u/i9Z6Ox/dUcLf9ePEmuhHOt4TfpaE0P6Pyja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461657; c=relaxed/simple;
	bh=Q9eGYiVwvpl56cxrU5qeL0eFz3Gem70suH5Bn8hceCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGQpu9CF9SfkYlZbIHXbr3Q4fMS2WZwsYODxB5KglOqys3tIREwOWRFENRQDhKxPCXdU5pfw8SDzrudUmFN+nRbV9qas75D6u3y5FFh0RN0R7yiuZ6kDbBF7u6Dbkx+0ZvqC0pX0VLDMDiMgfH1qBlMC4oTsuUIrG7pdCQ4ki4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RgixIbEd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=omXmbYwR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RgixIbEd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=omXmbYwR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RgixIbEd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="omXmbYwR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RgixIbEd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="omXmbYwR"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 956A05BDAD;
	Mon,  2 Mar 2026 14:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772461653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HEH02N549kjA0DcZAq+xGgOPixfyI6A9IeP4FqRBCQQ=;
	b=RgixIbEdOX2xwOfUPhriC5N73m1NUQ+FQvagI3gJLDvPKo+KwbwPLKvLEK4XrlIeFHRR0V
	lETA+xk0CIevU1b6z31FtL2uZODhwG3exsg8MxprzWzadGyFuRQ72Zhdjb7E1QMEhTXHPP
	6iXv8FqJ7mcGkWUYpk33FzgcUoNbE8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772461653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HEH02N549kjA0DcZAq+xGgOPixfyI6A9IeP4FqRBCQQ=;
	b=omXmbYwRsRykwKV+v728fpwb1QubqxrIbjNzU6Z0vqiRN0dUZDMpOvjzPYLEjQ1zY1/FnT
	eFOqo8dOKjg5MsDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RgixIbEd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=omXmbYwR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772461653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HEH02N549kjA0DcZAq+xGgOPixfyI6A9IeP4FqRBCQQ=;
	b=RgixIbEdOX2xwOfUPhriC5N73m1NUQ+FQvagI3gJLDvPKo+KwbwPLKvLEK4XrlIeFHRR0V
	lETA+xk0CIevU1b6z31FtL2uZODhwG3exsg8MxprzWzadGyFuRQ72Zhdjb7E1QMEhTXHPP
	6iXv8FqJ7mcGkWUYpk33FzgcUoNbE8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772461653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HEH02N549kjA0DcZAq+xGgOPixfyI6A9IeP4FqRBCQQ=;
	b=omXmbYwRsRykwKV+v728fpwb1QubqxrIbjNzU6Z0vqiRN0dUZDMpOvjzPYLEjQ1zY1/FnT
	eFOqo8dOKjg5MsDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A3D83EA6C;
	Mon,  2 Mar 2026 14:27:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VqnfE1WepWlQOAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 02 Mar 2026 14:27:33 +0000
Date: Mon, 2 Mar 2026 15:27:24 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Guangwu Zhang <guazhang@redhat.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Thomas Gleixner <tglx@kernel.org>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] Revert "lib/group_cpus.c: avoid acquiring cpu
 hotplug lock in group_cpus_evenly"
Message-ID: <0195766f-c2fd-4ed5-94e6-36dfe0895f21@flourine.local>
References: <20260226-revert-cpu-read-lock-v1-0-eb005072566e@kernel.org>
 <20260226-revert-cpu-read-lock-v1-3-eb005072566e@kernel.org>
 <aaBS4pvtiFHL1LSz@fedora>
 <eb461226-1b64-4b67-a419-5b5886792d68@flourine.local>
 <CAFj5m9LQ6KOhu0CsqYgW_9xZGDAj5KdUfX2gXAy_HODba-0GnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFj5m9LQ6KOhu0CsqYgW_9xZGDAj5KdUfX2gXAy_HODba-0GnA@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,flourine.local:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 956A05BDAD
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On Mon, Mar 02, 2026 at 10:12:49PM +0800, Ming Lei wrote:
> > Sure, I would like to add the lock back to group_cpus_evenly so it's
> > possible to add support for the isolcpu use case. For the isolcpus case,
> > it's necessary to access the cpu_online_mask when creating a
> > housekeeping cpu mask. I failed to find a good solution which doesn't
> > introduce horrible hacks (see Thomas' feedback on this [1]).
> >
> > Anyway, I am not totally set on this solution, but I having a proper
> > lock in this code path would make the isolcpu extension way cleaner I
> > think.
> 
> Then please include this patch with an explanation in your isolcpus
> patch set.

I didn't add it in the commit message because the code is not there yet,
thus only mentioned it the cover letter. But sure, I'll add this info.

> > What do you exactly mean with 'API hard to use'? The problem that the
> > caller/driver has to make sure it doesn't do anything like the nvme-pci
> > driver?
> 
> This API is usually called in slow path, in which subsystem locks are often
> required, then lock dependency against cpus_read_lock is added.

Yes, that's very reason I came up with this handshake protocol, which
only covers the block layer subsystem. I wonder if it would be possible
to do a lock free version with a retry check at the end. When a cpu
hotplug event happended during the calculation, start over. For this
some sort of generation count for cpu hotplug events would be handy. Just
think loud.
