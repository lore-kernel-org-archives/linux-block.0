Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-cys01nam02on0083.outbound.protection.outlook.com ([104.47.37.83]:20150
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727245AbeH2Xz4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 19:55:56 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: "Konopko, Igor J" <igor.j.konopko@intel.com>
CC: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] lightnvm: pblk: support variable OOB size
Date: Wed, 29 Aug 2018 19:57:25 +0000
Message-ID: <26B5331A-D040-4AB7-BB7C-5752A76F5515@cnexlabs.com>
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
 <106d492e-4f09-7af5-d89a-75c204f3da38@intel.com>
In-Reply-To: <106d492e-4f09-7af5-d89a-75c204f3da38@intel.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_4CECD028-685F-4020-98D7-91CACBD021B3";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_4CECD028-685F-4020-98D7-91CACBD021B3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 29 Aug 2018, at 16.51, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
>=20
>=20
> On 29.08.2018 12:09, Javier Gonz=C3=A1lez wrote:
>> This patchset adds pblk support for variable metadata sizes on the =
out
>> of bound area.
>> Igor, Marcin, you sent a patch some time ago implementing a similar
>> functionality, but it never got re-posted after review. Can you test
>> this and see if it works for your case? I did not implement support =
for
>> outlined metadata for the case where the reported OOB area is 0. It
>> should be pretty simple to do that on top of these patches though.
>=20
> Sure, we will test that and let you know. I was busy last time and due
> to that I never repost it. I will do this on top of your patches,
> hopefully soon.
>=20

Thanks Igor, this would be great.

--Apple-Mail=_4CECD028-685F-4020-98D7-91CACBD021B3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluG+qMACgkQIX4xUKFR
nnR0NxAAiVQXJKYU17Nm6QtFwZyBfRovomCllDAImTjYLcJ7hMwyj0WOuiJkR4wl
vovKkkrf75h66FP3eDWdkLMFBR2WcFig+W0VXXZKY7UhNrH4acoKyVgeph7Q9wB+
vgw7v6w56dqXsQC2Uca1k+9q/zgEaK0Z9dLAVmGbtqnBPTSnbstaUDnaFaYfq5S+
mEeNowMY5z1lcFPwhGUkl93eQuy7MdyaMDYBPKdXDHAmkEh5VY8FPmBjUk5zPMD6
0q7xuR/qZByky05pndKTJArHgvsSTKu3Gb7HaHQvUl9EzmuGel8BScHH0xd/Pup5
2MsQiD4FdnjZJmF37E7arLXbWwlQq1f3oCl99Er60KgEzQ8T6Q4zRJpAvoeLopfy
DPOwUmqgDKe0RqOzb2jhPdB5ZaibswfEfi8RSequFDGNXRjikWWnkThZt/wmc/jC
bmCawhhQ3lrM7bI+htOmNVWBitNaL0Vr4Y4U4OiQ7NebUPGEeO8s0+2sQm1mWGbv
K+5QIAgDIzdqPtLTblvhgZFRA7WKVj7z8lMR1cUeZ3IOmI6NqEKEbe0SssriXcNK
PxjUX8QiZ94awBXRTOr5s0wgtmQtU0uSwWMYOqhiqcMBVlhLFEYThDzQTAoImpTI
OBof8SGdnmB2vgy4/xC5y8i+RgxanyUD6twwfXBN0Qzp/VoZA4A=
=zYZi
-----END PGP SIGNATURE-----

--Apple-Mail=_4CECD028-685F-4020-98D7-91CACBD021B3--
