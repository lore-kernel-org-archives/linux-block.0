Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:46658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbcIOOoT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 10:44:19 -0400
Date: Thu, 15 Sep 2016 07:44:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, tglx@linutronix.de, agordeev@redhat.com,
        keith.busch@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] blk-mq: get rid of the cpumask in struct
 blk_mq_tags
Message-ID: <20160915144413.GA19508@infradead.org>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
 <1473862739-15032-14-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473862739-15032-14-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> +static int blk_mq_create_mq_map(struct blk_mq_tag_set *set,
> +		const struct cpumask *affinity_mask)
>  {
> +	int queue = -1, cpu = 0;
> +
> +	set->mq_map = kzalloc_node(sizeof(*set->mq_map) * nr_cpu_ids,
> +			GFP_KERNEL, set->numa_node);
> +	if (!set->mq_map)
> +		return -ENOMEM;
> +
> +	if (!affinity_mask)
> +		return 0;	/* map all cpus to queue 0 */
> +
> +	/* If cpus are offline, map them to first hctx */
> +	for_each_online_cpu(cpu) {
> +		if (cpumask_test_cpu(cpu, affinity_mask))
> +			queue++;
> +		if (queue >= 0)
> +			set->mq_map[cpu] = queue;
> +	}
> +
> +	return 0;
>  }

I just noticed that the patch adds this unused function due to a rebase
error.  Jens, do you you just want to fix this up while applying or
should I resend?
