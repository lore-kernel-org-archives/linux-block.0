Return-Path: <prvs=780bbe9f7=roger.pau@citrix.com>
Date: Thu, 6 Sep 2018 18:14:21 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Valentin Vidic <Valentin.Vidic@CARNet.hr>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jens Axboe
	<axboe@kernel.dk>, <xen-devel@lists.xenproject.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <drbd-user@lists.linbit.com>
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
Message-ID: <20180906161421.ba35p6qx5rvktjos@mac.bytemobile.com>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905162756.GA26705@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20180905162756.GA26705@gavran.carpriv.carnet.hr>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 05, 2018 at 06:27:56PM +0200, Valentin Vidic wrote:
> On Wed, Sep 05, 2018 at 12:36:49PM +0200, Roger Pau Monn� wrote:
> > On Wed, Aug 29, 2018 at 08:52:14AM +0200, Valentin Vidic wrote:
> > > Switching to closed state earlier can cause the block-drbd
> > > script to fail with 'Device is held open by someone':
> > > 
> > > root: /etc/xen/scripts/block-drbd: remove XENBUS_PATH=backend/vbd/6/51712
> > > kernel: [ 2222.278235] block drbd6: State change failed: Device is held open by someone
> > > kernel: [ 2222.278304] block drbd6:   state = { cs:Connected ro:Primary/Secondary ds:UpToDate/UpToDate r----- }
> > > kernel: [ 2222.278340] block drbd6:  wanted = { cs:Connected ro:Secondary/Secondary ds:UpToDate/UpToDate r----- }
> > > root: /etc/xen/scripts/block-drbd: Writing backend/vbd/6/51712/hotplug-error /etc/xen/scripts/block-drbd failed; error detected. backend/vbd/6/51712/hotplug-status error to xenstore.
> > > root: /etc/xen/scripts/block-drbd: /etc/xen/scripts/block-drbd failed; error detected.
> > > 
> > > Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  drivers/block/xen-blkback/xenbus.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> > > index a4bc74e72c39..43bddc996709 100644
> > > --- a/drivers/block/xen-blkback/xenbus.c
> > > +++ b/drivers/block/xen-blkback/xenbus.c
> > > @@ -323,6 +323,7 @@ static void xen_blkif_free(struct xen_blkif *blkif)
> > >  {
> > >  	WARN_ON(xen_blkif_disconnect(blkif));
> > >  	xen_vbd_free(&blkif->vbd);
> > > +	xenbus_switch_state(blkif->be->dev, XenbusStateClosed);
> > >  	kfree(blkif->be->mode);
> > >  	kfree(blkif->be);
> > >  
> > > @@ -814,7 +815,6 @@ static void frontend_changed(struct xenbus_device *dev,
> > >  
> > >  	case XenbusStateClosed:
> > >  		xen_blkif_disconnect(be->blkif);
> > > -		xenbus_switch_state(dev, XenbusStateClosed);
> > >  		if (xenbus_dev_is_online(dev))
> > >  			break;
> > 
> > AFAICT, this will cause the backend to never switch to 'Closed' state
> > until the toolstack sets online to 0, which is not good IMO.
> > 
> > If for example a frontend decides to close a device, the backend will
> > stay in state 'Closing' until the toolstack actually removes the disk
> > by setting online to 0.
> > 
> > This will prevent resetting blk connections, as blkback will refuse to
> > switch to state XenbusStateInitWait unless it's at XenbusStateClosed
> > (see the XenbusStateInitialising case in frontend_changed), which will
> > never be reached with your patch.
> 
> Ok, is it possible to test this somehow?

Yes, you can try booting a PV guest with pvgrub, that will cause
pvgrub to open a blk connection, then close it and afterwards the OS
kernel will start a new connection.

Thanks, Roger.
