Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04A1C3A5A1
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 01:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753C82173E
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 01:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbfHWBEW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 21:04:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:33546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730401AbfHWBEW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 21:04:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96BE2AEF3;
        Fri, 23 Aug 2019 01:04:20 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jianchao Wang <jianchao.wan9@gmail.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org
Date:   Fri, 23 Aug 2019 11:04:13 +1000
Subject: Re: Issues about the merge_bvec_fn callback in 3.10 series
In-Reply-To: <e93566fe-febf-5e99-d3e9-96a0c1f6ba13@gmail.com>
References: <S1732749AbfE3EBS/20190530040119Z+834@vger.kernel.org> <e93566fe-febf-5e99-d3e9-96a0c1f6ba13@gmail.com>
Message-ID: <878srkheuq.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21 2019, Jianchao Wang wrote:

> Hi dear all
>
> This is a question in older kernel versions.
>
> We are using 3.10 series kernel in our production. And we encountered iss=
ue as below,
>
> When add a page into a bio, .merge_bvec_fn will be invoked down to the bo=
ttom,
> and the bio->bi_rw would be saved into bvec_merge_data.bi_rw as the follo=
wing code,
>
> __bio_add_page
> ---
> 	if (q->merge_bvec_fn) {
> 		struct  bvm =3D {
> 			.bi_bdev =3D bio->bi_bdev,
> 			.bi_sector =3D bio->bi_iter.bi_sector,
> 			.bi_size =3D bio->bi_iter.bi_size,
> 			.bi_rw =3D bio->bi_rw,
> 		};
>
> 		/*
> 		 * merge_bvec_fn() returns number of bytes it can accept
> 		 * at this offset
> 		 */
> 		if (q->merge_bvec_fn(q, &bvm, bvec) < bvec->bv_len) {
> 			bvec->bv_page =3D NULL;
> 			bvec->bv_len =3D 0;
> 			bvec->bv_offset =3D 0;
> 			return 0;
> 		}
> 	}
> ---
>
> However, it seems that the bio->bi_rw has not been set at the moment (set=
 by submit_bio),=20
> so it is always zero.

Yeah, that's a problem.

>
> We have a raid5 and the raid5_mergeable_bvec would always handle the writ=
e as read and then
> we always get a write bio with a stripe chunk size which is not expected =
and would degrade the
> performance. This is code,
>
> raid5_mergeable_bvec
> ---
> 	if ((bvm->bi_rw & 1) =3D=3D WRITE)
> 		return biovec->bv_len; /* always allow writes to be mergeable */
>
> 	if (mddev->new_chunk_sectors < mddev->chunk_sectors)
> 		chunk_sectors =3D mddev->new_chunk_sectors;
> 	max =3D  (chunk_sectors - ((sector & (chunk_sectors - 1)) + bio_sectors)=
) << 9;
> 	if (max < 0) max =3D 0;
> 	if (max <=3D biovec->bv_len && bio_sectors =3D=3D 0)
> 		return biovec->bv_len;
> 	else
> 		return max;
>
> ---
>
> I have checked=20=20=20
> v3.10.108
> v3.18.140
> v4.1.49
> but there seems not fix for it.
>
> And maybe it would be fixed until=20
> 8ae126660fddbeebb9251a174e6fa45b6ad8f932
> block: kill merge_bvec_fn() completely
>
> Would anyone please give some suggestion on this ?

One option would be to make sure that ->bi_rw is set before
bio_add_page is called.
There are about 80 calls, so that isn't trivial, but you might not care
about several of them.

You could backport the 'kill merge_bvec_fn' patch if you like, but I
wouldn't.  The change of introducing a bug is much higher.

NeilBrown


> Any comment will be welcomed.
>
> Thanks in advance
> Jianchao

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl1fO40ACgkQOeye3VZi
gbnPuhAAw9AVIrNm82y9sI3q39S4Oka6YICVerF4ZtVvGUMUS7BtwVF1IY9md7gr
7++hb36y9njAviHpOxiL6kg2FH0J7tS8iWyi+ia9v1+hqT6MzdrBqqlsE7V/rdts
MnYZEOkQrrmZuqSUPzp29BlIcngQyiXKWdTek6rhr5XGM/WNaPGiemWD3Rc99Ukk
z3EYj1oo+60CNPYnNHUji1nXCMz2eZ4jN3spHIQdc2w7+vOA3QqwY/rLLvVgyVob
92zTE9B+XPktjajKA9yrIXbtWB4+peABQ+FDxiRmzoE3gRH4sQsRE9+rEatMhoFr
lE2rp2xWhVdrkkGyNAqfKYUSOKgMorE6zod+MSWw7okH5XzMcqDtGmIC9Bt+seAe
RdFvKkDHDFUiSrEmFzSpVSHqUEwze8x7LHLOhV8xczXeLZuKayl2yXHYqOuceXTC
/Spqlr70QK7+WXXjCuHXS8a1Mh9fD/EdhoqMh11Uot+sYkMVKYFVZNuyVDteKTiX
pqz6tNSmNydFME0lXakvLFydONBhFRsntNsGrwFkBhqrb0CBHBIMfv5i2ubouGhN
Bn6spG65dJkA2TZ1wsQ9Yg4hAxlCfkZA6S1O+08RQvIUk40VJPk/HmyQyy6LsZet
a98tkJTYhTx+dL2DHMR3EJXiw9wJ5DwyuyXLQXmiddgW4oYFFVE=
=RCE3
-----END PGP SIGNATURE-----
--=-=-=--
