Return-Path: <Valentin.Vidic@carnet.hr>
Date: Wed, 5 Sep 2018 18:27:56 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, drbd-user@lists.linbit.com
Message-ID: <20180905162756.GA26705@gavran.carpriv.carnet.hr>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 05, 2018 at 12:36:49PM +0200, Roger Pau Monn=E9 wrote:
> On Wed, Aug 29, 2018 at 08:52:14AM +0200, Valentin Vidic wrote:
> > Switching to closed state earlier can cause the block-drbd
> > script to fail with 'Device is held open by someone':
> >=20
> > root: /etc/xen/scripts/block-drbd: remove XENBUS_PATH=3Dbackend/vbd/6=
/51712
> > kernel: [ 2222.278235] block drbd6: State change failed: Device is he=
ld open by someone
> > kernel: [ 2222.278304] block drbd6:   state =3D { cs:Connected ro:Pri=
mary/Secondary ds:UpToDate/UpToDate r----- }
> > kernel: [ 2222.278340] block drbd6:  wanted =3D { cs:Connected ro:Sec=
ondary/Secondary ds:UpToDate/UpToDate r----- }
> > root: /etc/xen/scripts/block-drbd: Writing backend/vbd/6/51712/hotplu=
g-error /etc/xen/scripts/block-drbd failed; error detected. backend/vbd/6=
/51712/hotplug-status error to xenstore.
> > root: /etc/xen/scripts/block-drbd: /etc/xen/scripts/block-drbd failed=
; error detected.
> >=20
> > Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/block/xen-blkback/xenbus.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-b=
lkback/xenbus.c
> > index a4bc74e72c39..43bddc996709 100644
> > --- a/drivers/block/xen-blkback/xenbus.c
> > +++ b/drivers/block/xen-blkback/xenbus.c
> > @@ -323,6 +323,7 @@ static void xen_blkif_free(struct xen_blkif *blki=
f)
> >  {
> >  	WARN_ON(xen_blkif_disconnect(blkif));
> >  	xen_vbd_free(&blkif->vbd);
> > +	xenbus_switch_state(blkif->be->dev, XenbusStateClosed);
> >  	kfree(blkif->be->mode);
> >  	kfree(blkif->be);
> > =20
> > @@ -814,7 +815,6 @@ static void frontend_changed(struct xenbus_device=
 *dev,
> > =20
> >  	case XenbusStateClosed:
> >  		xen_blkif_disconnect(be->blkif);
> > -		xenbus_switch_state(dev, XenbusStateClosed);
> >  		if (xenbus_dev_is_online(dev))
> >  			break;
>=20
> AFAICT, this will cause the backend to never switch to 'Closed' state
> until the toolstack sets online to 0, which is not good IMO.
>=20
> If for example a frontend decides to close a device, the backend will
> stay in state 'Closing' until the toolstack actually removes the disk
> by setting online to 0.
>=20
> This will prevent resetting blk connections, as blkback will refuse to
> switch to state XenbusStateInitWait unless it's at XenbusStateClosed
> (see the XenbusStateInitialising case in frontend_changed), which will
> never be reached with your patch.

Ok, is it possible to test this somehow?

> Maybe the easiest solution would be to wait in the block-drbd script
> until the device is released? Maybe using fstat in a loop or one of
> the drbd tools?

That is an option, but I don't know if it is possible to check device
release like that.  Including drbd-user in CC, maybe they have some
idea how to solve this.

--=20
Valentin
