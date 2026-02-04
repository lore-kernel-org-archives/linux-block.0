Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262027A123
	for <linux-block@vger.kernel.org>; Wed,  4 Feb 2026 01:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770169408; cv=none; b=VT6oL9TdMKdzuwl6EHJazmCw+xYMe88jjzb9pNn7DB87nZrq2RA8NqwK36bBpjDcXdyvOJc31RBAEw5sGUAbm8GcnD8bnDKYeo8/As9f948vLtTdtJ/FsekCYE1SJacQlFvBbC4vWP5GCvO5DDTb+cCpyAa8bvXDwSvdoYCiAFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770169408; c=relaxed/simple;
	bh=ucLnmgZlnqxYuGZcB3RBwW2tBOdfc/Ub3fPokErAhwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wt9MvzzseOsnDmVCcM8oeoQo+TvRCNEf0ULdPzWISioMpFgHhBTSRW+uqpbkjo2OYJhbG3u6kqRZJQD3hI0hzUA4mMT2lPe2Qg8GROk6Vqfe74CGxcq89y/EJNEZqwQVfae05Nnf6Dw05z1su5xLxjPPSmGEIa8pdZLlyH3w91s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CoVB90Rn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7xbMd4i8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CoVB90Rn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7xbMd4i8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CoVB90Rn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7xbMd4i8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CoVB90Rn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7xbMd4i8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B85805BCC7;
	Wed,  4 Feb 2026 01:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770169404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VIK8G429bsxiDEpbTa51GrOkOhX3+0bwVELXO7VdwA=;
	b=CoVB90Rnw/UeTEsXuazminkvefpv8IW8b2UIRzDmVvkvA5tCWwpXsto8XCt8hIDBHB5Qph
	z9pc66fd3K3HBHc2YvB56E6ym+E1B3CBN4Lf8ho7+BDnkTqAsijdabuK/7XO12tUWvvHiI
	deMTWkFQDejbadJCA5s5ZloKEDBSSg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770169404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VIK8G429bsxiDEpbTa51GrOkOhX3+0bwVELXO7VdwA=;
	b=7xbMd4i8db2dRRQZIJFz53tUm9O5D51KgULxSCU2Q6Y2FUtf9EZcSAHc4pZdx5eBPbQflf
	2Yl7mdiqVvoqr0Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770169404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VIK8G429bsxiDEpbTa51GrOkOhX3+0bwVELXO7VdwA=;
	b=CoVB90Rnw/UeTEsXuazminkvefpv8IW8b2UIRzDmVvkvA5tCWwpXsto8XCt8hIDBHB5Qph
	z9pc66fd3K3HBHc2YvB56E6ym+E1B3CBN4Lf8ho7+BDnkTqAsijdabuK/7XO12tUWvvHiI
	deMTWkFQDejbadJCA5s5ZloKEDBSSg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770169404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VIK8G429bsxiDEpbTa51GrOkOhX3+0bwVELXO7VdwA=;
	b=7xbMd4i8db2dRRQZIJFz53tUm9O5D51KgULxSCU2Q6Y2FUtf9EZcSAHc4pZdx5eBPbQflf
	2Yl7mdiqVvoqr0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA5BD3EA63;
	Wed,  4 Feb 2026 01:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZOEDITqkgmm+egAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Feb 2026 01:43:22 +0000
Message-ID: <a14c022e-84c4-477e-998b-aab79e2cea6d@suse.de>
Date: Wed, 4 Feb 2026 02:43:20 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM?BFP TOPIC] Block-layer device resets
To: Nilay Shroff <nilay@linux.ibm.com>, Damien Le Moal <dlemoal@kernel.org>,
 lsf-pc <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
 <7ec5f552-197f-48be-9898-9cc4233783fc@kernel.org>
 <2594023b-b1a5-4752-bb4b-73a4fce4ef5d@suse.de>
 <10428c95-2023-466b-ad1a-4b190bc402a1@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <10428c95-2023-466b-ad1a-4b190bc402a1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.927];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 

On 2/3/26 13:19, Nilay Shroff wrote:
> 
> 
> On 2/3/26 4:34 AM, Hannes Reinecke wrote:
>> On 2/2/26 02:46, Damien Le Moal wrote:
>>> On 2/2/26 02:06, Hannes Reinecke wrote:
>>>> Hi all,
>>>>
>>>> We are currently working on implementing cross-controller resets for
>>>> NVMe, which requires to send a command to the target which then should
>>>> terminate all commands on a given controller.
>>>> While we could easily terminate the controller, the specification
>>>> also requires us to terminate all outstanding commands.
>>>> Which then recurses into my all-time favourite topic on how to
>>>> abort outstanding commands from the fs/bio layer.
>>>>
>>>> However, here we don't have to dissect/match to individual commands,
>>>> but rather have to abort everything, which seems rather easier.s
>>>>
>>>> So I would like to fathom whether such a thing is feasible/reasonable
>>>> (I think so, obviously, and can think of several other use-cases, too,
>>>> qemu springs to mind here ...) and discuss possible implementations
>>>> (set 'req->deadline' to zero for all pending commands?).
>>>> Or maybe we can do such a thing already and I'm just not aware of it...
>>>
>>> Hmmm... Command timeouts ? E.g. if a controller is slow to respond (send
>>> completions), the block layer timeout timer may trigger, which will call into
>>> the low level device driver to force a reset. But before the reset actually
>>> happens, completions may actually come back, and we do handle that race
>>> correctly, well at least for scsi/ata.
>>>
>>> Your scenario sound very similar to this: once you reset the controller,
>>> whatever was pending will be silent and can be aborted or retried. So it does
>>> sound like that should not be too difficult, no ? Generalize the timeout
>>> processing or do something similar ?
>>>
>> The good thing is we don't even need to generalize anything. It should
>> should be sufficient to walk the inflight requests and set
>> 'rq->deadline' to 'jiffies'. General idea here is to just _initiate_
>> command termination with this, one then still has to wait for all
>> commands to complete, but at least now there is a reasonable chance
>> that this will happen quickly.
> Well if the request which is being terminated this way happens to be admin
> command then it may cause the controller reset. The issue with this approach
> is that we're artificially inducing the timeout (instead of actually issuing
> abort) and NVMe driver timeout handler assumes the admin command timeout is
> fatal and it resets the controller.>
Well, yes, and no.
Command timeouts _are_ artificial; none of the command specifications
mention any timeout, so anything we do here is actually guesswork.
So the controller _must_ be able to abort commands.
I am fully aware that the NVMe driver does _not_ abort commands on 
timeout (but rather resets the controller), but that is an 
implementation detail of NVMe.
(And arguably something which we should fix. Time for another LSF
session, maybe).
Main point is that the block layer already has driver callbacks for
timeout, so one does not need to implement yet another callback.

> IMO, conceptually, the goal here is not to force a timeout but to explicitly
> abort all outstanding commands as required by the NVMe cross-controller reset
> semantics. So combining these two (timeout and abort) mechanisms makes the intent
> unclear and coupling abort semantics to timeout handling makes it fragile.
> 
> So from this perspective, it would be cleaner to have an explicit blk-mq callback
> for aborting all outstanding requests. The block layer would invoke this callback,
> and each driver could implement the abort logic according to its own requirements
> and specification constraints. For NVMe, this shall allow us to abort in-flight
> commands without overloading the timeout path or triggering unintended controller
> resets, any thoughts?
> 
Which is basically the direction I had been thinking about, having a
generic (block-layer) function to invoke device resets.
_How_ this function will be implemented is open for debate.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
