Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0041.outbound.protection.outlook.com ([104.47.42.41]:59784
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752644AbeBVKDd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 05:03:33 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 08/20] lightnvm: complete geo structure with maxoc*
Date: Thu, 22 Feb 2018 10:03:30 +0000
Message-ID: <6AB3CE71-8BC1-4D6E-A379-A7CFDF61B7FE@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-9-git-send-email-javier@cnexlabs.com>
 <5e2948ed-19a8-7bd5-6c50-df37a1454d16@lightnvm.io>
 <F70FB36A-967C-4B37-8037-C550249A0C3B@cnexlabs.com>
 <ec5d6c53-c3a1-7d66-9db7-407a519f0feb@lightnvm.io>
 <BA0987F5-AEA5-43BD-A065-3BF72E9A8676@cnexlabs.com>
 <9c8c1b50-0c8e-36cd-0f1d-a07753567f43@lightnvm.io>
In-Reply-To: <9c8c1b50-0c8e-36cd-0f1d-a07753567f43@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C6AE8225-AF1E-4834-A51E-2EB850D1EDDD";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_C6AE8225-AF1E-4834-A51E-2EB850D1EDDD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


Javier

> On 22 Feb 2018, at 11.00, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/22/2018 10:52 AM, Javier Gonzalez wrote:
>>> On 22 Feb 2018, at 10.45, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 02/22/2018 08:55 AM, Javier Gonzalez wrote:
>>>>> On 22 Feb 2018, at 08.45, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>> On 02/21/2018 10:26 AM, Javier Gonz=C3=A1lez wrote:
>>>>>> Complete the generic geometry structure with the maxoc and =
maxocpu
>>>>>> felds, present in the 2.0 spec.
>>>>>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>>>>>> ---
>>>>>>  drivers/nvme/host/lightnvm.c | 4 ++++
>>>>>>  include/linux/lightnvm.h     | 2 ++
>>>>>>  2 files changed, 6 insertions(+)
>>>>>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>>>>>> index cca32da05316..9c1f8225c4e1 100644
>>>>>> --- a/drivers/nvme/host/lightnvm.c
>>>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>>>> @@ -318,6 +318,8 @@ static int nvme_nvm_setup_12(struct =
nvme_nvm_id12 *id,
>>>>>>  	dev_geo->c.ws_min =3D sec_per_pg;
>>>>>>  	dev_geo->c.ws_opt =3D sec_per_pg;
>>>>>>  	dev_geo->c.mw_cunits =3D 8;		/* default to =
MLC safe values */
>>>>>> +	dev_geo->c.maxoc =3D dev_geo->all_luns;	/* default to 1 =
chunk per LUN */
>>>>>> +	dev_geo->c.maxocpu =3D 1;			/* =
default to 1 chunk per LUN */
>>>>>=20
>>>>> One can't assume that it is 1 open chunk per lun. If you need this =
for specific hardware, make a quirk for it.
>>>> Which default you want for 1.2 if not specified then? I use 1 =
because it
>>>> has been the implicit default until now.
>>>=20
>>> INT_MAX, since it then allows the maximum of open chunks. It cannot =
be assumed that other 1.2 devices is limited to a single open chunk.
>> So you want the default to be that all blocks on the device can be
>> opened at the same time. Interesting... I guess that such a SSD will
>> have a AA battery attached to it, but fine by me if that's how you =
want
>> it.
>=20
> I feel you're a bit sarcastic here. One may think of SLC and other =
memories that does one-shot programming. In that case no caching is =
needed, and therefore power-caps can be limited on the hardware.

Sure. Hope people move to 2.0 then for all >SLC memories out there,
otherwise we'll see a lot of quirks coming in. Thought we wanted to be
generic.

>=20
>> Assuming this, can we instead set it to the reported number of =
chunks,
>> since this is the hard limit anyway.
>=20
> Works for me.

Cool. I'll add this to the next version.

Javier

--Apple-Mail=_C6AE8225-AF1E-4834-A51E-2EB850D1EDDD
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqOlXAACgkQIX4xUKFR
nnSHwQ/9EgDfYkQ43KyFO1sVLKqWAeOS6c44+Pq9/ULg3XWN/Aw1LTUOIjNW8/Qf
k9rU4TTqtY9H6OLn2qSqq3T0qiUTNeQ0LgDFRWw7ipnJqU+g7umT53MHPyxuYCWB
jQOU/4o95tw4BXtYyo8eH6BijUM/7Mhx+o4FDEjYzsP3yIhJ92l1JO5ql1HRsIhp
wgUyXP2WVTO9d+RdYzCvR8zuPFUVkG+94T+5JAaAP4b9yCqZxRpZ8HRkDkAyHE2c
ab6FgoLnno/ut5oWp7c/DbeAX+QQCLxxhkxdsW2HiCQ9OQhhVyeqqhYO2daVH21p
9i6P0/o+oL49FL7RTkHf1Kfm4tgaQV/yjU5vV0FI+IkOXAdeyAIzDy0i0SXKk8KL
8Q3tSK4x1sF+ni6FyYVfbplkUpJa7MvZDMUkoaa3xcdaIxheDAYD7oAIB5FW1qbt
7Rv7WqaZFogYLkTb5ysCQoUH4EkK195Kky+FIdoU74Yk1ZRA8v1cOXG9nRxYRKbt
O3fypgoYiJdZHhQQH9/WM6FnlNr9Qk88SgdLpXXSalSsv9x+wLzd0/s/57+p4CMM
5NwDWRkP/bz5uTsfLg+sGwPBsoIPO+6HKyleN6gVJ1akLNMuo4Msvh80zTIRkHY2
lZTy2bnCM0pl52C29M7S9tdWqyK6WM0aCLgeDAYjuImcuyYiZK0=
=xMiB
-----END PGP SIGNATURE-----

--Apple-Mail=_C6AE8225-AF1E-4834-A51E-2EB850D1EDDD--
