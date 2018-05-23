Return-Path: <hare@suse.de>
Subject: Re: [PATCH 10/14] block: remove BLK_EH_HANDLED
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Ming Lei <ming.lei@redhat.com>,
 Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
 Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
 Rafael David Tinoco <rafael.tinoco@canonical.com>,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20180523121941.8632-1-hch@lst.de>
 <20180523121941.8632-11-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6293d425-ff72-125a-39d8-ad231d633733@suse.de>
Date: Wed, 23 May 2018 15:36:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180523121941.8632-11-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/23/2018 02:19 PM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   Documentation/scsi/scsi_eh.txt | 11 -----------
>   block/blk-mq.c                 |  3 ---
>   block/blk-timeout.c            |  3 ---
>   include/linux/blkdev.h         |  1 -
>   4 files changed, 18 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
