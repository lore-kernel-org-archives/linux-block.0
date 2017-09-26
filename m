Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59845 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935258AbdIZGFq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Sep 2017 02:05:46 -0400
Subject: Re: [PATCH v4 2/7] block: Make q_usage_counter also track legacy
 requests
To: Bart Van Assche <bart.vanassche@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        =Oleksandr Natalenko <oleksandr@natalenko.name>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20170925202924.16603-1-bart.vanassche@wdc.com>
 <20170925202924.16603-3-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <96bdb020-296c-a382-46e4-dffbdf84d32d@suse.de>
Date: Tue, 26 Sep 2017 08:05:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170925202924.16603-3-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/25/2017 10:29 PM, Bart Van Assche wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> This patch makes it possible to pause request allocation for
> the legacy block layer by calling blk_mq_freeze_queue() and
> blk_mq_unfreeze_queue().
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> [ bvanassche: Combined two patches into one, edited a comment and made sure
>   REQ_NOWAIT is handled properly in blk_old_get_request() ]
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/blk-core.c | 12 ++++++++++++
>  block/blk-mq.c   | 10 ++--------
>  2 files changed, 14 insertions(+), 8 deletions(-)
> 
I actually had a customer reoport hitting a q_usage_counter underflow,
so this is a real bugfix. And I'd advocate to have it pushed
independently on the overall patchset, if it should be delayed even further.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
