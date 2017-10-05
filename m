Return-Path: <davem@davemloft.net>
Date: Wed, 04 Oct 2017 17:42:55 -0700 (PDT)
Message-Id: <20171004.174255.1064054103427287818.davem@davemloft.net>
To: bart.vanassche@wdc.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de,
 martin.petersen@oracle.com, oleksandr@natalenko.name, mcgrof@kernel.org,
 ming.lei@redhat.com, hare@suse.com, jthumshirn@suse.de
Subject: Re: [PATCH v6 7/9] ide, scsi: Tell the block layer at request
 allocation time about preempt requests
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171005000110.15904-8-bart.vanassche@wdc.com>
References: <20171005000110.15904-1-bart.vanassche@wdc.com>
	<20171005000110.15904-8-bart.vanassche@wdc.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

From: Bart Van Assche <bart.vanassche@wdc.com>
Date: Wed,  4 Oct 2017 17:01:08 -0700

> Convert blk_get_request(q, op, __GFP_RECLAIM) into blk_get_request(q,
> op, BLK_MQ_PREEMPT). This patch does not change any functionality.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>

For IDE:

Acked-by: David S. Miller <davem@davemloft.net>
