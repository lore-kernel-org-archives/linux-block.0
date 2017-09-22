Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:43402 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbdIVKDR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 06:03:17 -0400
Received: by mail-wm0-f46.google.com with SMTP id m72so1395851wmc.0
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2017 03:03:17 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <3E24DF8F-A2D4-493C-AA9F-DC3EFC2E6364@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_3DE8BB68-7C2D-4EA1-BE82-13AF364A87A2";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/6] lightnvm: pblk: fix message if L2P MAP is in device
Date: Fri, 22 Sep 2017 12:03:14 +0200
In-Reply-To: <20170922094417.GB31904@dhcp-216.srv.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20170921112655.GA28539@dhcp-216.srv.tuxera.com>
 <D3D2476A-E07C-4012-A731-27552AFFCD5D@lightnvm.io>
 <20170922094417.GB31904@dhcp-216.srv.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_3DE8BB68-7C2D-4EA1-BE82-13AF364A87A2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Sure.

Matias: Can you fix this when picking it up?

Javier

> On 22 Sep 2017, at 11.44, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> On Fri, Sep 22, 2017 at 10:52:19AM +0200, Javier Gonz=C3=A1lez wrote:
>>> On 21 Sep 2017, at 13.26, Rakesh Pandit <rakesh@tuxera.com> wrote:
>>>=20
>>> This usually happens if we are developing with qemu and ll2pmode has
>>> default value.  Even in that case message seems wrong.
>>>=20
>>> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
>>> ---
>>> drivers/lightnvm/pblk-init.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>>> index 470ef04..c5c1337 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -913,7 +913,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, =
struct gendisk *tdisk,
>>> 	int ret;
>>>=20
>>> 	if (dev->identity.dom & NVM_RSP_L2P) {
>>> -		pr_err("pblk: device-side L2P table not supported. =
(%x)\n",
>>> +		pr_err("pblk: device-side L2P table supported. (%x)\n",
>>> 							=
dev->identity.dom);
>>> 		return ERR_PTR(-EINVAL);
>>> 	}
>>> --
>>> 2.5.0
>>=20
>> You're right. This is inherited from rrpc.
>>=20
>> Can we instead write "pblk: full host-side L2P table not supported"?
>> People will not know about the hybrid device/host L2P as time goes by
>> and it will just be confusing. I'm not even sure this will be part of
>> the 2.0 spec, so it will probably go away with time...
>=20
> Sure.  I was confused the first time.  This is better.
>=20
> It would be great if this is done while picking up.  I can repost as
> well if need be.
>=20
> Thanks,

--Apple-Mail=_3DE8BB68-7C2D-4EA1-BE82-13AF364A87A2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZxN/iAAoJEGMfBTt1mRjK6MoP/3bSmNbSZXz5rnS6ylcopAmF
vtR9PYdWS83vjvyZ7ofitAfYby2ctQiQmFwVuNaeLOhWFQyjRZloyxtoiV8PPAFZ
4EgjLT1tZc06NQ1H0aqNBwaRPPPL5iNosWSBxVWbuJ8BSSCW/pe1gw6YDplAWSaH
bYp1DK9pJ2gx5FwCGyFB1WLKTpMuI5qI7Yc6TUGn3FsDZuGTAimJin8r1tFnerAl
y5Trj/DSyGwdQtW2JUbFj/dep4F66XcGzDBm5vb46tVugllzpGBMRf5eEvfFiNt/
BvNjAF8/FHLq8rWYmIHwnUXRHtU91j7H/Y1YGNqvnKfxkfbja08JRA/f8dG1K26o
0MHAbKri3DmhooppZipW8suOp8w0hckryE5IbhvDV8V+XPsmXxsI223DstOhCPLj
kQ1pW9RZQFwJEPBVwPTFdCmMyzbTyQpCkvdDwxoApuVScrNWYzdAzQJJIbXUAzfI
NmtU/x06DQ6N6hx7GsQu+WPByxruhE97POCHuncAQyxRETwa/3DqgZug3pgGeKd1
qs2tb4/tW4q1101FcNSI4iXEf5xP11eQj4KPdBnR2VlBTarhxdMeOAV/P7w3M6V7
XmE73C5+RkL3JAik4Buen2poq5MoGWw+H4bjdjg5o8vC1cubT6IjkbElDbwDdsNm
atu0Bz1hCB617uvQBAxY
=3zoL
-----END PGP SIGNATURE-----

--Apple-Mail=_3DE8BB68-7C2D-4EA1-BE82-13AF364A87A2--
