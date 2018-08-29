Return-Path: <jgross@suse.com>
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
To: Valentin Vidic <Valentin.Vidic@CARNet.hr>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
From: Juergen Gross <jgross@suse.com>
Message-ID: <1701ccef-3ebb-973b-de32-059a8816d31c@suse.com>
Date: Wed, 29 Aug 2018 10:16:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 29/08/18 08:52, Valentin Vidic wrote:
> Switching to closed state earlier can cause the block-drbd
> script to fail with 'Device is held open by someone':
> 
> root: /etc/xen/scripts/block-drbd: remove XENBUS_PATH=backend/vbd/6/51712
> kernel: [ 2222.278235] block drbd6: State change failed: Device is held open by someone
> kernel: [ 2222.278304] block drbd6:   state = { cs:Connected ro:Primary/Secondary ds:UpToDate/UpToDate r----- }
> kernel: [ 2222.278340] block drbd6:  wanted = { cs:Connected ro:Secondary/Secondary ds:UpToDate/UpToDate r----- }
> root: /etc/xen/scripts/block-drbd: Writing backend/vbd/6/51712/hotplug-error /etc/xen/scripts/block-drbd failed; error detected. backend/vbd/6/51712/hotplug-status error to xenstore.
> root: /etc/xen/scripts/block-drbd: /etc/xen/scripts/block-drbd failed; error detected.
> 
> Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
> Cc: stable@vger.kernel.org
> ---
>  drivers/block/xen-blkback/xenbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index a4bc74e72c39..43bddc996709 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -323,6 +323,7 @@ static void xen_blkif_free(struct xen_blkif *blkif)
>  {
>  	WARN_ON(xen_blkif_disconnect(blkif));
>  	xen_vbd_free(&blkif->vbd);
> +	xenbus_switch_state(blkif->be->dev, XenbusStateClosed);
>  	kfree(blkif->be->mode);
>  	kfree(blkif->be);
>  
> @@ -814,7 +815,6 @@ static void frontend_changed(struct xenbus_device *dev,
>  
>  	case XenbusStateClosed:
>  		xen_blkif_disconnect(be->blkif);
> -		xenbus_switch_state(dev, XenbusStateClosed);
>  		if (xenbus_dev_is_online(dev))
>  			break;
>  		/* fall through */

Did you test whether it is okay to not change state in case the device
is still online?


Juergen
