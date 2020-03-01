Return-Path: <SRS0=IUku=4S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7045EC3F2CD
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 01:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAFD24649
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 01:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lG7S6XXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgCABCY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Feb 2020 20:02:24 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44253 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbgCABCY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Feb 2020 20:02:24 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48VQ3d0nRPz9sPk;
        Sun,  1 Mar 2020 12:02:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1583024542;
        bh=xX60jEJHQ8TOGfr7Bks8ppZYAvilikoA7iG7IgOAA/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lG7S6XXeWk9UcFIVfgK5YOIKonm6UnYNpoSOItxvNM470yA8PYTrcMrkx+EBv0iqT
         zT1z8cl3lCahvltsxOlY+xWZxhGhfZIr1SlVQotk0+zL0l6l8+0xIUfh2PlqDLovxc
         00QsBDrF/PdFu3/DdPuXsn0HgJ1VuUS9+Db0Pj9GQYbylasVe+AJnvfkIYZdW1hSVC
         b2Zt2wdF1rWMwg9XvO5l2VIvzWmtxZDL8YIkGu3QmSq/o4SMwfDDyXb91X8Lis4TkS
         3blCBmCczfceShTQlzCBenuWE13PqYdGN0rF0u9smEroL+r6c4Qb7rElyDfpQTJ85a
         T9b0yNd3JfxQg==
Date:   Sun, 1 Mar 2020 12:02:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH resend] loop: Fix IS_ERR() vs NULL bugs in
 loop_prepare_queue()
Message-ID: <20200301120219.22d92d73@canb.auug.org.au>
In-Reply-To: <20200228172136.h5dvwvrg5yfywxss@kili.mountain>
References: <c106c6ec-7171-3586-d5c5-5c14e386b3d5@kernel.dk>
        <20200228172136.h5dvwvrg5yfywxss@kili.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/i6Tur=gNYxaKV0D4z4Cotes";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--Sig_/i6Tur=gNYxaKV0D4z4Cotes
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 28 Feb 2020 20:21:36 +0300 Dan Carpenter <dan.carpenter@oracle.com>=
 wrote:
>
> The alloc_workqueue() function returns NULL on error, it never returns
> error pointers.
>=20
> Fixes: 29dab2122492 ("loop: use worker per cgroup instead of kworker")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> ---
> Resending because this goes through your -mm tree, Andrew.  The
> get_maintainer.pl script lead me astray.
>=20
>  drivers/block/loop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index da8ec0b9d909..a31ca5e04fae 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -897,7 +897,7 @@ static int loop_prepare_queue(struct loop_device *lo)
>  					WQ_UNBOUND | WQ_FREEZABLE |
>  					WQ_MEM_RECLAIM,
>  					lo->lo_number);
> -	if (IS_ERR(lo->workqueue))
> +	if (!lo->workqueue)
>  		return -ENOMEM;
> =20
>  	return 0;

Added to linux-next from tomorrow (in case Andrew has better things to
do with his weekend :-)).

--=20
Cheers,
Stephen Rothwell

--Sig_/i6Tur=gNYxaKV0D4z4Cotes
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5bCZsACgkQAVBC80lX
0GxlMgf/bCW6+K3FJmw7izRTxCApIyjOzBT5pvkC9bnCD7ymNZlTRsRjBrK4rXQP
/Dt8hXSox5yW3SFkh6TuMkxLVk4NMPWSCg1HH9zHANLbcwA6/ZJTg0VzrywxCP71
2A0d7r3MFuK92+NLb84yvz5+q3RfIi1x0+1KvDmtO/9aWbt2yWdicfJu2ZAPUqvY
pCYJZ1g3Y5u7O9cfpazteWKCpn2k0uEtAkosPUx6YkZmQnVvf9w8oMisU3Ke7oVz
VbkkIKJ1+2m/4YgwfFtRZpozWUY8YHvmReaEKNkJ1ZBhY6hiQ+dA075sgWDbket0
pv1Ou9g7BZhzNGTrihXkopxI/f5pAw==
=NCTl
-----END PGP SIGNATURE-----

--Sig_/i6Tur=gNYxaKV0D4z4Cotes--
