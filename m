Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7743C488;
	Mon, 24 Jun 2024 07:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719213197; cv=none; b=jWg0bw6e4CRvwgdpGhzj3bOWRdAqEjXRKZ2WTIgReybEZYMNkOOwpfJBgUlQfVtUd5p28KmN9N1PusSPrdFaoWZ7ciHdnQVoCJiLTZAb8rpQzZA/Fg2lmwoWuiVG4cXloO0f2VYu3TuLycwMJ1h0+oOC3z6jaVT5Wx6PJzX7qrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719213197; c=relaxed/simple;
	bh=iTdtiEwt9/HJOLVwSAPvN2XojIrFY/KVShnhsvo1OKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMI3u9rxGm63yTqv0gBcYpWUusZByENjFAFTJ1tgrXsXUIOkz3GYkv08RRYodrcFywojtzQBlNsNLDQLKe2flfZOA7EU81213z12/J3qo68vYbKBOzd5wF2HR2Ru5T+al3h9NbTtE6O37KOdpqivwMGo4NqxeEGkgjU9RMfFzrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XuPjne2P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IQUWtLYK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XuPjne2P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IQUWtLYK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XuPjne2P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IQUWtLYK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XuPjne2P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IQUWtLYK"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 111491F7B8;
	Mon, 24 Jun 2024 07:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719213193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hGdwXDllEsEEQ9aIN8vKYDMClfAsoO/eykqwd28TUUY=;
	b=XuPjne2PyEnx/QmjaV2VH09wnLKuzfWRUZDgbILUusIx8RpTMRM3Oy0gEL+cJORAdZY4cT
	B30BsktTIx0plmkuGKGBpqpT8K43oyl3V9ayV7X31XiaRLjD8R9GQLJ8BzMbOfFcWvEWPQ
	+oWlfpePxbm/2TKv5joEhtmReGFTslw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719213193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hGdwXDllEsEEQ9aIN8vKYDMClfAsoO/eykqwd28TUUY=;
	b=IQUWtLYKVJ88s/pwDMVLWk8DekxzAQGD1ArYT24w84Hqdu/YKuZGNh5m8bTqxHa0iamvX/
	it1sVNVoYXZ5mkBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719213193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hGdwXDllEsEEQ9aIN8vKYDMClfAsoO/eykqwd28TUUY=;
	b=XuPjne2PyEnx/QmjaV2VH09wnLKuzfWRUZDgbILUusIx8RpTMRM3Oy0gEL+cJORAdZY4cT
	B30BsktTIx0plmkuGKGBpqpT8K43oyl3V9ayV7X31XiaRLjD8R9GQLJ8BzMbOfFcWvEWPQ
	+oWlfpePxbm/2TKv5joEhtmReGFTslw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719213193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hGdwXDllEsEEQ9aIN8vKYDMClfAsoO/eykqwd28TUUY=;
	b=IQUWtLYKVJ88s/pwDMVLWk8DekxzAQGD1ArYT24w84Hqdu/YKuZGNh5m8bTqxHa0iamvX/
	it1sVNVoYXZ5mkBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DCAD13ACD;
	Mon, 24 Jun 2024 07:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3YGmEIUceWZReAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 24 Jun 2024 07:13:09 +0000
Date: Mon, 24 Jun 2024 09:13:06 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Frederic Weisbecker <fweisbecker@suse.com>, Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
	Sridhar Balaraman <sbalaraman@parallelwireless.com>, "brookxu.cn" <brookxu.cn@gmail.com>, 
	Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] sched/isolation: Add io_queue housekeeping option
Message-ID: <x2mjbnluozxykdtqns47f37ssdkziovkdzchon5zkcadgkuuif@qloym5wjwomm>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
 <20240621-isolcpus-io-queues-v1-1-8b169bf41083@suse.de>
 <20240622051156.GA11303@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622051156.GA11303@lst.de>
X-Spamd-Result: default: False [-2.26 / 50.00];
	BAYES_HAM(-2.96)[99.81%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,grimberg.me,linutronix.de,suse.com,suse.de,parallelwireless.com,gmail.com,redhat.com,vger.kernel.org,lists.infradead.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.26
X-Spam-Level: 

On Sat, Jun 22, 2024 at 07:11:57AM GMT, Christoph Hellwig wrote:
> > diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> > index 2b461129d1fa..fe751d704e99 100644
> > --- a/include/linux/sched/isolation.h
> > +++ b/include/linux/sched/isolation.h
> > @@ -16,6 +16,7 @@ enum hk_type {
> >  	HK_TYPE_WQ,
> >  	HK_TYPE_MANAGED_IRQ,
> >  	HK_TYPE_KTHREAD,
> > +	HK_TYPE_IO_QUEUE,
> >  	HK_TYPE_MAX
> >  };
> 
> It might be a good time to write comments explaining these types?

Sure, will do.

Do you think we should introduce a new type or just use the existing
managed_irq for this?
