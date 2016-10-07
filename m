Return-Path: <linux-block-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56333 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932141AbcJGShA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Oct 2016 14:37:00 -0400
Date: Fri, 7 Oct 2016 20:36:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Josef Bacik <jbacik@fb.com>
Cc: axboe@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        nbd-general@lists.sourceforge.net, w@uter.be, hch@infradead.org
Subject: Re: [PATCH][V2] nbd: add multi-connection support
Message-ID: <20161007183656.GE19976@amd>
References: <1473950634-4299-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MIdTMoZhcV1D07fI"
In-Reply-To: <1473950634-4299-1-git-send-email-jbacik@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--MIdTMoZhcV1D07fI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2016-09-15 10:43:54, Josef Bacik wrote:
> NBD can become contended on its single connection.  We have to serialize =
all
> writes and we can only process one read response at a time.  Fix this by
> allowing userspace to provide multiple connections to a single nbd device=
=2E  This
> coupled with block-mq drastically increases performance in multi-process =
cases.
> Thanks,
>=20
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Idea is that it can now use multiple CPUs concurrently...?

Do you have a diff for the nbd-server, too?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--MIdTMoZhcV1D07fI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlf360gACgkQMOfwapXb+vJqtgCgh/vAYn7Tzx2BkolV9tixHVL4
j4UAoJ8mNl8IsKP7QHnI8xj7QMNi74Qz
=rfFB
-----END PGP SIGNATURE-----

--MIdTMoZhcV1D07fI--
