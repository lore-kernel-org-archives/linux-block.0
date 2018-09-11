Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0050.outbound.protection.outlook.com ([104.47.40.50]:60544
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726563AbeIKQ3W (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 12:29:22 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Javier Gonzalez <javier@cnexlabs.com>
CC: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] lightnvm: do no update csecs and sos on 1.2
Date: Tue, 11 Sep 2018 11:30:23 +0000
Message-ID: <9C271B60-C421-4C9B-99B6-C30B65494095@cnexlabs.com>
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
 <1535537370-10729-3-git-send-email-javier@cnexlabs.com>
 <4ac29eb8-65bf-f733-d196-80c5bb41876c@lightnvm.io>
 <7493E737-A7F5-4F86-A91D-8BA01755714D@cnexlabs.com>
In-Reply-To: <7493E737-A7F5-4F86-A91D-8BA01755714D@cnexlabs.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_95538BEF-79E2-490F-B1AA-9EEF19F4197B";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_95538BEF-79E2-490F-B1AA-9EEF19F4197B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 11 Sep 2018, at 10.50, Javier Gonzalez <javier@cnexlabs.com> wrote:
>=20
>> On 7 Sep 2018, at 12.28, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>>=20
>> On 08/29/2018 12:09 PM, Javier Gonz=C3=A1lez wrote:
>>> In the OCSSD 2.0 spec., the sector and metadata sizes are reported =
though
>>> the standard nvme identify command. Thus, the lightnvm subsystem =
needs
>>> to update this information on the geometry structure on bootup.
>>> Since 1.2 devices report these values on the OCSSD geometry =
identify,
>>> avoid this update is it is unnecessary and can also corrupt the =
geometry
>>> if the devices does not report the nvme sizes correctly (which is =
not
>>> required by the OCSSD 1.2 spec either) >
>>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>>> ---
>>> drivers/nvme/host/lightnvm.c | 3 +++
>>> 1 file changed, 3 insertions(+)
>>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>>> index 5bfa354c5dd5..33ed09f8410e 100644
>>> --- a/drivers/nvme/host/lightnvm.c
>>> +++ b/drivers/nvme/host/lightnvm.c
>>> @@ -980,6 +980,9 @@ void nvme_nvm_update_nvm_info(struct nvme_ns =
*ns)
>>> 	struct nvm_dev *ndev =3D ns->ndev;
>>> 	struct nvm_geo *geo =3D &ndev->geo;
>>> +	if (geo->version =3D=3D NVM_OCSSD_SPEC_12)
>>> +		return;
>>=20
>> The lba format sizes are not explicit in 2.0 either. For a conforming =
drive, it should implement the NVM Command Set and expose the LBA format =
correctly. Although, I do get your incentive, and if it is okay with =
you, I'll reword the commit message to this and apply it?:
>>=20
>> "1.2 devices exposes their data and metadata size through the =
separate
>> identify command. Make sure that the NVMe LBA format does not =
override
>> these values."
>=20
> Sounds good. I'll resend either way as I rebased on top of =
for-4.20/core
> - you can change the commit as you think it suits.

Since Igor will send a patch for the OOB, can you pick this up
separately? No changes needed after rebase.

Thanks,
Javier

--Apple-Mail=_95538BEF-79E2-490F-B1AA-9EEF19F4197B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluXp0wACgkQIX4xUKFR
nnQ8MBAAzhUR+BsO/PngkgG4zefDhQVmdxqD9o8fkJTWQ7lkhREHhhrXIrzDc0b1
BBASza3GFUL2frk0/vpLAhOHAbX/d0q8TgEriOiJRzdscusXBlvIiLE2oRht318p
x4FY+GrN9n5ZLWBooT7mjsfFK0zgHPZB8Q9s57MmbpIDR//EAbd7Fxha5qZY9Hxk
Q+VP/64xeK5dGD978FYlVdU20q6C/IxQuWBNyRwtq2Zu8jYAbIfYvdo3hc17LMtK
ZLLAmuvmiWOgux51CFDfpfKzVSNdHk1IOqFKjVu9yIqONCrrNWeWew6sLlI2Lw32
U4i44MHW80Kge9Xq7r4Cwd+V1EGyAVE4a63okWixAOHWP7a+DimDfteKit/1Itd8
ZzKq3VJnyVF1cDCejGI5/tp0U1fjVed9R/AuvSo/4/sZdW1pz/y23V+MQufQQqod
dnlBoHzOzBVdsRbMmjDUezLx46WyFmSDvJJ9jsc1chANyeGY5LKmMUtRJ/lq+7Hj
Wj2G80lXTTk/fpMbrAaDca+XsTvjHPqr4HctGn2Ppc/FUct31em8ZTMoXh7snnDY
SUgZItM2b2sYq9dRDHKEOsN+hFjfDYQpbc+8WRaVMJil7EBGSZvy1PJvOsyKozz0
tnTIFTIg1bIw7hnlSaLviW4f08DL6GUJp9t3rPp2ts7OXjfwDZ8=
=J81c
-----END PGP SIGNATURE-----

--Apple-Mail=_95538BEF-79E2-490F-B1AA-9EEF19F4197B--
