Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39977 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752549AbeBVHyA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 02:54:00 -0500
Received: by mail-wm0-f65.google.com with SMTP id t82so1820276wmt.5
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 23:53:59 -0800 (PST)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <B3E32D7E-E531-4399-89C4-080B5A28E17D@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_AE09ABC6-6D85-4425-A0F8-542D14AEA3DF";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 04/20] lightnvm: add minor version to generic geometry
Date: Thu, 22 Feb 2018 08:53:54 +0100
In-Reply-To: <abd2b8f4-58b6-c97e-58e2-e271aae1f4a0@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-5-git-send-email-javier@cnexlabs.com>
 <abd2b8f4-58b6-c97e-58e2-e271aae1f4a0@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_AE09ABC6-6D85-4425-A0F8-542D14AEA3DF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 22 Feb 2018, at 08.34, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/21/2018 10:26 AM, Javier Gonz=C3=A1lez wrote:
>> Separate the version between major and minor on the generic geometry.
>> Also, add a "subversion" entry to sysfs to expose the minor version
>> without breaking user space.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/core.c      |  4 ++--
>>  drivers/nvme/host/lightnvm.c | 25 ++++++++++++++++++++-----
>>  include/linux/lightnvm.h     |  3 ++-
>>  3 files changed, 24 insertions(+), 8 deletions(-)
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index 42596afdf64c..dc9ec6baff45 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -897,8 +897,8 @@ static int nvm_init(struct nvm_dev *dev)
>>  		goto err;
>>  	}
>>  -	pr_debug("nvm: ver:%u nvm_vendor:%x\n",
>> -				dev_geo->ver_id,
>> +	pr_debug("nvm: ver:%u.%u nvm_vendor:%x\n",
>> +				dev_geo->major_ver_id, =
dev_geo->minor_ver_id,
>>  				dev_geo->c.vmnt);
>>    	ret =3D nvm_core_init(dev);
>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>> index 598abba66f52..71b4ac57a668 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -296,7 +296,8 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 =
*id,
>>  	}
>>    	/* 1.2 spec. only reports a single version id - unfold */
>> -	dev_geo->ver_id =3D id->ver_id;
>> +	dev_geo->major_ver_id =3D id->ver_id;
>> +	dev_geo->minor_ver_id =3D 2;
>>    	dev_geo->nr_chnls =3D src->num_ch;
>>  	dev_geo->nr_luns =3D src->num_lun;
>> @@ -377,7 +378,14 @@ static void nvme_nvm_set_addr_20(struct =
nvm_addr_format *dst,
>>  static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
>>  			     struct nvm_dev_geo *dev_geo)
>>  {
>> -	dev_geo->ver_id =3D id->mjr;
>> +	dev_geo->major_ver_id =3D id->mjr;
>> +	dev_geo->minor_ver_id =3D id->mnr;
>> +
>> +	if (!(dev_geo->major_ver_id =3D=3D 2 && dev_geo->minor_ver_id =3D=3D=
 0)) {
>> +		pr_err("nvm: OCSSD version not supported (v%d.%d)\n",
>> +				dev_geo->major_ver_id, =
dev_geo->minor_ver_id);
>> +		return -EINVAL;
>> +	}
>>    	dev_geo->nr_chnls =3D le16_to_cpu(id->num_grp);
>>  	dev_geo->nr_luns =3D le16_to_cpu(id->num_pu);
>> @@ -913,7 +921,11 @@ static ssize_t nvm_dev_attr_show(struct device =
*dev,
>>  	attr =3D &dattr->attr;
>>    	if (strcmp(attr->name, "version") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->ver_id);
>> +		return scnprintf(page, PAGE_SIZE, "%u\n",
>> +						dev_geo->major_ver_id);
>> +	} else if (strcmp(attr->name, "subversion") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "%u\n",
>> +						dev_geo->minor_ver_id);
>>  	} else if (strcmp(attr->name, "media_capabilities") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.mccap);
>>  	} else if (strcmp(attr->name, "read_typ") =3D=3D 0) {
>> @@ -1055,6 +1067,7 @@ static ssize_t nvm_dev_attr_show_20(struct =
device *dev,
>>    /* general attributes */
>>  static NVM_DEV_ATTR_RO(version);
>> +static NVM_DEV_ATTR_RO(subversion);
>>  static NVM_DEV_ATTR_RO(media_capabilities);
>>    static NVM_DEV_ATTR_RO(read_typ);
>> @@ -1085,6 +1098,7 @@ static NVM_DEV_ATTR_12_RO(max_phys_secs);
>>    static struct attribute *nvm_dev_attrs_12[] =3D {
>>  	&dev_attr_version.attr,
>> +	&dev_attr_subversion.attr,
>>  	&dev_attr_media_capabilities.attr,
>>    	&dev_attr_vendor_opcode.attr,
>> @@ -1134,6 +1148,7 @@ static NVM_DEV_ATTR_20_RO(reset_max);
>>    static struct attribute *nvm_dev_attrs_20[] =3D {
>>  	&dev_attr_version.attr,
>> +	&dev_attr_subversion.attr,
>>  	&dev_attr_media_capabilities.attr,
>>    	&dev_attr_groups.attr,
>> @@ -1167,7 +1182,7 @@ int nvme_nvm_register_sysfs(struct nvme_ns *ns)
>>  	if (!ndev)
>>  		return -EINVAL;
>>  -	switch (dev_geo->ver_id) {
>> +	switch (dev_geo->major_ver_id) {
>>  	case 1:
>>  		return sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
>>  					&nvm_dev_attr_group_12);
>> @@ -1184,7 +1199,7 @@ void nvme_nvm_unregister_sysfs(struct nvme_ns =
*ns)
>>  	struct nvm_dev *ndev =3D ns->ndev;
>>  	struct nvm_dev_geo *dev_geo =3D &ndev->dev_geo;
>>  -	switch (dev_geo->ver_id) {
>> +	switch (dev_geo->major_ver_id) {
>>  	case 1:
>>  		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
>>  					&nvm_dev_attr_group_12);
>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>> index 18e3751b1632..5af0b8837095 100644
>> --- a/include/linux/lightnvm.h
>> +++ b/include/linux/lightnvm.h
>> @@ -242,7 +242,8 @@ struct nvm_common_geo {
>>  /* Device identified geometry */
>>  struct nvm_dev_geo {
>>  	/* device reported version */
>> -	u8	ver_id;
>> +	u8	major_ver_id;
>> +	u8	minor_ver_id;
>>    	/* full device geometry */
>>  	u16	nr_chnls;
>=20
> Looks fairly good to me. Did you consider putting in the major and
> minor version id into the version attribute? e.g., keep 1 as 1, and
> have version 2 be exposed as 2.0?
>=20

Yes, we can do that. I'll do the changes for the next version.


--Apple-Mail=_AE09ABC6-6D85-4425-A0F8-542D14AEA3DF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlqOdxIACgkQYx8FO3WZ
GMrdqhAAmIVIAO4znHtk5HpKGY4eRQbDEhgLxkQL7yjl5hQj1N/CyKmqlZnbWpU4
kuMbLjOuoTgzrCCqwe7fqbk3Lq6yDXfFikywiOaTrg3Is/qc9saR/uWnLnsikwAA
k8meTFG1+UjLUuQI1lZ7cnuobbv+Cgt8BQ899lVUtRdYZ002f3n5eOmSFyE6M56V
xjpsPrlhiDE/n3i+vj8SHOGaXZz73NeO6EN7j/ePw6gyMz+UKffZCtQJ3YQystG+
mPIIyEZUeersQbCcoK5xv7JwmC1yw+VEWqXSPD4TBFq2ik5PWu0LCwMdPkSo1dsj
8B/9bfhVRJhiRTQcKYAANcAGHiHnSj6dRfudXfygYbcPt2FIEasjrpVUAtBKKFRF
KOC0kVzgtKABzP9nU59qpr2RFB0Mpa37bBWxMoxY0cZl9ol1ouxoOJQgSAilZmHv
7BFm23VMFWq0gDXhRz0sPOdjgtSqtEkDgwq9Ma7uoZunPxHwoPHowTltMc1QUkJg
30PVjlyAFu6pTsawPLF1fk1Lt7dsWESdg1WsKxhJGMe9Q+goG7DkrAQ/g1CLm+hU
gayhmF0J02Ap4hVGGVzZeQ5caZDbMvrbuSeGlsUu2qqdHB3WOmUK5I6o4oKOwoAn
Zsl60kRk9DJUQYSbUhCjzkcfhwOCRmz/ngxNvMQhLK4vlDVJ6i8=
=LJcM
-----END PGP SIGNATURE-----

--Apple-Mail=_AE09ABC6-6D85-4425-A0F8-542D14AEA3DF--
