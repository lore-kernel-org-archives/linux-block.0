Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57969 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753111AbcGDIKg (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Mon, 4 Jul 2016 04:10:36 -0400
Date: Mon, 4 Jul 2016 10:15:41 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, axboe@fb.com, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] blk-mq: allow the driver to pass in an affinity
 mask
Message-ID: <20160704081540.GA2783@agordeev.lab.eng.brq.redhat.com>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-12-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465934346-20648-12-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 14, 2016 at 09:59:04PM +0200, Christoph Hellwig wrote:
> +static int blk_mq_create_mq_map(struct blk_mq_tag_set *set,
> +		const struct cpumask *affinity_mask)
> +{
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

CPUs missing in an affinity mask are mapped to hctxs. Is that intended?

> +		if (queue > 0)

Why this check?

> +			set->mq_map[cpu] = queue;
> +	}
> +
> +	return 0;
> +}
> +
