Return-Path: <jthumshirn@suse.de>
Subject: Re: [PATCH v2 3/3] blk-mq: remove blk_mq_abort_requeue_list()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Zhang Yi <yizhan@redhat.com>,
 linux-block@vger.kernel.org
References: <20170520035605.21785-1-ming.lei@redhat.com>
 <20170520035605.21785-4-ming.lei@redhat.com>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <36461789-9377-a245-0920-5e6ee671f5bb@suse.de>
Date: Mon, 22 May 2017 09:43:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170520035605.21785-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/20/2017 05:56 AM, Ming Lei wrote:
> No one uses it any more, so remove it.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>


-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
