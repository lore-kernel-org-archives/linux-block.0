Return-Path: <prvs=8150a737c=roger.pau@citrix.com>
Date: Thu, 11 Oct 2018 18:34:27 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Vasilis Liaskovitis <vliaskovitis@suse.com>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <jgross@suse.com>, <axboe@kernel.dk>,
	<konrad.wilk@oracle.com>, <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH] xen/blkfront: avoid NULL blkfront_info
 dereference on device removal
Message-ID: <20181011163427.ilpsl4hxb2y3hcfp@mac.bytemobile.com>
References: <20181011162000.19191-1-vliaskovitis@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20181011162000.19191-1-vliaskovitis@suse.com>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 11, 2018 at 06:20:00PM +0200, Vasilis Liaskovitis wrote:
> If a block device is hot-added when we are out of grants,
> gnttab_grant_foreign_access fails with -ENOSPC (log message "28
> granting access to ring page") in this code path:
> 
>   talk_to_blkback ->
> 	setup_blkring ->
> 		xenbus_grant_ring ->
> 			gnttab_grant_foreign_access
> 
> and the failing path in talk_to_blkback sets the driver_data to NULL:
> 
>  destroy_blkring:
>         blkif_free(info, 0);
> 
>         mutex_lock(&blkfront_mutex);
>         free_info(info);
>         mutex_unlock(&blkfront_mutex);
> 
>         dev_set_drvdata(&dev->dev, NULL);
> 
> This results in a NULL pointer BUG when blkfront_remove and blkif_free
> try to access the failing device's NULL struct blkfront_info.
> 
> Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
> ---
>  drivers/block/xen-blkfront.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 429d20131c7e..92cc6cb6b078 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -2493,6 +2493,9 @@ static int blkfront_remove(struct xenbus_device *xbdev)
>  
>  	dev_dbg(&xbdev->dev, "%s removed", xbdev->nodename);
>  
> +	if (!info)
> +		goto out;

I don't see the point in adding the 'out' label. Can you just return 0
here?

Thanks, Roger.
