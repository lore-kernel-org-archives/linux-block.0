Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam01on0046.outbound.protection.outlook.com ([104.47.32.46]:13976
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751165AbeBZS1Q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Feb 2018 13:27:16 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V3 00/19] lightnvm: pblk: implement 2.0 support
Date: Mon, 26 Feb 2018 18:27:13 +0000
Message-ID: <49DA8C17-0960-4EBF-9FA7-364DE5EAF405@cnexlabs.com>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
 <93f1a727-55bf-ff7c-bc05-70cc9f5f9f27@lightnvm.io>
 <87859168-A64E-4FF6-9F7E-174A903704D0@cnexlabs.com>
 <398381af-7c17-4e57-1d07-f50051c05430@lightnvm.io>
In-Reply-To: <398381af-7c17-4e57-1d07-f50051c05430@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_BE59A5B0-5C13-4AC6-BDDB-7884027188C8";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_BE59A5B0-5C13-4AC6-BDDB-7884027188C8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 26 Feb 2018, at 19.24, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/26/2018 07:21 PM, Javier Gonzalez wrote:
>>> On 26 Feb 2018, at 19.19, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 02/26/2018 02:16 PM, Javier Gonz=C3=A1lez wrote:
>>>> # Changes since V2:
>>>> Apply Matias' feedback:
>>>>  - Remove generic nvm_id identify structure.
>>>>  - Do not remap capabilities (cap) to media and controlled =
capabilities
>>>>    (mccap). Instead, add a comment to prevent confusion when
>>>>    crosschecking with 2.0 spec.
>>>>  - Change maxoc and maxocpu defaults from 1 block to the max number =
of
>>>>    blocks.
>>>>  - Re-implement the generic geometry to use nvm_geo on both device =
and
>>>>    targets. Maintain nvm_common_geo to make it easier to copy the =
common
>>>>    part of the geometry (without having to overwrite =
target-specific
>>>>    fields, which is ugly and error prone). Matias, if you still =
want to
>>>>    get rid of this, we can do it.
>>>=20
>>> I do, the variables should go directly in nvm_geo. Thanks.
>> Ok. Is the rest ok with you?
> I'll go through it when the rebase is posted. Most of the patches is
> dependent on the first patch.

As it is now, it will be basically %s/geo->c.X/geo->X/g. If you can look
at the first patch now, I can put all comments in a single version more,
instead of going through one extra cycle...



--Apple-Mail=_BE59A5B0-5C13-4AC6-BDDB-7884027188C8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqUUX4ACgkQIX4xUKFR
nnS7UA//SC+FR9+b80VmVfi/OmtiDU2KXCIR4C9Qk5TgZyPdxgfSzqRZ5zFj5O9s
gEGpQ2sRxpejDzuYfMhkj/9osTwuFg2fvM9a6208ziR5A1R5+w6ZAMgfaNPIBXJ6
bwO7MFCDt3Pk/0ZFQ1iqRVsv+T+kXWNmH4FAVD2gvFsjETuEEzLe2dtm5TMC1eqC
dAqkDxwpDb8u1FXo5nFrGDGV3ko2kYRC6NAKPfMO0eskmxiFvrvoUutkR3UGZLEz
KBBd6IhvKNQ5KO9eqc2RnKGfeKJKzrgGT0HudPOk1wFxlG5Jq3eBfr36oDQnLDpF
9jPJC3hjpjPRFkpgHE4CdgIIXh4l2qJSHicqpe92vY7H/hhDX+lrS39D7aXUZRxv
weiskUqwiZKkVTt/DHY733DRnPqe8l1gfY0ZSFcwc59xrwyfeQQHxKVX8S7IDynS
6u0rl+q/AIsMzFSuhdX7t6qSxleMnxPLHVNokitntJYyoR6/N68bIRinc6ilJmtX
0FQhgXgs/j0geUV3CwCKkjFFHay2ZX9EU4w8b0thLlnHx+UD5ypSpXMqgc+pLI/4
+R5NzZIG4+KdvLdpW6zr/k7x2/i/UX2BDhXZtEvoQC96OQ4QxwJA7hZY4h2DRekl
SLB8PUZepVhucdrEo/h9gwL2l1BHFMOF4iAWmaAU6wERPe4B54w=
=xjFZ
-----END PGP SIGNATURE-----

--Apple-Mail=_BE59A5B0-5C13-4AC6-BDDB-7884027188C8--
