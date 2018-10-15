Return-Path: <prvs=8197794ea=roger.pau@citrix.com>
Date: Mon, 15 Oct 2018 16:02:01 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Vasilis Liaskovitis <vliaskovitis@suse.com>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <jgross@suse.com>,
	<boris.ostrovsky@oracle.com>, <konrad.wilk@oracle.com>, <axboe@kernel.dk>
Subject: Re: [PATCH v2] xen/blkfront: avoid NULL blkfront_info dereference on
 device removal
Message-ID: <20181015140201.elir7ettk7sz4aix@mac.bytemobile.com>
References: <20181015132508.23293-1-vliaskovitis@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20181015132508.23293-1-vliaskovitis@suse.com>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 15, 2018 at 03:25:08PM +0200, Vasilis Liaskovitis wrote:
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

Reviewed-by: Roger Pau Monn� <roger.pau@citrix.com>

Thanks.

I guess this is a candidate for backporting?
