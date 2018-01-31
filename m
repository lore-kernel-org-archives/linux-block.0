Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:50292 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752080AbeAaCAb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jan 2018 21:00:31 -0500
Received: by mail-it0-f67.google.com with SMTP id x128so3135957ite.0
        for <linux-block@vger.kernel.org>; Tue, 30 Jan 2018 18:00:31 -0800 (PST)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <E2E51BC8-63D4-40EC-9912-398BB73C9F16@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_0AB1DACA-E6D0-488A-9479-142D26DA5A0F";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 1/2] lightnvm: remove mlc pairs structure
Date: Wed, 31 Jan 2018 10:00:12 +0800
In-Reply-To: <20180130132605.28635-1-m@bjorling.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
References: <20180130132605.28635-1-m@bjorling.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_0AB1DACA-E6D0-488A-9479-142D26DA5A0F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 30 Jan 2018, at 21.26, Matias Bj=C3=B8rling <m@bjorling.me> wrote:
>=20
> The known implementations of the 1.2 specification, and upcoming 2.0
> implementation all expose a sequential list of pages to write.
> Remove the data structure, as it is no longer needed.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <m@bjorling.me>
> ---
> drivers/nvme/host/lightnvm.c | 14 +-------------
> 1 file changed, 1 insertion(+), 13 deletions(-)

Even though the current implementations does not use the MLC pairing
information, this is part of the on the 1.2 identification. Until we
eventually remove 1.2 support (if we do), the identify structure should
reflect the specification as is.

Javier


--Apple-Mail=_0AB1DACA-E6D0-488A-9479-142D26DA5A0F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlpxIywACgkQYx8FO3WZ
GMrdshAAsfVoIhvzKR9ItlMXk+N4PD7Lkh5bKZy0xbMCkZ3/BS51Vck4dfTbAmOM
MGqxwol/nWNjwACumr//RfNWEcd+chzxc9FE3s86wHrDJkKpRoHghPlL7cgR7MSt
svV+HMS2ofs8V8qHg3VTCCx6d6JuM6h3zWZ43Aqf7wCG5XIfZHLKHo52lU0QFujV
NAuf4VIzJ7plJt4uZLRM1G6hZ2PHHexToy+E20Ti4YkhZZpy8mYjxSzOP+Tbta+k
OaPzAKXYZBWRjHP1b0zAz/97wuNakNHWZFXm3PyBx/gKSak+PcKSvuD9UwmSTRzK
7hbMOPj6g9kk+PsMS6xUbyY0x37kT6DDtP+VRIj6/IIe0wc9TrO+bcCUsrxHOpXr
HJnbAGL2Wxu4Yvzx2mkP+fCTFkAgfe7EiHYem9VR+VCAAWlSEUMUeGjhymi6arsv
IUqbLeXsD81Ytm2wVgS77ymdzYalgXKHkRv3u55HWiuKGqJc2v8S45lMJgDoaMtw
xm1vUW3X3S/GxsZ0s0jlVeXeU5sGg+dV086/TgHBWKRkzLEKhaTytuPzijnvS3V9
ChtT2q//z7+nVRoPIvm0p800cxzV9abRK5ungKtVeUtT0ek5gJ9w62IZVAFVw7md
muByKAXffo6XOooywhSrI3cC6VPgL1qNVW+SCP94dvzasYdObeE=
=Clcy
-----END PGP SIGNATURE-----

--Apple-Mail=_0AB1DACA-E6D0-488A-9479-142D26DA5A0F--
