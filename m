Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46467 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756591AbdKDLW1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Nov 2017 07:22:27 -0400
Received: by mail-pf0-f196.google.com with SMTP id p87so4157349pfj.3
        for <linux-block@vger.kernel.org>; Sat, 04 Nov 2017 04:22:26 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <2AC384A2-C792-45AF-AF11-89CBC128C527@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_25930456-9B7D-46E7-9B69-17EC2CEDB058";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/3] nvme: fix eui_show() print format
Date: Sat, 4 Nov 2017 12:22:20 +0100
In-Reply-To: <1509722197.15520.17.camel@perches.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Joe Perches <joe@perches.com>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
 <1509703370-20379-4-git-send-email-javier@cnexlabs.com>
 <20171103125516.GC25186@lst.de> <1509722197.15520.17.camel@perches.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_25930456-9B7D-46E7-9B69-17EC2CEDB058
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Nov 2017, at 16.16, Joe Perches <joe@perches.com> wrote:
>=20
> On Fri, 2017-11-03 at 13:55 +0100, Christoph Hellwig wrote:
>> On Fri, Nov 03, 2017 at 11:02:50AM +0100, Javier Gonz=C3=A1lez wrote:
>>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
> []
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> []
>>> @@ -2108,7 +2108,7 @@ static ssize_t eui_show(struct device *dev, =
struct device_attribute *attr,
>>> 								char =
*buf)
>>> {
>>> 	struct nvme_ns *ns =3D nvme_get_ns_from_dev(dev);
>>> -	return sprintf(buf, "%8phd\n", ns->eui);
>>> +	return sprintf(buf, "%8phD\n", ns->eui);
>>> }
>>> static DEVICE_ATTR(eui, S_IRUGO, eui_show, NULL);
>>=20
>> This looks correct.  I wonder what the old code printed - does =
someone
>> have a device with an EUI-64 at hand to quickly cross check what we
>> did before?
>=20
> It uses spaces between bytes and not dashes.
>=20
> The code has been this way a couple years now.
>=20
> I think this proposal, while it might fix an
> unintentional output style, could also be an API
> and could cause user breakage if changed.
>=20
> Perhaps this should just become
>=20
> 	%8ph
>=20
> without D

That would be ok with me.

Javier.

--Apple-Mail=_25930456-9B7D-46E7-9B69-17EC2CEDB058
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAln9ouwACgkQYx8FO3WZ
GMpM1w//QjkGo6zOLsipCVBoLJFinBwPaCkVphZoPewXm+ZQYRDM7ycnu10F/FwB
v9gSnierWEVGtB3d4dtl/euDb9UCWfeIk82kRW7QfrKT7RLRgdd/d5uEg+jsYeiq
yiSX8CEc8ucZOxi4fLx2eoThUvQAghHlvyyzYjaP71maRHwYuP41TmZZGlqcCZcX
av3kavI8YaFdRv/onQPnU1z+WTByZStFbmfbgJpyp1+lLGYyJqdp1sthqZ37Qovc
FXfyIKTKy2RymMYhLREo992tdKbfkktZbpoOEHJKCzS4K7R1z5/oqszlm2qv33Qv
CS2MyUs2oOrS6txQQ1l1juh2KoskzlXu5Iak8rXGPIuxRryUAJ05TFQl7eXq5cRA
91uORawXt8wa3TkioVMBcegkIOULgBRvs9D1OxVaPf+MsVL9qKvb0Hs7ORrXbajj
ntGx9IUqlv+n07UB9JdIrhyB18ETYr/1oq7fUFb3H18UmdSh7zgaCqlRaz3PXi4L
4hycWvTZ/j4n6zxOwhqJdfF47UCjVK7iSe3Q6OSEKRuAPmnDRdf7++HJLc9yQNXP
zMAycsZNx+UqlKmciN4TvFsQczNx6CU6CCZCSNi++lNfgpy4+R515A2dAL373T+J
lq2b2qG/TiJ+FfO0I4tbfWNvIK7Tz0H7eW022qOBxPAPHRorUM4=
=mYqJ
-----END PGP SIGNATURE-----

--Apple-Mail=_25930456-9B7D-46E7-9B69-17EC2CEDB058--
