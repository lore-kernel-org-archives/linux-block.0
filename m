Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam02on0050.outbound.protection.outlook.com ([104.47.36.50]:37232
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752486AbeBSLFV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Feb 2018 06:05:21 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 5/6] lightnvm: remove nvm_dev_ops->max_phys_sect
Date: Mon, 19 Feb 2018 11:05:17 +0000
Message-ID: <CE52AA06-A417-4BD6-BCED-EB4035FC6906@cnexlabs.com>
References: <20180215131200.3354-1-mb@lightnvm.io>
 <20180215131200.3354-6-mb@lightnvm.io>
 <918E7340-05D7-4E2F-BC43-2B81D435C3C6@cnexlabs.com>
 <899e5ed5-4bf7-666a-d756-d86420cf9c9e@lightnvm.io>
In-Reply-To: <899e5ed5-4bf7-666a-d756-d86420cf9c9e@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D5BBF0B6-537F-450C-B8B7-2BDDE0C756A4";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_D5BBF0B6-537F-450C-B8B7-2BDDE0C756A4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 19 Feb 2018, at 08.31, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/16/2018 07:48 AM, Javier Gonzalez wrote:
>>> On 15 Feb 2018, at 05.11, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> The value of max_phys_sect is always static. Instead of
>>> defining it in the nvm_dev_ops structure, declare it as a global
>>> value.
>>>=20
>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>> ---
>>> drivers/lightnvm/core.c          | 28 +++++++---------------------
>>> drivers/lightnvm/pblk-init.c     |  9 ++++-----
>>> drivers/lightnvm/pblk-recovery.c |  8 ++------
>>> drivers/nvme/host/lightnvm.c     |  5 +----
>>> include/linux/lightnvm.h         |  5 ++---
>>> 5 files changed, 16 insertions(+), 39 deletions(-)
>> The patch looks good, but I have a question. If a target implements =
the
>> scalar interface, then it will not be limited to 64 lbas/ppas and it
>> will not make sense to split the bio base don this value. In fact, it
>> looks like in time, we will move to a scalar interface in the 2.0 =
path
>> to align with the zoned interface, so this value will be dependent on
>> whether the target is using the scalar or vector interface.
>=20
> Both read/write and vector interface will coexist. I am only removing
> what is hardwired into the specification.
>=20
> The read/write interface has always been able issue more than 64 LBAs,
> it is instead limited by what the hardware reports its max transfer
> size to be.
>=20

Exactly. I was thinking of a similar mechanism for the vector interface
to simplify integration with the scalar interface and avoid having an
if/else for what we now call max_phys_sect.

I guess we can wait and see what the code looks like when we adapt pblk.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>

Javier

--Apple-Mail=_D5BBF0B6-537F-450C-B8B7-2BDDE0C756A4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqKr2sACgkQIX4xUKFR
nnQkJQ//adk6w3jU1du8PM+to5WjuCwafd+lEUhE+sFIaqhP28IwuRpAlanIt1I8
24W3T7Iy9Zw/gDx8KwXTuOV3wIbxGMRyxk/2dD00u18L8VssQkVhpooZmuSWgrbs
Otf80oIkFQeiK0YarD82IfM7Wn/fzJSLtidq9d/MZRBl7S4xswZkNyzqRJr4Snwz
vcqoMb9gKtEmcEz06peK+bwbpyGWKe4vTgdDZF2vBfyyrsEV52f66kuFTlK1uW9S
WVe4qfN1pJ9ngWSJLPtbf/UOkDtjbqH2we5Ydh+oVQLdMLP+HxkfyKaa0y1cbLs9
xAaRyVCP0HPtEKk00C4l06UYh5oq60AvhnMnG1nKTEvxEbXXEwa0OZZQuJm+4m33
LV2LUA/z+rENmC4eH5MOAiPsAy2xXlP4PIyOBxsqm2xK1IMn23hMtxtluQdSlUgj
TUxlYxjVlKIk5hOmaVMIUWNUGcc+gsVAoyEZTaiHn5sTt7gV9bRZe0T6uDUybc9J
KYpZdnjLyRUput+t91x9//7y+6cH7z8iRskSV3iU5QnGKZvwKLZBDC+mZcNEKk6f
9+lxEPgiLESa4SsjAoD0TAtaNxC6a+iKDYrkFhi6KY6cl/QnyJ7pdtLP6EICIxd7
I7iHFaspxG853oGHyR5ZTVvUNpik54+psp05eTZ3L9ygPZUF3Dg=
=EimB
-----END PGP SIGNATURE-----

--Apple-Mail=_D5BBF0B6-537F-450C-B8B7-2BDDE0C756A4--
