Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF0E34CFBA
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521857; cv=none; b=kUIuf0mRXuymeAIihiWbqHZp+Z/mEtcABPJPUAgQu2DNtY4JtwzSIK6EFqM6mvu7Fn8tvTPBSwLTBkwsvMEjXvbWzk1KPE5gUdeCJOeyBFG9csCSve+yOoMpP7H6uRyd3aPLvmg009N5GeYvLYkryPeXlgYm0LyGsXR6Msj8PI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521857; c=relaxed/simple;
	bh=CUrvOOSpgTgq2Vs2HwoX/nmXG+JeBxLUPbgeVrvTpvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6MQI0FC+aj7sYlJPWuB98pbzp5mwHQNt/1sT/GPKpiOf0nc0i9oEEnKpxprN+L1lqoV6jzeMdXWjsacoZwt5ABjrzEA9F9dFz5qomQMdz/izs057zBoOh2/pxtEMOcKHfGkwxZIy/R4McaMXsPlaepio0XR01BPfc1TMx8pkHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OW8HqvS+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9yj5aC0I; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OW8HqvS+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9yj5aC0I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OW8HqvS+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9yj5aC0I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OW8HqvS+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9yj5aC0I"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B3475BD0F;
	Thu, 19 Feb 2026 17:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771521854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3aAYc1ZZs6ZaE0c3zSxai/gVSJLHwmYv23eJZTdoHRc=;
	b=OW8HqvS+u0y29fQlAANvMBCY5C3jonHuAPfG0useQJTK1GNog0vKqgJjesA1eFip43Jp84
	oVp5RCq8Mj/KL4AxU/EFjkJh2RdU8TAyRnEgPA2scvJ/4XEEsjVwwFl4JwpYn/1NPox6qV
	vol4m32c2exb0t96aJNQkBB62TY7NrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771521854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3aAYc1ZZs6ZaE0c3zSxai/gVSJLHwmYv23eJZTdoHRc=;
	b=9yj5aC0IHOqymlaYdyMS9D0k5gWa5NWujR6vX0GShqLH/dN5smRvRRECMD3Vaux+AngqFC
	hkUFnThbzRo1PoCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OW8HqvS+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9yj5aC0I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771521854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3aAYc1ZZs6ZaE0c3zSxai/gVSJLHwmYv23eJZTdoHRc=;
	b=OW8HqvS+u0y29fQlAANvMBCY5C3jonHuAPfG0useQJTK1GNog0vKqgJjesA1eFip43Jp84
	oVp5RCq8Mj/KL4AxU/EFjkJh2RdU8TAyRnEgPA2scvJ/4XEEsjVwwFl4JwpYn/1NPox6qV
	vol4m32c2exb0t96aJNQkBB62TY7NrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771521854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3aAYc1ZZs6ZaE0c3zSxai/gVSJLHwmYv23eJZTdoHRc=;
	b=9yj5aC0IHOqymlaYdyMS9D0k5gWa5NWujR6vX0GShqLH/dN5smRvRRECMD3Vaux+AngqFC
	hkUFnThbzRo1PoCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F5DB3EA65;
	Thu, 19 Feb 2026 17:24:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FDbKAj5Hl2mmKQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 19 Feb 2026 17:24:14 +0000
Date: Thu, 19 Feb 2026 18:23:58 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Kees Cook <kees@kernel.org>, Gogul Balakrishnan <bgogul@google.com>, 
	Arman Hasanzadeh <armanihm@google.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] blkdev: Annotate struct request_queue with
 __counted_by_ptr
Message-ID: <e3c0a209-56f7-4ac2-b089-e0600672cf25@flourine.local>
References: <20260219004940.2594201-1-morbo@google.com>
 <9b7a107e-bc07-4a75-86b0-2685d4c78bb9@flourine.local>
 <CAGG=3QXcA7et9LmZ+Cu8zn1yBXrPizL7BhYFvfFZpWA7aUR3xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QXcA7et9LmZ+Cu8zn1yBXrPizL7BhYFvfFZpWA7aUR3xw@mail.gmail.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2B3475BD0F

On Thu, Feb 19, 2026 at 09:02:12AM -0800, Bill Wendling wrote:
> It's normally fine to change the queue count just as long as either
> (1) the pointer to the queues is also reallocated, or (2) the count
> never goes over the original allocated value. (The second one is more
> difficult to check, of course.) The bounds safety features that Apple
> developed, and which are slowly being sent upstream, enforces (1).
> 
> I'll run the other tests, but I'm not familiar with the blktests (I
> downloaded them but haven't looked too deeply into them). Do you have
> some pointers on how to run them with a newly built kernel?

blktests has feature detection and every tests figures out, if it can
run or not. It will print some info when it's not possible.

The block test suite has at least a couple related tests:

./check block/029 block/040

This suite wants null_blk driver.

And for nvme/048 the fabrics parts needs to be used:

  NVMET_TRTYPES="tcp" ./check nvme/048

and the nvme-fabrics part nvme-tcp and nvmet-tcp.

If you need the exact config option I can compile you a list.

