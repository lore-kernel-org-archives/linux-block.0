Return-Path: <Valentin.Vidic@carnet.hr>
Date: Sat, 8 Sep 2018 09:34:32 +0200
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: drbd-user@lists.linbit.com
Cc: Jens Axboe <axboe@kernel.dk>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Message-ID: <20180908073432.GP26705@gavran.carpriv.carnet.hr>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905162756.GA26705@gavran.carpriv.carnet.hr>
 <20180907120337.GB11834@soda.linbit>
 <20180907121348.GM26705@gavran.carpriv.carnet.hr>
 <20180907132828.GC11834@soda.linbit>
 <20180907164500.GN26705@gavran.carpriv.carnet.hr>
 <20180907171459.GO26705@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180907171459.GO26705@gavran.carpriv.carnet.hr>
Subject: Re: [DRBD-user] [PATCH] xen-blkback: Switch to closed state after
 releasing the backing device
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 07, 2018 at 07:14:59PM +0200, Valentin Vidic wrote:
> In fact the first one is the original code path before I modified
> blkback.  The problem is it gets executed async from workqueue so
> it might not always run before the call to drbdadm secondary.

As the DRBD device gets released only when the last IO request
has finished, I found a way to check and wait for this in the
block-drbd script:

--- block-drbd.orig     2018-09-08 09:07:23.499648515 +0200
+++ block-drbd  2018-09-08 09:28:12.892193649 +0200
@@ -230,6 +230,24 @@
 and so cannot be mounted ${m2}${when}."
 }
 
+wait_for_inflight()
+{
+  local dev="$1"
+  local inflight="/sys/block/${dev#/dev/}/inflight"
+  local rd wr
+
+  if ! [ -f "$inflight" ]; then
+    return
+  fi
+
+  while true; do
+    read rd wr < $inflight
+    if [ "$rd" = "0" -a "$wr" = "0" ]; then
+      return
+    fi
+    sleep 1
+  done
+}
 
 t=$(xenstore_read_default "$XENBUS_PATH/type" 'MISSING')
 
@@ -285,6 +303,8 @@
         drbd_lrole="${drbd_role%%/*}"
         drbd_dev="$(drbdadm sh-dev $drbd_resource)"
 
+        wait_for_inflight $drbd_dev
+
         if [ "$drbd_lrole" != 'Secondary' ]; then
           drbdadm secondary $drbd_resource
         fi

-- 
Valentin
