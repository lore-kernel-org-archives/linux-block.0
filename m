Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993AA1F91D6
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755382; cv=none; b=sbgxyWb7wWGh/eFIdDQ36Z2bPJ9oX3R7iuve/DwqMyRE7/1lEheUP29L7Sy/7b73nIjLGDac8880Nq8FL0Ome0Si9O8aMb+Y+4v4NPsZ0NylfOfGIYpRGDLAlaE0G7dkSRSGfOEEQ98t3t6CuQ8B5bhpm1qLAbHcWpkS6Ds7V9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755382; c=relaxed/simple;
	bh=LGYh4yFsNCWfW7/mPUqIBluJipDIwDbYxYqWHXASBDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTeQUK7EdNngDagmjsYERAjOLkqOiu3ei2tQ1lK3ZvWq8kOXEJK+DdtQOIbefR3sRm9CGtlO4rRI3DigiFDfBmaXJYwqqI0eRPnSZ2k0il9dWmIHtsw6Y9Ys3i7v6xSYRkxddbLr0lU+9SqoSkf67PmU87zfYNQBc3m+E73yV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Qofe0shh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zh+EswcQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Qofe0shh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zh+EswcQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Qofe0shh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zh+EswcQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Qofe0shh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zh+EswcQ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E08962A8F;
	Thu, 14 May 2026 10:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778755378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0SR15dCMFPgdT5K8dA47qpO4yjgkZru934VF2Xbw6s=;
	b=Qofe0shhVFcgcUHR0AFW1shSUYfxwNIHhLSIlCgkI3hTuKNZxxwt9z0ewg89i1kUgInuZs
	PRm5VTvSOU5A9RRZ6W+h1KfPXDcwBS/hf7qwX6/F7dMO/Cb97v93Ur+WL5u39vYeQ3CgcC
	9Zm+t2jMau3z9fLdm+dilhGdaFRHWaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778755378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0SR15dCMFPgdT5K8dA47qpO4yjgkZru934VF2Xbw6s=;
	b=Zh+EswcQ1b4X/jfhBhEmNYznT4yG20u67ydNl24p10bRh9iLgvLHH8qmk0Zu0TbetDI8vr
	0MN6ubu5NC6fsPCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Qofe0shh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Zh+EswcQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778755378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0SR15dCMFPgdT5K8dA47qpO4yjgkZru934VF2Xbw6s=;
	b=Qofe0shhVFcgcUHR0AFW1shSUYfxwNIHhLSIlCgkI3hTuKNZxxwt9z0ewg89i1kUgInuZs
	PRm5VTvSOU5A9RRZ6W+h1KfPXDcwBS/hf7qwX6/F7dMO/Cb97v93Ur+WL5u39vYeQ3CgcC
	9Zm+t2jMau3z9fLdm+dilhGdaFRHWaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778755378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0SR15dCMFPgdT5K8dA47qpO4yjgkZru934VF2Xbw6s=;
	b=Zh+EswcQ1b4X/jfhBhEmNYznT4yG20u67ydNl24p10bRh9iLgvLHH8qmk0Zu0TbetDI8vr
	0MN6ubu5NC6fsPCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41A1A593A9;
	Thu, 14 May 2026 10:42:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YZwGEDKnBWp5TgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 14 May 2026 10:42:58 +0000
Date: Thu, 14 May 2026 12:42:57 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Daniel Wagner <wagi@monom.org>, axboe@kernel.dk, kbusch@kernel.org, 
	hch@lst.de, sagi@grimberg.me, mst@redhat.com, aacraid@microsemi.com, 
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, liyihang9@h-partners.com, 
	kashyap.desai@broadcom.com, sumit.saxena@broadcom.com, 
	shivasharan.srikanteshwara@broadcom.com, chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com, 
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, 
	jinpu.wang@cloud.ionos.com, tglx@kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, 
	maz@kernel.org, ruanjinjie@huawei.com, bigeasy@linutronix.de, 
	yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org, longman@redhat.com, 
	chenridong@huawei.com, hare@suse.de, kch@nvidia.com, ming.lei@redhat.com, 
	tom.leiming@gmail.com, steve@abita.co, sean@ashe.io, chjohnst@gmail.com, neelx@suse.com, 
	mproche@gmail.com, nick.lange@gmail.com, marco.crivellari@suse.com, 
	rishil1999@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 5/8] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
Message-ID: <70b4cbf0-9137-41de-881b-ff2a60f084ec@flourine.local>
References: <20260513005509.135966-1-atomlin@atomlin.com>
 <20260513005509.135966-6-atomlin@atomlin.com>
 <3af2cd18-1221-4ff6-aa7f-6dab74460eab@nitrogen.local>
 <bovevvg2n77nzdrvjkayca2piibjl4noykv24wthex7em4u5lo@beqyhu2xertk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bovevvg2n77nzdrvjkayca2piibjl4noykv24wthex7em4u5lo@beqyhu2xertk>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[monom.org,kernel.dk,kernel.org,lst.de,grimberg.me,redhat.com,microsemi.com,hansenpartnership.com,oracle.com,h-partners.com,broadcom.com,cloud.ionos.com,infradead.org,linaro.org,linux-foundation.org,huawei.com,linutronix.de,gmail.com,suse.de,nvidia.com,abita.co,ashe.io,suse.com,outlook.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLip3qrwmtdyuwmp1ydoxr43fi)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Queue-Id: 5E08962A8F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

On Wed, May 13, 2026 at 07:30:44PM -0400, Aaron Tomlin wrote:
> > I think this should also check if the CPU is online. The fallback should
> > ensure the system will boot.
> 
> While I completely agree with the goal of ensuring a safe boot, I suspect
> that we actually must iterate over for_each_possible_cpu(cpu) here to
> prevent map boundary violations during CPU hotplug events.

I have to check this version of the patch what is happening in detail.
Originally the idea was that the fallback should only be taken if it's
not possible to create a valid mapping due to $reason. In this case the
system should still boot and issue a warning. This is also what the
comments says in the function, pick one online CPU and map all hctx to
it. Don't bother to be smart.
