Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574A32E266D
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902026; cv=none; b=pl9ecJa0BqCpJKMZKj8/rqaQGG03Uyx8N/7R8qCOSB7tt1HHfxIEFxrB98GY+P/gsKXuvwNGXnWNskUFQn3WpoNrYgv3L9Nu20YgjmObXX6776cw6gyAZWtTVLzIn9puk3IsjL0JdNMZTdTC4HewtfNP+aJZlIXSLwl43BSYt3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902026; c=relaxed/simple;
	bh=OmJRu/p7HHi59gaQJPH1COfIfgEa1UgD7bDbyRQSRqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTY/cocfF36rdkmnuNwEscuA2EfG4MOHpGHrg8naHkDReri336JvFJJpzFnN3/6zJ+3ZBG+JetzQDDS8XvSubaQzNW7EAdz2Xta+nOBPeA1neffFlZ5N3pLxLWiwvOcDFq10jngTHQJ1Z1WjlHpITMMBk11qOff2Dym5Q3O31CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cVLOTojA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u0LFMmYS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cVLOTojA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u0LFMmYS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cVLOTojA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u0LFMmYS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cVLOTojA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u0LFMmYS"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 792D51F390;
	Mon,  7 Jul 2025 15:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751902021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PyUW2jNQ1CDdGSRifykhkuvSJEfICwLp3bIC3AG654A=;
	b=cVLOTojAsaEzE2ylJrc14lyBlCoujSmt871bNTemWjd44vFTUXrwnAN5rngNIzpAmS/04S
	lSyIm17lG15homkFtgiOIR3+q4bbOKpAOYQjMSokHbtbV/MzOvU9CY7F1B0no3m/nTw8KA
	Hi6cFVA20+fBD2orQM9tLs5ARVFgKqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751902021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PyUW2jNQ1CDdGSRifykhkuvSJEfICwLp3bIC3AG654A=;
	b=u0LFMmYSXLyPaeTdNeTKJX/sfPeif70MwlpcQ0dCaDDU9zLoKyAbRM6/4o4JQO8HanQ54j
	WlwdU6sOWxkV1IBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751902021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PyUW2jNQ1CDdGSRifykhkuvSJEfICwLp3bIC3AG654A=;
	b=cVLOTojAsaEzE2ylJrc14lyBlCoujSmt871bNTemWjd44vFTUXrwnAN5rngNIzpAmS/04S
	lSyIm17lG15homkFtgiOIR3+q4bbOKpAOYQjMSokHbtbV/MzOvU9CY7F1B0no3m/nTw8KA
	Hi6cFVA20+fBD2orQM9tLs5ARVFgKqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751902021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PyUW2jNQ1CDdGSRifykhkuvSJEfICwLp3bIC3AG654A=;
	b=u0LFMmYSXLyPaeTdNeTKJX/sfPeif70MwlpcQ0dCaDDU9zLoKyAbRM6/4o4JQO8HanQ54j
	WlwdU6sOWxkV1IBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 267A613A5E;
	Mon,  7 Jul 2025 15:27:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F4FrB0Xna2hHQwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 07 Jul 2025 15:27:01 +0000
Message-ID: <b2ff30b5-5f12-4276-876d-81a8b2f180c1@suse.de>
Date: Mon, 7 Jul 2025 17:26:46 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What should we do about the nvme atomics mess?
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Alan Adamson <alan.adamson@oracle.com>,
 John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20250707141834.GA30198@lst.de> <aGvYnMciN_IZC65Z@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aGvYnMciN_IZC65Z@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On 7/7/25 16:24, Keith Busch wrote:
> On Mon, Jul 07, 2025 at 04:18:34PM +0200, Christoph Hellwig wrote:
>> We could:
>>
>>   I.	 revert the check and the subsequent fixup.  If you really want
>>           to use the nvme atomics you already better pray a lot anyway
>> 	 due to issue 1)
>>   II.	 limit the check to multi-controller subsystems
>>   III.	 don't allow atomics on controllers that only report AWUPF and
>>   	 limit support to controllers that support that more sanely
>> 	 defined NAWUPF
>>
>> I guess for 6.16 we are limited to I. to bring us back to the previous
>> state, but I have a really bad gut feeling about it given the really
>> bad spec language and a lot of low quality NVMe implementations we're
>> seeing these days.
> 
> I like option III. The controler scoped atomic size is broken for all
> the reasons you mentioned, so I vote we not bother trying to make sense
> of it.
> 
Agree. We might consider I. as a fixup for stable, but should continue
with III going forward.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
