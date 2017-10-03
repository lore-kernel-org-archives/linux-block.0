Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:49946 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbdJCOn2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 10:43:28 -0400
Received: by mail-wm0-f51.google.com with SMTP id b189so13329248wmd.4
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 07:43:28 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <A9B2CD92-C7CE-478F-B361-704D1EFE7532@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_35BEA7E2-3A35-49AD-821D-4E4C8379353D";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] lightnvm: pblk: use vfree_atomic when freeing line
 metadata
Date: Tue, 3 Oct 2017 16:43:25 +0200
In-Reply-To: <2aa049d5-3c31-eabc-a995-499807837a19@virtuozzo.com>
Cc: Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <1507038524-24587-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <5f64209d-ba28-a642-ed44-66a5eced9a99@virtuozzo.com>
 <9AF41216-3CB7-4AFA-B461-0957074AF0A5@lightnvm.io>
 <2aa049d5-3c31-eabc-a995-499807837a19@virtuozzo.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_35BEA7E2-3A35-49AD-821D-4E4C8379353D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Oct 2017, at 16.20, Andrey Ryabinin <aryabinin@virtuozzo.com> =
wrote:
>=20
>=20
>=20
> On 10/03/2017 05:11 PM, Javier Gonz=C3=A1lez wrote:
>>> On 3 Oct 2017, at 16.07, Andrey Ryabinin <aryabinin@virtuozzo.com> =
wrote:
>>>=20
>>>=20
>>>=20
>>> On 10/03/2017 04:48 PM, Hans Holmberg wrote:
>>>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>>>=20
>>>> The commit bf22e37a6413 ("mm: add vfree_atomic()") made vfree =
unsafe to
>>>> call in atomic context (unless the call came from an interrupt) and
>>>> introduced vfree_atomic that is safe to call in atomic context.
>>>>=20
>>>> So, since we're holding locks when freeing line metadata, we need =
to
>>>> use the atomic version of vfree.
>>>>=20
>>>> Fix this by introducing an atomic variant of pblk_mfree and
>>>> switching to that in pblk_line_meta_free.
>>>>=20
>>>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>>> ---
>>>>=20
>>>> The patch is for:
>>>> https://github.com/OpenChannelSSD/linux branch for-4.15/pblk
>>>>=20
>>>> drivers/lightnvm/pblk-init.c | 3 ++-
>>>> drivers/lightnvm/pblk.h      | 8 ++++++++
>>>> 2 files changed, 10 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>>>> index c452478..3a191a6 100644
>>>> --- a/drivers/lightnvm/pblk-init.c
>>>> +++ b/drivers/lightnvm/pblk-init.c
>>>> @@ -396,7 +396,8 @@ static void pblk_line_meta_free(struct pblk =
*pblk)
>>>> 	spin_lock(&l_mg->free_lock);
>>>=20
>>> What's the point in holding ->free_lock here? It seems like it could =
be just dropped.
>>=20
>> This lock can indeed be dropped,
>=20
> So, let's do this. This would be the best way to fix this.
>=20
>> but the general pblk semaphore, which
>> serializes initialization and tear down cannot. This is taken on
>> pblk_exit().
>=20
> But semaphore is not the problem here. We can sleep under semaphore, =
so it's fine.
>=20

It seems to me like a false positive, but lockdep complains on the
mentioned rw_semaphore held by pblk, and on the mutex held by the
lightnvm subsystem when removing a target (dev->mlock).

[ 6037.778889] BUG: sleeping function called from invalid context at =
mm/vmalloc.c:1492
[ 6037.786579] in_atomic(): 1, irqs_disabled(): 0, pid: 1282, name: nvme
[ 6037.793050] 3 locks held by nvme/1282:
[ 6037.793053]  #0:  (&dev->mlock){+.+.+.}, at: [<ffffffff8ddff395>] =
nvm_ctl_ioctl+0x3c5/0x6a0
[ 6037.793075]  #1:  (pblk_lock){+.+.+.}, at: [<ffffffff8de0439b>] =
pblk_exit+0x1b/0x100
[ 6037.793092]  #2:  (&(&l_mg->free_lock)->rlock){+.+...}, at: =
[<ffffffff8de040ea>] pblk_line_meta_free+0x8a/0x130

Any ideas?

Thanks,
Javier




--Apple-Mail=_35BEA7E2-3A35-49AD-821D-4E4C8379353D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnTog0ACgkQYx8FO3WZ
GMryyg//RCzdvS5DYimVy4dNwsRECdnssPpE8BzJVBfV6aKuLc89Cac5gesPsJvj
mO8u1G/PnZYnPx/Eg0O1Cq5x9f3YLVbWOhvI44QLIYMafh3aM0AP0fCh77015ydd
pwm0isKSEh15xCpWBwzEjGnQMa6C6hOliXLOsTec4CPQvmSCZui0yAYMoG5jpUQf
4svowZRJ7QrjLgMiZrzmPCu/E2KJxHMF+bj6O36idMg3CROWHuNe492KYAvcXE2Q
ZAULKQhjOUAo8oFt8nCawLaMMlbeOO/qIjpxF8XC10H4UdqnRjHuBKyp/XZcGsVn
7NwdoK++ZjJSaI8BHi8dNEha4d+etqi36WU6OaThkF+UqVcvXTeH/vWUnNKkJHtf
i56IdQgENtOAWoyxDofyqqgSue+nWJ1wYG8xRypbi6UO8/44uRFBY82qRyCa8OD0
XsILlUsrN3a5p9GXJzvUsc7Ylpoy/ad7lhHgEQ/QToAZCgrnQPmQVMNbXWzFlowY
xCIHAJnwwhrk2IHKMIpKH0BowY64lL47Xb6qEI+LfBD7K3VHTC8DZNBb3hbxMiLx
rDIRboLyjXhJ5y+Jipyd/5W/cA4hv9ouCFZl6S7jk5Ug1m2zo/pF+d1HO09eF66w
Zn6Xd9IUF//cjaB1KQtGZ6h4hHBtLynuTWJLcmSu6jUtpJy1fZU=
=N/Z4
-----END PGP SIGNATURE-----

--Apple-Mail=_35BEA7E2-3A35-49AD-821D-4E4C8379353D--
