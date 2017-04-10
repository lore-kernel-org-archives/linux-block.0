Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:20944 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbdDJS4J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2017 14:56:09 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "mb@lightnvm.io" <mb@lightnvm.io>,
        "jg@lightnvm.io" <jg@lightnvm.io>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "javier@cnexlabs.com" <javier@cnexlabs.com>
Subject: Re: [PATCH 1/3] lightnvm: convert sprintf into snprintf
Date: Mon, 10 Apr 2017 18:56:06 +0000
Message-ID: <1491850565.4199.19.camel@sandisk.com>
References: <1491850297-18235-1-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1491850297-18235-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2017-04-10 at 20:51 +0200, Javier Gonz=E1lez wrote:
> Convert sprintf calls to snprintf in order to make possible buffer
> overflow more obvious.
>=20
> Signed-off-by: Javier Gonz=E1lez <javier@cnexlabs.com>
> ---
>  drivers/lightnvm/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index c3340ef..bdbb333 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -272,7 +272,8 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct=
 nvm_ioctl_create *create)
>  		goto err_disk;
>  	blk_queue_make_request(tqueue, tt->make_rq);
> =20
> -	sprintf(tdisk->disk_name, "%s", create->tgtname);
> +	snprintf(tdisk->disk_name, sizeof(tdisk->disk_name), "%s",
> +							create->tgtname);
>  	tdisk->flags =3D GENHD_FL_EXT_DEVT;
>  	tdisk->major =3D 0;
>  	tdisk->first_minor =3D 0;
> @@ -1195,13 +1196,13 @@ static long nvm_ioctl_get_devices(struct file *fi=
le, void __user *arg)
>  	list_for_each_entry(dev, &nvm_devices, devices) {
>  		struct nvm_ioctl_device_info *info =3D &devices->info[i];
> =20
> -		sprintf(info->devname, "%s", dev->name);
> +		snprintf(info->devname, sizeof(info->devname), "%s", dev->name);
> =20
>  		/* kept for compatibility */
>  		info->bmversion[0] =3D 1;
>  		info->bmversion[1] =3D 0;
>  		info->bmversion[2] =3D 0;
> -		sprintf(info->bmname, "%s", "gennvm");
> +		snprintf(info->bmname, sizeof(info->bmname), "%s", "gennvm");
>  		i++;
> =20
>  		if (i > 31) {

Hello Javier,

Although the above changes look fine to me, have you considered to use strl=
cpy()
instead of snprintf() for these string copy operations?

Bart.=
