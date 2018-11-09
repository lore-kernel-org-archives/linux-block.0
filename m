Return-Path: <greg@kroah.com>
Date: Fri, 9 Nov 2018 03:17:00 -0800
From: Greg KH <greg@kroah.com>
To: Manjunath Patil <manjunath.b.patil@oracle.com>
Cc: boris.ostrovsky@oracle.com, jgross@suse.com, konrad.wilk@oracle.com,
	roger.pau@citrix.com, axboe@kernel.dk,
	xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] xen-blkfront: fix kernel panic with blkfront_remove()
Message-ID: <20181109111700.GC26335@kroah.com>
References: <1541725108-1468-1-git-send-email-manjunath.b.patil@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1541725108-1468-1-git-send-email-manjunath.b.patil@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 08, 2018 at 04:58:28PM -0800, Manjunath Patil wrote:
> If a hot-attaching device fails inside domU[ex:negotiate_mq() returns
> with ENOMEM] we clear the blkfront_info struct in talk_to_blkback()
> 
> When we try to detach the device, blkfront_remove() tries to access
> blkfront_info leading to kernel panic.
> 
> Typical call stack involving panic -
>  #10 page_fault at ffffffff816f25df
>      [exception RIP: blkif_free+46]
>  #11 blkfront_remove at ffffffffa004de47 [xen_blkfront]
>  #12 xenbus_dev_remove at ffffffff813faa4c
>  #13 __device_release_driver at ffffffff814769aa
>  #14 device_release_driver at ffffffff81476a63
>  #15 bus_remove_device at ffffffff814762eb
>  #16 device_del at ffffffff81472684
>  #17 device_unregister at ffffffff814727e2
>  #18 xenbus_dev_changed at ffffffff813fa89f
>  #19 frontend_changed at ffffffff813fca19
>  #20 xenwatch_thread at ffffffff813f88f9
>  #21 kthread at ffffffff810a486b
>  #22 ret_from_fork at ffffffff816ed2a8
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
> ---
>  drivers/block/xen-blkfront.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index dc8fe25..144cda8 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -2496,6 +2496,9 @@ static int blkfront_remove(struct xenbus_device *xbdev)
>  
>  	dev_dbg(&xbdev->dev, "%s removed", xbdev->nodename);
>  
> +	if(!info)
> +		return 0;
> +

Always run scripts/checkpatch.pl on your patches so you do not get a
grumpy maintainer telling you to run scripts/checkpatch.pl on your
patches.

thanks,

greg k-h
