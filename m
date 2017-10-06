Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:52034 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdJFMMN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Oct 2017 08:12:13 -0400
Received: by mail-wm0-f47.google.com with SMTP id f4so7558931wme.0
        for <linux-block@vger.kernel.org>; Fri, 06 Oct 2017 05:12:13 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <503D9774-D34B-45EF-A998-64B846608B9B@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_CA550F44-8AAD-46C5-8705-D7378D21DB26";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Why removing REQ_FAILFAST_DRIVER in LightNVM?
Date: Fri, 6 Oct 2017 14:12:10 +0200
In-Reply-To: <EFDF36A0-7C36-44F5-B6F8-C8E6E0048B9B@lightnvm.io>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>,
        linux-block@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
References: <216FF7C0-4B2A-438A-BC63-88A9BBDC77CC@lightnvm.io>
 <20171006115927.GA12530@infradead.org>
 <6D7E3697-713C-4FBD-86EA-20AB1DC72742@lightnvm.io>
 <20171006120609.GA27720@infradead.org>
 <EFDF36A0-7C36-44F5-B6F8-C8E6E0048B9B@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_CA550F44-8AAD-46C5-8705-D7378D21DB26
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 6 Oct 2017, at 14.08, Javier Gonz=C3=A1lez <jg@lightnvm.io> wrote:
>=20
>> On 6 Oct 2017, at 14.06, Christoph Hellwig <hch@infradead.org> wrote:
>>=20
>> On Fri, Oct 06, 2017 at 02:01:46PM +0200, Javier Gonz=C3=A1lez wrote:
>>> I think it is good to fail fast as any other nvme I/O command and =
then
>>> recover in pblk if necessary.
>>=20
>> Note that we only do it for other nvme _passthrough_ commands - the
>> actual I/O commands dot not get the failfast flag.
>=20
> Yes. I was thinking of the LightNVM-specific _passthrough_ used by
> liblightnvm since I'm refactoring the sync. path at the moment; the
> "normal" async. path will be untouched for now.

In fact, for the normal I/O path the whole idea is to do this directly
in pblk, when we use struct request, and drop all these conversions in
lightnvm.c. But that will be later on...

Javier

--Apple-Mail=_CA550F44-8AAD-46C5-8705-D7378D21DB26
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnXcxoACgkQYx8FO3WZ
GMo9aA//b4LDwn66l+sSP1Opc1rqd6MHP+eMiIalQVAjs+YiYuEcse4pXHw/ktPy
0z2gTPjiOBxGcxbtrtGqJQsbZO38lBswREGRQkqvs9guzpRBoDVUDXLRfs2F7VEb
YzRP+buEYC1qhO5BAEG2FuW2Dxe21KoDVUhz5mbfn8z80OUkgF2v83dhPgLh+YVt
hCNQ0GChGdn5SzVTjQIk5gFc6I3C+aRzYJMgLVBijudkvvAUP9uQvFdeyE5u3zUs
w3g8C1qvln8W3tDIER4nEXut2L+kvqP7I6XNXXT2gn5uapG8ixDNkn3GrJoHz7R/
GJ+k6iTO8Wd59D6R1rppv52Ri8HDWJjQu8SbdIEAuun4UldX+QZBlpw4fAFOuV/+
Hs7Js1ISF7GzscdsQMDRQFlsMUPaICq1WwyCgT/TFHflegrjR6BJCoXwSO6oGB4N
HfjvspXKWzzTiKo851177A/aDJnLAb2FiKTC/1GBX6ESqO/xNrJXQrntsKCfSQSG
Y3mR3qcVP4g6fUr8Hq2t44zFoKuU9vduqDvGTWcCSq5n8H4dWdszvUDWAM9VTceo
ESWbM0DzJd89oDd51/UyPCbN1A8jNh+B0Ebv0Rtez0s2QV/gQtIDkU4Q4WwoLRqo
aZdaCrphgagrwPChXaRFH48E4XhmRzFUR8jQuUcuP/LifaKZcEg=
=gqH3
-----END PGP SIGNATURE-----

--Apple-Mail=_CA550F44-8AAD-46C5-8705-D7378D21DB26--
