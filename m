Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam02on0044.outbound.protection.outlook.com ([104.47.36.44]:28400
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751350AbdDKNsl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2017 09:48:41 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
CC: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] lightnvm: pblk
Date: Tue, 11 Apr 2017 13:48:37 +0000
Message-ID: <AAEB566E-D287-401C-8BAB-1E153D6EFBD3@cnexlabs.com>
References: <1491849399-12798-1-git-send-email-javier@cnexlabs.com>
 <ffcc53b3-2b60-dad4-4372-da5b190e6c6e@sandisk.com>
In-Reply-To: <ffcc53b3-2b60-dad4-4372-da5b190e6c6e@sandisk.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_E7F9834B-4443-4F30-A23B-A61D429F9EA7";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_E7F9834B-4443-4F30-A23B-A61D429F9EA7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Bart,

> On 10 Apr 2017, at 22.35, Bart Van Assche <bart.vanassche@sandisk.com> =
wrote:
>=20
> On 04/10/2017 11:36 AM, Javier Gonz=C3=A1lez wrote:
>> Changes since v3:
>> * Apply Bart's feedback [1]
>=20
> Thanks for having addressed these comments. But please also make sure
> that the pblk driver builds cleanly with W=3D1 C=3D2. When running =
"make
> M=3Ddrivers/lightnvm W=3D1 C=3D2" several warnings are reported that =
should be
> reviewed. At least the endianness warnings should be addressed. An =
example:
>=20
>  CHECK   drivers/lightnvm/pblk-gc.c
> drivers/lightnvm/pblk-gc.c:254:18: warning: incorrect type in =
assignment
> (different base types)
> drivers/lightnvm/pblk-gc.c:254:18:    expected unsigned long long
> [usertype] *lba_list
> drivers/lightnvm/pblk-gc.c:254:18:    got restricted __le64 [usertype] =
*
>=20
> Please also review the warnings reported by smatch (make
> M=3Ddrivers/lightnvm C=3D2 CHECK=3D"smatch -p=3Dkernel"). A few =
examples that
> most likely indicate bugs:
>=20
>  CHECK   drivers/lightnvm/pblk-init.c
> drivers/lightnvm/pblk-init.c:915: pblk_init() error: passing non
> negative 1 to ERR_PTR
> drivers/lightnvm/pblk-rb.c:782: pblk_rb_tear_down_check() error: we
> previously assumed 'rb->entries' could be null (see line 778)  CHECK
> drivers/lightnvm/pblk-read.c
> drivers/lightnvm/pblk-read.c:486: pblk_submit_read_gc() error: 'bio'
> dereferencing possible ERR_PTR()

I'll submit a v5 later today where these are addressed. Thanks.

>=20
> Thanks,
>=20
> Bart.

Javier

--Apple-Mail=_E7F9834B-4443-4F30-A23B-A61D429F9EA7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJY7N60AAoJECF+MVChUZ50DugQAL35wrXal/Ta4HxHmymL/UC4
5wmUngVawlLXshTzlYhKJ0Wy0nnUg7lHbD2vh5XFn2zoRfDr2k5zcVad/PHHzMZX
MnYeOlYMVE/pan7CHsAXt0vXstMRUwQGNbnxmdjvHKLVZEaioGtHimylduXnYgQ9
S8AtxpD6bVBqCwmpS15FruOpPcP1kxcB5Ofvz3buRHB4DGjT0+WOh1GQH23Thiri
U41/olK1MDGiFE2iy6VC5rRg5CKCUtUWnlIbd4hO/5AmvPiOHW+RguryP2cgztSw
3wY/JaOah6u9lzLx9fESyvNWXzk3iVDd4NgJv995Z3fYXGLgaxmuZUwTUDSM3TaF
OOegAwICgeJzGtVjNsXkL5x0sMgZi+BRLGdNrZQ1djfPM2FuKlIIYUXMOmmtpCj1
fA4ziexYj+3e9cBGBQuaFnuIIim5jLUk0XHk9uJe1mlid9ysF16b9hHI27BzdTuo
9rV7vGRUx7/52dT+kWpNTMtZMvRAW3oNzhRtmhNto2K85NbqVHQZzItLq4u5Fghe
/c0dS+X3LSjxOe6e0kBiLAPxSRgEO5f/rL+kGhdqqw9z3OEfZ06FUKLQW2roKXZv
2WIlgcjNSv5kit9lukR2hvmFB558cck4IeRufaPDoZARf908Vp5jaJPO92efxiag
Bm55FGcXs8bHrnxW1OG4
=cO2k
-----END PGP SIGNATURE-----

--Apple-Mail=_E7F9834B-4443-4F30-A23B-A61D429F9EA7--
