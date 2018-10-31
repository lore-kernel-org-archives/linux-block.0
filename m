Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 14/16] nvme: utilize two queue maps, one for reads and one
 for writes
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-15-axboe@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <193a50fe-0c02-9f01-f110-5cfa1cec9283@grimberg.me>
Date: Tue, 30 Oct 2018 18:57:05 -0700
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-15-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> +static int queue_irq_offset(struct nvme_dev *dev)
> +{
> +	/* if we have more than 1 vec, admin queue offsets us 1 */

offsets us by 1?

> +	if (dev->num_vecs > 1)
> +		return 1;
> +
> +	return 0;
> +}
> +

...

> @@ -1934,13 +2048,48 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>   	 * setting up the full range we need.
>   	 */
>   	pci_free_irq_vectors(pdev);
> -	result = pci_alloc_irq_vectors_affinity(pdev, 1, nr_io_queues + 1,
> -			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
> -	if (result <= 0)
> -		return -EIO;
> +
> +	/*
> +	 * For irq sets, we have to ask for minvec == maxvec. This passes
> +	 * any reduction back to us, so we can adjust our queue counts and
> +	 * IRQ vector needs.
> +	 */
> +	do {
> +		nvme_calc_io_queues(dev, nr_io_queues);
> +		irq_sets[0] = dev->io_queues[NVMEQ_TYPE_READ];
> +		irq_sets[1] = dev->io_queues[NVMEQ_TYPE_WRITE];
> +		if (!irq_sets[1])
> +			affd.nr_sets = 1;
> +
> +		/*
> +		 * Need IRQs for read+write queues, and one for the admin queue
> +		 */
> +		nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
> +
> +		result = pci_alloc_irq_vectors_affinity(pdev, nr_io_queues,
> +				nr_io_queues,
> +				PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
> +
> +		/*
> +		 * Need to reduce our vec counts
> +		 */
> +		if (result == -ENOSPC) {
> +			nr_io_queues--;
> +			if (!nr_io_queues)
> +				return result;
> +			continue;
> +		} else if (result <= 0)
> +			return -EIO;
> +		break;
> +	} while (1);
> +
>   	dev->num_vecs = result;
>   	dev->max_qid = max(result - 1, 1);
>   
> +	dev_info(dev->ctrl.device, "%d/%d/%d read/write queues\n",
> +					dev->io_queues[NVMEQ_TYPE_READ],
> +					dev->io_queues[NVMEQ_TYPE_WRITE]);
> +

Perhaps it would be better if we move this code into a function.
