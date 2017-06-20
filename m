Return-Path: <hare@suse.de>
Subject: Re: [PATCH v4 11/12] block: Constify disk_type
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke
 <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20170619220801.12557-1-bart.vanassche@wdc.com>
 <20170619220801.12557-12-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6c4dc6f3-6812-81dc-c2fd-fc3f4faa6ca2@suse.de>
Date: Tue, 20 Jun 2017 08:43:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170619220801.12557-12-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 12:08 AM, Bart Van Assche wrote:
> From: Bart Van Assche <bart.vanassche@sandisk.com>
> 
> The variable 'disk_type' is never modified so constify it.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/genhd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index d252d29fe837..7f520fa25d16 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -36,7 +36,7 @@ struct kobject *block_depr;
>  static DEFINE_SPINLOCK(ext_devt_lock);
>  static DEFINE_IDR(ext_devt_idr);
>  
> -static struct device_type disk_type;
> +static const struct device_type disk_type;
>  
>  static void disk_check_events(struct disk_events *ev,
>  			      unsigned int *clearing_ptr);
> @@ -1183,7 +1183,7 @@ static char *block_devnode(struct device *dev, umode_t *mode,
>  	return NULL;
>  }
>  
> -static struct device_type disk_type = {
> +static const struct device_type disk_type = {
>  	.name		= "disk",
>  	.groups		= disk_attr_groups,
>  	.release	= disk_release,
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
