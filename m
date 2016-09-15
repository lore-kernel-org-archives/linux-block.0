Subject: Re: [PATCH 13/13] blk-mq: get rid of the cpumask in struct
 blk_mq_tags
To: Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
 <1473862739-15032-14-git-send-email-hch@lst.de>
 <20160915144413.GA19508@infradead.org>
Cc: tglx@linutronix.de, agordeev@redhat.com, keith.busch@intel.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <a56cdc55-fcc5-02c8-74d1-ca182d70e1d2@fb.com>
Date: Thu, 15 Sep 2016 08:46:41 -0600
MIME-Version: 1.0
In-Reply-To: <20160915144413.GA19508@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/15/2016 08:44 AM, Christoph Hellwig wrote:
>> +static int blk_mq_create_mq_map(struct blk_mq_tag_set *set,
>> +		const struct cpumask *affinity_mask)
>>  {
>> +	int queue = -1, cpu = 0;
>> +
>> +	set->mq_map = kzalloc_node(sizeof(*set->mq_map) * nr_cpu_ids,
>> +			GFP_KERNEL, set->numa_node);
>> +	if (!set->mq_map)
>> +		return -ENOMEM;
>> +
>> +	if (!affinity_mask)
>> +		return 0;	/* map all cpus to queue 0 */
>> +
>> +	/* If cpus are offline, map them to first hctx */
>> +	for_each_online_cpu(cpu) {
>> +		if (cpumask_test_cpu(cpu, affinity_mask))
>> +			queue++;
>> +		if (queue >= 0)
>> +			set->mq_map[cpu] = queue;
>> +	}
>> +
>> +	return 0;
>>  }
>
> I just noticed that the patch adds this unused function due to a rebase
> error.  Jens, do you you just want to fix this up while applying or
> should I resend?

Killed it off manually, I already applied and pushed it out.

-- 
Jens Axboe
