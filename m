Return-Path: <Valentin.Vidic@carnet.hr>
Date: Mon, 10 Sep 2018 18:18:31 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: drbd-user@lists.linbit.com, Jens Axboe <axboe@kernel.dk>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-block@vger.kernel.org, xen-devel@lists.xenproject.org
Message-ID: <20180910161831.GG26705@gavran.carpriv.carnet.hr>
References: <20180905162756.GA26705@gavran.carpriv.carnet.hr>
 <20180907120337.GB11834@soda.linbit>
 <20180907121348.GM26705@gavran.carpriv.carnet.hr>
 <20180907132828.GC11834@soda.linbit>
 <20180907164500.GN26705@gavran.carpriv.carnet.hr>
 <20180907171459.GO26705@gavran.carpriv.carnet.hr>
 <20180908073432.GP26705@gavran.carpriv.carnet.hr>
 <20180910124531.GA31737@soda.linbit>
 <20180910132252.GE26705@gavran.carpriv.carnet.hr>
 <20180910150058.suxehc3uheyho4qx@mac.bytemobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180910150058.suxehc3uheyho4qx@mac.bytemobile.com>
Subject: Re: [DRBD-user] [PATCH] xen-blkback: Switch to closed state after
 releasing the backing device
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 10, 2018 at 05:00:58PM +0200, Roger Pau Monn� wrote:
> I can try to take a look at this and attempt to make sure the state is
> only changed to closed in blkback _after_ the device has been
> released, but it might take me a couple of days to get you a patch.

Thanks, I have two test nodes now where I can try different approaches.

> I'm afraid that other hotplug scripts will also have issues with such
> behavior, and we shouldn't force all users of hotplug scripts to add
> such workarounds.

True, iSCSI and other "network" disks might have similar problems.

-- 
Valentin
