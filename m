Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F96C38885C
	for <linux-block@vger.kernel.org>; Tue, 10 Feb 2026 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740890; cv=none; b=Sj48wsnja3lE/ABxDVNSWwgVtMunsE/yEZvJuzjKZSuKhpNzU5lZyTmW0wwzRRbgn1mG4c+P5foc4h6XNrJHormNi+epPmXycLwvGPLODavGNOAx1tApp42ASrj98mn4RE1rty5Kg/LXW0rj2NREFJngoCNgCz0xdwhrJTYZ0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740890; c=relaxed/simple;
	bh=DH3k4FdGPdWWQRQ6qmhNiFNtxu/TvUz5786JIq53OKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0kqjAnl5SKfrDqL+ShHUgtOQWBW9A1zm/QP93IykZhmHh5UlOr7XW/WUjFbLLx3s4vg8iVBn+Iyrxzl68b2PFAk2oiifoaMyBc58YldSZQ+YBntDwXzv+l/HTzaiWcgIcg8057skurj6Rig4zYQ/qU3ZPv2ENzekO1nSg5Zi/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ugm4qDQz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b7YKrMfv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ugm4qDQz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b7YKrMfv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ugm4qDQz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b7YKrMfv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ugm4qDQz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b7YKrMfv"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4EA0E3E712;
	Tue, 10 Feb 2026 16:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770740887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nAVsEo8GmnBUTthGDjzzMOFlPvlLeck1eI358Mycbwo=;
	b=ugm4qDQznhpOWKcyUIGTZHtVYaZM8SCUGsqKfy9U/oNutiefPjZuYeJJXouvdFS1PIC5dp
	VG1duQEusSsTFBYwaCgQ8LXedBEGI7GyrQ6CIQzkqp7oRXVY7UXfSITUO7KYjAMOc7OKRQ
	QtWWzB7mD7098ykplzK4zz4LJmSIJ18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770740887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nAVsEo8GmnBUTthGDjzzMOFlPvlLeck1eI358Mycbwo=;
	b=b7YKrMfvHozmd7LuRgInoCwFe/lFsljMEz8EVUYTaWY88c//gKTkKWgSfxZROXObFqB/MQ
	2EOa+bGorSnHLYAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ugm4qDQz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=b7YKrMfv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770740887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nAVsEo8GmnBUTthGDjzzMOFlPvlLeck1eI358Mycbwo=;
	b=ugm4qDQznhpOWKcyUIGTZHtVYaZM8SCUGsqKfy9U/oNutiefPjZuYeJJXouvdFS1PIC5dp
	VG1duQEusSsTFBYwaCgQ8LXedBEGI7GyrQ6CIQzkqp7oRXVY7UXfSITUO7KYjAMOc7OKRQ
	QtWWzB7mD7098ykplzK4zz4LJmSIJ18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770740887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nAVsEo8GmnBUTthGDjzzMOFlPvlLeck1eI358Mycbwo=;
	b=b7YKrMfvHozmd7LuRgInoCwFe/lFsljMEz8EVUYTaWY88c//gKTkKWgSfxZROXObFqB/MQ
	2EOa+bGorSnHLYAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 352B73EA62;
	Tue, 10 Feb 2026 16:28:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WTtZDJdci2nYdwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 10 Feb 2026 16:28:07 +0000
Date: Tue, 10 Feb 2026 17:28:02 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai@fnnas.com>, 
	axboe@kernel.dk, sagi@grimberg.me, sven@kernel.org, j@jannau.net, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, tj@kernel.org, 
	nilay@linux.ibm.com, ming.lei@redhat.com, neal@gompa.dev, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
Message-ID: <f3451ddd-96b6-4bc1-9d4c-964e361d56fc@flourine.local>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-4-yukuai@fnnas.com>
 <20260209145832.GC18315@lst.de>
 <aYn-xwFHCpd7sITJ@kbusch-mbp>
 <e3e7d95b-2712-4365-922d-731449e7193a@fnnas.com>
 <aYtKFNm-wRKn6l66@kbusch-mbp>
 <20260210154108.GB2484@lst.de>
 <aYtWSscg6L9xxlzc@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYtWSscg6L9xxlzc@kbusch-mbp>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 4EA0E3E712
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Tue, Feb 10, 2026 at 09:01:14AM -0700, Keith Busch wrote:
> On Tue, Feb 10, 2026 at 04:41:08PM +0100, Christoph Hellwig wrote:
> > On Tue, Feb 10, 2026 at 08:09:08AM -0700, Keith Busch wrote:
> > > If you leave the queue quiesced, pending IO will form requests that are
> > > entered and waiting in the block layer. You can't freeze a queue with
> > > entered requests.
> > > 
> > > We unquiesce first to flush any pending IO that had entered during the
> > > prior reset. It's not the best way to handle this situation. It would be
> > > smarter to steal the bio's from all the entered requests, then end those
> > > requests, then resubmit the bios after the hw queues are initialized. We
> > > don't do that because no one's really complained, probably because the
> > > queue counts don't usually change after a reset.
> > 
> > FYI, Daniel Wagner had been thinking about doing this reinsert for
> > something (I forgot what exactly),

This feature would solve a tricky problem with isolation patches:

https://lore.kernel.org/linux-nvme/87cy7vrbc4.ffs@tglx/

Currently, it's not possible to take the cpu hotplug lock which would
prevent races in the cpu-queue mapping. The current logic depends on
making progress in the error case. If it would be possible to fail the
in-flight request in the error handler and reinsert them in the block
layer, progress could be guaranteed when holding the cpu hotplug lock.

Unfortunatly, haven't found time to implement and test this idea so far.
Sorry.
