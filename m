Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:56384 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbdJCOtj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 10:49:39 -0400
Received: by mail-wm0-f48.google.com with SMTP id l68so3651837wmd.5
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 07:49:38 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <6DF6EE74-01FC-4C86-98E1-E437A41D3CB7@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_461C780B-8EAD-4CB7-AE8A-34BB47DA6D47";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] lightnvm: pblk: use vfree_atomic when freeing line
 metadata
Date: Tue, 3 Oct 2017 16:49:35 +0200
In-Reply-To: <A9B2CD92-C7CE-478F-B361-704D1EFE7532@lightnvm.io>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
References: <1507038524-24587-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <5f64209d-ba28-a642-ed44-66a5eced9a99@virtuozzo.com>
 <9AF41216-3CB7-4AFA-B461-0957074AF0A5@lightnvm.io>
 <2aa049d5-3c31-eabc-a995-499807837a19@virtuozzo.com>
 <A9B2CD92-C7CE-478F-B361-704D1EFE7532@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_461C780B-8EAD-4CB7-AE8A-34BB47DA6D47
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Oct 2017, at 16.43, Javier Gonz=C3=A1lez <jg@lightnvm.io> wrote:
>=20
>> On 3 Oct 2017, at 16.20, Andrey Ryabinin <aryabinin@virtuozzo.com> =
wrote:
>>=20
>>=20
>>=20
>> On 10/03/2017 05:11 PM, Javier Gonz=C3=A1lez wrote:
>>>> On 3 Oct 2017, at 16.07, Andrey Ryabinin <aryabinin@virtuozzo.com> =
wrote:
>>>>=20
>>>>=20
>>>>=20
>>>> On 10/03/2017 04:48 PM, Hans Holmberg wrote:
>>>>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>>>>=20
>>>>> The commit bf22e37a6413 ("mm: add vfree_atomic()") made vfree =
unsafe to
>>>>> call in atomic context (unless the call came from an interrupt) =
and
>>>>> introduced vfree_atomic that is safe to call in atomic context.
>>>>>=20
>>>>> So, since we're holding locks when freeing line metadata, we need =
to
>>>>> use the atomic version of vfree.
>>>>>=20
>>>>> Fix this by introducing an atomic variant of pblk_mfree and
>>>>> switching to that in pblk_line_meta_free.
>>>>>=20
>>>>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>>>> ---
>>>>>=20
>>>>> The patch is for:
>>>>> https://github.com/OpenChannelSSD/linux branch for-4.15/pblk
>>>>>=20
>>>>> drivers/lightnvm/pblk-init.c | 3 ++-
>>>>> drivers/lightnvm/pblk.h      | 8 ++++++++
>>>>> 2 files changed, 10 insertions(+), 1 deletion(-)
>>>>>=20
>>>>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>>>>> index c452478..3a191a6 100644
>>>>> --- a/drivers/lightnvm/pblk-init.c
>>>>> +++ b/drivers/lightnvm/pblk-init.c
>>>>> @@ -396,7 +396,8 @@ static void pblk_line_meta_free(struct pblk =
*pblk)
>>>>> 	spin_lock(&l_mg->free_lock);
>>>>=20
>>>> What's the point in holding ->free_lock here? It seems like it =
could be just dropped.
>>>=20
>>> This lock can indeed be dropped,
>>=20
>> So, let's do this. This would be the best way to fix this.
>>=20
>>> but the general pblk semaphore, which
>>> serializes initialization and tear down cannot. This is taken on
>>> pblk_exit().
>>=20
>> But semaphore is not the problem here. We can sleep under semaphore, =
so it's fine.
>=20
> It seems to me like a false positive, but lockdep complains on the
> mentioned rw_semaphore held by pblk, and on the mutex held by the
> lightnvm subsystem when removing a target (dev->mlock).
>=20
> [ 6037.778889] BUG: sleeping function called from invalid context at =
mm/vmalloc.c:1492
> [ 6037.786579] in_atomic(): 1, irqs_disabled(): 0, pid: 1282, name: =
nvme
> [ 6037.793050] 3 locks held by nvme/1282:
> [ 6037.793053]  #0:  (&dev->mlock){+.+.+.}, at: [<ffffffff8ddff395>] =
nvm_ctl_ioctl+0x3c5/0x6a0
> [ 6037.793075]  #1:  (pblk_lock){+.+.+.}, at: [<ffffffff8de0439b>] =
pblk_exit+0x1b/0x100
> [ 6037.793092]  #2:  (&(&l_mg->free_lock)->rlock){+.+...}, at: =
[<ffffffff8de040ea>] pblk_line_meta_free+0x8a/0x130
>=20
> Any ideas?
>=20

Ok. When dropping ->free_lock, lockdep does not complain. It's just a
misleading notification from lockdep, signalling semaphores as "held
locks" when a real non sleeping lock is being taken.

We will just remove ->free_lock then.

Thanks Andrey.

Javier


--Apple-Mail=_461C780B-8EAD-4CB7-AE8A-34BB47DA6D47
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnTo38ACgkQYx8FO3WZ
GMrx9g/+IbFH5UIvQU/u8YVzHQ7fUM0ObfieKtkfUzmHwHz9vcf8+QA5JNWLDmc9
n1vbaTKbbi7PcUaFms9EJoXsOJhRSZQUSaRNAgDIg9QgpESvXq7fKr4hja9KKCMp
dHE/Q1hSQ8o8CcyCWtGKEsGrmiklVY/UIKZtWZVYJdzTtOjyAzXBGvJBwAss9UOK
PiILdj0S/bHOmX49oXhmLnKisSmHEuBeOzfvXr5L6jlSHbky45iBdygTF2g3PHk5
86vZ4wuDVJKK1nO8pAKQUjXhsCkbX0um3BTosyvbPg9S3QrHLnZyC5UGoGIXj+1m
oVCQlWgaTu8fNKJeIq8iB6xOgfqTCckRgpJBndEdQz4uTmknx125YLxbHd+bNg1S
THL0jx/iZM6UWS3b+SWH0+PhpiRQM6ryMBZbGEMiMjEuZz32hDVwpPUENU55FCrb
HMF4VLwNn5TWKt850MD+69KlR9irPW4KzsI4oLtH8yL5vA2q28X/KFFOEvEs/El3
MglALMu/shcXCaU2cuPhYa8wKHLjmAHX2STe49Rq9pAPuH6aUxKtdsQuex2EV8Yp
ZA1DViVMvPM0mMx3kNIsCww+vFWkStwj5Ei5byWxFYBkeno2CZ5dd9I7qgQc6KAt
xKHxWmh7/fZwjPTGaLJnjBtpA2c2SbGuTD1yQqEOiT6A4zGZO2E=
=hI44
-----END PGP SIGNATURE-----

--Apple-Mail=_461C780B-8EAD-4CB7-AE8A-34BB47DA6D47--
