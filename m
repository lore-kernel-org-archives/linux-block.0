Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA2AC43331
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 15:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973B32081B
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 15:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbAHKTI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfIFPAT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:00:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45756 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfIFPAS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Sep 2019 11:00:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id l1so6264948lji.12;
        Fri, 06 Sep 2019 08:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=Z9WTj2Nud1Nz+srhtJ8nXHwPxkOxBmBz3BB9U9QFpYs=;
        b=lbAHKTI3g+r3FcCHgogYouiuqsl4j1GyRLOMugPWTBTSp9XiDKYbnqDS3N+lYexVZj
         WY6jzj4T+4Q9yKpeP4E+nOba0+tQdy0e/QoBfbavJjvYNjqlzj0WaGZAYSIxuQsqOPwR
         XefiNSz0tTWigra76zfdKDUazHJc5TODoAWFYMnfQcR9jcU3zlyYDVrl1Dh6uf5cUkI0
         E7KkyVgppF+ZkOIOfl74QByY2E3IKYZMN1zdN3TieFWzJXxiS2RAF8pUUoAt88wFHUyc
         7Yqwsz1T6hz4hP5c6YA9JRULrDiUA3dfGTCV37IbkN3swKwKKZ+pQ9ljv6aGPDV1n96l
         A2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=Z9WTj2Nud1Nz+srhtJ8nXHwPxkOxBmBz3BB9U9QFpYs=;
        b=rKphntYQEHhouuJXh4BGVi5ca8kzMHhptLyXBzEVyZWE0f4JDMSbAOwADwbhXoVghJ
         bNrC6f4TQEUmVTifmuMKWBkSQyeh8uV6on8XsWKKuZNzIIs5rJo6uLF/qbO9l0PVEQWW
         Ll1M8e1MVrUQ570dttOp5Nm8zMpWzWA44ojX11QaPAW1dU5L20b/wZje9M3dE3fA8/FJ
         C0sqLQNzGMQn+Lkt7s5oXy+htK80BI1WXKuXNDof36hA8uuAp9Va4TU0SK5rD3KB9i3r
         VSOmi1xHGcMRnR2uF58nhIGRGOuDNH89e8E9Fa9zJFRhel5+rLSp4rgAn/RImJ9q0Ckp
         GsBw==
X-Gm-Message-State: APjAAAU3lP2mQJAow5+YQ80mIICGRyggHFsnWUTZoRkXWiI6eesaYg22
        xgPVBqMYHie1lIEPVng+q14EnLVv
X-Google-Smtp-Source: APXvYqz67NqaRHGxFyfTetTgjg+tIsiP2DAA9Mq3FIs4tKg+Wnq1Sx21QcCaET5io1u1i96WIOC5jQ==
X-Received: by 2002:a2e:988c:: with SMTP id b12mr5765398ljj.212.1567782015877;
        Fri, 06 Sep 2019 08:00:15 -0700 (PDT)
Received: from [192.168.100.31] (mm-82-227-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.227.82])
        by smtp.gmail.com with ESMTPSA id n24sm974373ljj.87.2019.09.06.08.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 08:00:15 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, josef@toxicpanda.com
References: <cover.1567780718.git.asml.silence@gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [RESEND][PATCH v2 0/2] Fix misuse of blk_rq_stats in
 blk-iolatency
Message-ID: <087e6627-79fc-f565-348b-5f4b5b5fefcf@gmail.com>
Date:   Fri, 6 Sep 2019 18:00:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cover.1567780718.git.asml.silence@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5gafCOY7DM2fSOsMuHObGXJlfC1eAT61u"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5gafCOY7DM2fSOsMuHObGXJlfC1eAT61u
Content-Type: multipart/mixed; boundary="kSCknI9fXK5GSNfedAkmVODvpfHqM9Qw7";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, josef@toxicpanda.com
Message-ID: <087e6627-79fc-f565-348b-5f4b5b5fefcf@gmail.com>
Subject: Re: [RESEND][PATCH v2 0/2] Fix misuse of blk_rq_stats in
 blk-iolatency
References: <cover.1567780718.git.asml.silence@gmail.com>
In-Reply-To: <cover.1567780718.git.asml.silence@gmail.com>

--kSCknI9fXK5GSNfedAkmVODvpfHqM9Qw7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Jens, could you please at last take a look?

The patches have been stalling here for almost 2 months
(see
https://lkml.kernel.org/lkml/ac0700a1-0984-417b-d5d8-35c4ba56f6f6@gmail.c=
om/T/)

Thanks

On 06/09/2019 17:42, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
>=20
> There are implicit assumptions about struct blk_rq_stats, which make
> it's very easy to misuse. The first patch fixes a bug caused by that.
> The second employs type-system to prevent recurrences.
>=20
> v2: rebase + reformulate commit messages (no code changes)
>=20
> Acked-by: Josef Bacik <josef@toxicpanda.com>
>=20
> Pavel Begunkov (2):
>   blk-iolatency: Fix zero mean in previous stats
>   blk-stats: Introduce explicit stat staging buffers
>=20
>  block/blk-iolatency.c     | 60 ++++++++++++++++++++++++++++++---------=

>  block/blk-stat.c          | 48 +++++++++++++++++++++++--------
>  block/blk-stat.h          |  9 ++++--
>  include/linux/blk_types.h |  6 ++++
>  4 files changed, 94 insertions(+), 29 deletions(-)
>=20

--=20
Yours sincerely,
Pavel Begunkov


--kSCknI9fXK5GSNfedAkmVODvpfHqM9Qw7--

--5gafCOY7DM2fSOsMuHObGXJlfC1eAT61u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl1ydH0ACgkQWt5b1Glr
+6Vh7hAAj8gBXrBQbmRx/nMDcvUV0T1s/d5+SOVF5vP4WHyHH/VOQdCl9ZVAcgpB
cFBFiu1r4pB9efXnlyolZ0mnUljd9fIkmiUMITk8B/2CzaniXtKSN7Jl6L4pn0n6
SQWzIEXBtEc/GhCMeMZnuUdtNiBlTykOc3haVw8mXF6NTTsN/smlg/ldTDTxbhYU
2LTJOPo8vtftoZaLDNPHAXMdKf2EdEgQ+0wNN+wybfxSoCs48f3+jcpWX6oPnIm0
lN5WWp6FBTBrGlQNttgeXUBThOixM4Igj5VnSx8yq+iMVI/UfEfGO07eS6cErggS
XZBvttjzPOyyqR9mVE4rDF8fBzzAJBJgvAJjTA62CaLusf9Pyp35tETKbSOcIanP
OnbT8bdVs6fB12Q0gRoxMu+NOklIuKYUmVs2LDMOAK/9ckkp4pBohYnl4Vo4y83I
FvsRwswAnE5wVA9BMNoqLYal8MA6vmFuuHZRfso9aNUhaA8qduzpU82HluzOKQX3
9SEtoAukpPJgUKYWy7mQrPeHnOab9YstiG8+z3JZ92pkoHyG9HjtjHKzvmSe/FoF
bPwbVU/fIyHPeV3eGbv85YMJ0sS1oM04imDNtASJ7FXNhPhcZ0VWY35Prb08Kdcu
r7qocG3DRUu9ai46YoxcuAulsVl6QEwPPZDivkPFkLIaz+vFoXI=
=dmVC
-----END PGP SIGNATURE-----

--5gafCOY7DM2fSOsMuHObGXJlfC1eAT61u--
