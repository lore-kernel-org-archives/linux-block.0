Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0089.outbound.protection.outlook.com ([104.47.41.89]:47872
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752027AbeDRMIv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Apr 2018 08:08:51 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/11] lightnvm: pblk: remove unnecessary indirection
Date: Wed, 18 Apr 2018 12:08:47 +0000
Message-ID: <B2B2C448-938C-49FD-ADA6-D35C8E9F66F1@cnexlabs.com>
References: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
 <1523874332-6272-8-git-send-email-javier@cnexlabs.com>
 <62002f4f-bfca-03be-c54f-23b15223446b@lightnvm.io>
In-Reply-To: <62002f4f-bfca-03be-c54f-23b15223446b@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_457CFC07-E92E-4168-9173-8AEE28253AF5";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_457CFC07-E92E-4168-9173-8AEE28253AF5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Apr 2018, at 05.11, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 4/16/18 12:25 PM, Javier Gonz=C3=A1lez wrote:
>> Remove unnecessary indirection on the read path.
>=20
> Title and description are the same. Can you elaborate what changed
> since pblk_submit_io now directly can be returned, and doesn't have
> its return value rewritten to NVM_IO_ERR?
>=20

My bad - I assumed submit_io was giving NVM_ errors. I'll resend
returning NVM_IO_ERR - the indirection is still unnecessary (and it's
not used anywhere else in the code).

Javier

--Apple-Mail=_457CFC07-E92E-4168-9173-8AEE28253AF5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlrXNU0ACgkQIX4xUKFR
nnSKUA/+OTbeU+76Le3pvzM5zNIAsNhUY58fu9jPBVpYEbYgZX2C4ieY94K395az
dKAlSYF8aJ4ZQRKvgctyjXDHBJAj10c98n8cbz/i01Is3pw5uNsQWD3lnsFPUffe
Usrzt+mOXqkejATGDcpsYsL9vv9Hdjs8NweFsKDTkjc0SCEUnQBEy6Zd5QVyvYeB
A2z8OHrOJJ3i8c5wuAjpTO9zYaX88ZkSVNZJidj7wLa0bWtIrwoolClJg76rLth+
EHOa1mkvay5QhW/XeQa1sWbhcNuKl/L7X4wz9FXAphga92sFIYuWxT9Zdrm1qGGC
Q4ZTlSH7AjECNOxiLB77TedIz7ahwOiu5wfW8dS5Mk4VyjK7lxgMuPU0PdkVz8Oy
kJnIoqO/tyUFWXWfEGVj0CiQsN9sUaKHhz5hV4TtBP1S/DQH2bJVwUMrKX/goHuu
rXGas1/caijA4L6T5NECH92PI9Y9aQoHRCnYsm7slxuJSyrTpkMTqHDUJIV6lAZb
uyIBy+EqMrMTzpq+nLahZ9ZfKiudwi3Sp+4ouqypypCQhcrptA4n3gBvr/TmMxHa
ZloIbdj+I+zSPeyBW4LHozwzwkE7Z663uBi7h4rwiQpTZ34DsavQS7BbH+zBVO0L
MAz+xp32e6DOlksvQsc4aPl5f6vXnnQTMgOMnPLJUjbPKuxgHFA=
=H3sQ
-----END PGP SIGNATURE-----

--Apple-Mail=_457CFC07-E92E-4168-9173-8AEE28253AF5--
