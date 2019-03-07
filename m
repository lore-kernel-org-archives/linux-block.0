Return-Path: <SRS0=/o95=RK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC229C43381
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 12:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2F120675
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 12:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="WBqnlQC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfCGMUH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:20:07 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34324 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGMUH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Mar 2019 07:20:07 -0500
Received: by mail-ed1-f68.google.com with SMTP id a16so13289716edn.1
        for <linux-block@vger.kernel.org>; Thu, 07 Mar 2019 04:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc:message-id:references
         :to;
        bh=CQuNGyIyxSSVbTHcjpW5O7rAm6W+DagJKdg61CNr2UY=;
        b=WBqnlQC/h80oMk2uf8Zw3Fo5RlwXCPuCZkwlmJ9QjJJ/9LkIdkai3XxW4ZwEQBBgFc
         P69ChqmaZlNm4Rh2mJEgh31rTEMafUUoEko8a3bRyQzGhBOH703Weuho9S5Bdu670EBI
         LYShM/RB++pAbeh/GF5hf5ZjVPVSf6XYtO11V27lgZTb0xAfQz8a1iapeuuwfioep77K
         jth5tl28ssFhbhjOsteuT0iAo1Y2XUYon6rLz4Xs2DuXDToA8Jinmc/Fvzt9NXrE2HKi
         EiXnj1h1ARBlFHa/gX7z26oDwlaBRO9ZpWFXTWhzTHHZLHqzWAdLD5EZFqzohbppyGbY
         k7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :message-id:references:to;
        bh=CQuNGyIyxSSVbTHcjpW5O7rAm6W+DagJKdg61CNr2UY=;
        b=nySSZNbVlUwuImEbXsbKOpdCpIxiBT4bS1lKNDEJ/1nDnP73Bxpa9JCLbgEBG0W2rF
         UsI/wMOxvJv9nUa1JKv/mMjFIDqd1H/GEyB9yMLIDXSzEHvyoo5v3Tkp2S7JKf4Ptfid
         p4qKIfLdFUsBNZNlFjITaSXhH2uLiipXpnjd7ggvWhBY3vKdyC+/nGgm7mG1UT9Mib4z
         EVDs3U0UMkFw8TzHSnzqPHXp2Jpktqz8e/XwWZDekivrrqPLvt70wkgnJraYOf0rmbuc
         mkIHsXftf24myzWcWa8v4lw5eEI6j+w6/IaaNEthHtyRbHrUdDmvdD9/hWSSXwjykPkL
         FsIw==
X-Gm-Message-State: APjAAAXPwFq4Pf3Qx0n1lQQI0zQR3eZO0NJJRkJ+dPR/j2gbkLHWI9nS
        qTOYO+gI6ltmAv3H+lQWBO8DrQ==
X-Google-Smtp-Source: APXvYqxYtrmEFuvizbDYTFjva1C/bQHagl3ivb9M0T/5ATiB1eLSjW+jetI2CC7hmfrm79WGs2ZHuQ==
X-Received: by 2002:a50:b497:: with SMTP id w23mr28296564edd.84.1551961205256;
        Thu, 07 Mar 2019 04:20:05 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id q55sm1342581eda.19.2019.03.07.04.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 04:20:04 -0800 (PST)
Content-Type: multipart/signed;
        boundary="Apple-Mail=_0B2F614E-A456-4F05-BA49-8560D02200BF";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2] lightnvm: pblk: fix bio leak on large sized io
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
X-Priority: 3
In-Reply-To: <20190307072351epcms2p1966fd363dfb73cc7b34248b9c2269987@epcms2p1>
Date:   Thu, 7 Mar 2019 13:20:03 +0100
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-Id: <CB2701F7-17BA-4057-B1A7-6E2E0B9DEBEB@javigon.com>
References: <CGME20190307072351epcms2p1966fd363dfb73cc7b34248b9c2269987@epcms2p1>
 <20190307072351epcms2p1966fd363dfb73cc7b34248b9c2269987@epcms2p1>
To:     chansol.kim@samsung.com
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_0B2F614E-A456-4F05-BA49-8560D02200BF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 7 Mar 2019, at 08.23, Chansol Kim <chansol.kim@samsung.com> wrote:
>=20
> For large size io where blk_queue_split needs to be called inside
> pblk_rw_io, results in bio leak as bio_endio is not called on the
> newly allocated. One way to observe this is to mounting ext4
> filesystem on the target and issuing 1MB io with dd, e.g., dd bs=3D1MB
> if=3D/dev/null of=3D/mount/myvolume. kmemleak reports:
>=20
> unreferenced object 0xffff88803d7d0100 (size 256):
>  comm "kworker/u16:1", pid 68, jiffies 4294899333 (age 284.120s)
>  hex dump (first 32 bytes):
>    00 00 00 00 00 00 00 00 00 60 e8 31 81 88 ff ff  .........`.1....
>    01 40 00 00 06 06 00 00 00 00 00 00 05 00 00 00  .@..............
>  backtrace:
>    [<000000001f5aa04f>] kmem_cache_alloc+0x204/0x3c0
>    [<0000000040945aab>] mempool_alloc_slab+0x1d/0x30
>    [<00000000b4959ab4>] mempool_alloc+0x83/0x220
>    [<00000000646bad9b>] bio_alloc_bioset+0x229/0x320
>    [<000000009264b251>] bio_clone_fast+0x26/0xc0
>    [<0000000008250252>] bio_split+0x41/0x110
>    [<00000000e365cad0>] blk_queue_split+0x349/0x930
>    [<00000000eb5426bc>] pblk_make_rq+0x1b5/0x1f0
>    [<00000000eea09cec>] generic_make_request+0x2f9/0x690
>    [<00000000ae6acede>] submit_bio+0x12e/0x1f0
>    [<00000000f9b8b82a>] ext4_io_submit+0x64/0x80
>    [<000000009e4f817d>] ext4_bio_write_page+0x32e/0x890
>    [<00000000cbd0d106>] mpage_submit_page+0x65/0xc0
>    [<000000000eec7359>] mpage_map_and_submit_buffers+0x171/0x330
>    [<000000009a7afcb6>] ext4_writepages+0xd5e/0x1650
>    [<000000004476b096>] do_writepages+0x39/0xc0
>=20
> In case there is a need for a split, blk_queue_split returns the newly
> allocated bio to the caller by changing the value of pointer passed as
> a reference, while the original is passed to generic_make_requests.
>=20
> Although pblk_rw_io's local variable bio* has changed and passed to
> pblk_submit_read and pblk_write_to_cache, work is done on this new
> bio*, and pblk_rw_io returns NVM_IO_DONE, pblk_make_rq calls bio_endio
> on the old bio* because it passed bio pointer by value to pblk_rw_io.
>=20
> pblk_rw_io is unfolded into pblk_make_rq so that there is no copying
> of bio* and bio_endio is called on the correct bio*.
>=20
> Signed-off-by: Chansol Kim <chansol.kim@samsung.com>
> ---
> v2:
> - Instead of changing pblk_rw_io's parameter, unfolded it into =
pblk_make_rq
>=20
> drivers/lightnvm/pblk-init.c | 47 =
++++++++++++++++++--------------------------
> 1 file changed, 19 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 8b643d0..0c98305 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -47,36 +47,10 @@ static struct pblk_global_caches pblk_caches =3D {
>=20
> struct bio_set pblk_bio_set;
>=20
> -static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
> -			  struct bio *bio)
> -{
> -	int ret;
> -
> -	/* Read requests must be <=3D 256kb due to NVMe's 64 bit =
completion bitmap
> -	 * constraint. Writes can be of arbitrary size.
> -	 */
> -	if (bio_data_dir(bio) =3D=3D READ) {
> -		blk_queue_split(q, &bio);
> -		ret =3D pblk_submit_read(pblk, bio);
> -		if (ret =3D=3D NVM_IO_DONE && bio_flagged(bio, =
BIO_CLONED))
> -			bio_put(bio);
> -
> -		return ret;
> -	}
> -
> -	/* Prevent deadlock in the case of a modest LUN configuration =
and large
> -	 * user I/Os. Unless stalled, the rate limiter leaves at least =
256KB
> -	 * available for user I/O.
> -	 */
> -	if (pblk_get_secs(bio) > pblk_rl_max_io(&pblk->rl))
> -		blk_queue_split(q, &bio);
> -
> -	return pblk_write_to_cache(pblk, bio, PBLK_IOTYPE_USER);
> -}
> -
> static blk_qc_t pblk_make_rq(struct request_queue *q, struct bio *bio)
> {
> 	struct pblk *pblk =3D q->queuedata;
> +	int ret;
>=20
> 	if (bio_op(bio) =3D=3D REQ_OP_DISCARD) {
> 		pblk_discard(pblk, bio);
> @@ -86,7 +60,24 @@ static blk_qc_t pblk_make_rq(struct request_queue =
*q, struct bio *bio)
> 		}
> 	}
>=20
> -	switch (pblk_rw_io(q, pblk, bio)) {
> +	/* Read requests must be <=3D 256kb due to NVMe's 64 bit =
completion bitmap
> +	 * constraint. Writes can be of arbitrary size.
> +	 */
> +	if (bio_data_dir(bio) =3D=3D READ) {
> +		blk_queue_split(q, &bio);
> +		ret =3D pblk_submit_read(pblk, bio);
> +	} else {
> +		/* Prevent deadlock in the case of a modest LUN =
configuration
> +		 * and large user I/Os. Unless stalled, the rate limiter
> +		 * leaves at least 256KB available for user I/O.
> +		 */
> +		if (pblk_get_secs(bio) > pblk_rl_max_io(&pblk->rl))
> +			blk_queue_split(q, &bio);
> +
> +		ret =3D pblk_write_to_cache(pblk, bio, =
PBLK_IOTYPE_USER);
> +	}
> +
> +	switch (ret) {
> 	case NVM_IO_ERR:
> 		bio_io_error(bio);
> 		break;
> --
> 2.7.4

Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_0B2F614E-A456-4F05-BA49-8560D02200BF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyBDHMACgkQPEYBfS0l
eOBjYw//fI/0CYVbYNvk5VCzHrNNzCWpHqrRgI9amWFZ4K6Fg0CvFm5JgVeWnUj3
1jSC1Iu9aklYp+MH8YlLhn9QkU7w301fRKcxTVHRirqKVZ/jHSkmwOhKsXP2Dq4+
j229JnUppUmPMFR7Jf6gZxuHAthE6MSIguIsaua1/fX+97xKrz2C7upmKhsmT150
cYrqET8BLFph9cvPMnHQXU/WCQReQp3CWv55PDLk5MF+4PZRoWXB04fIIo1Cl/hJ
8YIR/lxqOnVmiDSzwVaZSecHq7qVS9rPe0poR4I3l1CSw3i104TnLXAEPi96Elkr
/frnZidQHO1bQdBc1Ecimejbpf0Cbh/Hfk7rBZlqdicJjrrCOI7wCluv2o3e7Z3Y
tuCLSlNrFM3fhz42h/SHYZUsrPSgSlvxaJP3NE1GcOc36kQlu1jHCJcTWCqPt8EZ
mpU9Z2b8+8oasWv5RLJ5fWFfyftT+2IIVlPZ/bySZAWNx1YHEB6CV69iwLd/Folw
tRSMSi4NzReH0WWmZ3BIe8Eczu2HUux1iGopSBeAWByYdc/CDuwzfHIg5be4djSe
oPnhfORdKkA3Fd1HN8q4FfN3X70bIfH5NvPG0F3ILi86u2n9ZlkooG1zC6g6hrDa
AUEVfLkvPoqAlwsx1EQe7s2Zub+DND/tAAPhxm+ySomb07CapvI=
=KgOU
-----END PGP SIGNATURE-----

--Apple-Mail=_0B2F614E-A456-4F05-BA49-8560D02200BF--
