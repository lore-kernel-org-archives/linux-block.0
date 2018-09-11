Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr720043.outbound.protection.outlook.com ([40.107.72.43]:17821
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbeIKNsu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 09:48:50 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] lightnvm: do no update csecs and sos on 1.2
Date: Tue, 11 Sep 2018 08:50:15 +0000
Message-ID: <7493E737-A7F5-4F86-A91D-8BA01755714D@cnexlabs.com>
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
 <1535537370-10729-3-git-send-email-javier@cnexlabs.com>
 <4ac29eb8-65bf-f733-d196-80c5bb41876c@lightnvm.io>
In-Reply-To: <4ac29eb8-65bf-f733-d196-80c5bb41876c@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_0CFEC981-5C7B-4091-A588-A47E99D88670";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_0CFEC981-5C7B-4091-A588-A47E99D88670
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 7 Sep 2018, at 12.28, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/29/2018 12:09 PM, Javier Gonz=C3=A1lez wrote:
>> In the OCSSD 2.0 spec., the sector and metadata sizes are reported =
though
>> the standard nvme identify command. Thus, the lightnvm subsystem =
needs
>> to update this information on the geometry structure on bootup.
>> Since 1.2 devices report these values on the OCSSD geometry identify,
>> avoid this update is it is unnecessary and can also corrupt the =
geometry
>> if the devices does not report the nvme sizes correctly (which is not
>> required by the OCSSD 1.2 spec either) >
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/nvme/host/lightnvm.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>> index 5bfa354c5dd5..33ed09f8410e 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -980,6 +980,9 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
>>  	struct nvm_dev *ndev =3D ns->ndev;
>>  	struct nvm_geo *geo =3D &ndev->geo;
>>  +	if (geo->version =3D=3D NVM_OCSSD_SPEC_12)
>> +		return;
>=20
> The lba format sizes are not explicit in 2.0 either. For a conforming =
drive, it should implement the NVM Command Set and expose the LBA format =
correctly. Although, I do get your incentive, and if it is okay with =
you, I'll reword the commit message to this and apply it?:
>=20
> "1.2 devices exposes their data and metadata size through the separate
> identify command. Make sure that the NVMe LBA format does not override
> these values."
>=20

Sounds good. I'll resend either way as I rebased on top of for-4.20/core
- you can change the commit as you think it suits.

Javier

--Apple-Mail=_0CFEC981-5C7B-4091-A588-A47E99D88670
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluXgcQACgkQIX4xUKFR
nnS1QRAAp9vhDsE8e4vNrjXa8GQlK6rrGLNb+P/7edeAbsRbQynhaWMLwaFBgkW2
sUE5ooCszzbZc4YneyRAzsgmSddnU7DrRlnH24Cc5ExnNvqPTLZG5Qz6dCrwbvMZ
dy51Y1cjhiymcpYH9mXBAiz4fzj+ZNx9Rbyr7NqLm2QAe8oVSvVQwoOJuuk4JEB/
p95KEJRdl2deKl5e4b2+7MqTQlQV5j6TWPOsY2jRd8kKXKfzxIH91TuGAmG4AgU5
/pV3i67+qcCFYHSSRsl0rsykZageIcVHm7cLWx35dFwRt0Xjd+lVZRrEFEcyrDaD
th/FlzygQuuikEcG+fpNGvi3RosJcTTxDMqIYz2rKePZ3pnYLXfI96Ll6do6C5Vh
nYmZ5s7eS0M7X1LoPcBq7zcSz4JnzFLgrmBu+KX4Isp9elLtJDJO6zBztDNaeuOW
yZDVxjW6GWfx4OM5msV32RB8ehEnKdIc32uSFQ4o4eMShtGpwXy93H1Bu0h+/TeK
b0IZp7KvUyGyQJrlkal2yQXSv+BijPKPgSZ1HZUpM/JYNT7GUHL+Ef2F+6IyvBoU
IjNfLvmMEIx/H9ypgXkUItPSbKnqw8FWmWszuqbrMoX7bwSroLthApwYKiImWamG
+dMzmQ+P9NdZw003K5cGCin64CoiQo2Lou/9c844kR+rzN5CRs0=
=WQLW
-----END PGP SIGNATURE-----

--Apple-Mail=_0CFEC981-5C7B-4091-A588-A47E99D88670--
