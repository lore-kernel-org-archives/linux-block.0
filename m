Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52857 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeBWI4Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Feb 2018 03:56:24 -0500
Received: by mail-wm0-f68.google.com with SMTP id t3so3217100wmc.2
        for <linux-block@vger.kernel.org>; Fri, 23 Feb 2018 00:56:24 -0800 (PST)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <34D9B5A3-0A44-4214-9B2B-E0030DC20BA4@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_833FFC8A-C59D-4062-96E8-15926FD617E6";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] lightnvm: fix memory leak in pblk_luns_init
Date: Fri, 23 Feb 2018 09:56:18 +0100
In-Reply-To: <870ebf31-340a-1673-d4b3-e755dd2be493@lightnvm.io>
Cc: Huaicheng Li <huaicheng@cs.uchicago.edu>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <20180222210147.GA29523@gmail.com>
 <CANr0WEcDSy3YuZ8kaNuB7Z0wFfiV6AwT=bg4W3MNq--2txX2xQ@mail.gmail.com>
 <870ebf31-340a-1673-d4b3-e755dd2be493@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_833FFC8A-C59D-4062-96E8-15926FD617E6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 23 Feb 2018, at 07.12, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/23/2018 12:03 AM, Huaicheng Li wrote:
>> Please ignore my previous email as I found the memory is free'ed at
>> pblk_init()'s error handling logic.
>> Sorry for the interruption.
>> On Thu, Feb 22, 2018 at 3:01 PM, Huaicheng Li =
<huaicheng@cs.uchicago.edu>
>> wrote:
>>> Signed-off-by: Huaicheng Li <huaicheng@cs.uchicago.edu>
>>> ---
>>> drivers/lightnvm/pblk-init.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>>> index 93d671ca518e..330665d91d8d 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -510,6 +510,7 @@ static int pblk_luns_init(struct pblk *pblk, =
struct
>>> ppa_addr *luns)
>>>                 if (ret) {
>>>                         while (--i >=3D 0)
>>>                                 kfree(pblk->luns[i].bb_list);
>>> +                       kfree(pblk->luns);
>>>                         return ret;
>>>                 }
>>>         }
>>> --
>>> 2.13.6
>=20
> No worries. The initialization part is pretty complex due to all the
> data structures being set up. I would love to have a clean
> initialization function, which cleans up after it self. But being able
> to share the "fail" bringup and tear-down code is very helpful and
> makes other parts easier.

As part of the 2.0 patches, I took a first try at refactoring the
init/exit sequences to maintain the same fail paths but minimizing
dependencies across structures. One of the big parts have been the bad
block initialization, which now is much cleaner, but still needs more
work to be as I would like it to. Patches are very welcome :)

Javier

--Apple-Mail=_833FFC8A-C59D-4062-96E8-15926FD617E6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlqP1zIACgkQYx8FO3WZ
GMrtRhAAqldPkPdDQ0TLTyQZQgGzmS5tAmfLDw9TkR1pT0F8cPo3uVXBPf1OEApk
FsBPCAPJee1UAirLkqws7YICh2P8vCvifJ+mxmi5tbruySrc9A/fGMqtuLXp0NCe
krGkzcIexglI1RlccaKiQvAp4h0ot3yNROGCLGhS1BnldjI/FpDXQ8kHGccKU/Zk
KoPxGT1mfebHqSudbHh/stnyggM4gre1RDtS4Ghhw4ZA6nZ/kbi1eBrCPGojxVnZ
/rYvwtBMVaaKuv4ss7dDs7IwXoj09uCy99rOQPUCEZL1/4MK8x26NeV3HOrJqCIG
e7eJ8zsGkQ3iOPGyHkD7LN8riE+gDdlczX/PSEBZyTnK5uZTTfdn6Msks7cB/5FK
HOL2GlpvqYRqMkWpZc+gbARNNjLNRnn7Und+5fUFzX5gRuGClOSntGlZPcc96PyZ
46zm5DPgzMMPmacDTXRmH1qw6wb9/v5jNnej8CP4VDjhHg7IXmqMys0Kn1S2LO2v
FOXsOS/861U0xroYIKzEp74N+GuMTmrqNZRys2mCrqaVqQMUkyEo/2UjJ3LmJ/PF
i+l4ZzbaJcX1fHMsiEMmFWFQ8r+uGoqpjMQfPNu5ES7l/cuOwtrxbMu90a3iDFUe
OBNHQOfXhNaZ+IbK4++m1vnUpAE4tFzPy4qYd+e4lOTwuCGkXNM=
=1Tjn
-----END PGP SIGNATURE-----

--Apple-Mail=_833FFC8A-C59D-4062-96E8-15926FD617E6--
