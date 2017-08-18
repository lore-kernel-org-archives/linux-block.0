Return-Path: <hare@suse.de>
Subject: Re: [PATCH 10/12] xen-blkback: Fix indentation
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Roger Pau Monn303251 <roger.pau@citrix.com>, xen-devel@lists.xenproject.org
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
 <20170817232311.25948-11-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1b190eba-1b2c-6d6c-42d4-f1f480417a3c@suse.de>
Date: Fri, 18 Aug 2017 09:40:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170817232311.25948-11-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 01:23 AM, Bart Van Assche wrote:
> Avoid that smatch reports the following warning when building with
> C=2 CHECK="smatch -p=kernel":
> 
> drivers/block/xen-blkback/blkback.c:710 xen_blkbk_unmap_prepare() warn: inconsistent indenting
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Roger Pau Monn303251 <roger.pau@citrix.com>
> Cc: xen-devel@lists.xenproject.org
> ---
>  drivers/block/xen-blkback/blkback.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> index fe7cd58c43d0..68157a84bf4d 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -705,9 +705,9 @@ static unsigned int xen_blkbk_unmap_prepare(
>  				    GNTMAP_host_map, pages[i]->handle);
>  		pages[i]->handle = BLKBACK_INVALID_HANDLE;
>  		invcount++;
> -       }
> +	}
>  
> -       return invcount;
> +	return invcount;
>  }
>  
>  static void xen_blkbk_unmap_and_respond_callback(int result, struct gntab_unmap_queue_data *data)
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
