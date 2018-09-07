Return-Path: <lars.ellenberg@linbit.com>
Return-Path: <lars.ellenberg@linbit.com>
Date: Fri, 7 Sep 2018 14:03:37 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Valentin Vidic <Valentin.Vidic@CARNet.hr>
Cc: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Jens Axboe <axboe@kernel.dk>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
	drbd-user@lists.linbit.com
Subject: Re: [DRBD-user] [PATCH] xen-blkback: Switch to closed state after
 releasing the backing device
Message-ID: <20180907120337.GB11834@soda.linbit>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905162756.GA26705@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180905162756.GA26705@gavran.carpriv.carnet.hr>
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

Very frequently it is *NOT* the "original user", that "still" holds it
open, but udev, or something triggered-by-udev.

So double-checking the udev rules,
or the "lvm global_filter" settings may help.
You could instrument DRBD to log current->{pid,comm} on open and close,
so you can better detect who the "someone" is in the message above.

Adding a small retry loop in the script may help as well.

As a side note, 
with DRBD 9 (which still moves too fast to be "in tree")
we have the "auto-promote" feature, where no explicit promotion/demotion
is necessary anymore, but DRBD (tries to) promote itself with the
first "RW" opener, and demote itself once the last opener is gone.


Hth,
    Lars
