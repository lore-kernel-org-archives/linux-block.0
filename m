Return-Path: <Valentin.Vidic@carnet.hr>
Date: Wed, 5 Sep 2018 18:28:01 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, drbd-user@lists.linbit.com
Message-ID: <20180905162801.GB26705@gavran.carpriv.carnet.hr>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905113515.GU26705@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180905113515.GU26705@gavran.carpriv.carnet.hr>
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 05, 2018 at 01:35:15PM +0200, Valentin Vidic wrote:
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

Would it be possible to call xen_vbd_free before the state change?

        case XenbusStateClosed:
                xen_blkif_disconnect(be->blkif);
                xen_vbd_free(&be->blkif->vbd);
                xenbus_switch_state(dev, XenbusStateClosed);

-- 
Valentin
