Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Wed, 31 Aug 2016 12:38:53 -0400
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/7] blk-mq: allow the driver to pass in an affinity mask
Message-ID: <20160831163852.GB5598@localhost.localdomain>
References: <1472468013-29936-1-git-send-email-hch@lst.de>
 <1472468013-29936-5-git-send-email-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <1472468013-29936-5-git-send-email-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@fb.com, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 29, 2016 at 12:53:30PM +0200, Christoph Hellwig wrote:
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
> +		if (queue >= 0)
> +			set->mq_map[cpu] = queue;
> +	}

This can't be right. We have a single affinity mask for the entire
set, but what I think we want is an one affinity mask for each
nr_io_queues. The irq_create_affinity_mask should then create an array
of cpumasks based on nr_vecs..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
