Return-Path: <Valentin.Vidic@carnet.hr>
Date: Fri, 7 Sep 2018 13:15:19 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, drbd-user@lists.linbit.com
Message-ID: <20180907111519.GJ26705@gavran.carpriv.carnet.hr>
References: <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905113515.GU26705@gavran.carpriv.carnet.hr>
 <20180905162801.GB26705@gavran.carpriv.carnet.hr>
 <20180906162932.7qge5dmrgyqbmbbj@mac.bytemobile.com>
 <20180906221929.GZ26705@gavran.carpriv.carnet.hr>
 <20180907071530.te5dxdvg4zqgqscj@mac.bytemobile.com>
 <20180907072319.GA26705@gavran.carpriv.carnet.hr>
 <20180907075455.szxahgevvlmfjvwy@mac.bytemobile.com>
 <20180907102026.GH26705@gavran.carpriv.carnet.hr>
 <20180907104309.z4jsga5hcnphwxu7@mac.bytemobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180907104309.z4jsga5hcnphwxu7@mac.bytemobile.com>
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 07, 2018 at 12:43:09PM +0200, Roger Pau Monn� wrote:
> I would prefer if you could avoid open-coding this here, and instead
> use xen_vbd_create or similar. I would also prefer that the call to
> xen_vbd_create in backend_changed was removed and we had a single call
> to xen_vbd_create that's used for both initial device connection and
> reconnection.
> 
> Also, I think this could cause issues if for some reason the frontend
> switches to state 'Connected' before hotplug scripts have run, in
> which case you would try to open an unexpected device because pdevice
> won't be correctly set.

Sure, this is just to test if the idea would work and needs a lot of
cleanup. Unfortunately it does not seem to help with the original
problem because this case is not executed on VM shutdown:

        case XenbusStateClosed:
                xen_blkif_disconnect(be->blkif);
                xen_vbd_free(&be->blkif->vbd);
                xenbus_switch_state(dev, XenbusStateClosed);

Instead xen_vbd_free gets run from a different code path after the
remove script has already failed:

[  337.407634] block drbd0: State change failed: Device is held open by someone
[  337.407673] block drbd0:   state = { cs:Connected ro:Primary/Secondary ds:UpToDate/UpToDate r----- }
[  337.407713] block drbd0:  wanted = { cs:Connected ro:Secondary/Secondary ds:UpToDate/UpToDate r----- }
...
[  340.109459] Workqueue: events xen_blkif_deferred_free [xen_blkback]
[  340.109461]  0000000000000000 ffffffff81331e54 ffff883f84d19d38 ffff883f84d19d32
[  340.109463]  ffffffffc058169e ffff883f84d19d88 ffff883f84d19d20 ffffffffc05816f7
[  340.109465]  ffff883f84d19d88 ffff883f87b5a900 ffffffff81092fea 0000000088ec3080
[  340.109467] Call Trace:
[  340.109471]  [<ffffffff81331e54>] ? dump_stack+0x5c/0x78
[  340.109473]  [<ffffffffc058169e>] ? xen_vbd_free.isra.9+0x2e/0x60 [xen_blkback]
[  340.109475]  [<ffffffffc05816f7>] ? xen_blkif_deferred_free+0x27/0x70 [xen_blkback]
[  340.109477]  [<ffffffff81092fea>] ? process_one_work+0x18a/0x420
[  340.109479]  [<ffffffff810932cd>] ? worker_thread+0x4d/0x490
[  340.109480]  [<ffffffff81093280>] ? process_one_work+0x420/0x420
[  340.109482]  [<ffffffff81099329>] ? kthread+0xd9/0xf0
[  340.109484]  [<ffffffff81099250>] ? kthread_park+0x60/0x60
[  340.109486]  [<ffffffff81615df7>] ? ret_from_fork+0x57/0x70

-- 
Valentin
