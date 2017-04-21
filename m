Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35364 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424459AbdDUTGQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 15:06:16 -0400
Received: by mail-wm0-f42.google.com with SMTP id w64so22537077wma.0
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2017 12:06:16 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <F1FB4E37-23D4-4E6B-9310-78FA4699556C@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A62A987E-1F9B-473C-8C4B-C64030F5D14B";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] lightnvm: propagate pblk_init return to userspace
Date: Fri, 21 Apr 2017 17:07:50 +0200
In-Reply-To: <20170420182356.GA7866@hercules.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20170420182356.GA7866@hercules.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_A62A987E-1F9B-473C-8C4B-C64030F5D14B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 20 Apr 2017, at 20.23, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> =46rom userspace calling ioctl(NVM_DEV_CREATE) was returning ENOMEM =
for
> invalid arguments even though pblk (pblk_init) was returning correctly
> -EINVAL to nvm_create_tgt inside core.  This patch propagates the
> correct return value to userspace.
>=20
> Because pblk was introduced recently this only needs to go in 4.12.
>=20
> Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
>=20

Looks good.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>

Javier

--Apple-Mail=_A62A987E-1F9B-473C-8C4B-C64030F5D14B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJY+iBHAAoJEGMfBTt1mRjKDcQQAK0BOSZtGW8YKR2yR36hCDLh
GvuEODhpskjUs26nDfdb+bXwqJo7qvGxKpAaGcGg0QahVgjtGFdoHAqfQIQNFijD
9yJ43o2ortvNaH9owD09zlgVOmv7JP/LoloUNLeO3fPONhiuL7ElzrGBZTP7Bg5A
znRtPUC/FCTB/Ptl6staAiXO5T5OETwN66OnjRTubsCeaxnyaVorNsNJjZM8hCoV
NYy9ePC7g56Z1nTEDUZG77JLvunUtFtrZ4YD7SRxFUcP9I0MMua89+5cCCTUChxj
JjE+vwakLc3UeFPVuQHoCELG48QMU1wVG23JZ5abLmpJoqzRguRGiVDvpBi1IITd
LSBZTKY/OyB07BNn0nAByM+vXTCLghyDtBIw1x8dkdK/NmFidBzV2y1IZmJfotv+
xofFIAu6MBM00mk7yyvMRfk9bon9Em9kJ2l6YfMQ+o2hEwINbzvO+OHSdCCbCTZ/
gd+7/J8VorX/1xYf411YxouIKCIidnGjGAq0UDwcQaqn1DVbt0OnDt095G1DJlIP
cDKBer/fNFxkPNov0h38zCibh4bAYAOhFA2QZfx5Hi2uelzlrF7+7eZ0DMsD0uii
lRJ7IgS9A/d4/Hh2vmmYKaIjAqz7GcmZo41XgKQmpiRvPS/q/WR4K//sQ2x/kg6k
+I8VWbDbPHGkryCpZtVd
=c01T
-----END PGP SIGNATURE-----

--Apple-Mail=_A62A987E-1F9B-473C-8C4B-C64030F5D14B--
