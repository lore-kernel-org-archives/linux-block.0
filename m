Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E3EC433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 06:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9194D60F92
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 06:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbhIFG5T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Sep 2021 02:57:19 -0400
Received: from ozlabs.org ([203.11.71.1]:38799 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238731AbhIFG5T (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Sep 2021 02:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1630911373;
        bh=jcQ/6Pc2/Mt2USwYnSLPOKPRTPl5IBzg5wdJ+DsqOfU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lVjpohUObh6Y3PtsCAvjMPA4kN4HEgpAyFQG1/va5qROWZw5H2KaHx2kjUESB1uQn
         JZNLQRFrIC71SUGvqtnHI/sQsmOnmfv4pPgPAp/NuEl0n/L+V0UuBf7FA5x07rJJxB
         BN8hIB/fklXGRv9yWe/8kEMLDiOg3WMdd7Jk+VcicHXOl80v1BeIcdrJTEM8e+7DXM
         8SYtVeNNm9o8gClgIiVZ1ixbv3TiKt8laGOicxcF6206kcP2Ox+ou5VIouZw34Nbkf
         3R8xE/Bp8W05QXHaRmqMGiXh3Hw+BDpx8tFm6F96M2rJDar6VRc29v0YadJ0feAQnY
         xrSVFachn/muA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4H2zhF2Pt3z9sCD;
        Mon,  6 Sep 2021 16:56:12 +1000 (AEST)
Date:   Mon, 6 Sep 2021 16:56:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block/mq-deadline: Move dd_queued() to fix defined but
 not used warning
Message-ID: <20210906165611.0e52f096@canb.auug.org.au>
In-Reply-To: <a0592ddf-306a-a833-785f-750a601487dd@kernel.dk>
References: <20210830091128.1854266-1-geert@linux-m68k.org>
        <caf2449c-e86d-195d-3635-9be49159166a@kernel.dk>
        <20210906125605.658fe211@canb.auug.org.au>
        <a0592ddf-306a-a833-785f-750a601487dd@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dmmp0/GyNKKoKjoHbF.jZAc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--Sig_/dmmp0/GyNKKoKjoHbF.jZAc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Sun, 5 Sep 2021 21:04:17 -0600 Jens Axboe <axboe@kernel.dk> wrote:
>
> Sure, it's actually the only branch I haven't sent off yet today. Will
> do so now.

Excellent, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/dmmp0/GyNKKoKjoHbF.jZAc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmE1u4sACgkQAVBC80lX
0Gy41wf9FCzS6NlUsQLBdscrRA81iTYhS9n4HRGSyuEjmj/9/Vz2PCj/gmSt4XcE
81IIpVI/deTJOPYsRiMJU1Wp252Z0/FNeZ7Iw7Qkh5k+3Y4mtw8VVYLUCJ1w4csq
3nOYl8QxVvFY0qpR93e10wsqH4Um0OOajQYL4EjKzUuPyJsgtbyIb4cksP2u3/UV
LXyDLWVmIC8lXiglj0XaXYsuV56+fESkWuqjDhBmRNdWod8XutHAlwAvUkRpMlU5
xLsgpKpjQoNMY41flj9Ye3tElsF9pxiCjaupdIdQ77RLiES6ZuR8P+YK7mFMlw1M
SpJCffgw63RAfKmaPSlogXd5QMI6uw==
=aQJc
-----END PGP SIGNATURE-----

--Sig_/dmmp0/GyNKKoKjoHbF.jZAc--
