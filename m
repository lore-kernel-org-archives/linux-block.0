Return-Path: <lars.ellenberg@linbit.com>
Return-Path: <lars.ellenberg@linbit.com>
Date: Mon, 10 Sep 2018 14:45:31 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Valentin Vidic <Valentin.Vidic@CARNet.hr>
Cc: drbd-user@lists.linbit.com, Jens Axboe <axboe@kernel.dk>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [DRBD-user] [PATCH] xen-blkback: Switch to closed state after
 releasing the backing device
Message-ID: <20180910124531.GA31737@soda.linbit>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905162756.GA26705@gavran.carpriv.carnet.hr>
 <20180907120337.GB11834@soda.linbit>
 <20180907121348.GM26705@gavran.carpriv.carnet.hr>
 <20180907132828.GC11834@soda.linbit>
 <20180907164500.GN26705@gavran.carpriv.carnet.hr>
 <20180907171459.GO26705@gavran.carpriv.carnet.hr>
 <20180908073432.GP26705@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180908073432.GP26705@gavran.carpriv.carnet.hr>
List-ID: <linux-block@vger.kernel.org>

On Sat, Sep 08, 2018 at 09:34:32AM +0200, Valentin Vidic wrote:
> On Fri, Sep 07, 2018 at 07:14:59PM +0200, Valentin Vidic wrote:
> > In fact the first one is the original code path before I modified
> > blkback.  The problem is it gets executed async from workqueue so
> > it might not always run before the call to drbdadm secondary.
> 
> As the DRBD device gets released only when the last IO request
> has finished, I found a way to check and wait for this in the
> block-drbd script:

> --- block-drbd.orig     2018-09-08 09:07:23.499648515 +0200
> +++ block-drbd  2018-09-08 09:28:12.892193649 +0200
> @@ -230,6 +230,24 @@
>  and so cannot be mounted ${m2}${when}."
>  }
>  
> +wait_for_inflight()
> +{
> +  local dev="$1"
> +  local inflight="/sys/block/${dev#/dev/}/inflight"
> +  local rd wr
> +
> +  if ! [ -f "$inflight" ]; then
> +    return
> +  fi
> +
> +  while true; do
> +    read rd wr < $inflight
> +    if [ "$rd" = "0" -a "$wr" = "0" ]; then

If it is "idle" now, but still "open",
this will not sleep, and still fail the demotion below.

> +      return
> +    fi
> +    sleep 1
> +  done
> +}
>  
>  t=$(xenstore_read_default "$XENBUS_PATH/type" 'MISSING')
>  
> @@ -285,6 +303,8 @@
>          drbd_lrole="${drbd_role%%/*}"
>          drbd_dev="$(drbdadm sh-dev $drbd_resource)"
>  
> +        wait_for_inflight $drbd_dev
> +
>          if [ "$drbd_lrole" != 'Secondary' ]; then
>            drbdadm secondary $drbd_resource

You try to help it by "waiting forever until it appears to be idle".
I suggest to at least limit the retries by iteration or time.
And also (or, instead; but you'd potentially get a number of
"scary messages" in the logs) add something like:
	  for i in 1 2 3 5 7 x; do
            drbdadm secondary $drbd_resource && exit 0
            if [ $i = x ]; then
	      # ... "appears to still be in use, maybe by" ...
              fuser -v $drbd_dev
              exit 1
	    # else ... "will retry in $i seconds" ...
            fi
            sleep $i
	  done
...

Or, well, yes, fix blkback to not "defer" the final close "too long",
if at all possible.

    Lars
