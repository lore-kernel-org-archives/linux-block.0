Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:40740 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753933AbeDRLnp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Apr 2018 07:43:45 -0400
Received: by mail-it0-f54.google.com with SMTP id u62-v6so2041776ita.5
        for <linux-block@vger.kernel.org>; Wed, 18 Apr 2018 04:43:45 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <2CA1C6E9-8228-47BC-A0A1-570425574829@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_91313AD1-6031-484A-A10B-303E6672271E";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH 08/11] lightnvm: pblk: remove unnecessary argument
Date: Wed, 18 Apr 2018 04:43:34 -0700
In-Reply-To: <feabf6cc-a25b-b3de-3259-c211cb7120f0@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
 <1523874332-6272-9-git-send-email-javier@cnexlabs.com>
 <feabf6cc-a25b-b3de-3259-c211cb7120f0@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_91313AD1-6031-484A-A10B-303E6672271E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


Javier

> On 17 Apr 2018, at 05.12, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 4/16/18 12:25 PM, Javier Gonz=C3=A1lez wrote:
>> Remove unnecessary argument on pblk_line_free()
>=20
> Why was the argument no longer needed?

You can see it is not used... It a straightforward clean up.

Javier

--Apple-Mail=_91313AD1-6031-484A-A10B-303E6672271E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlrXL2YACgkQPEYBfS0l
eODCyhAArVZhJPvYW5LBC5+/hTGhpUdVdyESPJnjOcsnd1fypcf6/ZkbagwxElLg
1W0X0f7xPLtZqjXSafoc2a/ema1E7/ByhDHRKMb5FcC2kmtlJo9ur3GQ8lTgVNI/
kILzj42rJOdQe7krnrbUHpil4/G/M/E3l+r1BTV5mOngPvnzpVb02ZDXfzdTBqtq
Avoloya11BwQDvkuQyjP2zXyG94Vx9puo+45/PGOdC5l+lTrqvDnBWM8/oWYDWk4
D/i1Jb0a1xPReJ6G3uSoItodXFhJ65G2V9mZMiP/P9SRa0WnpBr/bJoNC+a/wPt3
rfLfqBmyxgccMXormf3KNyFkpyZAz/ebt3/yvk3reH0EGMfwQJp5J3uRYFpCW1ab
ZAQGZRkxUiJa1dGGah1wCav90GGVaL7xK8La2POm32S2RsJR14YgkyqUPn1nqOGr
Bt/ISjlp2A95hBQqzqPaSLI+85eoJdSeReUruKxmBajDLP2ZTEpxH7496KPtGFAj
Wa5Sd+M1ybHqbEu6SHVRRgSqW7NwtgInRj8pLYcZDkl4VzqGnG/j3fOz5kAScwgo
Ziq/rhaKO/HzdowkV0y2GerWN73b+D+enFFpcNxDh85rND4vMEE5bqGkNzACagck
l5/ahcLxE7FNBJ94u2vPhTNXHUdtzJaxqv+ME2jlrlHyHqW+QVY=
=ZCVy
-----END PGP SIGNATURE-----

--Apple-Mail=_91313AD1-6031-484A-A10B-303E6672271E--
