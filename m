Return-Path: <javier@cnexlabs.com>
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [V5 PATCH 0/3] lightnvm: pblk: take write semaphore on metadata
Date: Mon, 17 Sep 2018 10:11:33 +0000
Message-ID: <CF27AC45-B351-4AD9-956D-02EF4E05EF21@cnexlabs.com>
References: <1536665091-12641-1-git-send-email-javier@cnexlabs.com>
 <5d12e1ca-546d-7909-a8ce-b16ab4596041@lightnvm.io>
In-Reply-To: <5d12e1ca-546d-7909-a8ce-b16ab4596041@lightnvm.io>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_1AEE1F5A-EEBA-496A-B2CF-2CC4A944773C";
	protocol="application/pgp-signature";
	micalg=pgp-sha512
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

--Apple-Mail=_1AEE1F5A-EEBA-496A-B2CF-2CC4A944773C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Sep 2018, at 10.11, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 09/11/2018 01:24 PM, Javier Gonz=C3=A1lez wrote:
>> # Changes since V4:
>>  - Rebase on top of Matias' core
>>  - Reorder patches to avoid in-patchset changes
>> # Changes since V3:
>>  - Encapsulate rqd dma allocations to reduce code replication (by =
Matias)
>> # Changes since V2:
>>  - Split the original patch between the metadata refactoring and the
>>    semaphore logic. This simplifies the write path, where the =
semaphore
>>    is taken.
>> # Changes singe V1:
>>     - Fix double I/O on the read path (by Matias)
>>     - Improve commit message (by Jens)
>> This patchset refactors the metadata separate write and read paths,
>> which simplifies how the semaphore is taken for writes.
>> Thanks,
>> Javier
>> Javier Gonz=C3=A1lez (3):
>>   lightnvm: encapsule rqd dma allocations
>>   lightnvm: pblk: refactor metadata paths
>>   lightnvm: pblk: take write semaphore on metadata
>>  drivers/lightnvm/pblk-core.c     | 376 =
++++++++++++++++++++-------------------
>>  drivers/lightnvm/pblk-gc.c       |   2 +-
>>  drivers/lightnvm/pblk-read.c     |  31 ++--
>>  drivers/lightnvm/pblk-recovery.c |  34 ++--
>>  drivers/lightnvm/pblk-write.c    |  15 +-
>>  drivers/lightnvm/pblk.h          |   7 +-
>>  6 files changed, 222 insertions(+), 243 deletions(-)
>=20
> Thanks. Applied for 4.20. I've renamed the first patch to "lightnvm: =
pblk: encapsulate rqd dma allocations".

Sounds good. Thanks!

Javier

--Apple-Mail=_1AEE1F5A-EEBA-496A-B2CF-2CC4A944773C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluffc8ACgkQIX4xUKFR
nnTKJQ/+OT2C2cAopVq8N8MRdhprjtIrLkfqf5gKj4zkLb0aNtiuApSQUPTwnnwF
9L546U6kUQo6t5tPmlesz91JK6RozitqUnzb1e5kCqmCOEOSmyayBS6wqI3zyjV7
Knd9pVD/cZ6mUoWl5dkyTadOGn3NX1ke1BSXcAseWi9JOPgnJFvpYubSL2TZK26h
ZRka8M76qSCJMkxiinyT1wvDY7OxYJDtO5j3S+RiEAl5dWzdvUapoQqTNExSj+Kl
ZBhTgn0LNrsjdgOV0/t9j9EQhA8OvnvL8GPEaP5w7YPskuXh8a4ec2ugbmjVd6f7
8pldIVFymhPxIhciRrPVexuQ7n1LNvmN/xjr7bszIulMosX/8xeYjrYVRWRU8I/N
bTb52N9LTsEgbLjsKFx1y8Et3dXRvsEhMl+rPG3wTlhku+qnZS7yTap5UlX+GYJG
jivHIPi4EcqXzsm5QXu5pRYhYjpOn3F8lhj8iPdZjv913skQoJRpV+O1taiUcVRv
OWIu312ZcQJx6zlmgcBk/4fQK4ZVygSFuAUyg9wgtQHz9+kL/HwaY3IsUqYo3D+H
fCxft7EMWQWRXg0sM7zFzYxa2GCkawmUumY9EAlQZSxatpgZYfWlAOiBOHTpz0Hj
dGfOkWFfm4XrDcJyPDtyQqTGM4ItpncOmbCiiOLCTKqoFvGcjnY=
=P9HD
-----END PGP SIGNATURE-----

--Apple-Mail=_1AEE1F5A-EEBA-496A-B2CF-2CC4A944773C--
