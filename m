Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39293 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729316AbeHMOyL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Aug 2018 10:54:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id h4-v6so8120022edi.6
        for <linux-block@vger.kernel.org>; Mon, 13 Aug 2018 05:12:09 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <61F640FB-E38C-41CE-B95A-D2CDAA0008EF@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_0C412472-56DD-42A0-87DE-E5A812CD2C81";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] lightnvm: pblk: take write semaphore on metadata
Date: Mon, 13 Aug 2018 14:12:04 +0200
In-Reply-To: <CANr-nt18UvLY7YjUqTDtd-mi+Az-WTMvcbCTC1uVgBpddS=zxQ@mail.gmail.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <1533297919-27253-1-git-send-email-javier@cnexlabs.com>
 <CANr-nt18UvLY7YjUqTDtd-mi+Az-WTMvcbCTC1uVgBpddS=zxQ@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_0C412472-56DD-42A0-87DE-E5A812CD2C81
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 10 Aug 2018, at 10.04, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> On Fri, Aug 3, 2018 at 2:05 PM, Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>> pblk guarantees write ordering at a chunk level through a per open =
chunk
>> semaphore. At this point, since we only have an open I/O stream for =
both
>> user and GC data, the semaphore is per parallel unit.
>>=20
>> Since metadata I/O is synchronous, the semaphore is not needed as
>> ordering is guaranteed. However, if the metadata scheme changes or
>> multiple streams are open, this guarantee might not be preserved.
>>=20
>> This patch makes sure that all writes go through the semaphore, even =
for
>> synchronous I/O. This is consistent with pblk's write I/O model. It =
also
>> simplifies maintenance since changes in the metdatada scheme could =
cause
>> ordering issues.
>>=20
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>> drivers/lightnvm/pblk-core.c | 14 ++++++++++++--
>> drivers/lightnvm/pblk.h      |  1 +
>> 2 files changed, 13 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index 00984b486fea..160b54d26bfa 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -493,6 +493,16 @@ int pblk_submit_io_sync(struct pblk *pblk, =
struct nvm_rq *rqd)
>>        return nvm_submit_io_sync(dev, rqd);
>> }
>>=20
>> +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
>> +{
>> +       if (rqd->opcode !=3D NVM_OP_PWRITE)
>> +               pblk_submit_io_sync(pblk, rqd);
>> +
>> +       pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
>=20
> This will only work if rqd->nr_ppas > 1, better check if rqd->nr_ppas
> is 1 and pass &ppa->ppa_addr on to pblk_down_page when needed.


For this particular case, we will always get > 1 ppas, but you're right,
it is more robust to do the check for future cases. I'll add that to V3.
Thanks!

Javier

--Apple-Mail=_0C412472-56DD-42A0-87DE-E5A812CD2C81
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAltxdZQACgkQPEYBfS0l
eODZnw//V7Q/gZ+s59nT4Wb4mt57BNSa81cogmG/6ge8L3ao+vFGLR0UN8udtAx9
cHUVTQpdtBLRlxQEYlOefMP7YYcWyH8vChO8Vg2eZHie0ivLpf3yfIv86Y7cgmSR
dzkQwbJqrw11WDgDv0FacAQeGPfr7pODMxw7JX5OaxKUP2QHm/5cWflmqTyAt/Qs
1C2G3vguI+BufHu4oMQkw42MpKgMtCMe1IRrwnVzA37tNPuxQJ5h6LAe1heohbNk
blCk0LEBVcwXUrKyawzR01Z5tIOpDS+Q7oDaV+MoMPS9fIBR2x1KlijIGIIeruc+
QRSKdxGPgaU7okbnMFJc1jgKHXPhUtyqLC3WwWjm7ebMS5qCGIjCmxwUoETR8T4I
szaa4LYBZ3iojlDAK1Pyo0SVbd+LRaUI1y+KlylH0hXS6vvq5bUEVr5QAiJKPpVE
i10XbMmVF/RiKxo4HZg84ipLifu15u61J29tJigcIadqG3Z3NIxwfVF4/cHczFCo
z3uBZFXqp7e/JhDmCZc3iLx78Mr9U2da9WXfOYMtRnZem3VqEHvRwb68aMvFTnG9
av0H6oZ6ZjAKutNP4ET2ZGl647thxTqBkeR7IXsxfQTMhoVbETwOGH3EmYuc4lnM
5NpgJ2fM9/HXQZY7F+QsM+2P0BB+vFraFyQewF55xP5wpU4vvRw=
=PtHW
-----END PGP SIGNATURE-----

--Apple-Mail=_0C412472-56DD-42A0-87DE-E5A812CD2C81--
