Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-db5eur01on0078.outbound.protection.outlook.com ([104.47.2.78]:41555
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751094AbdDDHrK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Apr 2017 03:47:10 -0400
Subject: Re: [PATCH rfc 5/6] block: Add rdma affinity based queue mapping
 helper
To: Sagi Grimberg <sagi@grimberg.me>, <linux-rdma@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
References: <1491140492-25703-1-git-send-email-sagi@grimberg.me>
 <1491140492-25703-6-git-send-email-sagi@grimberg.me>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <becb84ac-7819-a207-56b1-70f16cb80e42@mellanox.com>
Date: Tue, 4 Apr 2017 10:46:54 +0300
MIME-Version: 1.0
In-Reply-To: <1491140492-25703-6-git-send-email-sagi@grimberg.me>
Content-Type: text/plain; charset="windows-1255"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c
> new file mode 100644
> index 000000000000..d402f7c93528
> --- /dev/null
> +++ b/block/blk-mq-rdma.c
> @@ -0,0 +1,56 @@
> +/*
> + * Copyright (c) 2017 Sagi Grimberg.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */

shouldn't you include  <linux/kobject.h> and <linux/blkdev.h> like in 
commit 8ec2ef2b66ea2f that fixes blk-mq-pci.c ?

> +#include <linux/blk-mq.h>
> +#include <linux/blk-mq-rdma.h>
> +#include <rdma/ib_verbs.h>
> +#include <linux/module.h>
> +#include "blk-mq.h"

Is this include needed ?


> +
> +/**
> + * blk_mq_rdma_map_queues - provide a default queue mapping for rdma device
> + * @set:	tagset to provide the mapping for
> + * @dev:	rdma device associated with @set.
> + * @first_vec:	first interrupt vectors to use for queues (usually 0)
> + *
> + * This function assumes the rdma device @dev has at least as many available
> + * interrupt vetors as @set has queues.  It will then query it's affinity mask
> + * and built queue mapping that maps a queue to the CPUs that have irq affinity
> + * for the corresponding vector.
> + *
> + * In case either the driver passed a @dev with less vectors than
> + * @set->nr_hw_queues, or @dev does not provide an affinity mask for a
> + * vector, we fallback to the naive mapping.
> + */
> +int blk_mq_rdma_map_queues(struct blk_mq_tag_set *set,
> +		struct ib_device *dev, int first_vec)
> +{
> +	const struct cpumask *mask;
> +	unsigned int queue, cpu;
> +
> +	if (set->nr_hw_queues > dev->num_comp_vectors)
> +		goto fallback;
> +
> +	for (queue = 0; queue < set->nr_hw_queues; queue++) {
> +		mask = ib_get_vector_affinity(dev, first_vec + queue);
> +		if (!mask)
> +			goto fallback;

Christoph,
we can use fallback also in the blk-mq-pci.c in case 
pci_irq_get_affinity fails, right ?

> +
> +		for_each_cpu(cpu, mask)
> +			set->mq_map[cpu] = queue;
> +	}
> +
> +	return 0;
> +fallback:
> +	return blk_mq_map_queues(set);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_rdma_map_queues);

Otherwise, Looks good.

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
