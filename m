Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D64824B1;
	Mon,  1 Jul 2024 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823398; cv=none; b=hGSSRiH7bim/Q9UzDs6X15uwD1aOmqJ+nBTUQaZTjiWgyANi67wgJk7tnIaQu7BXzoHNvGs1o9LkNDqCap4S8f6cbirnR9VeHrIt98sZdg08wrshn/SJVCvrZOFxBHA8ZdYVw/Sh65nsPlHXRiBHf4ZvZYDY0rOPs48dCZlTqlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823398; c=relaxed/simple;
	bh=iKKJnz8DOvSs+0IlwtcTPhx8Kpj5HEFRMbgY9GRZsiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmtUdQZPvI7Uj3mDnhr9xnJBRqIgi1p64XOahqUIFRkfcvuI41EEZTIiFhQxYHvjvaJwY8IUFW8WNB1cDXL918If+yqi6/JFar+5H191ZIDlUFIkgGhZoIVCEjpYJvUqYpmdrCBsZ4kcQTDJ6xcRb/96cvAfTbkPacgJInNehU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cKUI307r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tEKfHShe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cKUI307r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tEKfHShe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cKUI307r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tEKfHShe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cKUI307r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tEKfHShe"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B10D221AB2;
	Mon,  1 Jul 2024 08:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719823394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIGflQywJ8dMNdlKWrZr5XV9go3j7auton/EPKSlbOY=;
	b=cKUI307rRb/HXjE2LY3/FdpZ+60oCL5DdFYtsOSUJh3imAPs1DMSM8hlrwlKI9rBeZff47
	UOHTlB1YkZBO7cJsBCBrNpzXTtwMXRkkSTjHTY+1bYh4c9BScxhovb9lB1iI6l8O+xXbht
	xRBF0Afm3Djlz6qZy7LXL2wXcjl+OhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719823394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIGflQywJ8dMNdlKWrZr5XV9go3j7auton/EPKSlbOY=;
	b=tEKfHSheR0o5BNtMV3BsolCPze4YAKmPupn+SeMGYwRh0MhJFP5hH5Qp6WUHoUrsBGZby7
	wQccriqBj0pX/iDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cKUI307r;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tEKfHShe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719823394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIGflQywJ8dMNdlKWrZr5XV9go3j7auton/EPKSlbOY=;
	b=cKUI307rRb/HXjE2LY3/FdpZ+60oCL5DdFYtsOSUJh3imAPs1DMSM8hlrwlKI9rBeZff47
	UOHTlB1YkZBO7cJsBCBrNpzXTtwMXRkkSTjHTY+1bYh4c9BScxhovb9lB1iI6l8O+xXbht
	xRBF0Afm3Djlz6qZy7LXL2wXcjl+OhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719823394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIGflQywJ8dMNdlKWrZr5XV9go3j7auton/EPKSlbOY=;
	b=tEKfHSheR0o5BNtMV3BsolCPze4YAKmPupn+SeMGYwRh0MhJFP5hH5Qp6WUHoUrsBGZby7
	wQccriqBj0pX/iDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A3C313800;
	Mon,  1 Jul 2024 08:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FdU9HSJsgmZnBwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 01 Jul 2024 08:43:14 +0000
Message-ID: <0d8a5256-9719-45c5-b098-237b5a82fd36@suse.de>
Date: Mon, 1 Jul 2024 10:43:14 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
To: Ming Lei <ming.lei@redhat.com>, Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>, Frederic Weisbecker <fweisbecker@suse.com>,
 Mel Gorman <mgorman@suse.de>,
 Sridhar Balaraman <sbalaraman@parallelwireless.com>,
 "brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
 <ZoFgLxGXrk4VCR03@fedora>
 <b2ncik6c7xicsnzihhwfjjqood2yys52tzotohjnxj6o2mapg5@m364yzsjbvs2>
 <ZoJY6a1CHCENAZZ8@fedora>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZoJY6a1CHCENAZZ8@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,grimberg.me,linutronix.de,lst.de,suse.com,suse.de,parallelwireless.com,gmail.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B10D221AB2
X-Spam-Flag: NO
X-Spam-Score: -3.00
X-Spam-Level: 

On 7/1/24 09:21, Ming Lei wrote:
> On Mon, Jul 01, 2024 at 09:08:32AM +0200, Daniel Wagner wrote:
>> On Sun, Jun 30, 2024 at 09:39:59PM GMT, Ming Lei wrote:
>>>> Make group_cpus_evenly aware of isolcpus configuration and use the
>>>> housekeeping CPU mask as base for distributing the available CPUs into
>>>> groups.
>>>>
>>>> Fixes: 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed interrupts")
>>>
>>> isolated CPUs are actually handled when figuring out irq effective mask,
>>> so not sure how commit 11ea68f553e2 is wrong, and what is fixed in this
>>> patch from user viewpoint?
>>
>> IO queues are allocated/spread on the isolated CPUs and if there is an
>> thread submitting IOs from an isolated CPU it will cause noise on the
>> isolated CPUs. The question is this a use case you need/want to support?
> 
> I have talked RH Openshift team weeks ago and they have such usage.
> 
> userspace is free to run any application from isolated CPUs via 'taskset
> -c' even though 'isolcpus=' is passed from command line.
> 
> Kernel can not add such new constraint on userspace.
> 
>> We have customers who are complaining that even with isolcpus provided
>> they still see IO noise on the isolated CPUs.
> 
> That is another issue, which has been fixed by the following patch:
> 
> a46c27026da1 blk-mq: don't schedule block kworker on isolated CPUs
> 
Hmm. Just when I thought I understood the issue ...

How is this supposed to work, then, given that I/O can be initiated
from the isolated CPUs?
I would have accepted that we have two scheduling domains, blk-mq is
spread across all cpus, and the blk-mq cpusets are arranged according
to the isolcpu settings.
Then we can initiate I/O from the isolated cpus, and the scheduler
would 'magically' ensure that everything is only run on isolated cpus.

But that patch would completely counteract such a setup, as during
I/O we more often than not will invoke kblockd, which then would cause
cross-talk on non-isolated cpus.

What is the idea here?

Confused,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

