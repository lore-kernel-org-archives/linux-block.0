Return-Path: <Valentin.Vidic@carnet.hr>
Date: Fri, 7 Sep 2018 00:19:29 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, drbd-user@lists.linbit.com
Message-ID: <20180906221929.GZ26705@gavran.carpriv.carnet.hr>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905113515.GU26705@gavran.carpriv.carnet.hr>
 <20180905162801.GB26705@gavran.carpriv.carnet.hr>
 <20180906162932.7qge5dmrgyqbmbbj@mac.bytemobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180906162932.7qge5dmrgyqbmbbj@mac.bytemobile.com>
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 06, 2018 at 06:29:32PM +0200, Roger Pau Monn� wrote:
> On Wed, Sep 05, 2018 at 06:28:01PM +0200, Valentin Vidic wrote:
> > On Wed, Sep 05, 2018 at 01:35:15PM +0200, Valentin Vidic wrote:
> > > > AFAICT, this will cause the backend to never switch to 'Closed' state
> > > > until the toolstack sets online to 0, which is not good IMO.
> > > > 
> > > > If for example a frontend decides to close a device, the backend will
> > > > stay in state 'Closing' until the toolstack actually removes the disk
> > > > by setting online to 0.
> > > > 
> > > > This will prevent resetting blk connections, as blkback will refuse to
> > > > switch to state XenbusStateInitWait unless it's at XenbusStateClosed
> > > > (see the XenbusStateInitialising case in frontend_changed), which will
> > > > never be reached with your patch.
> > 
> > Would it be possible to call xen_vbd_free before the state change?
> > 
> >         case XenbusStateClosed:
> >                 xen_blkif_disconnect(be->blkif);
> >                 xen_vbd_free(&be->blkif->vbd);
> >                 xenbus_switch_state(dev, XenbusStateClosed);
> 
> I think that will break reconnection, since xen_vbd_create is only
> called after hotplug script execution is performed (which happens only
> once at device attachment), but not when DomU changes frontend
> state.
> 
> If you want to perform this xen_vbd_free you will also have to move
> the xen_vbd_create call AFAICT, to a place that's also called when
> reconnecting a device. Note that I could be wrong, so it might be
> worth a shot to try different approaches since the blkback code is
> quite tangled and I might miss something.

It seems like the Closed state is not a good point to call the remove
script since the device could go back from Closed to Connected.

Maybe it would help to introduce a new final state (7 = XenbusStateFree
or XenbusStateRemove) that would be set after xen_vbd_free to let the
userspace know it is safe to run the remove script?

static void xen_blkif_free(struct xen_blkif *blkif)
{

        WARN_ON(xen_blkif_disconnect(blkif));
        xen_vbd_free(&blkif->vbd);
        xenbus_switch_state(blkif->be->dev, XenbusStateFree);
        kfree(blkif->be->mode);
        kfree(blkif->be);

        /* Make sure everything is drained before shutting down */
        kmem_cache_free(xen_blkif_cachep, blkif);
}

-- 
Valentin
