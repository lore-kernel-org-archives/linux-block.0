Return-Path: <hare@suse.de>
Subject: Re: [PATCH 3/6] skd_main: don't use req->special
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20181109183208.19879-1-hch@lst.de>
 <20181109183208.19879-4-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ad41f25a-53f2-da55-57e7-8bdf2b71858a@suse.de>
Date: Sat, 10 Nov 2018 13:57:29 +0100
MIME-Version: 1.0
In-Reply-To: <20181109183208.19879-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/9/18 7:32 PM, Christoph Hellwig wrote:
> Add a retries field to the internal request structure instead, which gets
> set to zero on the first submission.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/skd_main.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
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
