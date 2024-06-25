Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2291CFB6;
	Tue, 25 Jun 2024 06:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297459; cv=none; b=KKr83UkPZQKfsGzo0o/AIB78XsxSqwBHbyGVjllkR+bOYNIRHO/yjzuElQ5OtybIwJh80Zyg+DaAEOREsdku2iRpbbzigD6X8loqkyqmunB4MfECA/JMyaW4uC1w3mGCbpJSjYIgtOeo+nTlyBKETXWPSkGRXfpowRnoY3nCrCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297459; c=relaxed/simple;
	bh=a/imagm117zbWVKOdMKcE34gDSGvXoENHOb9TM/AR1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWb0RkNRRHRZc36au6fxGh+xE1uWXPhPoIK+lEAHd4PWtT5+dpZD9lKTK5TsaqEl5vPVQZcR0gI/EedJJXWdJFHwPCMjJOx4anDmYMd3T59Si0dQzuIJjriEddQK0i3oMtdFzTGC9rYjjh8nZRNXFNvRPz/rjdMDG7UYrp7IRek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j7hsXQI1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UtkR0vWH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j7hsXQI1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UtkR0vWH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j7hsXQI1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UtkR0vWH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j7hsXQI1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UtkR0vWH"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F65A1F849;
	Tue, 25 Jun 2024 06:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719297455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Dw67TcI8wAAs6NeF87J/NxxswPE+07yoxyWkCK0pOo=;
	b=j7hsXQI1BBfJ0DmHLbYegDowQcM7GI6Jp7Em+jQFMUS+wFBgzBfqZOfwYy6F6RypI7sJYq
	6EMRvpS6soHeXXgku0TH3BcXE4yUQIJ9CE7s9MP58ODaJK2OVqYaxJIMLP97liB3QCSdj7
	T+dBoT1plJ94GjvVY7zZQ/rLdvZTT8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719297455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Dw67TcI8wAAs6NeF87J/NxxswPE+07yoxyWkCK0pOo=;
	b=UtkR0vWHw/bFimZRLB16FqMqiOI+rummyanAZG4EvbBxIuMGe6CeRYzIXyQTlpjEg2fW10
	Tr4uBWyEnjZynYDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=j7hsXQI1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UtkR0vWH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719297455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Dw67TcI8wAAs6NeF87J/NxxswPE+07yoxyWkCK0pOo=;
	b=j7hsXQI1BBfJ0DmHLbYegDowQcM7GI6Jp7Em+jQFMUS+wFBgzBfqZOfwYy6F6RypI7sJYq
	6EMRvpS6soHeXXgku0TH3BcXE4yUQIJ9CE7s9MP58ODaJK2OVqYaxJIMLP97liB3QCSdj7
	T+dBoT1plJ94GjvVY7zZQ/rLdvZTT8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719297455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Dw67TcI8wAAs6NeF87J/NxxswPE+07yoxyWkCK0pOo=;
	b=UtkR0vWHw/bFimZRLB16FqMqiOI+rummyanAZG4EvbBxIuMGe6CeRYzIXyQTlpjEg2fW10
	Tr4uBWyEnjZynYDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E28291384C;
	Tue, 25 Jun 2024 06:37:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BDFtMq5lembMDwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 25 Jun 2024 06:37:34 +0000
Message-ID: <55315fc9-4439-43b0-a4d2-89ab4ea598f0@suse.de>
Date: Tue, 25 Jun 2024 08:37:34 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] sched/isolation: Add io_queue housekeeping option
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbecker@suse.com>, Mel Gorman <mgorman@suse.de>,
 Sridhar Balaraman <sbalaraman@parallelwireless.com>,
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
 <20240621-isolcpus-io-queues-v1-1-8b169bf41083@suse.de>
 <20240622051156.GA11303@lst.de>
 <x2mjbnluozxykdtqns47f37ssdkziovkdzchon5zkcadgkuuif@qloym5wjwomm>
 <20240624084705.GA20292@lst.de>
 <sjna556zvxyyj6as5pk6bbgmdwoiybl4gubqnlrxyfdvhbnlma@ewka5cxxowr7>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sjna556zvxyyj6as5pk6bbgmdwoiybl4gubqnlrxyfdvhbnlma@ewka5cxxowr7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9F65A1F849
X-Spam-Score: -3.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,grimberg.me,linutronix.de,suse.com,suse.de,parallelwireless.com,gmail.com,redhat.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/24/24 11:00, Daniel Wagner wrote:
> On Mon, Jun 24, 2024 at 10:47:05AM GMT, Christoph Hellwig wrote:
>>> Do you think we should introduce a new type or just use the existing
>>> managed_irq for this?
>>
>> No idea really.  What was the reason for adding a new one?
> 
> I've added the new type so that the current behavior of spreading the
> queues over to the isolated CPUs is still possible. I don't know if this
> a valid use case or not. I just didn't wanted to kill this feature it
> without having discussed it before.
> 
> But if we agree this doesn't really makes sense with isolcpus, then I
> think we should use the managed_irq one as nvme-pci is using the managed
> IRQ API.
> 
I'm in favour in expanding/modifying the managed irq case.
For managed irqs the driver will be running on the housekeeping CPUs 
only, and has no way of even installing irq handlers for the isolcpus.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

