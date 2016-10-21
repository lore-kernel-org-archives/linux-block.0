Return-Path: <shaun.tancheff@seagate.com>
MIME-Version: 1.0
In-Reply-To: <20161021154242.3707589-1-arnd@arndb.de>
References: <20161021154242.3707589-1-arnd@arndb.de>
From: Shaun Tancheff <shaun.tancheff@seagate.com>
Date: Fri, 21 Oct 2016 15:46:15 -0500
Message-ID: <CAJVOszBe_+0s7Jm2c6SG8yFMgN8cG0fFv-mgnguTCA_5sm0bxQ@mail.gmail.com>
Subject: Re: [PATCH] block: zoned: fix harmless maybe-uninitialized warning
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Axboe <axboe@kernel.dk>, Shaun Tancheff <shaun@tancheff.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@hgst.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 21, 2016 at 10:42 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The blkdev_report_zones produces a harmless warning when
> -Wmaybe-uninitialized is set, after gcc gets a little confused
> about the multiple 'goto' here:
>
> block/blk-zoned.c: In function 'blkdev_report_zones':
> block/blk-zoned.c:188:13: error: 'nz' may be used uninitialized in this f=
unction [-Werror=3Dmaybe-uninitialized]
>
> Moving the assignment to nr_zones makes this a little simpler
> while also avoiding the warning reliably. I'm removing the
> extraneous initialization of 'int ret' in the same patch, as
> that is semi-related and could cause an uninitialized use of
> that variable to not produce a warning.
>
> Fixes: 6a0cb1bc106f ("block: Implement support for zoned block devices")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  block/blk-zoned.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 667f95d86695..472211fa183a 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -80,7 +80,7 @@ int blkdev_report_zones(struct block_device *bdev,
>         unsigned int i, n, nz;
>         unsigned int ofst;
>         void *addr;
> -       int ret =3D 0;
> +       int ret;
>
>         if (!q)
>                 return -ENXIO;
> @@ -179,14 +179,12 @@ int blkdev_report_zones(struct block_device *bdev,
>
>         }
>
> +       *nr_zones =3D nz;
>  out:
>         bio_for_each_segment_all(bv, bio, i)
>                 __free_page(bv->bv_page);
>         bio_put(bio);
>
> -       if (ret =3D=3D 0)
> -               *nr_zones =3D nz;
> -
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(blkdev_report_zones);
> --
> 2.9.0

Reviewed-by: Shaun Tancheff <shaun.tancheff@seagate.com>

> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp=
-3A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDQIBAg&c=3DIGDlg0lD0b-nebmJJ=
0Kp8A&r=3DWg5NqlNlVTT7Ugl8V50qIHLe856QW0qfG3WVYGOrWzA&m=3DRyRS1pzTGdFENUb0P=
bQRSMAhvMgZx_dBftw2khYVIXU&s=3Dp9SYS2a__p_YHv8FoZVz9kuTQQ7LIZBVKCkZuQgR0cs&=
e=3D



--=20
Shaun Tancheff
