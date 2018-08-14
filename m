Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr730066.outbound.protection.outlook.com ([40.107.73.66]:12865
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730488AbeHNQJj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Aug 2018 12:09:39 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] lightnvm: move bad block and chunk state logic to
 core
Date: Tue, 14 Aug 2018 13:22:26 +0000
Message-ID: <3B0C813D-EA2C-422A-B017-07F4A5B11956@cnexlabs.com>
References: <20180814131735.6853-1-mb@lightnvm.io>
In-Reply-To: <20180814131735.6853-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1985CC79-7CEA-467B-B2AE-90539FABBB33";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_1985CC79-7CEA-467B-B2AE-90539FABBB33
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 14 Aug 2018, at 15.17, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> This patch moves the 1.2 and 2.0 block/chunk metadata retrieval to
> core.
>=20
> Javier, would you like me to pick up your 1.2 chunk state patch and
> merge it into this one, or would you like to rebase on this later when
> it has been reviewed?
>=20

This is great. Thanks! Let me look into the patch itself, test, etc. I'm
ok with merging the 1.2 chunk fixes here. I'll then rebase the 2.0 WP
recovery patches that I have staging and submit them.

Javier

--Apple-Mail=_1985CC79-7CEA-467B-B2AE-90539FABBB33
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlty15AACgkQIX4xUKFR
nnROCQ/9GtueUh20caiYuoFfZJ90gtHk2S1AfX7Slk9RQQ6dDefZmS/xdvSY+4JU
GZQg3RhJz1s49toDOOgCuKcU8F2WPNZsubreYd2suZBgYF+O4EdC12eKpVwUyOs/
BzyM8iYrr0I0indanazoPKKfH4Kn0HUvo3gj0xnaIVhVsCHba79Jhuh1yEiqWYrT
5jXAMVNoT5d7pJ2thdF+xUNFZuatm8eeQkV1vQTlabRdRdcTRbVRoJb0KNve4wS6
lBGu3EUjcHYAYmYKf3DKpWQByWN9ICxkwr7MDq8+xnLCtEWflx4tcgsDyivonSbG
QySSmWAILiLCk5Epcg5Lg/N1T5vhngsRfduhnrdD53JfxCZu0HjAlchnyJ/0Ymx6
koELWJWBqUVKYIRQuNfiy4Xpn8SX5T8f9msW9CLW77UmskQB5hCeKnb50GYAfiLW
N5CaJ8V70ZGOFnv++gj/SHctT/SFLahHVWC7Fy638N383GLXD7m4MMs4Sxq7FeSJ
dz0X1mFYaiCveL0wWJ3gzu29bKWD3gNUffCCW672BVdsSb5nUCUSG9xXiI4e8GL+
MfEESk6qFo0eMZUC2WMflMN7C+O7ChnvGlVnsU0YRoskQjtYf1n55surril5Eb8S
zNtsZWfWT2hVZE9lWv0gAKCceCcphFJbITN1Cb+iDijofyf6xaI=
=Wxc+
-----END PGP SIGNATURE-----

--Apple-Mail=_1985CC79-7CEA-467B-B2AE-90539FABBB33--
