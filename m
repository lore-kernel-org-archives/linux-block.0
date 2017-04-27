Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:57665 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031362AbdD0XVr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2017 19:21:47 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "hch@lst.de" <hch@lst.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH 3/6] mtip32xx: abstract out "are any commands active"
 helper
Date: Thu, 27 Apr 2017 23:21:41 +0000
Message-ID: <1493335300.2625.17.camel@sandisk.com>
References: <1493333494-600-1-git-send-email-axboe@fb.com>
         <1493333494-600-4-git-send-email-axboe@fb.com>
In-Reply-To: <1493333494-600-4-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-04-27 at 16:51 -0600, Jens Axboe wrote:
> This is a prep patch for backoff in ->queue_rq() for non-ncq commands.
>=20
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  drivers/block/mtip32xx/mtip32xx.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/m=
tip32xx.c
> index 36f3d34f2156..f0732cc92864 100644
> --- a/drivers/block/mtip32xx/mtip32xx.c
> +++ b/drivers/block/mtip32xx/mtip32xx.c
> @@ -1030,6 +1030,22 @@ static bool mtip_pause_ncq(struct mtip_port *port,
>  	return false;
>  }
> =20
> +static bool mtip_commands_active(struct mtip_port *port)
> +{
> +	unsigned int n;
> +	unsigned int active =3D 1;

Hello Jens,

Initializing 'active' doesn't harm but I don't think that is needed in this
function. Anyway:

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
