Return-Path: <Valentin.Vidic@carnet.hr>
Date: Fri, 7 Sep 2018 14:13:48 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: drbd-user@lists.linbit.com
Cc: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Jens Axboe <axboe@kernel.dk>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-block@vger.kernel.org, xen-devel@lists.xenproject.org
Message-ID: <20180907121348.GM26705@gavran.carpriv.carnet.hr>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905162756.GA26705@gavran.carpriv.carnet.hr>
 <20180907120337.GB11834@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180907120337.GB11834@soda.linbit>
Subject: Re: [DRBD-user] [PATCH] xen-blkback: Switch to closed state after
 releasing the backing device
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 07, 2018 at 02:03:37PM +0200, Lars Ellenberg wrote:
> Very frequently it is *NOT* the "original user", that "still" holds it
> open, but udev, or something triggered-by-udev.
> 
> So double-checking the udev rules,
> or the "lvm global_filter" settings may help.
> You could instrument DRBD to log current->{pid,comm} on open and close,
> so you can better detect who the "someone" is in the message above.

Don't think there is anything else holding the device open, because it
is possible to change state to Secondary a few seconds later. But I will
try to print those values in case anything interesting comes up.

> Adding a small retry loop in the script may help as well.

Yes, that is an option, but it would still leave those nasty "State
change failed" messages in the log. I guess there is no way to check
the value of DRBD device->open_cnt from userspace?

-- 
Valentin
