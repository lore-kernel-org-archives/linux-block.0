Return-Path: <vliaskovitis@suse.com>
Message-ID: <886d0f79d59d2d35ca75f9d2d79cdb45c1628c78.camel@suse.com>
Subject: Re: [Xen-devel] [PATCH] xen/blkfront: avoid NULL blkfront_info
 dereference on device removal
From: Vasilis Liaskovitis <vliaskovitis@suse.com>
To: Roger Pau =?ISO-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: axboe@kernel.dk, jgross@suse.com, konrad.wilk@oracle.com,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Date: Mon, 15 Oct 2018 10:55:54 +0200
In-Reply-To: <20181011163427.ilpsl4hxb2y3hcfp@mac.bytemobile.com>
References: <20181011162000.19191-1-vliaskovitis@suse.com>
	 <20181011163427.ilpsl4hxb2y3hcfp@mac.bytemobile.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-10-11 at 18:34 +0200, Roger Pau Monné wrote:
> --- a/drivers/block/xen-blkfront.c
> > +++ b/drivers/block/xen-blkfront.c
> > @@ -2493,6 +2493,9 @@ static int blkfront_remove(struct
> > xenbus_device *xbdev)
> >  
> >  	dev_dbg(&xbdev->dev, "%s removed", xbdev->nodename);
> >  
> > +	if (!info)
> > +		goto out;
> 
> I don't see the point in adding the 'out' label. Can you just return
> 0
> here?

of course, I will send a second version.
 
thanks for the review,

- Vasilis

> 
> Thanks, Roger.
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
