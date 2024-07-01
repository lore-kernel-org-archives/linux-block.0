Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AD01EB39;
	Mon,  1 Jul 2024 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719816221; cv=none; b=KoDOreaOI6OqeaQGaqvKkPlul5+/VX2X0HO2QCQXsBAVoXEmBRBpDPt6LMEiyKFIbSDoEryrs9PoyUMqHR6UtmN44EFBXHGS7xff0eOBaf93WLMhguTBqzmr68wKdvmCuO6z6g8GNqSCv5ufR2kUgQUGQsPFqliqH1fAtbWCmCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719816221; c=relaxed/simple;
	bh=5qnOCWfOErjfZWoriSn33e8IRH+pdlFj0WbdWgsiXuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYUQ4prpeRdg/FA4Ao7nwMeAYMDvbny9HuA1JCrKpsfuNnMrDVBTQPT0WwKxeQXX2jXK8Vc+6kSolvHGAncJI8DVyb/Iy8lA72EAY2OhS7/hfYiDdH9OC3E8mZlfIH2Z/qVyw+YVFPw7nRBeEbRPNpNLHffWVhCe9timrh/1JDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cZx/mn+d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PCrSfyiq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QBRrC09v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n2fWQk2j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cZx/mn+d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PCrSfyiq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QBRrC09v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n2fWQk2j"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F1E21F8CC;
	Mon,  1 Jul 2024 06:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719816218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=io+vHh/wENzYYopWBqwKu+pSriO7/Za5mn1v17FgrIY=;
	b=cZx/mn+dLq2Mzn1BIwTi0bdAgUwlhHx8N4G/2nUeA2kOpHcAgiNux3roxDK9Kw8oC2lfvv
	vNGsxUA4sVRVg/4C5D6KOwAqk0VSxSLcbRKWjlRUNhZaxJRIeG2h3HXDpYP6e/fZEwnqBH
	BZJ9YNb8M9IN3ooKejkG56N9r6eR0X4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719816218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=io+vHh/wENzYYopWBqwKu+pSriO7/Za5mn1v17FgrIY=;
	b=PCrSfyiqDff4THtn+h5XqzfMJZJMMUeX42I7XzSkJflto40fFZbVLJdBDKx9LGRV84jHVO
	gUAH+we3QK+O2lDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719816216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=io+vHh/wENzYYopWBqwKu+pSriO7/Za5mn1v17FgrIY=;
	b=QBRrC09v1q/fTaTfHjNChQriSQ+AYa0q8kBBmX6PaI0FNErPhu8nmu7ysh0s/0pP13Z0Mo
	a4A+2AVP5oyubKftakCAradC3sNkqpz6svhpBuwXz0Bk7557bh/M93GP1yY5a/bkpitgy1
	dCJqEo5L4KCn9t6xJQfyhgq3/bEVt00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719816216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=io+vHh/wENzYYopWBqwKu+pSriO7/Za5mn1v17FgrIY=;
	b=n2fWQk2jZ04OskWKHSwDZ4CzNySI5LTNRq0A6gQHN8d/vJCGjgTIrNkEXwChZmkJDrXiuR
	SE56tS3/wiFijpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BB7213800;
	Mon,  1 Jul 2024 06:43:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HL4HBRdQgmYrYwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 01 Jul 2024 06:43:35 +0000
Message-ID: <1a1a4684-a55d-4c27-8509-9bf61408872f@suse.de>
Date: Mon, 1 Jul 2024 08:43:34 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
Content-Language: en-US
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
 <ZoIPzQNEsUWOWp3f@fedora>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZoIPzQNEsUWOWp3f@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,grimberg.me,linutronix.de,lst.de,suse.com,suse.de,parallelwireless.com,gmail.com,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]

On 7/1/24 04:09, Ming Lei wrote:
> On Thu, Jun 27, 2024 at 04:10:53PM +0200, Daniel Wagner wrote:
>> group_cpus_evenly distributes all present CPUs into groups. This ignores
>> the isolcpus configuration and assigns isolated CPUs into the groups.
>>
>> Make group_cpus_evenly aware of isolcpus configuration and use the
>> housekeeping CPU mask as base for distributing the available CPUs into
>> groups.
>>
>> Fixes: 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed interrupts")
>> Signed-off-by: Daniel Wagner <dwagner@suse.de>
>> ---
>>   lib/group_cpus.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 73 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
>> index ee272c4cefcc..19fb7186f9d4 100644
>> --- a/lib/group_cpus.c
>> +++ b/lib/group_cpus.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/cpu.h>
>>   #include <linux/sort.h>
>>   #include <linux/group_cpus.h>
>> +#include <linux/sched/isolation.h>
>>   
>>   #ifdef CONFIG_SMP
>>   
>> @@ -330,7 +331,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
>>   }
>>   
>>   /**
>> - * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
>> + * group_possible_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
>>    * @numgrps: number of groups
>>    *
>>    * Return: cpumask array if successful, NULL otherwise. And each element
>> @@ -344,7 +345,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
>>    * We guarantee in the resulted grouping that all CPUs are covered, and
>>    * no same CPU is assigned to multiple groups
>>    */
>> -struct cpumask *group_cpus_evenly(unsigned int numgrps)
>> +static struct cpumask *group_possible_cpus_evenly(unsigned int numgrps)
>>   {
>>   	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
>>   	cpumask_var_t *node_to_cpumask;
>> @@ -423,6 +424,76 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>>   	}
>>   	return masks;
>>   }
>> +
>> +/**
>> + * group_mask_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
>> + * @numgrps: number of groups
>> + * @cpu_mask: CPU to consider for the grouping
>> + *
>> + * Return: cpumask array if successful, NULL otherwise. And each element
>> + * includes CPUs assigned to this group.
>> + *
>> + * Try to put close CPUs from viewpoint of CPU and NUMA locality into
>> + * same group. Allocate present CPUs on these groups evenly.
>> + */
>> +static struct cpumask *group_mask_cpus_evenly(unsigned int numgrps,
>> +					      const struct cpumask *cpu_mask)
>> +{
>> +	cpumask_var_t *node_to_cpumask;
>> +	cpumask_var_t nmsk;
>> +	int ret = -ENOMEM;
>> +	struct cpumask *masks = NULL;
>> +
>> +	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
>> +		return NULL;
>> +
>> +	node_to_cpumask = alloc_node_to_cpumask();
>> +	if (!node_to_cpumask)
>> +		goto fail_nmsk;
>> +
>> +	masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
>> +	if (!masks)
>> +		goto fail_node_to_cpumask;
>> +
>> +	build_node_to_cpumask(node_to_cpumask);
>> +
>> +	ret = __group_cpus_evenly(0, numgrps, node_to_cpumask, cpu_mask, nmsk,
>> +				  masks);
>> +
>> +fail_node_to_cpumask:
>> +	free_node_to_cpumask(node_to_cpumask);
>> +
>> +fail_nmsk:
>> +	free_cpumask_var(nmsk);
>> +	if (ret < 0) {
>> +		kfree(masks);
>> +		return NULL;
>> +	}
>> +	return masks;
>> +}
>> +
>> +/**
>> + * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
>> + * @numgrps: number of groups
>> + *
>> + * Return: cpumask array if successful, NULL otherwise.
>> + *
>> + * group_possible_cpus_evently() is used for distributing the cpus on all
>> + * possible cpus in absence of isolcpus command line argument.
>> + * group_mask_cpu_evenly() is used when the isolcpus command line
>> + * argument is used with managed_irq option. In this case only the
>> + * housekeeping CPUs are considered.
>> + */
>> +struct cpumask *group_cpus_evenly(unsigned int numgrps)
>> +{
>> +	const struct cpumask *hk_mask;
>> +
>> +	hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
>> +	if (!cpumask_empty(hk_mask))
>> +		return group_mask_cpus_evenly(numgrps, hk_mask);
>> +
>> +	return group_possible_cpus_evenly(numgrps);
> 
> Since this patch, some isolated CPUs may not be covered in
> blk-mq queue mapping.
> 
> Meantime people still may submit IO workload from isolated CPUs
> such as by 'taskset -c', blk-mq may not work well for this situation,
> for example, IO hang may be caused during cpu hotplug.
> 
> I did see this kind of usage in some RH Openshift workloads.
> 
> If blk-mq problem can be solved, I am fine with this kind of
> change.
> 
That was kinda the idea of this patchset; when 'isolcpus' is active any 
in-kernel driver can only run on the housekeeping CPUs, and I/O from the 
isolcpus is impossible.
(Otherwise they won't be isolated anymore, and the whole concepts 
becomes ever so shaky.).
Consequently we should not spread blk-mq onto the isolcpus (which is 
what this patchset attempts). We do need to check how we could inhibit 
I/O from the isolcpus, though; not sure if we do that now.
Something we need to check.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

