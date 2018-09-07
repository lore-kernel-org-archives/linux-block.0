Return-Path: <lars.ellenberg@linbit.com>
Return-Path: <lars.ellenberg@linbit.com>
Date: Fri, 7 Sep 2018 15:28:28 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Valentin Vidic <Valentin.Vidic@CARNet.hr>
Cc: drbd-user@lists.linbit.com, Jens Axboe <axboe@kernel.dk>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [DRBD-user] [PATCH] xen-blkback: Switch to closed state after
 releasing the backing device
Message-ID: <20180907132828.GC11834@soda.linbit>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905162756.GA26705@gavran.carpriv.carnet.hr>
 <20180907120337.GB11834@soda.linbit>
 <20180907121348.GM26705@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180907121348.GM26705@gavran.carpriv.carnet.hr>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 07, 2018 at 02:13:48PM +0200, Valentin Vidic wrote:
> On Fri, Sep 07, 2018 at 02:03:37PM +0200, Lars Ellenberg wrote:
> > Very frequently it is *NOT* the "original user", that "still" holds it
> > open, but udev, or something triggered-by-udev.
> > 
> > So double-checking the udev rules,
> > or the "lvm global_filter" settings may help.
> > You could instrument DRBD to log current->{pid,comm} on open and close,
> > so you can better detect who the "someone" is in the message above.
> 
> Don't think there is anything else holding the device open, because it
> is possible to change state to Secondary a few seconds later. But I will
> try to print those values in case anything interesting comes up.
> 
> > Adding a small retry loop in the script may help as well.
> 
> Yes, that is an option, but it would still leave those nasty "State
> change failed" messages in the log. I guess there is no way to check
> the value of DRBD device->open_cnt from userspace?

We don't expose that, no.
But even if we did, that would not be racefree :-)

The last (or even: any?) "close" of a block device that used to be open
for WRITE triggeres a udev "change" event, thus a udev run,
and the minimal action will be some read-only open and ioctl from
(systemd-)udev itself, more likely there also will be blkid and possibly
pvscan and similar actions. All of them should be read-only openers,
and all of them should be "short".
But they will race with the drbd demotion.

You can watch that happen with
# udevadm monitor &
then open and close for write:
# : > /dev/sda
(or any other block device ...)

To excercise the drbd vs udev race,
(you can leave the udevadm monitor running if you want):
## clear dmesg
# dmesg -c > /dev/null
## promote
# drbdadm primary s0 ;
## open/close for write
# : > /dev/drbd0 ;
## the close has triggered a udev run,
## which will now race with demotion,
## which will "sometimes" fail:
# drbdadm secondary s0 ;
## wait a bit, and retry
# sleep 1; drbdadm secondary s0 ; dmesg

### --- example output on some test box right now: ----------------
@root@ava:~# udevadm monitor &
...
monitor will print the received events for:
UDEV - the event which udev sends out after rule processing
KERNEL - the kernel uevent
...
@root@ava:~# dmesg -c > /dev/null; drbdadm primary s0 ; : > /dev/drbd0 ; drbdadm secondary s0  ; sleep 1; drbdadm secondary s0 ; dmesg
KERNEL[609638.990320] change   /devices/virtual/block/drbd0 (block)
KERNEL[609638.991364] change   /devices/virtual/block/drbd0 (block)
UDEV  [609639.008879] change   /devices/virtual/block/drbd0 (block)
0: State change failed: (-12) Device is held open by someone
Command 'drbdsetup-84 secondary 0' terminated with exit code 11
UDEV  [609639.011652] change   /devices/virtual/block/drbd0 (block)
KERNEL[609640.017356] change   /devices/virtual/block/drbd0 (block)
KERNEL[609640.018074] change   /devices/virtual/block/drbd0 (block)
[609613.882751] block drbd0: role( Secondary -> Primary )
[609613.889998] block drbd0: State change failed: Device is held open by someone
[609613.894280] block drbd0:   state = { cs:WFConnection ro:Primary/Unknown ds:UpToDate/Outdated r----- }
[609613.897609] block drbd0:  wanted = { cs:WFConnection ro:Secondary/Unknown ds:UpToDate/Outdated r----- }
[609614.909537] block drbd0: role( Primary -> Secondary )
[609614.909662] block drbd0: 0 KB (0 bits) marked out-of-sync by on disk bit-map.
UDEV  [609640.024588] change   /devices/virtual/block/drbd0 (block)
UDEV  [609640.028731] change   /devices/virtual/block/drbd0 (block)
@root@ava:~#
### --------------------------------------------------------------

Obviously change s0 and drbd0 appropriately; to exactly hit the time
window where udev has it open may be tricky, and on a busy system even
the sleep 1 can be not enough (so even the second invocation may fail
still), on an idle system udev may already be done, or may not even have
started yet when the first "secondary" runs.

Your best bet is to review your udev rules,
and make sure "drbd*" will not be looked at
by blkid or pvscan or similar.

See also: https://github.com/systemd/systemd/commit/fee854ee8ccde
respectively https://github.com/systemd/systemd/issues/9371
to get rid even of the unconditional open by systemd-udevd itself.

Note,
I'm not saying blkback has no issue; I don't know.
I'm just pointing out that there are other things
that may cause the same effects.

    Lars
