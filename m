Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:51553 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbdJCOLP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 10:11:15 -0400
Received: by mail-wm0-f50.google.com with SMTP id f4so9132652wme.0
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 07:11:14 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <9AF41216-3CB7-4AFA-B461-0957074AF0A5@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_6B8B45EE-3357-430B-A895-6C31B5D84F8F";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] lightnvm: pblk: use vfree_atomic when freeing line
 metadata
Date: Tue, 3 Oct 2017 16:11:11 +0200
In-Reply-To: <5f64209d-ba28-a642-ed44-66a5eced9a99@virtuozzo.com>
Cc: Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <1507038524-24587-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <5f64209d-ba28-a642-ed44-66a5eced9a99@virtuozzo.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_6B8B45EE-3357-430B-A895-6C31B5D84F8F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 3 Oct 2017, at 16.07, Andrey Ryabinin <aryabinin@virtuozzo.com> =
wrote:
>=20
>=20
>=20
> On 10/03/2017 04:48 PM, Hans Holmberg wrote:
>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>=20
>> The commit bf22e37a6413 ("mm: add vfree_atomic()") made vfree unsafe =
to
>> call in atomic context (unless the call came from an interrupt) and
>> introduced vfree_atomic that is safe to call in atomic context.
>>=20
>> So, since we're holding locks when freeing line metadata, we need to
>> use the atomic version of vfree.
>>=20
>> Fix this by introducing an atomic variant of pblk_mfree and
>> switching to that in pblk_line_meta_free.
>>=20
>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>> ---
>>=20
>> The patch is for:
>> https://github.com/OpenChannelSSD/linux branch for-4.15/pblk
>>=20
>> drivers/lightnvm/pblk-init.c | 3 ++-
>> drivers/lightnvm/pblk.h      | 8 ++++++++
>> 2 files changed, 10 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>> index c452478..3a191a6 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -396,7 +396,8 @@ static void pblk_line_meta_free(struct pblk =
*pblk)
>> 	spin_lock(&l_mg->free_lock);
>=20
> What's the point in holding ->free_lock here? It seems like it could =
be just dropped.
>=20

This lock can indeed be dropped, but the general pblk semaphore, which
serializes initialization and tear down cannot. This is taken on
pblk_exit().

Javier

--Apple-Mail=_6B8B45EE-3357-430B-A895-6C31B5D84F8F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnTmn8ACgkQYx8FO3WZ
GMrYqRAA36kCi62R/uDagZwTuNmJr6PQi1lEyMKtCdd7tAMJr+LmH4GGIMECD71v
HAt6B7aELmpwu69Y0qzjlcJyBFhRDTsNMDptCeIj59+g1UtmhiSNeFTmrJn7n/9F
vulbHlbb+sQ2xP2jEH/2RVhFEelShJSZYDoxR3HzNb16ry697RwJngYoXX1en47X
v25yOECFgc30zU3DN0CdZ8W2/e4ECnE447ue8ZhgZOVomk4tgxIx/0rKAu5xeQQ4
/AhWphWp7RplxH5u+vmO+VQElifunUW/u/tsPMgHEK8FUeyRx1Vu3Br4GS4q1VtD
RP3joeYKJjB8o+9uus8F+R+p8XtTHIYCtvcziLxE+OZYh7q33/wQfoq+w4Hdr6Rl
z/TSZI1OSB7EwnYJW4AQ/gMd8SHmfIKjpbflBeq73mFOKvApAOL8uHNOySvJTIfG
vzr0ZmAYCp8SqSDgy5aR6WzOvxOPI3vG9hX7D4UnCIV696pXntvIe3e/LQO7qYtk
Ia9JpAOW9aygVh9f92D15X4jwZtnWzwq7u9vJGtBNTFiZchf2q1L8NuQWCaclwxw
m/WZx1yIzfwm5vXriM04l+2DfFX5nocKrK6AKCUVRHf3OLvLqxCMmB9dfQ6eClAr
hKN5V9jHQu1dpE+ViAt8UDIsX/iaZxUxVXWT183bdRjZl/HlPnM=
=78kz
-----END PGP SIGNATURE-----

--Apple-Mail=_6B8B45EE-3357-430B-A895-6C31B5D84F8F--
