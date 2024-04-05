Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8816FF52
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331405; cv=none; b=osMht5fzQ1sfk/nosm3MyEqcUfKarq54K5fKrnrWm9rq2WVYIQzQtcrIYuSocwDkKT5bTDiSyN+wXAe+LokwYrDWYCJbbjfliuYQIskeeHBni0YM8uyon/hJ0musFiYjEtbUqLGJomuYZ7fXyvUKEUFFJ4k7Px1ReSWyZvnXlwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331405; c=relaxed/simple;
	bh=gdzi5tWvUKbB9CzuY8TZQO8TjBaj+4ca62W9bgWepxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuDekVT3U0qp6puMBbTKicu0SVMqMezTvwDZGgpV/kMGrnD/Jkmi9RaZWWuxfOcDwfbzS0rR1Wp526LN9adF6wHY88Qzy4Ennksbr/dBIueSDnkjUV5qPXjG3ehS5vRWorSTeY0yJVKY7h0mXzpZytH/82AdWUsVEUVwLTXO6tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bXS73QYC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZiRird/D; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bXS73QYC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZiRird/D; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bXS73QYC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZiRird/D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bXS73QYC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZiRird/D"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 696A01F7E0;
	Fri,  5 Apr 2024 15:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712331401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dwuiT7ZpNTuZOK2uB1PuBKLWk7YWD/Bi6Wj2zqKr5PQ=;
	b=bXS73QYCNrwgZgxepMm5fWpFZ/s2Sg4M8FaSmTpJB4oW8q/gZiRBgn3Iy8r6uro6X9LSPn
	NX4OE2Gd/sL2FMTyfegysCujqCoE/0E+M+EcIuLydRHA1vn79mD/jjgu/gvAgxV8tBPSHc
	vYtVICnlDXyjDu4y6qOsKKUwZsypR/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712331401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dwuiT7ZpNTuZOK2uB1PuBKLWk7YWD/Bi6Wj2zqKr5PQ=;
	b=ZiRird/DNvaQ205+3E9cZznYnx+qug2CVYUKHsmpKlSWBjjOFPuXC6j4IQ57H/zA78j8/8
	QEe7D6A37dwVA/Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712331401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dwuiT7ZpNTuZOK2uB1PuBKLWk7YWD/Bi6Wj2zqKr5PQ=;
	b=bXS73QYCNrwgZgxepMm5fWpFZ/s2Sg4M8FaSmTpJB4oW8q/gZiRBgn3Iy8r6uro6X9LSPn
	NX4OE2Gd/sL2FMTyfegysCujqCoE/0E+M+EcIuLydRHA1vn79mD/jjgu/gvAgxV8tBPSHc
	vYtVICnlDXyjDu4y6qOsKKUwZsypR/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712331401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dwuiT7ZpNTuZOK2uB1PuBKLWk7YWD/Bi6Wj2zqKr5PQ=;
	b=ZiRird/DNvaQ205+3E9cZznYnx+qug2CVYUKHsmpKlSWBjjOFPuXC6j4IQ57H/zA78j8/8
	QEe7D6A37dwVA/Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E9B5139F1;
	Fri,  5 Apr 2024 15:36:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 7SYUBokaEGbDWwAAn2gu4w
	(envelope-from <hare@suse.de>); Fri, 05 Apr 2024 15:36:41 +0000
Message-ID: <46e26322-a677-4c27-bc22-e2c65ed9d03c@suse.de>
Date: Fri, 5 Apr 2024 17:36:40 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/2] block,nvme: latency-based I/O scheduler
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20240403141756.88233-1-hare@kernel.org>
 <Zg8YNrSnZPjR4kan@kbusch-mbp.dhcp.thefacebook.com>
 <b255fca4-a9da-4364-a3af-eb699eeb4160@suse.de>
 <ZhAS0YKfV07qlUes@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZhAS0YKfV07qlUes@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:email]

On 4/5/24 17:03, Keith Busch wrote:
> On Fri, Apr 05, 2024 at 08:21:14AM +0200, Hannes Reinecke wrote:
>> On 4/4/24 23:14, Keith Busch wrote:
>>> On Wed, Apr 03, 2024 at 04:17:54PM +0200, Hannes Reinecke wrote:
>>>> Hi all,
>>>>
>>>> there had been several attempts to implement a latency-based I/O
>>>> scheduler for native nvme multipath, all of which had its issues.
>>>>
>>>> So time to start afresh, this time using the QoS framework
>>>> already present in the block layer.
>>>> It consists of two parts:
>>>> - a new 'blk-nlatency' QoS module, which is just a simple per-node
>>>>     latency tracker
>>>> - a 'latency' nvme I/O policy
>>> Whatever happened with the io-depth based path selector? That should
>>> naturally align with the lower latency path, and that metric is cheaper
>>> to track.
>>
>> Turns out that tracking queue depth (on the NVMe level) always requires
>> an atomic, and with that a performance impact.
>> The qos/blk-stat framework is already present, and as the numbers show
>> actually leads to a performance improvement.
>>
>> So I'm not quite sure what the argument 'cheaper to track' buys us here...
> 
> I was considering the blk_stat framework compared to those atomic
> operations. I usually don't enable stats because all the extra
> ktime_get_ns() and indirect calls are relatively costly. If you're
> enabling stats anyway though, then yeah, I guess I don't really have a
> point and your idea here seems pretty reasonable.

Pretty much. Of course you need stats to be enabled.
And problem with the queue depth is that it's actually quite costly
to compute; the while sbitmap thingie is precisely there to _avoid_
having to track the queue depth.
I can't really see how one could track the queue depth efficiently;
the beauty of the blk_stat framework is that it's running async, and
only calculated after I/O is completed.
We could do a 'mock' queue depth by calculating the difference between
submitted and completed I/O, but even then you'd have to inject a call
in the hot path to track the number of submissions.

In the end, the latency tracker did what I wanted to achieve (namely
balance out uneven paths), _and_ got faster than round-robin, so I 
didn't care about queue depth tracking.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich

