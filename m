Return-Path: <prvs=396451df5=anthony.perard@citrix.com>
Date: Fri, 18 Aug 2017 12:46:23 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Roger Pau Monn303251 <roger.pau@citrix.com>
CC: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <xen-devel@lists.xenproject.org>, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [Xen-devel] [PATCH 12/12] xen-blkfront: Avoid that gcc 7 warns
 about fall-through when building with W=1
Message-ID: <20170818114623.GF1475@perard.uk.xensource.com>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
 <20170817232311.25948-13-bart.vanassche@wdc.com>
 <20170818085401.5fokhfurydomfxow@MacBook-Pro-de-Roger.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170818085401.5fokhfurydomfxow@MacBook-Pro-de-Roger.local>
Return-Path: anthony.perard@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Fri, Aug 18, 2017 at 09:54:01AM +0100, Roger Pau Monn303251 wrote:
> On Thu, Aug 17, 2017 at 04:23:11PM -0700, Bart Van Assche wrote:
> > Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: Roger Pau Monn303251 <roger.pau@citrix.com>
> > Cc: xen-devel@lists.xenproject.org
> > ---
> >  drivers/block/xen-blkfront.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> > index 98e34e4c62b8..270019e3e5d8 100644
> > --- a/drivers/block/xen-blkfront.c
> > +++ b/drivers/block/xen-blkfront.c
> > @@ -2456,7 +2456,7 @@ static void blkback_changed(struct xenbus_device *dev,
> >  	case XenbusStateClosed:
> >  		if (dev->state == XenbusStateClosed)
> >  			break;
> > -		/* Missed the backend's Closing state -- fallthrough */
> > +		/* fall through */
> 
> This is losing information present in the original comment. Would
> splitting the comment into two make gcc happy?

What about:

-		/* Missed the backend's Closing state -- fallthrough */
+		/* fallthrough -- Missed the backend's Closing state */

FIY:
https://gcc.gnu.org/onlinedocs/gcc-7.2.0/gcc/Warning-Options.html#index-Wimplicit-fallthrough

A dash seems to be needed between "fall through" and a extra comment,
with fallthrough first.

Regards,

-- 
Anthony PERARD
