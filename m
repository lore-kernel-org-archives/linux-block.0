Return-Path: <hare@suse.de>
Subject: Re: [PATCH 2/6] nullb: remove leftover legacy request code
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20181109183208.19879-1-hch@lst.de>
 <20181109183208.19879-3-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0c3dfadb-eb4d-a99a-a521-abdafd7df2a2@suse.de>
Date: Sat, 10 Nov 2018 13:56:46 +0100
MIME-Version: 1.0
In-Reply-To: <20181109183208.19879-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/9/18 7:32 PM, Christoph Hellwig wrote:
> null_softirq_done_fn is only used for the blk-mq path, so remove the
> other branch.  Also rename the function to better match the method name.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/null_blk_main.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
