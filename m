Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0079.outbound.protection.outlook.com ([104.47.40.79]:23802
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752627AbeBVHrh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 02:47:37 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 03/20] lightnvm: fix capabilities for 2.0 sysfs
Date: Thu, 22 Feb 2018 07:47:33 +0000
Message-ID: <19BA9139-DB6D-4A9B-A0B4-72F38BE648E9@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-4-git-send-email-javier@cnexlabs.com>
 <23b494fb-264d-a8ef-6172-5330d5a63bea@lightnvm.io>
In-Reply-To: <23b494fb-264d-a8ef-6172-5330d5a63bea@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_397BD780-928F-4AAB-918C-0EDB508B4A7B";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_397BD780-928F-4AAB-918C-0EDB508B4A7B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 22 Feb 2018, at 08.28, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/21/2018 10:26 AM, Javier Gonz=C3=A1lez wrote:
>> Both 1.2 and 2.0 specs define a field for media and controller
>> capabilities. Also, 1.2 defines a separate field dedicated to device
>> capabilities.
>> In 2.0 sysfs, this values have been mixed. Revert them to the right
>> value.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/nvme/host/lightnvm.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>> index 969bb874850c..598abba66f52 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -914,8 +914,8 @@ static ssize_t nvm_dev_attr_show(struct device =
*dev,
>>    	if (strcmp(attr->name, "version") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->ver_id);
>> -	} else if (strcmp(attr->name, "capabilities") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.cap);
>> +	} else if (strcmp(attr->name, "media_capabilities") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.mccap);
>>  	} else if (strcmp(attr->name, "read_typ") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.trdt);
>>  	} else if (strcmp(attr->name, "read_max") =3D=3D 0) {
>> @@ -993,8 +993,8 @@ static ssize_t nvm_dev_attr_show_12(struct device =
*dev,
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.tbem);
>>  	} else if (strcmp(attr->name, "multiplane_modes") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "0x%08x\n", =
dev_geo->c.mpos);
>> -	} else if (strcmp(attr->name, "media_capabilities") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "0x%08x\n", =
dev_geo->c.mccap);
>> +	} else if (strcmp(attr->name, "capabilities") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "0x%08x\n", =
dev_geo->c.cap);
>>  	} else if (strcmp(attr->name, "max_phys_secs") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", NVM_MAX_VLBA);
>>  	} else {
>> @@ -1055,7 +1055,7 @@ static ssize_t nvm_dev_attr_show_20(struct =
device *dev,
>>    /* general attributes */
>>  static NVM_DEV_ATTR_RO(version);
>> -static NVM_DEV_ATTR_RO(capabilities);
>> +static NVM_DEV_ATTR_RO(media_capabilities);
>>    static NVM_DEV_ATTR_RO(read_typ);
>>  static NVM_DEV_ATTR_RO(read_max);
>> @@ -1080,12 +1080,12 @@ static NVM_DEV_ATTR_12_RO(prog_max);
>>  static NVM_DEV_ATTR_12_RO(erase_typ);
>>  static NVM_DEV_ATTR_12_RO(erase_max);
>>  static NVM_DEV_ATTR_12_RO(multiplane_modes);
>> -static NVM_DEV_ATTR_12_RO(media_capabilities);
>> +static NVM_DEV_ATTR_12_RO(capabilities);
>>  static NVM_DEV_ATTR_12_RO(max_phys_secs);
>>    static struct attribute *nvm_dev_attrs_12[] =3D {
>>  	&dev_attr_version.attr,
>> -	&dev_attr_capabilities.attr,
>> +	&dev_attr_media_capabilities.attr,
>>    	&dev_attr_vendor_opcode.attr,
>>  	&dev_attr_device_mode.attr,
>> @@ -1108,7 +1108,7 @@ static struct attribute *nvm_dev_attrs_12[] =3D =
{
>>  	&dev_attr_erase_typ.attr,
>>  	&dev_attr_erase_max.attr,
>>  	&dev_attr_multiplane_modes.attr,
>> -	&dev_attr_media_capabilities.attr,
>> +	&dev_attr_capabilities.attr,
>>  	&dev_attr_max_phys_secs.attr,
>>    	NULL,
>> @@ -1134,7 +1134,7 @@ static NVM_DEV_ATTR_20_RO(reset_max);
>>    static struct attribute *nvm_dev_attrs_20[] =3D {
>>  	&dev_attr_version.attr,
>> -	&dev_attr_capabilities.attr,
>> +	&dev_attr_media_capabilities.attr,
>>    	&dev_attr_groups.attr,
>>  	&dev_attr_punits.attr,
>=20
> With the mccap changes, it should make sense to keep the capabilities
> as is.

The change adds mccap, but sysfs points to cap, which is wrong. This
patch is needed. Otherwise, we change the name of mccap to cap, which
is _very_ confusing to people familiar to both specs. We can change
the name of mccap to cap in a future spec revision.

Javier

--Apple-Mail=_397BD780-928F-4AAB-918C-0EDB508B4A7B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqOdZIACgkQIX4xUKFR
nnQoURAAtkK91HVURpL7i4HLmx7iIRkLFEdP2VkZEmWMk6UchbN25VIgmDpX0OGF
t1uSmihMYf26Pa16dGij4/qGLuGqWUaHDrrmom5mAtylqbeJUOKFtRMwWbUzodx7
eM/0yYsefLXrQ0g3jtcdKZkhtRCTaLT6Jos9MaacntELOLa0H/s5OX4v+rTrws5i
YG39vVcMno4T5AwEGz5VaTxCBAXoY+fuSdPsG11+5bZHFISUh4sThd4Japx+Zriv
LglRlZLW3p6b8mmJDqW7GE25KTPODRHZ1rDwc86zugEMSTXx6REUTHOhmd0zdpqc
6TT1vviML0HnH3oJ6dYspKXQ1NPry7no7oI0a2Dmqbn/9XuAiVQFWSrEddRFlUL0
EhjAgg/5Kw1zzA49rCyl7KSZzIJw3YxigekuzNTbVjWib/sa0EKoBGJglc8o2wsy
q6Pvp4NtZ5dWQBOrwwhy4q4fLs8obsjMRS/epIOD5+7gCOO8yKgT1Q2+eBO91cnJ
MPEvoUJEmVugfYcO9qZTInCO1/hhNnaCKQudyaoN4QeUklZBYJt1nvZWGadKrnKJ
hQPtuo2j97PnnvozCzt8G6D4o23sigZCN7s4dKITJTUdU4V2xUuGojuJQO4Z8LgF
9Qfh3UmMpsoDkUY2/xsC7m9F6zYFW+lzThMlYIawu6UKrMvc814=
=aZWg
-----END PGP SIGNATURE-----

--Apple-Mail=_397BD780-928F-4AAB-918C-0EDB508B4A7B--
