Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BCE824B1;
	Mon,  1 Jul 2024 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823071; cv=none; b=eyWCGM3Fi6sKLK870djks/QAE/Xyx0LF7SUrRaamk1T8FWked9kHgHJuDjVWF5mF6qYwHVkk97dU3edLICK0LIdbTY++tWA8i8xNtA77YEpjXb8xk50X4K4Tn8Na/CN7t/sqhjENgNOMo3LuVn0owvmNAbfwLopu9F3gK/MDDPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823071; c=relaxed/simple;
	bh=z1c/jnaMyyECMTO08cjIFYw3C0Nr3rFOAmIzgBr0DWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTLs9DVLBSH3rPlUi/Rae9ZzdfMFcfaqDNbhec6WL3f0kRSDotyW/TzdRFbdwYhpUo14rfvMPntS+aQ32qcyclT/X/Ghwu7SRsWFi4/kF5N5ERZO44gtyq/a9X2ru03hdKsP0onXkIJimpIUJGruCRw/e9jv4UovQCaphbXS++Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I4nV9Ylx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZB9v+kpZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I4nV9Ylx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZB9v+kpZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I4nV9Ylx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZB9v+kpZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I4nV9Ylx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZB9v+kpZ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 554D61F828;
	Mon,  1 Jul 2024 08:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719823067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3kQfKoVCscU2QmuUe+U8gkx9JfwV8/mko2lyXjdYfo=;
	b=I4nV9YlxxlyjG/h5r5LzjIf7h2qFyFqvx/O9b+qHa99f8UkdKIk0TSBP69R9kIxT7JHWJF
	vAalYwkgBNgDY2knEl7kSO0KRWNlnjhR88QteYNQyNWG9HYEXkYuVRZDwlTJblW1YHhMfL
	vPAg8v5D3FhLHx8UoVrjWaf2hp5wUXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719823067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3kQfKoVCscU2QmuUe+U8gkx9JfwV8/mko2lyXjdYfo=;
	b=ZB9v+kpZzynlkxKGMNtUnbBqh1TdA3BpO8r9sMxxxYvExhTj3YqmpuT61AbhLrxjikjaWY
	ojozBkXhdgY3uDCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719823067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3kQfKoVCscU2QmuUe+U8gkx9JfwV8/mko2lyXjdYfo=;
	b=I4nV9YlxxlyjG/h5r5LzjIf7h2qFyFqvx/O9b+qHa99f8UkdKIk0TSBP69R9kIxT7JHWJF
	vAalYwkgBNgDY2knEl7kSO0KRWNlnjhR88QteYNQyNWG9HYEXkYuVRZDwlTJblW1YHhMfL
	vPAg8v5D3FhLHx8UoVrjWaf2hp5wUXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719823067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3kQfKoVCscU2QmuUe+U8gkx9JfwV8/mko2lyXjdYfo=;
	b=ZB9v+kpZzynlkxKGMNtUnbBqh1TdA3BpO8r9sMxxxYvExhTj3YqmpuT61AbhLrxjikjaWY
	ojozBkXhdgY3uDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF05113800;
	Mon,  1 Jul 2024 08:37:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SLZzLtpqgmbmBQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 01 Jul 2024 08:37:46 +0000
Message-ID: <c797bdc1-b949-4d88-a65f-904d909755dc@suse.de>
Date: Mon, 1 Jul 2024 10:37:46 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
To: Ming Lei <ming.lei@redhat.com>
Cc: Daniel Wagner <dwagner@suse.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>,
 Frederic Weisbecker <fweisbecker@suse.com>, Mel Gorman <mgorman@suse.de>,
 Sridhar Balaraman <sbalaraman@parallelwireless.com>,
 "brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
 <ZoIPzQNEsUWOWp3f@fedora> <1a1a4684-a55d-4c27-8509-9bf61408872f@suse.de>
 <ZoJWXRgycA8UeYB3@fedora>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZoJWXRgycA8UeYB3@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,kernel.dk,kernel.org,grimberg.me,linutronix.de,lst.de,suse.com,parallelwireless.com,gmail.com,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 

On 7/1/24 09:10, Ming Lei wrote:
> On Mon, Jul 01, 2024 at 08:43:34AM +0200, Hannes Reinecke wrote:
>> On 7/1/24 04:09, Ming Lei wrote:
[ .. ]
>>>
>>> Since this patch, some isolated CPUs may not be covered in
>>> blk-mq queue mapping.
>>>
>>> Meantime people still may submit IO workload from isolated CPUs
>>> such as by 'taskset -c', blk-mq may not work well for this situation,
>>> for example, IO hang may be caused during cpu hotplug.
>>>
>>> I did see this kind of usage in some RH Openshift workloads.
>>>
>>> If blk-mq problem can be solved, I am fine with this kind of
>>> change.
>>>
>> That was kinda the idea of this patchset; when 'isolcpus' is active any
>> in-kernel driver can only run on the housekeeping CPUs, and I/O from the
>> isolcpus is impossible.
>> (Otherwise they won't be isolated anymore, and the whole concepts becomes
>> ever so shaky.).
> 
> Userspace may still force to run IO workload from isolated CPUs when they do
> not care CPU isolation, and kernel still should complete IO from isolated CPUs,
> and can't run into hang or panic meantime.
> 
> And we do support this kind of usage now, then regression is caused by
> this patch.
> 
Hmm. Guess we need to modify the grouping algorithm to group across all 
cpus, but ensure that each group consists either of all housekeeping 
CPUs or all isolated cpus.
Daniel?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

