Return-Path: <hare@suse.de>
Subject: Re: [PATCH 4/6] aoe: replace ->special use with private data in the
 request
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20181109183208.19879-1-hch@lst.de>
 <20181109183208.19879-5-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e1e14587-1a75-54ec-748b-36d8329f82bb@suse.de>
Date: Sat, 10 Nov 2018 13:58:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181109183208.19879-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/9/18 7:32 PM, Christoph Hellwig wrote:
> Makes the code a whole lot better to read..
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/aoe/aoe.h    |  4 ++++
>  drivers/block/aoe/aoeblk.c |  1 +
>  drivers/block/aoe/aoecmd.c | 27 +++++++++------------------
>  drivers/block/aoe/aoedev.c | 11 ++++++-----
>  4 files changed, 20 insertions(+), 23 deletions(-)
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
