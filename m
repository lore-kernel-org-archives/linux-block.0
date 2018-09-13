Return-Path: <prvs=787f1cd73=roger.pau@citrix.com>
Date: Thu, 13 Sep 2018 17:08:00 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Valentin Vidic <Valentin.Vidic@CARNet.hr>
CC: <drbd-user@lists.linbit.com>, Jens Axboe <axboe@kernel.dk>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>
Subject: Re: [DRBD-user] [PATCH] xen-blkback: Switch to closed state after
 releasing the backing device
Message-ID: <20180913150800.haswzd7t2xccbgvl@mac.bytemobile.com>
References: <20180907120337.GB11834@soda.linbit>
 <20180907121348.GM26705@gavran.carpriv.carnet.hr>
 <20180907132828.GC11834@soda.linbit>
 <20180907164500.GN26705@gavran.carpriv.carnet.hr>
 <20180907171459.GO26705@gavran.carpriv.carnet.hr>
 <20180908073432.GP26705@gavran.carpriv.carnet.hr>
 <20180910124531.GA31737@soda.linbit>
 <20180910132252.GE26705@gavran.carpriv.carnet.hr>
 <20180910150058.suxehc3uheyho4qx@mac.bytemobile.com>
 <20180910161831.GG26705@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20180910161831.GG26705@gavran.carpriv.carnet.hr>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 10, 2018 at 06:18:31PM +0200, Valentin Vidic wrote:
> On Mon, Sep 10, 2018 at 05:00:58PM +0200, Roger Pau Monn� wrote:
> > I can try to take a look at this and attempt to make sure the state is
> > only changed to closed in blkback _after_ the device has been
> > released, but it might take me a couple of days to get you a patch.
> 
> Thanks, I have two test nodes now where I can try different approaches.
> 
> > I'm afraid that other hotplug scripts will also have issues with such
> > behavior, and we shouldn't force all users of hotplug scripts to add
> > such workarounds.
> 
> True, iSCSI and other "network" disks might have similar problems.

So I have the following patch which I think might solve your issues
while keeping the reset logic working. Would you mind giving it a try
with your use case and pvgrub?

Thanks, Roger.
---8<---
>From c6a76a6265f29440c886b422c9d1b8549ffd6ed8 Mon Sep 17 00:00:00 2001
From: Roger Pau Monne <roger.pau@citrix.com>
Date: Thu, 13 Sep 2018 11:27:57 +0200
Subject: [PATCH] xen-blkback: only set Closed state when resources have been
 released
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Don't set the backend to Closed state until all the resources have
been released and the blkback instance is gone. Setting the backend
state to Closed will be done by xenbus_dev_remove after removing the
device instance.

Note that this requires disconnecting and allowing reconnection with
state Closing, since the Closed state will only be reached when
detaching the device.

Reported-by: Valentin Vidic <Valentin.Vidic@carnet.hr>
Signed-off-by: Roger Pau Monn� <roger.pau@citrix.com>
---
 drivers/block/xen-blkback/xenbus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index a4bc74e72c39..b0629f1b0511 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -770,7 +770,8 @@ static void frontend_changed(struct xenbus_device *dev,
 
 	switch (frontend_state) {
 	case XenbusStateInitialising:
-		if (dev->state == XenbusStateClosed) {
+		if (dev->state == XenbusStateClosed ||
+		    dev->state == XenbusStateClosing) {
 			pr_info("%s: prepare for reconnect\n", dev->nodename);
 			xenbus_switch_state(dev, XenbusStateInitWait);
 		}
@@ -809,12 +810,12 @@ static void frontend_changed(struct xenbus_device *dev,
 		break;
 
 	case XenbusStateClosing:
+		xen_blkif_disconnect(be->blkif);
 		xenbus_switch_state(dev, XenbusStateClosing);
 		break;
 
 	case XenbusStateClosed:
 		xen_blkif_disconnect(be->blkif);
-		xenbus_switch_state(dev, XenbusStateClosed);
 		if (xenbus_dev_is_online(dev))
 			break;
 		/* fall through */
-- 
2.18.0
