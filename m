Return-Path: <Valentin.Vidic@carnet.hr>
Date: Fri, 7 Sep 2018 12:20:26 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, drbd-user@lists.linbit.com
Message-ID: <20180907102026.GH26705@gavran.carpriv.carnet.hr>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905113515.GU26705@gavran.carpriv.carnet.hr>
 <20180905162801.GB26705@gavran.carpriv.carnet.hr>
 <20180906162932.7qge5dmrgyqbmbbj@mac.bytemobile.com>
 <20180906221929.GZ26705@gavran.carpriv.carnet.hr>
 <20180907071530.te5dxdvg4zqgqscj@mac.bytemobile.com>
 <20180907072319.GA26705@gavran.carpriv.carnet.hr>
 <20180907075455.szxahgevvlmfjvwy@mac.bytemobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180907075455.szxahgevvlmfjvwy@mac.bytemobile.com>
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 07, 2018 at 09:54:55AM +0200, Roger Pau Monn� wrote:
> Then I'm afraid you will have to look into the vbd_free/create fix.

Yes, here is a first draft for that idea, let me know if you see some
problems there:

--- xenbus.c.orig       2018-09-07 12:11:57.798071485 +0200
+++ xenbus.c    2018-09-07 12:14:23.536077992 +0200
@@ -758,6 +759,7 @@
                             enum xenbus_state frontend_state)
 {
        struct backend_info *be = dev_get_drvdata(&dev->dev);
+       struct block_device *bdev;
        int err;
 
        pr_debug("%s %p %s\n", __func__, dev, xenbus_strstate(frontend_state));
@@ -772,6 +774,22 @@
 
        case XenbusStateInitialised:
        case XenbusStateConnected:
+               if (!be->blkif->vbd.bdev) {
+                       printk("blkdev_get");
+                       bdev = blkdev_get_by_dev(be->blkif->vbd.pdevice,
+                                                be->blkif->vbd.readonly ?
+                                                FMODE_READ : FMODE_WRITE, NULL);
+
+                       if (IS_ERR(bdev)) {
+                               pr_warn("frontend_changed: device %08x could not be opened\n",
+                                       be->blkif->vbd.pdevice);
+                               break;
+                       }
+
+                       printk("blkdev_get good");
+                       be->blkif->vbd.bdev = bdev;
+               }
+
                /*
                 * Ensure we connect even when two watches fire in
                 * close succession and we miss the intermediate value
@@ -808,6 +826,7 @@
 
        case XenbusStateClosed:
                xen_blkif_disconnect(be->blkif);
+               xen_vbd_free(&be->blkif->vbd);
                xenbus_switch_state(dev, XenbusStateClosed);
                if (xenbus_dev_is_online(dev))
                        break;

-- 
Valentin
