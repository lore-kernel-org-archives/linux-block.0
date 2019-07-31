Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF497C433FF
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 17:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B316206A2
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 17:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Gm0DNahb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfGaRNU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:13:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46590 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfGaRNU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 13:13:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so66433208edr.13
        for <linux-block@vger.kernel.org>; Wed, 31 Jul 2019 10:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=f1LF3yb4DZ7OR897ZGLAel5hvQn+h9DZaHtHoF52s7U=;
        b=Gm0DNahbdzmxTjb6RPdo8UA5Qe2qrTf0rvxt5t7sud1MKQnztfM2FEhX1kh+2hucRs
         pxY7Z6HR7rnXXYfCUaeEjI4m583IjMjYpZu8TzCGhT80vv7G6GBg4mJCYIVIsaHyOJc7
         D2HNqHynhlXiS3kLSg6BPCjjmSoYz6JZrNgVATnEB+1RZSECXDcapTw3s/fQfdVAZVml
         MEjOaHsdyjlb30goi6Z2/uQ2x1arQHVcfqxOfxpLKZX1D16EVlG3Qf2HTVZfDC2EIp6H
         0E4gjixEiCze8baRPdPaheKeU9M5tgehQAyx93gP132xV88yxJ8Zvs5mT2vZtN0syRMS
         547A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=f1LF3yb4DZ7OR897ZGLAel5hvQn+h9DZaHtHoF52s7U=;
        b=AN4OM0tRT2ZEeabInFjIOjysp4OOIohUrwUE3oBL/agMvS/tnnnpmqhnJrsOEtRPTc
         2JvYtFZQqH1etQ6mVsM16Z6lsMPai2GKBRTqHgtXF7oaungayVMFuF8PABy4/NrOk88l
         mSFf6i4nQDugBNYuZpuDy/v3qvRbFAA16cn7I43dRiunUayVv4sHG7LNjAwojjTDC5q7
         VEJtKatCDs8TCB1F/4H1PO+q1TpXTyrN4Dn2rhYV/i7F/8Y8nSzOo5btfYQusFxLY4Cn
         7zBUCe8LE6GcDhyzOERFJJOYI4+bdgJV5ebEzASHuKmMGrjgdGXEblmmhJmypoymAk2R
         BQRQ==
X-Gm-Message-State: APjAAAVreHzHFjgOkbooOOlV1FI/oR8GaPlnEH6NwGxs2e47zAzkqey4
        3sPWh6vEZgcdf5RIMo/OI+jsO9P5
X-Google-Smtp-Source: APXvYqxYX4Jgwcn5jKDKS1R3hovfm+uGF81JcTlllqIrn/pRLr2iPcDoZYhxFP1N3pz5IGZWXmbtvw==
X-Received: by 2002:a17:906:bcd6:: with SMTP id lw22mr96345683ejb.68.1564593199104;
        Wed, 31 Jul 2019 10:13:19 -0700 (PDT)
Received: from [192.168.1.177] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id a18sm9699868ejp.2.2019.07.31.10.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 10:13:17 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <C081CC43-4FBD-43DD-B494-9AFF545F79D8@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_216A0ED2-C55E-4922-AD94-CE22385C5ADA";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 4/4] block: stop exporting bio_map_kern
Date:   Wed, 31 Jul 2019 19:13:17 +0200
In-Reply-To: <1564566096-28756-5-git-send-email-hans@owltronix.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Hans Holmberg <hans@owltronix.com>
References: <1564566096-28756-1-git-send-email-hans@owltronix.com>
 <1564566096-28756-5-git-send-email-hans@owltronix.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_216A0ED2-C55E-4922-AD94-CE22385C5ADA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 31 Jul 2019, at 11.41, Hans Holmberg <hans@owltronix.com> wrote:
>=20
> Now that there no module users left of bio_map_kern, stop
> exporting the symbol.
>=20
> Signed-off-by: Hans Holmberg <hans@owltronix.com>
> ---
> block/bio.c | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/block/bio.c b/block/bio.c
> index 299a0e7651ec..96ca0b4e73bb 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1521,7 +1521,6 @@ struct bio *bio_map_kern(struct request_queue =
*q, void *data, unsigned int len,
> 	bio->bi_end_io =3D bio_map_kern_endio;
> 	return bio;
> }
> -EXPORT_SYMBOL(bio_map_kern);
>=20
> static void bio_copy_kern_endio(struct bio *bio)
> {
> --
> 2.7.4

Haven=E2=80=99t realized we were the only users at this point. Nice =
cleanup.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_216A0ED2-C55E-4922-AD94-CE22385C5ADA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAl1BzC0ACgkQPEYBfS0l
eOBpoA//S0BjiAVpc1ZrajXZt6THci8rGkpZBJFH5R4am3mtz6rg5QGzEZrUavtp
AS0ZSxh5R3DonHJQYn0+Uw/GoqRy1TLxGqfnCwJTWmCN3bwT8C4eKgMmirSAdgit
NyiitH73st+bU5DGa2dU5mWIxru/QQJnzvVNV+K8IVgqTScG6KaZG0fK4DOCK95g
rcjvEJjLzaS5uNtFVSeC9AVdhMHaIK1WUT27gLiad+MRGHhxyJMRkPYGR+CQW1qd
6okzT9aCSKFvOSvIQPlXOIZ5e2IwMru0LfaLXcfVf3JDQ6jkYx+0LKj5o3Cffbw6
MWguizKs5WHom4SQaxhsNeoUpkQYiKTwvaJBumQRISpoFJR1HJ34igRpULVyh9VS
8vXqwHoFqwx/D/HMof6o72OET83kWKvR/sd990nMQMF0mpk5BlMpM+/S3aGMrCSI
U7WNFHKcFhyFiB6eqsd/+GtpYYLOx0BqBZZZ6yUW/i89aSSqJhKEinceh854+du/
rIQhJluKmRiinxpqdaLuwkLOvhJCUzfLJS8M3LoTn9nc9+C8qpi5GRwRil+B58jI
suQRdZjufg3N+17k6jxR7S1jxAghSsqTTZDLY4xMde4hzNerfQEXtHqJR4rgSP6n
TqShO63GV76Ub6K4gBuIWJlqUQg/sIyZfGON7d5UWcxnxmcX5wc=
=Egr4
-----END PGP SIGNATURE-----

--Apple-Mail=_216A0ED2-C55E-4922-AD94-CE22385C5ADA--
