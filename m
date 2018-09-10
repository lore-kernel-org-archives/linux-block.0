Return-Path: <Valentin.Vidic@carnet.hr>
Date: Mon, 10 Sep 2018 15:22:52 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: drbd-user@lists.linbit.com
Cc: Jens Axboe <axboe@kernel.dk>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Message-ID: <20180910132252.GE26705@gavran.carpriv.carnet.hr>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905162756.GA26705@gavran.carpriv.carnet.hr>
 <20180907120337.GB11834@soda.linbit>
 <20180907121348.GM26705@gavran.carpriv.carnet.hr>
 <20180907132828.GC11834@soda.linbit>
 <20180907164500.GN26705@gavran.carpriv.carnet.hr>
 <20180907171459.GO26705@gavran.carpriv.carnet.hr>
 <20180908073432.GP26705@gavran.carpriv.carnet.hr>
 <20180910124531.GA31737@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180910124531.GA31737@soda.linbit>
Subject: Re: [DRBD-user] [PATCH] xen-blkback: Switch to closed state after
 releasing the backing device
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 10, 2018 at 02:45:31PM +0200, Lars Ellenberg wrote:
> On Sat, Sep 08, 2018 at 09:34:32AM +0200, Valentin Vidic wrote:
> > On Fri, Sep 07, 2018 at 07:14:59PM +0200, Valentin Vidic wrote:
> > > In fact the first one is the original code path before I modified
> > > blkback.  The problem is it gets executed async from workqueue so
> > > it might not always run before the call to drbdadm secondary.
> > 
> > As the DRBD device gets released only when the last IO request
> > has finished, I found a way to check and wait for this in the
> > block-drbd script:
> 
> > --- block-drbd.orig     2018-09-08 09:07:23.499648515 +0200
> > +++ block-drbd  2018-09-08 09:28:12.892193649 +0200
> > @@ -230,6 +230,24 @@
> >  and so cannot be mounted ${m2}${when}."
> >  }
> >  
> > +wait_for_inflight()
> > +{
> > +  local dev="$1"
> > +  local inflight="/sys/block/${dev#/dev/}/inflight"
> > +  local rd wr
> > +
> > +  if ! [ -f "$inflight" ]; then
> > +    return
> > +  fi
> > +
> > +  while true; do
> > +    read rd wr < $inflight
> > +    if [ "$rd" = "0" -a "$wr" = "0" ]; then
> 
> If it is "idle" now, but still "open",
> this will not sleep, and still fail the demotion below.

True, but in this case blkback is holding it open until all
the writes have finished and the last write closes the device.
Since fuser can't check blkback this is an approximation that
seems to work because I don't get any failed drbdadm calls now.

> You try to help it by "waiting forever until it appears to be idle".
> I suggest to at least limit the retries by iteration or time.
> And also (or, instead; but you'd potentially get a number of
> "scary messages" in the logs) add something like:

Ok, should I open a PR to discuss this change further?

> Or, well, yes, fix blkback to not "defer" the final close "too long",
> if at all possible.

blkback needs to finish the writes on shutdown or I get a fsck errors
on next boot. Ideally XenbusStateClosed should be delayed until the
device release but currently it does not seem possible without breaking
other things.

-- 
Valentin
