Return-Path: <Valentin.Vidic@carnet.hr>
Date: Fri, 7 Sep 2018 19:14:59 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: drbd-user@lists.linbit.com
Cc: Jens Axboe <axboe@kernel.dk>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Message-ID: <20180907171459.GO26705@gavran.carpriv.carnet.hr>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905162756.GA26705@gavran.carpriv.carnet.hr>
 <20180907120337.GB11834@soda.linbit>
 <20180907121348.GM26705@gavran.carpriv.carnet.hr>
 <20180907132828.GC11834@soda.linbit>
 <20180907164500.GN26705@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180907164500.GN26705@gavran.carpriv.carnet.hr>
Subject: Re: [DRBD-user] [PATCH] xen-blkback: Switch to closed state after
 releasing the backing device
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 07, 2018 at 06:45:00PM +0200, Valentin Vidic wrote:
> Adding a dump_stack in drbd_release gives two possible code paths,
> both from xen_blkback and the first one from workqueue being the
> problematic one:

In fact the first one is the original code path before I modified
blkback.  The problem is it gets executed async from workqueue so
it might not always run before the call to drbdadm secondary.

> [  530.698782] CPU: 0 PID: 4 Comm: kworker/0:0 Tainted: G           O    4.9.0-8-amd64 #1 Debian 4.9.110-3+deb9u4
> [  530.698783] Hardware name: HP ProLiant BL460c Gen9, BIOS I36 09/12/2016
> [  530.698784] Workqueue: events xen_blkif_deferred_free [xen_blkback]
> [  530.698785]  0000000000000000 ffffffff81331e54 ffff883f82143800 ffff883f741b5660
> [  530.698787]  ffffffffc03a309e ffff883f741b5580 ffffffff81245ca8 0000000281a186b5
> [  530.698789]  000000008935f100 8412ffa31a64cc4c 000000000000020a ffff883fa6218280
> [  530.698791] Call Trace:
> [  530.698792]  [<ffffffff81331e54>] ? dump_stack+0x5c/0x78
> [  530.698805]  [<ffffffffc03a309e>] ? drbd_release+0x1e/0x40 [drbd]
> [  530.698810]  [<ffffffff81245ca8>] ? __blkdev_put+0x1e8/0x2a0
> [  530.698813]  [<ffffffffc055d6b8>] ? xen_vbd_free.isra.9+0x48/0x60 [xen_blkback]
> [  530.698814]  [<ffffffffc055d6f7>] ? xen_blkif_deferred_free+0x27/0x70 [xen_blkback]
> [  530.698816]  [<ffffffff81092fea>] ? process_one_work+0x18a/0x420
> [  530.698817]  [<ffffffff810932cd>] ? worker_thread+0x4d/0x490
> [  530.698818]  [<ffffffff81093280>] ? process_one_work+0x420/0x420
> [  530.698820]  [<ffffffff81099329>] ? kthread+0xd9/0xf0
> [  530.698822]  [<ffffffff81099250>] ? kthread_park+0x60/0x60
> [  530.698823]  [<ffffffff81615df7>] ? ret_from_fork+0x57/0x70

-- 
Valentin
