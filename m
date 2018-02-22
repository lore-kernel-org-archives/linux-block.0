Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0065.outbound.protection.outlook.com ([104.47.34.65]:21792
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751657AbeBVHzS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 02:55:18 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 08/20] lightnvm: complete geo structure with maxoc*
Date: Thu, 22 Feb 2018 07:55:16 +0000
Message-ID: <F70FB36A-967C-4B37-8037-C550249A0C3B@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-9-git-send-email-javier@cnexlabs.com>
 <5e2948ed-19a8-7bd5-6c50-df37a1454d16@lightnvm.io>
In-Reply-To: <5e2948ed-19a8-7bd5-6c50-df37a1454d16@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_46920EEA-63A4-4E90-9A8C-FC633EAEE95A";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_46920EEA-63A4-4E90-9A8C-FC633EAEE95A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 22 Feb 2018, at 08.45, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/21/2018 10:26 AM, Javier Gonz=C3=A1lez wrote:
>> Complete the generic geometry structure with the maxoc and maxocpu
>> felds, present in the 2.0 spec.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/nvme/host/lightnvm.c | 4 ++++
>>  include/linux/lightnvm.h     | 2 ++
>>  2 files changed, 6 insertions(+)
>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>> index cca32da05316..9c1f8225c4e1 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -318,6 +318,8 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 =
*id,
>>  	dev_geo->c.ws_min =3D sec_per_pg;
>>  	dev_geo->c.ws_opt =3D sec_per_pg;
>>  	dev_geo->c.mw_cunits =3D 8;		/* default to MLC safe =
values */
>> +	dev_geo->c.maxoc =3D dev_geo->all_luns;	/* default to 1 chunk =
per LUN */
>> +	dev_geo->c.maxocpu =3D 1;			/* default to 1 =
chunk per LUN */
>=20
> One can't assume that it is 1 open chunk per lun. If you need this for =
specific hardware, make a quirk for it.
>=20

Which default you want for 1.2 if not specified then? I use 1 because it
has been the implicit default until now.

Javier

--Apple-Mail=_46920EEA-63A4-4E90-9A8C-FC633EAEE95A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqOd2EACgkQIX4xUKFR
nnTrzw//TBAoR1C/1TIN5ZWGevvG9ySmoxeqmG6FIZQ5PAOHUnHz9NtF3Rk3LEra
T4qmH7vm4mr6Hlaqquca+LdXpX2QAzWEr39v8Xh0RDYK5ygx7cPYaijoYkoaQG5o
Meil3lVMBpTg39rWNhOIVRjYYCBykEDGdAhgWdAfSrwfaWkeZ/K3+m6E+fXNllTJ
tcKvRSZDpKl1V5wLAdSgywNTbO6QOf63MzhFQ2N4IbLxeHdu8+0EHArwTq/zZ4S7
sfO5kbDs/y3G1Qr1mB2oHoTxEiNDcXjKIfwzCq3oOdtFmkat8GhPRbHeLJl7h4JF
vfAZh120+WXb9z6xCumPspPqNXcsaW24G4y6S5he+xiwVC+RzNt6oHLC3xIf4lpA
yJwogm0M8vQQHXhZYZRasoOodJ7aURlmmzt6j2UWVNwrJ9XoQa1Uxw6Ahoq3adSg
9YTlomaD9CVN1h0n3pKPZJ2SG3G9gOJV24BgcKHQEmb9w0SoCzSyBbPr3HOYcWTs
JfOQ2wp2amtHIlM6C535/qjdGzuZMKpfie8UOvXKyRpaRxMJptAQPmfG8Ka/zJxz
99zIC+6c+N3Pe2lc1jq3Z0EYg4vRI+O8SwOH7fTCGsnzljp5ootbRYp5TYzfOouW
7hkqB6HOIfw0LTPP3eHLf3uYk6v9vtuueFipNkAoTF0aqWS1M+c=
=NDck
-----END PGP SIGNATURE-----

--Apple-Mail=_46920EEA-63A4-4E90-9A8C-FC633EAEE95A--
