Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105FFC433EF
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 06:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E648961051
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 06:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhIDGgP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Sep 2021 02:36:15 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:37726 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbhIDGgO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Sep 2021 02:36:14 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 46DC31C0BA6; Sat,  4 Sep 2021 08:35:10 +0200 (CEST)
Date:   Sat, 4 Sep 2021 08:35:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     axboe@kernel.dk, linux-leds@vger.kernel.org,
        linux-block@vger.kernel.org, linux@vger.kernel.org,
        gregkh@linuxfoundation.org, kabel@kernel.org
Subject: Re: [PATCH 00/18] Introduce block device LED trigger
Message-ID: <20210904063510.GB25286@amd>
References: <20210903204548.2745354-1-arequipeno@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <20210903204548.2745354-1-arequipeno@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds a new "blkdev" LED trigger for disk (or other block
> device) activity LEDs.
>=20
> It has the following functionality.

Correct address for lkml is linux-kernel@vger, not linux@vger.

Best regards,
							Pavel
--=20
http://www.livejournal.com/~pavelmachek

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmEzE54ACgkQMOfwapXb+vIl8gCgjOGjMpQotLAJWXHqaDsRaXLa
ingAnio6/p0dHx1pSC4H9bb2POdUPoBE
=oyPP
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
