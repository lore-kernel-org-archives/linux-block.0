Return-Path: <prvs=7880d46e1=roger.pau@citrix.com>
Date: Fri, 14 Sep 2018 18:18:41 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Valentin Vidic <Valentin.Vidic@CARNet.hr>
CC: <drbd-user@lists.linbit.com>, Jens Axboe <axboe@kernel.dk>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>
Subject: Re: [DRBD-user] [PATCH] xen-blkback: Switch to closed state after
 releasing the backing device
Message-ID: <20180914161841.zqenjczqgfkycdmm@mac.bytemobile.com>
References: <20180907132828.GC11834@soda.linbit>
 <20180907164500.GN26705@gavran.carpriv.carnet.hr>
 <20180907171459.GO26705@gavran.carpriv.carnet.hr>
 <20180908073432.GP26705@gavran.carpriv.carnet.hr>
 <20180910124531.GA31737@soda.linbit>
 <20180910132252.GE26705@gavran.carpriv.carnet.hr>
 <20180910150058.suxehc3uheyho4qx@mac.bytemobile.com>
 <20180910161831.GG26705@gavran.carpriv.carnet.hr>
 <20180913150800.haswzd7t2xccbgvl@mac.bytemobile.com>
 <20180914114951.GH2153@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20180914114951.GH2153@gavran.carpriv.carnet.hr>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 14, 2018 at 01:49:51PM +0200, Valentin Vidic wrote:
> On Thu, Sep 13, 2018 at 05:08:00PM +0200, Roger Pau Monn� wrote:
> > So I have the following patch which I think might solve your issues
> > while keeping the reset logic working. Would you mind giving it a try
> > with your use case and pvgrub?
> 
> Thanks for the patch.  It seems to be having some problems with pvgrub:
> machines don't boot past pvgrub and they are using 100% CPU.  Also in
> dom0 xenstored is usind 100% CPU - strace reports it is looping in this:
> 
> read(26, "\\\240\0\0", 4)               = 4
> read(26, "\0\0\0\0L\0\0\0)\0\0\0\35\0\0\0+\\\232`\231\31\1&", 24) = 24
> read(26, "/local/domain/0/backend/vbd/1/51712/state", 41) = 41
> read(26, "\2\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\1\0\0\0004", 29) = 29
> read(26, "\0\330\0\0", 4)               = 4
> read(26, "\0\0\0\0L\0\0\0)\0\0\0\35\0\0\0+\\JG\231\31\1&", 24) = 24
> read(26, "/local/domain/0/backend/vbd/2/51712/state", 41) = 41
> read(26, "\2\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\2\0\0\0\1\0\0\0004", 29) = 29
> read(26, "\0\200\1\0", 4)               = 4
> read(26, "\0\0\0\0L\0\0\0)\0\0\0\35\0\0\0+\\Z\373\231\31\1&", 24) = 24
> read(26, "/local/domain/0/backend/vbd/5/51712/state", 41) = 41
> read(26, "\2\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\5\0\0\0\1\0\0\0004", 29) = 29
> read(12, "\321\1\0\0", 4)               = 4
> write(12, "\321\1\0\0", 4)              = 4

I see the issue, blkfront in pvgrub is waiting for the backend to
switch to Closed state before booting the OS kernel, so my fix is not
going to work. I guess I will have to find a proper way to switch to
Closed state.

Thanks, Roger.
