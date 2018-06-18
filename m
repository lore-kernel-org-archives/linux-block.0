Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam01on0048.outbound.protection.outlook.com ([104.47.32.48]:4807
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934470AbeFRO3m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jun 2018 10:29:42 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "michal.sorn@intel.com" <michal.sorn@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>
Subject: Re: [PATCH 5/5] lightnvm: pblk: Disable interleaved metadata in pblk
Date: Mon, 18 Jun 2018 14:29:37 +0000
Message-ID: <5F064E8B-56A2-45AD-BEA5-A5C115995D0C@cnexlabs.com>
References: <20180615222706.3801-1-igor.j.konopko@intel.com>
 <20180615222706.3801-6-igor.j.konopko@intel.com>
 <5977e8b8-223b-3d15-76df-82c827d6775a@lightnvm.io>
In-Reply-To: <5977e8b8-223b-3d15-76df-82c827d6775a@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_998AFD64-B10A-4A1C-9005-3232A520E05F";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_998AFD64-B10A-4A1C-9005-3232A520E05F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 16 Jun 2018, at 21.38, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 06/16/2018 12:27 AM, Igor Konopko wrote:
>> Currently pblk and lightnvm does only check for size
>> of OOB metadata and does not care wheather this meta
>> is located in separate buffer or is interleaved with
>> data in single buffer.
>> In reality only the first scenario is supported, where
>> second mode will break pblk functionality during any
>> IO operation.
>> The goal of this patch is to block creation of pblk
>> devices in case of interleaved metadata
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> ---
>>  drivers/lightnvm/pblk-init.c | 6 ++++++
>>  drivers/nvme/host/lightnvm.c | 1 +
>>  include/linux/lightnvm.h     | 1 +
>>  3 files changed, 8 insertions(+)
>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>> index 5eb641da46ed..483a6d479e7d 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -1238,6 +1238,12 @@ static void *pblk_init(struct nvm_tgt_dev =
*dev, struct gendisk *tdisk,
>>  		return ERR_PTR(-EINVAL);
>>  	}
>>  +	if (geo->ext) {
>> +		pr_err("pblk: extended (interleaved) metadata in data =
buffer"
>> +			" not supported\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>>  	pblk =3D kzalloc(sizeof(struct pblk), GFP_KERNEL);
>>  	if (!pblk)
>>  		return ERR_PTR(-ENOMEM);
>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>> index 670478abc754..872ab854ccf5 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -979,6 +979,7 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
>>    	geo->csecs =3D 1 << ns->lba_shift;
>>  	geo->sos =3D ns->ms;
>> +	geo->ext =3D ns->ext;
>>  }
>>    int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int =
node)
>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>> index 72a55d71917e..b13e64e2112f 100644
>> --- a/include/linux/lightnvm.h
>> +++ b/include/linux/lightnvm.h
>> @@ -350,6 +350,7 @@ struct nvm_geo {
>>  	u32	clba;		/* sectors per chunk */
>>  	u16	csecs;		/* sector size */
>>  	u16	sos;		/* out-of-band area size */
>> +	u16	ext;		/* metadata in extended data buffer */
>>    	/* device write constrains */
>>  	u32	ws_min;		/* minimum write size */
>=20
> I think bool type would be better here. Can it be placesd a bit down, =
just over the 1.2 stuff?
>=20
> Also, feel free to fix up the checkpatch stuff in patch 1 & 3 & 5.

Apart from Matias' comments, it looks good to me.

Traditionally, we have separated subsystem and target patches to make
sure there is no coupling between pblk and lightnvm, but if Matias is ok
with starting having patches covering all at once, then good for me too.

Javier


--Apple-Mail=_998AFD64-B10A-4A1C-9005-3232A520E05F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlsnwcwACgkQIX4xUKFR
nnRgHRAAoBhvbDX8uOZz1v8tHL8bRgcJ+5Br/5hXSAS0pobN87d3bUYQwNRIGpyM
0QwH4RerOI1J/PfTaPmDP4bJpiCu2qI1N7Eg2sLEhg9Ad52Oj03JVNwsd9dvj0H3
qD9KY8ycThAdv1DaRqwfjlvVKzGTZS2ZLR+C+93aDh+IxbNy6qy9LABY5uC4q10L
PbvBx7LkoRvk2sV5yrYwBFpemHpUgTX72XOltDZqE6jxGj6RSospex1MW4OiyscK
RBbhtWwjrtotgu1O9zfx2bRmLyNst/rsYEAH4EAvm0nRxebHh4aw3uhz5DxYWmCw
vdaYeYRI8MtTW18VM+foIWElycno9pc2odOxbJoajseZY8+rkqCEL2yZs7Ec0AtE
u8ycdXDCeHIPIbQDdxBf7UakuROHyIrqHngT11P9aHcWd+6O8QMppXHr4uqQ881Q
2D8VvQgGPcbDA18U9VjBC2S7oR6WRn7kN2sQhwMlmaPr6BSkoV5muTzCnAul9NB9
nUBNAKzFkMkvcV6Li7p7JKYWOUPhZXNsBzqovngi/79b4Phv7/XfPlYMCGA1glen
Dt+HzUrSkL23LPdhyA5BvNaf3DBvt2T40GPJo2ACsrB4ukhRi0Fg6ZhU7f6GkTMh
5paaoqMqIxE+kLnnUbc+qHh0ynpRVT2OdcoY6tJAd0i6jHuQxFw=
=SeYo
-----END PGP SIGNATURE-----

--Apple-Mail=_998AFD64-B10A-4A1C-9005-3232A520E05F--
