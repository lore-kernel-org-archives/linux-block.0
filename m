Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0059.outbound.protection.outlook.com ([104.47.42.59]:10890
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753279AbeBVLMZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 06:12:25 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 03/20] lightnvm: fix capabilities for 2.0 sysfs
Date: Thu, 22 Feb 2018 11:12:23 +0000
Message-ID: <C1D66C1C-48B9-4B45-AB28-EEA1D52EB121@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-4-git-send-email-javier@cnexlabs.com>
 <23b494fb-264d-a8ef-6172-5330d5a63bea@lightnvm.io>
 <19BA9139-DB6D-4A9B-A0B4-72F38BE648E9@cnexlabs.com>
 <616ad3c9-b10c-0439-2d63-5e9e25abce84@lightnvm.io>
 <A949EA48-27DF-4370-B213-3A4CE4E4F7D1@cnexlabs.com>
 <e4ac9c84-3dd5-41e3-8190-905d2a7f5d5d@lightnvm.io>
In-Reply-To: <e4ac9c84-3dd5-41e3-8190-905d2a7f5d5d@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6D82E9C4-F34F-4420-8D35-C888EC6865C9";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_6D82E9C4-F34F-4420-8D35-C888EC6865C9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 22 Feb 2018, at 12.10, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/22/2018 11:25 AM, Javier Gonzalez wrote:
>>> On 22 Feb 2018, at 10.39, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 02/22/2018 08:47 AM, Javier Gonzalez wrote:
>>>>> On 22 Feb 2018, at 08.28, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>>> On 02/21/2018 10:26 AM, Javier Gonz=C3=A1lez wrote:
>>>>>> Both 1.2 and 2.0 specs define a field for media and controller
>>>>>> capabilities. Also, 1.2 defines a separate field dedicated to =
device
>>>>>> capabilities.
>>>>>> In 2.0 sysfs, this values have been mixed. Revert them to the =
right
>>>>>> value.
>>>>>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>>>>>> ---
>>>>>>  drivers/nvme/host/lightnvm.c | 18 +++++++++---------
>>>>>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>>>>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>>>>>> index 969bb874850c..598abba66f52 100644
>>>>>> --- a/drivers/nvme/host/lightnvm.c
>>>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>>>> @@ -914,8 +914,8 @@ static ssize_t nvm_dev_attr_show(struct =
device *dev,
>>>>>>        if (strcmp(attr->name, "version") =3D=3D 0) {
>>>>>>          return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->ver_id);
>>>>>> -    } else if (strcmp(attr->name, "capabilities") =3D=3D 0) {
>>>>>> -        return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.cap);
>>>>>> +    } else if (strcmp(attr->name, "media_capabilities") =3D=3D =
0) {
>>>>>> +        return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.mccap);
>>>>>>      } else if (strcmp(attr->name, "read_typ") =3D=3D 0) {
>>>>>>          return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.trdt);
>>>>>>      } else if (strcmp(attr->name, "read_max") =3D=3D 0) {
>>>>>> @@ -993,8 +993,8 @@ static ssize_t nvm_dev_attr_show_12(struct =
device *dev,
>>>>>>          return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.tbem);
>>>>>>      } else if (strcmp(attr->name, "multiplane_modes") =3D=3D 0) =
{
>>>>>>          return scnprintf(page, PAGE_SIZE, "0x%08x\n", =
dev_geo->c.mpos);
>>>>>> -    } else if (strcmp(attr->name, "media_capabilities") =3D=3D =
0) {
>>>>>> -        return scnprintf(page, PAGE_SIZE, "0x%08x\n", =
dev_geo->c.mccap);
>>>>>> +    } else if (strcmp(attr->name, "capabilities") =3D=3D 0) {
>>>>>> +        return scnprintf(page, PAGE_SIZE, "0x%08x\n", =
dev_geo->c.cap);
>>>>>>      } else if (strcmp(attr->name, "max_phys_secs") =3D=3D 0) {
>>>>>>          return scnprintf(page, PAGE_SIZE, "%u\n", NVM_MAX_VLBA);
>>>>>>      } else {
>>>>>> @@ -1055,7 +1055,7 @@ static ssize_t nvm_dev_attr_show_20(struct =
device *dev,
>>>>>>    /* general attributes */
>>>>>>  static NVM_DEV_ATTR_RO(version);
>>>>>> -static NVM_DEV_ATTR_RO(capabilities);
>>>>>> +static NVM_DEV_ATTR_RO(media_capabilities);
>>>>>>    static NVM_DEV_ATTR_RO(read_typ);
>>>>>>  static NVM_DEV_ATTR_RO(read_max);
>>>>>> @@ -1080,12 +1080,12 @@ static NVM_DEV_ATTR_12_RO(prog_max);
>>>>>>  static NVM_DEV_ATTR_12_RO(erase_typ);
>>>>>>  static NVM_DEV_ATTR_12_RO(erase_max);
>>>>>>  static NVM_DEV_ATTR_12_RO(multiplane_modes);
>>>>>> -static NVM_DEV_ATTR_12_RO(media_capabilities);
>>>>>> +static NVM_DEV_ATTR_12_RO(capabilities);
>>>>>>  static NVM_DEV_ATTR_12_RO(max_phys_secs);
>>>>>>    static struct attribute *nvm_dev_attrs_12[] =3D {
>>>>>>      &dev_attr_version.attr,
>>>>>> -    &dev_attr_capabilities.attr,
>>>>>> +    &dev_attr_media_capabilities.attr,
>>>>>>        &dev_attr_vendor_opcode.attr,
>>>>>>      &dev_attr_device_mode.attr,
>>>>>> @@ -1108,7 +1108,7 @@ static struct attribute *nvm_dev_attrs_12[] =
=3D {
>>>>>>      &dev_attr_erase_typ.attr,
>>>>>>      &dev_attr_erase_max.attr,
>>>>>>      &dev_attr_multiplane_modes.attr,
>>>>>> -    &dev_attr_media_capabilities.attr,
>>>>>> +    &dev_attr_capabilities.attr,
>>>>>>      &dev_attr_max_phys_secs.attr,
>>>>>>        NULL,
>>>>>> @@ -1134,7 +1134,7 @@ static NVM_DEV_ATTR_20_RO(reset_max);
>>>>>>    static struct attribute *nvm_dev_attrs_20[] =3D {
>>>>>>      &dev_attr_version.attr,
>>>>>> -    &dev_attr_capabilities.attr,
>>>>>> +    &dev_attr_media_capabilities.attr,
>>>>>>        &dev_attr_groups.attr,
>>>>>>      &dev_attr_punits.attr,
>>>>>=20
>>>>> With the mccap changes, it should make sense to keep the =
capabilities
>>>>> as is.
>>>> The change adds mccap, but sysfs points to cap, which is wrong. =
This
>>>> patch is needed. Otherwise, we change the name of mccap to cap, =
which
>>>> is _very_ confusing to people familiar to both specs. We can change
>>>> the name of mccap to cap in a future spec revision.
>>>> Javier
>>>=20
>>> Think of the sysfs capabilities as an abstract value that defines =
generic capabilities. It is not directly tied to either 1.2 or 2.0.
>> I=E2=80=99m thinking about the user looking at sysfs and at the spec =
at the same time - I myself get confused when names don=E2=80=99t match.
>> Anyway, I=E2=80=99ll keep it the way it was and add a comment for =
clarification. Would that work for you?
>=20
> That works. One may also wait until it is going to be used, e.g., when
> vector copy is implemented. Then it's natural to revisit.

Ok. Let's do that then. I'll drop the 2 patches then.

Javier

--Apple-Mail=_6D82E9C4-F34F-4420-8D35-C888EC6865C9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqOpZMACgkQIX4xUKFR
nnRvsxAAiJAn0P9b2pH8Wa96wCR7jCv7o5BWLMuNk+59232/4CBzOx4YrMxJF7hq
jhvhI+AAuxw4/7UsTcHlhfcwmbF9M/KORyuEw6CUCxi7ShyfiH8K+ZpVMxFFIAWJ
dzJmKj4b/5hmdvs2NmoKr3eCpKELUpcIe5qPcnn+N32CIFzrBrMW9ilkqE8CXZ0c
soYmL8Gwfi9gAmwyVSjMedWWIqhae0oYWrndJv7rH65NdYONumf52VlrhBq2jNVJ
DaQB/pEJxNP2+16BE7/etFNbe2NIwV7wRgrgqU1q5sGVPjPdTmJsZrZsBLwM1ixy
5EAJ3wibvKWQqOXeW+Tflz0EuWtSaJdVkcr0vjXhaOm5QhgEmGTEGIsaSi5kj1nc
nH55e1yTiIPr779pRxSPEUXSX9uLCy4DBsV5UzUzsQPHuwx1BeotQFdFKu2AUGek
UbTy4b+ijUbjPIb2QRnOb1bk23ux2go/pKcOoNvps9eQVbNgoH01J2FU2i2oUruf
u8OvGLetxRN5rUwU3Fq0TPwVssAXn37rL7FsvoFXA8ypIh0f5M8p1PGA9kD4fwTq
egDAFCkeJwE3WEnf+p7aPPM90xLObtfT1GtHnBH9YUgnxovYCrASpEzOCJQMoZUF
Bnk7kGsMnQc3JQ1J/zLNLVdEZuIHeLSv8tJs3mzDSP1JGgT3Hck=
=J6zo
-----END PGP SIGNATURE-----

--Apple-Mail=_6D82E9C4-F34F-4420-8D35-C888EC6865C9--
