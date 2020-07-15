Return-Path: <SRS0=PIBb=A2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C0AC433E2
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 02:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6FB2074B
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 02:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="J+AcP4tw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgGOCTt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgGOCTs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jul 2020 22:19:48 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7090DC061755;
        Tue, 14 Jul 2020 19:19:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B61L81L3Hz9sQt;
        Wed, 15 Jul 2020 12:19:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594779584;
        bh=+IIpIm5NBf0FLv1htcwiZDfeAADjuxvH47Lc0Ejtq2Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J+AcP4twDPUf7D3brcjpb2DpRsznmMk+CLVEFTrsUO9Ji+U8fVuT0SNBqrFT9hEvS
         FsawEyHoGcwyCrM98PfdwyQj3qamcqRdlQQv0DRlF0RDE2IkhB5YuCj7HGCtZk+Wua
         84syc2Qhj326ydHFFS5bBx9o0JVdSr7P8Jrw4tnEMParhSna+26dVQuk3AOCgLTryG
         0lvYRtA5rMznfCP2LCLcdoze16ghklSs0tyWJJIEBoVVrdXWh32Y0ThO4kmy+yYhvI
         iSkeSD6CTuhFd3M1LvF9ZaYRGkZbXGKkDeHK3GniAHtcnobwmpC4+tp31Lg/ogDXwR
         3qOhRN9xa3FSg==
Date:   Wed, 15 Jul 2020 12:19:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Qian Cai <cai@lca.pw>
Cc:     Guo Xuenan <guoxuenan@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, wangli74@huawei.com,
        fangwei1@huawei.com, ming.lei@redhat.com, josef@toxicpanda.com,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-rq-qos: remove redundant finish_wait to
 rq_qos_wait.
Message-ID: <20200715121942.33bb34d8@canb.auug.org.au>
In-Reply-To: <20200714232123.GA49251@lca.pw>
References: <20200628135625.3396636-1-guoxuenan@huawei.com>
        <20200714232123.GA49251@lca.pw>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.aioA6X+ig3cO9mw.DyZQFf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--Sig_/.aioA6X+ig3cO9mw.DyZQFf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 14 Jul 2020 19:21:24 -0400 Qian Cai <cai@lca.pw> wrote:
>
> On Sun, Jun 28, 2020 at 09:56:25AM -0400, Guo Xuenan wrote:
> > It is no need do finish_wait twice after acquiring inflight.
> >=20
> > Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> > ---
> >  block/blk-rq-qos.c | 2 --
> >  1 file changed, 2 deletions(-)
> >=20
> > diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> > index 656460636ad3..18f3eab9f768 100644
> > --- a/block/blk-rq-qos.c
> > +++ b/block/blk-rq-qos.c
> > @@ -273,8 +273,6 @@ void rq_qos_wait(struct rq_wait *rqw, void *private=
_data,
> >  		if (data.got_token)
> >  			break;
> >  		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
> > -			finish_wait(&rqw->wait, &data.wq);
> > -
> >  			/*
> >  			 * We raced with wbt_wake_function() getting a token,
> >  			 * which means we now have two. Put our local token
> > --=20
> > 2.25.4 =20
>=20
> Reverting this commit fixed an issue that swapping workloads will stall f=
or
> days without being able to make any progress below.

I have reverted that commit from linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/.aioA6X+ig3cO9mw.DyZQFf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8OZ78ACgkQAVBC80lX
0GybOAgAnpJviyuvglPkeY5E4Ah0HAPdrEr3GmaaWUxS8v+D1qxs3u8/Jd8UhPOP
I8nZsL3u41jxUzFtn8jMy8b3/8k+BbZej+aRXwLIg6O42YS/40AfX+SYvOnMp0n3
mD9joEL0hUoqvpZSWfPRLWzgqvzF7KLCKY9wyvB+f5xQDrzftY67u+4J6A9YyG5Z
AvsUetVrt2SvOpxavgjs9YyHE/XDC5CPAy7QnDyZUu0Y7RC9ndoGcNOYtZrQ9BjZ
e1tisxXkROR0IUSAQv9x/xExKLj4uUi4Z0RDdHD5lWuokOUZi6WA6XRORqgfFbRW
uJPi45PylXE4PrzRYnZKEghPtTmyKA==
=KgD5
-----END PGP SIGNATURE-----

--Sig_/.aioA6X+ig3cO9mw.DyZQFf--
