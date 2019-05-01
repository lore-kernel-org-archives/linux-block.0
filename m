Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDD1C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 06:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D0121743
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 06:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="r6jPw2Ig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfEAGXJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 02:23:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36625 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEAGXI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 02:23:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id a8so12169981edx.3
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2019 23:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=/Vida3LwMyb7XhXeIsx5zFir1PNJpHMaI2wUSw/qLh8=;
        b=r6jPw2IgvqWYqMjTXF+UGixcTfdKYwJi046G0AXOZLPyJp5282QQNGBNj918Zv0ww/
         +gCl5WqMWgS4DvHCMJmPYoHEcAZOWTSdx6ajCmNHW74YEWbTf3dODfnR9fogpBiemg4O
         X679uybbtNnW/YsUxykWhF8NRAL51srscoflLW2OIYjp2kSWM+HqDb0BsiK/5bdzb2gt
         AnoXJkmrcrD1R0PvsA9VBhkKJvkmbdIiptFtJRrlOmV7FsA3mzethF2vTAhJqCe/wujT
         AlftZ4stkjf1+qxoLD29xW5d85gzY3Y2IEbkN93a/LspSxaM/fU6NR67hZV59pz20J3r
         gK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=/Vida3LwMyb7XhXeIsx5zFir1PNJpHMaI2wUSw/qLh8=;
        b=ghk4r2517gqP5iIdgaa/TYCTAYNOsBrpVXqUKp8a8/ePU+49dB9OaA1b3Uhvt00vhA
         hswmF+9HwYVgNz6a8k7vcFxQdD2KIoD92k+/75ALjd4+lP+DW/Akza6Fp8b9VbRo1tRR
         04MxeL982dc0rbqzNIolvGIVaI6f5Gy9AsWPULP5BQcbtJkP8D6F0Acg3bMDJgwbUUbr
         B+3NGJKhQVfwboeD6+34UE/QhKeNd+nj3p1E9uZJ72JPYbhLW9AUVuFfEYnyTDFxXfDx
         JfqiBla1pt5WcZBcgzmasTM/tuayIewZf5Ehf0eFhTK31lH3UA+o72FvEVqrBzlejphp
         vveg==
X-Gm-Message-State: APjAAAV/uo4uCsR4u5XRCvbDRwh/EdUD16YkuxSkSr+OcHo9mxfsOYfY
        6lahBW7oQpNmKNg8DXygA00arQan5/Ev20c4
X-Google-Smtp-Source: APXvYqyklRsI9dskkk7SXb+wlToKQmOfSeHoRtwsG0cdkTrfm4GOOY+7xFdreDZuUs5/3Lbci9F7QQ==
X-Received: by 2002:a50:b662:: with SMTP id c31mr11598642ede.252.1556691786267;
        Tue, 30 Apr 2019 23:23:06 -0700 (PDT)
Received: from [192.168.1.143] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id i20sm1776815ejj.57.2019.04.30.23.23.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 23:23:05 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <D123FD19-795D-4B59-AAB6-C94E2CC33DAE@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_9B0D39AB-8F29-486F-8F43-E42155F08890";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [RFC PATCH 13/18] drivers: set bio iopriority field
Date:   Wed, 1 May 2019 08:23:04 +0200
In-Reply-To: <20190501042831.5313-14-chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
 <20190501042831.5313-14-chaitanya.kulkarni@wdc.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_9B0D39AB-8F29-486F-8F43-E42155F08890
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 1 May 2019, at 06.28, Chaitanya Kulkarni =
<Chaitanya.Kulkarni@wdc.com> wrote:
>=20
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
> drivers/block/drbd/drbd_actlog.c    | 2 ++
> drivers/block/drbd/drbd_bitmap.c    | 3 +++
> drivers/block/xen-blkback/blkback.c | 3 +++
> drivers/block/zram/zram_drv.c       | 2 ++
> drivers/lightnvm/pblk-read.c        | 2 ++
> drivers/lightnvm/pblk-write.c       | 1 +
> drivers/md/bcache/journal.c         | 2 ++
> drivers/md/bcache/super.c           | 2 ++
> drivers/md/dm-bufio.c               | 2 ++
> drivers/md/dm-cache-target.c        | 1 +
> drivers/md/dm-io.c                  | 2 ++
> drivers/md/dm-log-writes.c          | 5 +++++
> drivers/md/dm-thin.c                | 1 +
> drivers/md/dm-writecache.c          | 2 ++
> drivers/md/dm-zoned-metadata.c      | 4 ++++
> drivers/md/md.c                     | 4 ++++
> drivers/md/raid5-cache.c            | 4 ++++
> drivers/md/raid5-ppl.c              | 3 +++
> drivers/nvme/target/io-cmd-bdev.c   | 7 +++++++
> drivers/staging/erofs/internal.h    | 3 +++
> drivers/target/target_core_iblock.c | 3 +++
> 21 files changed, 58 insertions(+)
>=20
> diff --git a/drivers/block/drbd/drbd_actlog.c =
b/drivers/block/drbd/drbd_actlog.c
> index 5f0eaee8c8a7..67235633c172 100644
> --- a/drivers/block/drbd/drbd_actlog.c
> +++ b/drivers/block/drbd/drbd_actlog.c
> @@ -27,6 +27,7 @@
> #include <linux/crc32c.h>
> #include <linux/drbd.h>
> #include <linux/drbd_limits.h>
> +#include <linux/ioprio.h>
> #include "drbd_int.h"
>=20
>=20
> @@ -159,6 +160,7 @@ static int _drbd_md_sync_page_io(struct =
drbd_device *device,
> 	bio->bi_private =3D device;
> 	bio->bi_end_io =3D drbd_md_endio;
> 	bio_set_op_attrs(bio, op, op_flags);
> +	bio_set_prio(bio, get_current_ioprio());
>=20
> 	if (op !=3D REQ_OP_WRITE && device->state.disk =3D=3D D_DISKLESS =
&& device->ldev =3D=3D NULL)
> 		/* special case, drbd_md_read() during =
drbd_adm_attach(): no get_ldev */
> diff --git a/drivers/block/drbd/drbd_bitmap.c =
b/drivers/block/drbd/drbd_bitmap.c
> index 11a85b740327..e7cb027488c7 100644
> --- a/drivers/block/drbd/drbd_bitmap.c
> +++ b/drivers/block/drbd/drbd_bitmap.c
> @@ -30,6 +30,7 @@
> #include <linux/drbd.h>
> #include <linux/slab.h>
> #include <linux/highmem.h>
> +#include <linux/ioprio.h>
>=20
> #include "drbd_int.h"
>=20
> @@ -1028,6 +1029,8 @@ static void bm_page_io_async(struct =
drbd_bm_aio_ctx *ctx, int page_nr) __must_ho
> 	bio->bi_private =3D ctx;
> 	bio->bi_end_io =3D drbd_bm_endio;
> 	bio_set_op_attrs(bio, op, 0);
> +	bio_set_prio(bio, get_current_ioprio());
> +
>=20
> 	if (drbd_insert_fault(device, (op =3D=3D REQ_OP_WRITE) ? =
DRBD_FAULT_MD_WR : DRBD_FAULT_MD_RD)) {
> 		bio_io_error(bio);
> diff --git a/drivers/block/xen-blkback/blkback.c =
b/drivers/block/xen-blkback/blkback.c
> index fd1e19f1a49f..41294944267d 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -42,6 +42,7 @@
> #include <linux/delay.h>
> #include <linux/freezer.h>
> #include <linux/bitmap.h>
> +#include <linux/ioprio.h>
>=20
> #include <xen/events.h>
> #include <xen/page.h>
> @@ -1375,6 +1376,7 @@ static int dispatch_rw_block_io(struct =
xen_blkif_ring *ring,
> 			bio->bi_end_io  =3D end_block_io_op;
> 			bio->bi_iter.bi_sector  =3D preq.sector_number;
> 			bio_set_op_attrs(bio, operation, =
operation_flags);
> +			bio_set_prio(bio, get_current_ioprio());
> 		}
>=20
> 		preq.sector_number +=3D seg[i].nsec;
> @@ -1393,6 +1395,7 @@ static int dispatch_rw_block_io(struct =
xen_blkif_ring *ring,
> 		bio->bi_private =3D pending_req;
> 		bio->bi_end_io  =3D end_block_io_op;
> 		bio_set_op_attrs(bio, operation, operation_flags);
> +		bio_set_prio(bio, get_current_ioprio());
> 	}
>=20
> 	atomic_set(&pending_req->pendcnt, nbio);
> diff --git a/drivers/block/zram/zram_drv.c =
b/drivers/block/zram/zram_drv.c
> index 399cad7daae7..1a4e3b0e98ad 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -33,6 +33,7 @@
> #include <linux/sysfs.h>
> #include <linux/debugfs.h>
> #include <linux/cpuhotplug.h>
> +#include <linux/ioprio.h>
>=20
> #include "zram_drv.h"
>=20
> @@ -596,6 +597,7 @@ static int read_from_bdev_async(struct zram *zram, =
struct bio_vec *bvec,
>=20
> 	bio->bi_iter.bi_sector =3D entry * (PAGE_SIZE >> 9);
> 	bio_set_dev(bio, zram->bdev);
> +	bio_set_prio(bio, get_current_ioprio());
> 	if (!bio_add_page(bio, bvec->bv_page, bvec->bv_len, =
bvec->bv_offset)) {
> 		bio_put(bio);
> 		return -EIO;
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index 0b7d5fb4548d..2b866744545e 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -16,6 +16,7 @@
>  * pblk-read.c - pblk's read path
>  */
>=20
> +#include <linux/ioprio.h>
> #include "pblk.h"
>=20
> /*
> @@ -336,6 +337,7 @@ static int pblk_setup_partial_read(struct pblk =
*pblk, struct nvm_rq *rqd,
>=20
> 	new_bio->bi_iter.bi_sector =3D 0; /* internal bio */
> 	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
> +	bio_set_prio(bio, get_current_ioprio());
>=20
> 	rqd->bio =3D new_bio;
> 	rqd->nr_ppas =3D nr_holes;
> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
> index 6593deab52da..3fdbbff40fde 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -628,6 +628,7 @@ static int pblk_submit_write(struct pblk *pblk, =
int *secs_left)
>=20
> 	bio->bi_iter.bi_sector =3D 0; /* internal bio */
> 	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> +	bio_set_prio(bio, get_current_ioprio());
>=20
> 	rqd =3D pblk_alloc_rqd(pblk, PBLK_WRITE);
> 	rqd->bio =3D bio;
>=20

pblk bits look god to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_9B0D39AB-8F29-486F-8F43-E42155F08890
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlzJO0gACgkQPEYBfS0l
eOCCjRAAxfZJCm8rjvJ7d0I8BLlaXo8a/4pJ5JVUCgw27xlwfhpYG9SE4A6zmeFr
cEDmwn41kzOPLVsDNPaoptD6zoTn7OqAplKX2FQpld8uqSJ4IikLNRBLSgMdhUdm
oVXYAVnh8jsLlAUSDWDSmi+jHywM+DTuM5FONLYjig2MOo0X8WHCHU05vMsFnYno
gSMu9xsdYoIiWFdtJ9K4BtZikf7b+SeTaRqobmzLOWaEDWwlbydVeCCQnNxBVTWa
OZYAoQIj/LFY2JzkGf/s14hgJJ1dvL6fiBABE1Gax70kq70YZXu+xNH1g3VEMe35
daUEY3we3mH6/nYnOZtPUt2PCHjuysfcEP7oQbfZzH6WhboBm6IIh/o+0YCop3TD
Qr4Ds9XZp+DOS/Ox1YzmzCiV7/L2mWTWs3lZ8mzDtGeJ5uMhAxgdpAq3P2ce0iRP
6uCTc3UqPWX2CriIpu8WbW1Mslb9kh+KHHBA1xyqublk89Ug9rvORbnQVxZXIAJp
zKkFK/y/KGI52e0wRxJRq5sS0hYGkmOv7eD6sabs5LmlHpWjgJw9MMy/rMORO26E
9+YjdndbRExO8+5pIlrq8NvJOA7qIGemCaLL7BQpqGOON4yAnA01aHIOl3a7pMRA
UqKiWbXOafWSlqfTkndtE/kqlUcbMk4mjE/QOib304nR7C0d+Qg=
=5p57
-----END PGP SIGNATURE-----

--Apple-Mail=_9B0D39AB-8F29-486F-8F43-E42155F08890--
