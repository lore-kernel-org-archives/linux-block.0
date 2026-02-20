Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FCF35979
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771573447; cv=none; b=gKTJxYsFSosbPyfp3p3QsJ8ThORMGH+vCo1X1urXITGrPtQcl89Qda7O6LgH5wB8Swl0WMlIPALfmoJtaXbuedl7uRSr4truZ9d1gWBGiY7FpJZgZaCPIzDtHmO7alkgBJY5xwJfeNT9AwshXPM4N93lgpbb77qOrudifyyJPuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771573447; c=relaxed/simple;
	bh=RA8MFQctvAP9Ys4BFdXyLbsx47/dbg63EgFpps+eiVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTcXAmOHM7JTjLRNZeCt4mdvuF2ExrIFcJcKMxOWEbuTjaJ+XmoHmu/URZH8TKphu6qvX/oj7DFKLmL10jGrefBseUrpxV4MLQKkVsiXv2y+FJjYT4RHL8aV66wwcWZo8vZQofxLIv2FLmU5VH6Cq3Zprw4c113BlSTvmJmllik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BwGng01S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5vZicEWZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZzHogcgo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=njdbUyVP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BwGng01S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5vZicEWZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZzHogcgo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="njdbUyVP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3DC085BCC2;
	Fri, 20 Feb 2026 07:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771573444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9zZU8rQyq0UhB0/jWOvgsYzj7gv8Vqlnis9ECm8PdA=;
	b=BwGng01SvwKa1gDxtgZNBjoR/YEinPXtLps71cMXhv7vZeEZlevPdFutA797m5DRloHr+F
	Da/70SwFrPx5Qkl0d/WWAw3eBmMvX8Doz7F+WCsbLdxUzFNqsDq6RMfxUdiUr+/LCS0FNH
	aV0OIra7orT0sM4SGsSW4NKTVC6Uqog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771573444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9zZU8rQyq0UhB0/jWOvgsYzj7gv8Vqlnis9ECm8PdA=;
	b=5vZicEWZgitKKdCEQ5uUzWsqL4kiwLAV4vC0HfKiF9WS1RpIXryYHYG6bs8ZxbvfPlimAZ
	WMR1GtnAUUjiAxCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZzHogcgo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=njdbUyVP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771573443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9zZU8rQyq0UhB0/jWOvgsYzj7gv8Vqlnis9ECm8PdA=;
	b=ZzHogcgoE+vTqZ6Wudm8OaOLN/3bQG8fC9G5EBOl05yVRRgLoi4HCQKJNRwzrLbyuxSJBW
	cApJ/K7vhiSotHfJqgF8rJV1LC2mKYtjH567TE6D3xFO7E4UA8uWHoh98RoorNupi+kxVM
	0a+o7lMO3yEVVbeJwazXqx2PrO/6MS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771573443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9zZU8rQyq0UhB0/jWOvgsYzj7gv8Vqlnis9ECm8PdA=;
	b=njdbUyVPMylL0bvLamqip/1ferRENunYoH3/mgFzOmlsNBmGEJEitKBOJFxOrkKEqap4cw
	gagR4Q6FQY+mr6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3B343EA65;
	Fri, 20 Feb 2026 07:44:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hQt8OMIQmGm5fAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 20 Feb 2026 07:44:02 +0000
Message-ID: <29a7ef25-27a8-49cd-a2f2-8db693ada39c@suse.de>
Date: Fri, 20 Feb 2026 08:44:02 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Memory fragmentation with large block sizes
To: Theodore Tso <tytso@mit.edu>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org
References: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
 <20260219143242.GC69183@macsyma-wired.lan>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260219143242.GC69183@macsyma-wired.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3DC085BCC2

On 2/19/26 15:32, Theodore Tso wrote:
> On Thu, Feb 19, 2026 at 10:54:48AM +0100, Hannes Reinecke wrote:
>> Hi all,
>>
>> I (together with the Czech Technical University) did some experiments trying
>> to measure memory fragmentation with large block sizes.
>> Testbed used was an nvme setup talking to a nvmet storage over
>> the network.
>>
>> Doing so raised some challenges:
>>
>> - How do you _generate_ memory fragmentation? The MM subsystem is
>>    precisely geared up to avoid it, so you would need to come up
>>    with some idea how to defeat it. With the help from Willy I managed
>>    to come up with something, but I really would like to discuss
>>    what would be the best option here.
> 
> I'm trying to understand the goal of the experiment.  I'm guessing
> that the goal was to see how much memory fragmentation would result
> from using large block sizes with the control being to use, say, 4k
> blocks.  Is that correct?
> 
The main goal was to figure out if we have increased memory 
fragmentation when using LBS.
Clearly, most (internal) allocations still work on page-sized
objects, so one can argue that using LBS might increase fragmentation.
On the other hand, all _filesystem_ objects will be in LBS sizes,
so we won't increase fragmentation if we only allocate in LBS sizes.
So which is it?

> So I guess the question here is what are realstic workloads that
> people would have in real world situations, so we can do the A-B
> experiments to see what using LBS result in?
> 
Yes.

>> - What is acceptable memory fragmentation? Are we good enough if the
>>    measured fragmentation does not grow during the test runs?
> 
> I can think of two possible metrics.  The first is whether it results
> in degradation of performance given certain real world workloads.
> 
> The second is whether given a particular memory pressure, the memory
> fragmentation results in more jobs getting OOM killed.
> 
That would be ideal, but we first need to have a program exerting
memory pressure...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
