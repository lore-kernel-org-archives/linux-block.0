Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2B9C433F5
	for <linux-block@archiver.kernel.org>; Sun,  5 Sep 2021 18:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C560560F6D
	for <linux-block@archiver.kernel.org>; Sun,  5 Sep 2021 18:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhIESn4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Sep 2021 14:43:56 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55186 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbhIESn4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Sep 2021 14:43:56 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 44D921C0B77; Sun,  5 Sep 2021 20:42:51 +0200 (CEST)
Date:   Sun, 5 Sep 2021 20:42:50 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     axboe@kernel.dk, linux-leds@vger.kernel.org,
        linux-block@vger.kernel.org, gregkh@linuxfoundation.org,
        kabel@kernel.org
Subject: Re: [PATCH 01/18] docs: Add block device (blkdev) LED trigger
 documentation
Message-ID: <20210905184250.GA9022@amd>
References: <20210903204548.2745354-1-arequipeno@gmail.com>
 <20210903204548.2745354-2-arequipeno@gmail.com>
 <20210904062938.GA25286@amd>
 <63839834-d383-d224-8bbd-d37c6803a68f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <63839834-d383-d224-8bbd-d37c6803a68f@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>+What:		/sys/class/leds/<led>/add_blkdev
> >>+Date:		September 2021
> >>+Contact:	Ian Pilcher <arequipeno@gmail.com>
> >>+Description:
> >>+		Associate a block device with this LED by writing its kernel
> >>+		name (as shown in /sys/block) to this attribute.  Multiple
> >>+		device names may be written at once, separated by whitespace.
> >
> >This is seriously strange interface.
>=20
> It's the netdev-like interface that Marek described in an earlier note
> (adapted for the fact that the trigger supports many-to-many
> relationships).
>=20
> >If you have directory with symlinks, why not use symlink() syscall
> >instead of add_blkdev, and unlink() syscall instead of delete_blkdev?
>=20
> I'd actually had that thought as well, but I didn't see any obvious way
> to do that in sysfs when I looked.  If you know how to do it or know of
> an example, please let me know.

We got Greg in the Cc list, he'd be right person to talk to...

> If using symlink()/unlink() isn't an option, do you have a suggestion
> for a less seriously strange interface?

Let us explore this possibility, first.

Best regards,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmE1D6oACgkQMOfwapXb+vJMWgCginEN4Y9uJOdO0H7JnjicsLqx
yjIAoJXBr/8EHsWbDG3d+hS3W5luf+HM
=eTQh
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
