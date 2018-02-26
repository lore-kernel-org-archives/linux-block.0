Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0055.outbound.protection.outlook.com ([104.47.42.55]:6821
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751061AbeBZSVd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Feb 2018 13:21:33 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V3 00/19] lightnvm: pblk: implement 2.0 support
Date: Mon, 26 Feb 2018 18:21:30 +0000
Message-ID: <87859168-A64E-4FF6-9F7E-174A903704D0@cnexlabs.com>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
 <93f1a727-55bf-ff7c-bc05-70cc9f5f9f27@lightnvm.io>
In-Reply-To: <93f1a727-55bf-ff7c-bc05-70cc9f5f9f27@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_18179592-2D2E-4B0F-9049-D187C12F9DBB";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_18179592-2D2E-4B0F-9049-D187C12F9DBB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 26 Feb 2018, at 19.19, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/26/2018 02:16 PM, Javier Gonz=C3=A1lez wrote:
>> # Changes since V2:
>> Apply Matias' feedback:
>>  - Remove generic nvm_id identify structure.
>>  - Do not remap capabilities (cap) to media and controlled =
capabilities
>>    (mccap). Instead, add a comment to prevent confusion when
>>    crosschecking with 2.0 spec.
>>  - Change maxoc and maxocpu defaults from 1 block to the max number =
of
>>    blocks.
>>  - Re-implement the generic geometry to use nvm_geo on both device =
and
>>    targets. Maintain nvm_common_geo to make it easier to copy the =
common
>>    part of the geometry (without having to overwrite target-specific
>>    fields, which is ugly and error prone). Matias, if you still want =
to
>>    get rid of this, we can do it.
>=20
> I do, the variables should go directly in nvm_geo. Thanks.

Ok. Is the rest ok with you?

Javier

--Apple-Mail=_18179592-2D2E-4B0F-9049-D187C12F9DBB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqUUCgACgkQIX4xUKFR
nnQkRRAAuLSn0BX0JlOuYOwal+a6Yjd5abQx/xU8J/U+Eo0noEMWfuJbFjX/JE7u
qFMklCX4fbmCc5hHWEfN/oUysebOLEEetVJnErfuWgrcumbYC7SvhYKIsjk+4Cwr
c9j7dpeY4HM8rQGHO3K9gMtUBzA3ocjIuQ0j5LNTlGVLpz3sjCdf4ZBrcIxjVCQT
HtUQiCcXsbQshTSMd5TlblP4M8Cu1bHhstYn36QaNCNFokUjUsvL8ioFxyVq5E8u
ncmL2fHJqQVM2VjDWSYsbLjtHjc6TVVlt2n9u/uTxdAnKburxOu+SlKXiCx1bbqc
8HiqPBO+TFMeM0OKNNYIRXyyPmwJzu6j4ol7Rf2tYrAlcHEGm2zFnQJJKge9Gz2+
Yn5sT7a7Mq3MAgXUjGJ1FzkKK3Cxwxj5KNXt9ro5XbuCDi0VMpz4HxQJ8OvXC9hi
nR7sAhwe+bdAqeGXyi3AdnwWIuxmHj9QCpQdDklz4mhOWnAF3vIrAu70+N7jMyUG
sqWIgIX8yd+BWWHHZ12EA90JqMCjGmioFj4jT4awE6Cs829U/4uU/C4PL/Py+ykG
4hBy6jxC0CZoO0Jess67nGkTCa8lwQ1DbpwScs4QkKSj/XAH2X05Zewi3l1PqsLV
93hWskR619u3YMh27tUavh0FM4BkF5yPz05DmMYYpbXcGZuxpuc=
=Nsjq
-----END PGP SIGNATURE-----

--Apple-Mail=_18179592-2D2E-4B0F-9049-D187C12F9DBB--
