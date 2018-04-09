Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/8] blk-mq: fix and improve queue mapping
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefan Haberland <sth@linux.vnet.ibm.com>
References: <20180408094814.28953-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <218448cb-bdf5-903b-3363-1c53de686b67@kernel.dk>
Date: Mon, 9 Apr 2018 09:00:12 -0600
MIME-Version: 1.0
In-Reply-To: <20180408094814.28953-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/8/18 3:48 AM, Ming Lei wrote:
> Hi Jens,
> 
> The first two patches fix issues about queue mapping.
> 
> The other 6 patches improve queue mapping for blk-mq.
> 
> Christian, this patches should fix your issue, so please give
> a test, and the patches can be found in the following tree:
> 
> 	https://github.com/ming1/linux/commits/v4.17-rc-blk-fix_mapping_v1
> 
> Thanks,
> Ming
> 
> Ming Lei (8):
>   blk-mq: make sure that correct hctx->next_cpu is set
>   blk-mq: don't keep offline CPUs mapped to hctx 0
>   blk-mq: avoid to write intermediate result to hctx->next_cpu
>   blk-mq: introduce blk_mq_hw_queue_first_cpu() to figure out first cpu
>   blk-mq: remove blk_mq_delay_queue()
>   blk-mq: don't check queue mapped in __blk_mq_delay_run_hw_queue()
>   blk-mq: reimplement blk_mq_hw_queue_mapped
>   blk-mq: remove code for dealing with remapping queue

Thanks Ming, applied for this series.

-- 
Jens Axboe
