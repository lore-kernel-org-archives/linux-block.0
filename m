Return-Path: <Valentin.Vidic@carnet.hr>
Date: Fri, 7 Sep 2018 18:45:00 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: drbd-user@lists.linbit.com
Cc: Jens Axboe <axboe@kernel.dk>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Message-ID: <20180907164500.GN26705@gavran.carpriv.carnet.hr>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905162756.GA26705@gavran.carpriv.carnet.hr>
 <20180907120337.GB11834@soda.linbit>
 <20180907121348.GM26705@gavran.carpriv.carnet.hr>
 <20180907132828.GC11834@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180907132828.GC11834@soda.linbit>
Subject: Re: [DRBD-user] [PATCH] xen-blkback: Switch to closed state after
 releasing the backing device
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 07, 2018 at 03:28:28PM +0200, Lars Ellenberg wrote:
> We don't expose that, no.
> But even if we did, that would not be racefree :-)
> 
> The last (or even: any?) "close" of a block device that used to be open
> for WRITE triggeres a udev "change" event, thus a udev run,
> and the minimal action will be some read-only open and ioctl from
> (systemd-)udev itself, more likely there also will be blkid and possibly
> pvscan and similar actions. All of them should be read-only openers,
> and all of them should be "short".
> But they will race with the drbd demotion.

True, but did not find any strange interaction with udev during VM shutdown.

This is what udevadm monitor reports:

KERNEL[1174.220256] remove   /devices/vbd-10-51712 (xen-backend)
UDEV  [1174.222484] remove   /devices/vbd-10-51712 (xen-backend)
KERNEL[1174.224405] remove   /devices/console-10-0 (xen-backend)
UDEV  [1174.226964] remove   /devices/console-10-0 (xen-backend)
KERNEL[1174.287215] change   /devices/virtual/block/drbd0 (block)
KERNEL[1174.287267] change   /devices/virtual/block/drbd0 (block)
UDEV  [1174.295811] change   /devices/virtual/block/drbd0 (block)
UDEV  [1174.301983] change   /devices/virtual/block/drbd0 (block)

Strace on the udev daemon gives only these:

[pid  7416] execve("/sbin/drbdadm", ["/sbin/drbdadm", "sh-udev", "minor-0"], [/* 10 vars */]) = 0
[pid  7416] execve("/lib/drbd/drbdadm-84", ["drbdadm", "sh-udev", "minor-0"], [/* 12 vars */]) = 0
[pid  7418] execve("/sbin/drbdadm", ["/sbin/drbdadm", "sh-udev", "minor-0"], [/* 9 vars */]) = 0
[pid  7418] execve("/lib/drbd/drbdadm-84", ["drbdadm", "sh-udev", "minor-0"], [/* 11 vars */]) = 0

and this should be 65-drbd.rules to add/remove symlinks in /dev.

Adding a dump_stack in drbd_release gives two possible code paths,
both from xen_blkback and the first one from workqueue being the
problematic one:

[  530.698782] CPU: 0 PID: 4 Comm: kworker/0:0 Tainted: G           O    4.9.0-8-amd64 #1 Debian 4.9.110-3+deb9u4
[  530.698783] Hardware name: HP ProLiant BL460c Gen9, BIOS I36 09/12/2016
[  530.698784] Workqueue: events xen_blkif_deferred_free [xen_blkback]
[  530.698785]  0000000000000000 ffffffff81331e54 ffff883f82143800 ffff883f741b5660
[  530.698787]  ffffffffc03a309e ffff883f741b5580 ffffffff81245ca8 0000000281a186b5
[  530.698789]  000000008935f100 8412ffa31a64cc4c 000000000000020a ffff883fa6218280
[  530.698791] Call Trace:
[  530.698792]  [<ffffffff81331e54>] ? dump_stack+0x5c/0x78
[  530.698805]  [<ffffffffc03a309e>] ? drbd_release+0x1e/0x40 [drbd]
[  530.698810]  [<ffffffff81245ca8>] ? __blkdev_put+0x1e8/0x2a0
[  530.698813]  [<ffffffffc055d6b8>] ? xen_vbd_free.isra.9+0x48/0x60 [xen_blkback]
[  530.698814]  [<ffffffffc055d6f7>] ? xen_blkif_deferred_free+0x27/0x70 [xen_blkback]
[  530.698816]  [<ffffffff81092fea>] ? process_one_work+0x18a/0x420
[  530.698817]  [<ffffffff810932cd>] ? worker_thread+0x4d/0x490
[  530.698818]  [<ffffffff81093280>] ? process_one_work+0x420/0x420
[  530.698820]  [<ffffffff81099329>] ? kthread+0xd9/0xf0
[  530.698822]  [<ffffffff81099250>] ? kthread_park+0x60/0x60
[  530.698823]  [<ffffffff81615df7>] ? ret_from_fork+0x57/0x70

[ 1216.251924] CPU: 14 PID: 297 Comm: xenwatch Tainted: G           O    4.9.0-8-amd64 #1 Debian 4.9.110-3+deb9u4
[ 1216.251925] Hardware name: HP ProLiant BL460c Gen9, BIOS I36 09/12/2016
[ 1216.251926]  0000000000000000 ffffffff81331e54 ffff883f82143800 ffff883f741b5660
[ 1216.251928]  ffffffffc03a309e ffff883f741b5580 ffffffff81245ca8 0000000281a186b5
[ 1216.251930]  ffffffffc0562360 97e48f39d448f082 000000000000020a 0000000000000006
[ 1216.251933] Call Trace:
[ 1216.251935]  [<ffffffff81331e54>] ? dump_stack+0x5c/0x78
[ 1216.251947]  [<ffffffffc03a309e>] ? drbd_release+0x1e/0x40 [drbd]
[ 1216.251951]  [<ffffffff81245ca8>] ? __blkdev_put+0x1e8/0x2a0
[ 1216.251954]  [<ffffffff81414910>] ? register_xenbus_watch+0xe0/0xe0
[ 1216.251956]  [<ffffffffc055d6b8>] ? xen_vbd_free.isra.9+0x48/0x60 [xen_blkback]
[ 1216.251959]  [<ffffffffc055e9fe>] ? frontend_changed+0x9e/0x660 [xen_blkback]
[ 1216.251961]  [<ffffffff814120d9>] ? xenbus_read_driver_state+0x39/0x60
[ 1216.251962]  [<ffffffff8141542c>] ? xenbus_otherend_changed+0x8c/0x120
[ 1216.251964]  [<ffffffff81414910>] ? register_xenbus_watch+0xe0/0xe0
[ 1216.251967]  [<ffffffff81414995>] ? xenwatch_thread+0x85/0x120
[ 1216.251969]  [<ffffffff810bbfb0>] ? prepare_to_wait_event+0xf0/0xf0
[ 1216.251971]  [<ffffffff81099329>] ? kthread+0xd9/0xf0
[ 1216.251973]  [<ffffffff81099250>] ? kthread_park+0x60/0x60
[ 1216.251975]  [<ffffffff81615df7>] ? ret_from_fork+0x57/0x70

-- 
Valentin
