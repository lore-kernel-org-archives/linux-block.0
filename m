Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD6EC282D4
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 06:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881382077B
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 06:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="HX/eR27L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfA3G6h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 01:58:37 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40989 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfA3G6g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 01:58:36 -0500
Received: by mail-ed1-f68.google.com with SMTP id a20so18083606edc.8
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 22:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc:message-id:references
         :to;
        bh=k6NNgqElM9/DaHABwmEkBcN4u6cJ99+4hahoB4TWcm0=;
        b=HX/eR27LFfOChB1lRjn6ho5mqBVa2z+fQ93qsuzDADG3jhx0sHrdJ/jIfqJZTQoMrV
         LrHawyHfvwhz4o3ToLrgcTZ5z4bNyaysGxGU3Keik2AdEytTzWRxHQPoxj0nsM6SBi+7
         7PrkHX4Xu2Y5l+LU3YsXnoFdljXa5bfbFk4NyWah3sd87ivEE/z11Us+l1BrV0hs9Uxv
         05zaxG4mQkQfBk3aOACP14GOGpe6jqBGy4JELPtWj97X8/efmF80CU416z+7rEjftrjW
         11sc+uCd7P8QxCGztoAuJYcv+f8DfEeZU2XeeHbsOrtbeufBf3Hg2okDDHTS2bv4a9Lx
         v7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :message-id:references:to;
        bh=k6NNgqElM9/DaHABwmEkBcN4u6cJ99+4hahoB4TWcm0=;
        b=P6lcbuYwxsH2izumlnZQOqiv0BDJxB/+7huXPRzCNtwkWddsNsdmUTcHrrc/1ldU/u
         jMOrgwXn58AOxsIF+eG6EMBUAc2QNLeRCOVf20KWChj47kRAAkT7J2C9T6Mj6i9OsLLs
         A9gwp3iEKLM4RzRkyyeQN0Kw7L/LAzg2QtpM6ncpG+nq9oOzh49yIHyI2eiubY8BOPGH
         mx08VqVWbqcDY0cV4FAaE2/VtFv4oM5WTYCMi46jUy24zjSLfKNi3/ZiiUeBPc1JUrRI
         ybbICjiFmptIWSKPjrGPCgL8aK8reVVzhVei9xwIeQiKb0hNU7iRdTmDqJY832UJ2+3/
         KiUg==
X-Gm-Message-State: AJcUukd4n+6js7zneBajr9InRHlt7LFujS9uEKGiyEjfAbGTTc7SXVNO
        GwHyFmogyNlL+LnX7yorumImPkDOs/pgSw==
X-Google-Smtp-Source: ALg8bN7+W09VpglwLaRPAPDIRrcVzOQiIPDO786W7My9UDgOIoyQ7QT7C5RL9XcTfH1NwMz7RTHv3Q==
X-Received: by 2002:a50:a726:: with SMTP id h35mr28742921edc.192.1548831514283;
        Tue, 29 Jan 2019 22:58:34 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id by5-v6sm169037ejb.7.2019.01.29.22.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 22:58:33 -0800 (PST)
Content-Type: multipart/signed;
        boundary="Apple-Mail=_B7078D6E-B0F1-4B78-8DCF-2345F282E0A3";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] lightnvm: pblk: fix bio leak on large sized io
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
X-Priority: 3
In-Reply-To: <20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
Date:   Wed, 30 Jan 2019 07:58:32 +0100
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Matias Bjorling <matias.bjorling@wdc.com>
Message-Id: <73383E80-2096-4323-AB45-F007B060E93A@javigon.com>
References: <CGME20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
 <20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
To:     chansol.kim@samsung.com
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_B7078D6E-B0F1-4B78-8DCF-2345F282E0A3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 30 Jan 2019, at 02.53, =EA=B9=80=EC=B0=AC=EC=86=94 =
<chansol.kim@samsung.com> wrote:
>=20
>=20
> Changes:
> 1. Function pblk_rw_io to get bio* as a reference
> 2. In pblk_rw_io bio_put call on read case removed
>=20
> A fix to address issue where
> 1. pblk_make_rq calls pblk_rw_io passes bio* pointer as a value (0xA)
> 2. pblk_rw_io calls blk_queue_split passing bio* pointer as reference
> 3. In blk_queue_split, when there is a split, the original bio* (0xA)
>    is passed to generic_make_requests, and the newly allocated bio is
>    returned
> 4. If NVM_IO_DONE returned, pblk_make_rq calls bio_endio on the bio*,
>    that is not the one returned by blk_queue_split
> 5. As a result bio_endio is not called on the newly allocated bio.
>=20
> Signed-off-by: chansol.kim <chansol.kim@samsung.com>
> ---
> drivers/lightnvm/pblk-init.c | 22 ++++++++--------------
> 1 file changed, 8 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index b57f764d..4efc929 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -31,30 +31,24 @@ static DECLARE_RWSEM(pblk_lock);
> struct bio_set pblk_bio_set;
>=20
> static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
> -			  struct bio *bio)
> +			  struct bio **bio)
> {
> -	int ret;
> -
> 	/* Read requests must be <=3D 256kb due to NVMe's 64 bit =
completion bitmap
> 	 * constraint. Writes can be of arbitrary size.
> 	 */
> -	if (bio_data_dir(bio) =3D=3D READ) {
> -		blk_queue_split(q, &bio);
> -		ret =3D pblk_submit_read(pblk, bio);
> -		if (ret =3D=3D NVM_IO_DONE && bio_flagged(bio, =
BIO_CLONED))
> -			bio_put(bio);
> -
> -		return ret;
> +	if (bio_data_dir(*bio) =3D=3D READ) {
> +		blk_queue_split(q, bio);
> +		return pblk_submit_read(pblk, *bio);
> 	}
>=20
> 	/* Prevent deadlock in the case of a modest LUN configuration =
and large
> 	 * user I/Os. Unless stalled, the rate limiter leaves at least =
256KB
> 	 * available for user I/O.
> 	 */
> -	if (pblk_get_secs(bio) > pblk_rl_max_io(&pblk->rl))
> -		blk_queue_split(q, &bio);
> +	if (pblk_get_secs(*bio) > pblk_rl_max_io(&pblk->rl))
> +		blk_queue_split(q, bio);
>=20
> -	return pblk_write_to_cache(pblk, bio, PBLK_IOTYPE_USER);
> +	return pblk_write_to_cache(pblk, *bio, PBLK_IOTYPE_USER);
> }
>=20
> static blk_qc_t pblk_make_rq(struct request_queue *q, struct bio *bio)
> @@ -69,7 +63,7 @@ static blk_qc_t pblk_make_rq(struct request_queue =
*q, struct bio *bio)
> 		}
> 	}
>=20
> -	switch (pblk_rw_io(q, pblk, bio)) {
> +	switch (pblk_rw_io(q, pblk, &bio)) {
> 	case NVM_IO_ERR:
> 		bio_io_error(bio);
> 		break;
> --
> 2.7.4

Thanks for the fix Chansol.

Matias: I see that checkpatch complains about the signed-ff, but it
seems to be due to the name mismatch english / korean - not sure if
there is a good fix for this.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_B7078D6E-B0F1-4B78-8DCF-2345F282E0A3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxRSxgACgkQPEYBfS0l
eOBNuA//fLZiS0ENATfcdNG90HZFuF2ghFFFSE7hSZ7deDQZ+fxcUgx7cI8yFDyp
GcfCcgSu6Tj+w2Ifmf5VTg7cqjrOiIwhY3up5yvWj9t9sJc3HUtfbPzTlv6/1y3d
A5wVoUKy5KrkaxARDtxuhozTDZ/qmfGLIYl8XzTd9EjjNtWTFczBZHANF/vbQHg3
NrnO6+2QT7Q5lUu3TKlJggYvTa53r3iEVThPvuKQDrPsxkfVJuk6KVmAvDxzg3ja
M/XQVi8CCvLuLn7L3jOA057YhZMnRsWq8WAHjHBAb8XW18NHTthlsY/kxdWED3a5
hWJZJb5Es5JnPIv2wJT+AF88Uk1cJGT1NMRw0wlTUbT6EAf30blWPWa1GMWUtnmQ
7O6tKCvLLjI7RgeKKxPYT/s1+Q0Nd9smzyMP+l1QvlHlYNJm9TAI10574VrPZ7tz
kxkFbarT1GkuKA/e6ZYMELrDSxDPgxSbISkARtXkErAu6cCxTDrw+6B5ktJHmFZB
LgEq73f3RuZL1oROuLLlbnTUUntnJjTVBP5UQb12nrNSXpvxjt5N5qUG4YJFxtSV
wHpNi4xubL6VG/J1Lwsgl5vGSKZ8NajKrP4IqiGXLxdZx1X0BPahd74v3Z9J/EYa
tlNx0TnoYmq53lupCJPlrj+hU/pMhEWTdlaLhBDABGR+uhKX8oo=
=Y9J5
-----END PGP SIGNATURE-----

--Apple-Mail=_B7078D6E-B0F1-4B78-8DCF-2345F282E0A3--
