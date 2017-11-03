Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52942 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbdKCM4O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Nov 2017 08:56:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id t139so1386209wmt.1
        for <linux-block@vger.kernel.org>; Fri, 03 Nov 2017 05:56:14 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <C8D5839F-0C9A-4B38-A694-2C3CB62D27AE@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_95D3AB21-3E0D-44A7-B5BB-C4A5F9AB119A";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/3] nvme: compare NQN string with right size
Date: Fri, 3 Nov 2017 13:56:11 +0100
In-Reply-To: <20171103125429.GB25186@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
 <1509703370-20379-3-git-send-email-javier@cnexlabs.com>
 <20171103125429.GB25186@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_95D3AB21-3E0D-44A7-B5BB-C4A5F9AB119A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Nov 2017, at 13.54, Christoph Hellwig <hch@lst.de> wrote:
>=20
> On Fri, Nov 03, 2017 at 11:02:49AM +0100, Javier Gonz=C3=A1lez wrote:
>> Compare subnqns using NVMF_NQN_SIZE as it is < 256
>>=20
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>> drivers/nvme/host/core.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index bd1d5ff911c9..ae8ab0a1ef0d 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1743,7 +1743,7 @@ static void nvme_init_subnqn(struct nvme_ctrl =
*ctrl, struct nvme_id_ctrl *id)
>>=20
>> 	nqnlen =3D strnlen(id->subnqn, NVMF_NQN_SIZE);
>> 	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
>> -		strcpy(ctrl->subnqn, id->subnqn);
>> +		strncpy(ctrl->subnqn, id->subnqn, NVMF_NQN_SIZE);
>> 		return;
>> 	}
>=20
> This isn't a compare, but a copy.  Except for that it looks ok to me.

True. Can you change the message when picking it up?

--Apple-Mail=_95D3AB21-3E0D-44A7-B5BB-C4A5F9AB119A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAln8Z2sACgkQYx8FO3WZ
GMrbABAAieU9sDa3a3J1dPjWv0BWw8qGRNo4n1UUeAufE+pFC+kHvbCAxkHC5ATh
kULh6bWLiKsr6nuRbwNzeHeq2cyqxfMwgCurFleiDAXHmSQFrWo0KyRNfsD3uIG5
Xp/XvTlpmjkK1oPPovlAwtbzwejPUlTPB8VwG4yTDmIqg7vV9oXStiFfp4YZyISD
1FjL0zs430Put8gKjgqA7X93/BmjfntIPFDaelAlYa6Acloct45gmjLdcP52bISU
QH61QAeWWnodW5Rbw8HfrmpkBctSkNFcI4La5b2Tchi2pL2LAgPXEX7FHe8uuXFR
7I4RXn/EQZnkD7TeP/6dxZx4GcZQVA5mIQI5KvIm1tWaMe1GzR83rfavITFA8CU0
cXfGdl4gpxqCdFU7mLzGGyY6qmey+ukw/mWov8ZP+V1/HyayUeAlgb9thmHl5r6W
45Wyg2KrQcJ/0uN62EvdGVedlSedP1Ezp6HXAcknWa2jaxqXgi4z/Ead+0Tuzbg6
DfkXqQLK8u5wkmFgpJCrv4NgY2vQ0SQnGvCIMpEZLEmX+jNe3ffJAl2slRdR/hU7
r3mkc+llipr7syXVXcLUdwMa+6SeU8dlxe0HqexVm7LNPNe72Y6pAfO7sMNAq+hD
2mtXWPYAS/Vc/j9SzedSFw4f2gOHhQUFc6+AL3wJBj3FQ+AEUKU=
=sToE
-----END PGP SIGNATURE-----

--Apple-Mail=_95D3AB21-3E0D-44A7-B5BB-C4A5F9AB119A--
