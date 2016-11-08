Return-Path: <hch@lst.de>
Date: Tue, 8 Nov 2016 15:55:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] genirq/affinity: Handle pre/post vectors in
	irq_create_affinity_masks()
Message-ID: <20161108145508.GA12519@lst.de>
References: <1478544462-9549-1-git-send-email-hch@lst.de> <1478544462-9549-4-git-send-email-hch@lst.de> <a7e25633-b9fb-468f-fd33-28dbc0368cc1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a7e25633-b9fb-468f-fd33-28dbc0368cc1@suse.de>
List-ID: <linux-block@vger.kernel.org>

[please trim the f***king context in your replies, thanks..]

On Tue, Nov 08, 2016 at 09:15:27AM +0100, Hannes Reinecke wrote:
>> +irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>>  {
>> -	int n, nodes, vecs_per_node, cpus_per_vec, extra_vecs, curvec = 0;
>> +	int n, nodes, vecs_per_node, cpus_per_vec, extra_vecs, curvec;
>> +	int affv = nvecs - affd->pre_vectors - affd->post_vectors;
>>  	nodemask_t nodemsk = NODE_MASK_NONE;
>>  	struct cpumask *masks;
>>  	cpumask_var_t nmsk;
> Check for NULL affd?

We expect all callers to pass a valid one.
