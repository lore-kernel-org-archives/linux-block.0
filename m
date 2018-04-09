Return-Path: <borntraeger@de.ibm.com>
Subject: Re: [PATCH 0/8] blk-mq: fix and improve queue mapping
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Cc: Stefan Haberland <sth@linux.vnet.ibm.com>
References: <20180408094814.28953-1-ming.lei@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 9 Apr 2018 12:13:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180408094814.28953-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <9db87ee1-f821-42a6-93de-ce4d3264e27b@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>



On 04/08/2018 11:48 AM, Ming Lei wrote:
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

Looks good. With all patches applied, I can no longer reproduce any warning message.
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>

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
> 
>  block/blk-mq-cpumap.c  |   5 ---
>  block/blk-mq-debugfs.c |   1 -
>  block/blk-mq.c         | 101 +++++++++++--------------------------------------
>  block/blk-mq.h         |   2 +-
>  include/linux/blk-mq.h |   2 -
>  5 files changed, 24 insertions(+), 87 deletions(-)
> 
