Return-Path: <SRS0=KgRV=V2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5889CC433FF
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 11:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A80216C8
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 11:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387676AbfG2L1a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:27:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55886 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387629AbfG2L1a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jul 2019 07:27:30 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 49605802A0; Mon, 29 Jul 2019 13:27:16 +0200 (CEST)
Date:   Mon, 29 Jul 2019 13:27:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Frank Steiner <fsteiner-mail1@bio.ifi.lmu.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        GOTO Masanori <gotom@debian.or.jp>,
        YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>
Subject: Re: [PATCH 3/3] scsi: nsp32: rename LED_* macros to EXT_PORT_LED_*
Message-ID: <20190729112728.GB396@amd>
References: <1564322446-28255-1-git-send-email-akinobu.mita@gmail.com>
 <1564322446-28255-4-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <1564322446-28255-4-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-07-28 23:00:46, Akinobu Mita wrote:
> The nsp32 driver defines LED_ON and LED_OFF macros for EXT_PORT_DDR or
> EXT_PORT register values.  The LED_OFF and LED_ON macros conflict with
> the LED subsystem's LED_OFF and LED_ON enums.
>=20
> This renames these LED_* macros to EXT_PORT_LED_* in nsp32 driver.
>=20
> Cc: Frank Steiner <fsteiner-mail1@bio.ifi.lmu.de>
> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0+2B8ACgkQMOfwapXb+vKNrQCfV6ovrkayd3uO5M4FskCe/Maq
xNIAoKzQtQP1KbG8Doy2R8Ple3GU+K5X
=bZYr
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
