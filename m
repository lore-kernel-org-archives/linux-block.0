Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0077.outbound.protection.outlook.com ([104.47.40.77]:4000
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726564AbeJIUsS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Oct 2018 16:48:18 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "hans.ml.holmberg@owltronix.com" <hans.ml.holmberg@owltronix.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>
Subject: Re: [PATCH 3/5] lightnvm: Flexible DMA pool entry size
Date: Tue, 9 Oct 2018 13:31:13 +0000
Message-ID: <A280C756-99F0-4924-9109-FCA170F5D0EB@cnexlabs.com>
References: <20181005133437.25255-1-igor.j.konopko@intel.com>
 <20181005133437.25255-4-igor.j.konopko@intel.com>
 <CANr-nt2xoSM60je_EpK0UAvhf2-0=9GPiUsisppoMfNKYT_dhA@mail.gmail.com>
 <76a225ff-b375-4464-c184-a642be3c27c0@intel.com>
 <CANr-nt3doDy2mPmrrgR3aSbG7pPAct+OBRTWGL5s+fQf+h+NuA@mail.gmail.com>
 <e5fcd475-09e9-8e25-2e02-3897b9331d8b@lightnvm.io>
 <DAB4F6C9-D09D-42B1-8DB9-07BD4A233007@cnexlabs.com>
 <7aac4b5a-dc13-acf9-2582-4541567374e2@lightnvm.io>
In-Reply-To: <7aac4b5a-dc13-acf9-2582-4541567374e2@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_F548444B-6322-453D-9620-4BB5E7313209";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_F548444B-6322-453D-9620-4BB5E7313209
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 9 Oct 2018, at 22.23, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 10/09/2018 03:10 PM, Javier Gonzalez wrote:
>>> On 9 Oct 2018, at 21.56, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 10/09/2018 02:10 PM, Hans Holmberg wrote:
>>>> On Tue, Oct 9, 2018 at 12:03 PM Igor Konopko =
<igor.j.konopko@intel.com> wrote:
>>>>> On 09.10.2018 11:16, Hans Holmberg wrote:
>>>>>> On Fri, Oct 5, 2018 at 3:38 PM Igor Konopko =
<igor.j.konopko@intel.com> wrote:
>>>>>>> Currently whole lightnvm and pblk uses single DMA pool,
>>>>>>> for which entry size is always equal to PAGE_SIZE.
>>>>>>> PPA list always needs 8b*64, so there is only 56b*64
>>>>>>> space for OOB meta. Since NVMe OOB meta can be bigger,
>>>>>>> such as 128b, this solution is not robustness.
>>>>>>>=20
>>>>>>> This patch add the possiblity to support OOB meta above
>>>>>>> 56b by creating separate DMA pool for PBLK with entry
>>>>>>> size which is big enough to store both PPA list and such
>>>>>>> a OOB metadata.
>>>>>>>=20
>>>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>>>>> ---
>>>>>>>   drivers/lightnvm/core.c          | 33 =
+++++++++++++++++++++++---------
>>>>>>>   drivers/lightnvm/pblk-core.c     | 19 +++++++++---------
>>>>>>>   drivers/lightnvm/pblk-init.c     | 11 +++++++++++
>>>>>>>   drivers/lightnvm/pblk-read.c     |  3 ++-
>>>>>>>   drivers/lightnvm/pblk-recovery.c |  9 +++++----
>>>>>>>   drivers/lightnvm/pblk.h          | 11 ++++++++++-
>>>>>>>   drivers/nvme/host/lightnvm.c     |  6 ++++--
>>>>>>>   include/linux/lightnvm.h         |  8 +++++---
>>>>>>>   8 files changed, 71 insertions(+), 29 deletions(-)
>>>>>>>=20
>>>>>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>>>>>>> index efb976a863d2..48db7a096257 100644
>>>>>>> --- a/drivers/lightnvm/core.c
>>>>>>> +++ b/drivers/lightnvm/core.c
>>>>>>> @@ -641,20 +641,33 @@ void nvm_unregister_tgt_type(struct =
nvm_tgt_type *tt)
>>>>>>>   }
>>>>>>>   EXPORT_SYMBOL(nvm_unregister_tgt_type);
>>>>>>>=20
>>>>>>> -void *nvm_dev_dma_alloc(struct nvm_dev *dev, gfp_t mem_flags,
>>>>>>> -                                                       =
dma_addr_t *dma_handler)
>>>>>>> +void *nvm_dev_dma_alloc(struct nvm_dev *dev, void *pool,
>>>>>>> +                               gfp_t mem_flags, dma_addr_t =
*dma_handler)
>>>>>>>   {
>>>>>>> -       return dev->ops->dev_dma_alloc(dev, dev->dma_pool, =
mem_flags,
>>>>>>> -                                                               =
dma_handler);
>>>>>>> +       return dev->ops->dev_dma_alloc(dev, pool ?: =
dev->dma_pool,
>>>>>>> +                                               mem_flags, =
dma_handler);
>>>>>>>   }
>>>>>>>   EXPORT_SYMBOL(nvm_dev_dma_alloc);
>>>>>>>=20
>>>>>>> -void nvm_dev_dma_free(struct nvm_dev *dev, void *addr, =
dma_addr_t dma_handler)
>>>>>>> +void nvm_dev_dma_free(struct nvm_dev *dev, void *pool,
>>>>>>> +                               void *addr, dma_addr_t =
dma_handler)
>>>>>>>   {
>>>>>>> -       dev->ops->dev_dma_free(dev->dma_pool, addr, =
dma_handler);
>>>>>>> +       dev->ops->dev_dma_free(pool ?: dev->dma_pool, addr, =
dma_handler);
>>>>>>>   }
>>>>>>>   EXPORT_SYMBOL(nvm_dev_dma_free);
>>>>>>>=20
>>>>>>> +void *nvm_dev_dma_create(struct nvm_dev *dev, int size, char =
*name)
>>>>>>> +{
>>>>>>> +       return dev->ops->create_dma_pool(dev, name, size);
>>>>>>> +}
>>>>>>> +EXPORT_SYMBOL(nvm_dev_dma_create);
>>>>>>> +
>>>>>>> +void nvm_dev_dma_destroy(struct nvm_dev *dev, void *pool)
>>>>>>> +{
>>>>>>> +       dev->ops->destroy_dma_pool(pool);
>>>>>>> +}
>>>>>>> +EXPORT_SYMBOL(nvm_dev_dma_destroy);
>>>>>>> +
>>>>>>>   static struct nvm_dev *nvm_find_nvm_dev(const char *name)
>>>>>>>   {
>>>>>>>          struct nvm_dev *dev;
>>>>>>> @@ -682,7 +695,8 @@ static int nvm_set_rqd_ppalist(struct =
nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
>>>>>>>          }
>>>>>>>=20
>>>>>>>          rqd->nr_ppas =3D nr_ppas;
>>>>>>> -       rqd->ppa_list =3D nvm_dev_dma_alloc(dev, GFP_KERNEL, =
&rqd->dma_ppa_list);
>>>>>>> +       rqd->ppa_list =3D nvm_dev_dma_alloc(dev, NULL, =
GFP_KERNEL,
>>>>>>> +                                               =
&rqd->dma_ppa_list);
>>>>>>>          if (!rqd->ppa_list) {
>>>>>>>                  pr_err("nvm: failed to allocate dma memory\n");
>>>>>>>                  return -ENOMEM;
>>>>>>> @@ -708,7 +722,8 @@ static void nvm_free_rqd_ppalist(struct =
nvm_tgt_dev *tgt_dev,
>>>>>>>          if (!rqd->ppa_list)
>>>>>>>                  return;
>>>>>>>=20
>>>>>>> -       nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, =
rqd->dma_ppa_list);
>>>>>>> +       nvm_dev_dma_free(tgt_dev->parent, NULL, rqd->ppa_list,
>>>>>>> +                               rqd->dma_ppa_list);
>>>>>>>   }
>>>>>>>=20
>>>>>>>   static int nvm_set_flags(struct nvm_geo *geo, struct nvm_rq =
*rqd)
>>>>>>> @@ -1145,7 +1160,7 @@ int nvm_register(struct nvm_dev *dev)
>>>>>>>          if (!dev->q || !dev->ops)
>>>>>>>                  return -EINVAL;
>>>>>>>=20
>>>>>>> -       dev->dma_pool =3D dev->ops->create_dma_pool(dev, =
"ppalist");
>>>>>>> +       dev->dma_pool =3D dev->ops->create_dma_pool(dev, =
"ppalist", PAGE_SIZE);
>>>>>>>          if (!dev->dma_pool) {
>>>>>>>                  pr_err("nvm: could not create dma pool\n");
>>>>>>>                  return -ENOMEM;
>>>>>>=20
>>>>>> Why hack the nvm_dev_ interfaces when you are not using the dev =
pool anyway?
>>>>>> Wouldn't it be more straightforward to use dma_pool_* instead?
>>>>>=20
>>>>> In order to call dma_pool_create() I need NVMe device structure, =
which
>>>>> in my understanding is not public, so this is why I decided to =
reuse
>>>>> plumbing which was available in nvm_dev_* interfaces.
>>>> Hmm, yes, I see now.
>>>>> If there is some easy way to call dma_pool_create() from pblk =
module and
>>>>> I'm missing that - let me know. I can rewrite this part, if there =
is
>>>>> some better way to do so.
>>>> Create and destroy needs to go through dev->ops, but once you have
>>>> allocated the pool, there is no need for going through the dev->ops
>>>> for allocate/free as far as I can see.
>>>> Matias: can't we just replace .dev_dma_alloc / .dev_dma_free  by =
calls
>>>> to dma_pool_alloc/free ?
>>>=20
>>> Better to make the initial dma alloc better. I don't want targets to =
play around with their own DMA pools.
>>>=20
>>> Something like the below (only compile tested :)):
>> Good idea. One comment below, though.
>>> diff --git i/drivers/lightnvm/core.c w/drivers/lightnvm/core.c
>>> index efb976a863d2..f87696aa6b57 100644
>>> --- i/drivers/lightnvm/core.c
>>> +++ w/drivers/lightnvm/core.c
>>> @@ -1141,11 +1141,17 @@ EXPORT_SYMBOL(nvm_alloc_dev);
>>> int nvm_register(struct nvm_dev *dev)
>>> {
>>>        int ret;
>>> +       int meta_sz;
>>>=20
>>>        if (!dev->q || !dev->ops)
>>>                return -EINVAL;
>>>=20
>>> -       dev->dma_pool =3D dev->ops->create_dma_pool(dev, "ppalist");
>>> +       /* Allow room for both metadata and ppa list in the dma pool =
*/
>>> +       meta_sz =3D (dev->geo.sos * NVM_MAX_VLBA) +
>>> +                                       (sizeof(uint64_t) * =
NVM_MAX_VLBA);
>>> +       meta_sz =3D PAGE_SIZE * (meta_sz >> PAGE_SHIFT);
>> Can we just send the required min meta_sz and then let the dma
>> allocation do the alignment? The diver knows if it can fit the
>> allocation without wasting unnecessary space.
>=20
> The alignment must be a power of two, and from what I can see, the
> size will be rounded up internally in the dma_pool_create function. I
> don't have a strong opinion either way.
>=20
>> Also, by sharing the ppa_list allocation and the metadata on the same
>> pool, we risk having unnecessary larger DMA buffers for the ppa_list.
>> Better have 2 pools, each with each own size. In fact, the only =
reason
>> we made the original allocation PAGE_SIZE was to fit the ppa_list and
>> metadata on the same allocation; now that we are relaxing this, we =
can
>> have tighter allocations for the ppa_list as there is a hard limit on =
64
>> lbas (512B).
>=20
> Let's keep it together for now. I want to avoid having if/else's in
> the target code that has to decide on which pool to use.

Why if/else? The lba list is allocated from the ppa_list pool and the
metadatada from the meta_pool. =46rom the target perspective it is
different pools for a different purposes, as opposed to the small pool
for 256B PRPs in the nvme driver, which requires a size check.

Am I missing something?

> Also, most devices will fit within the PAGE_SIZE allocation.

We hear requirements for larger OOB areas form different places, so I'm
not sure this is true anymore.

Javier

--Apple-Mail=_F548444B-6322-453D-9620-4BB5E7313209
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlu8rZ8ACgkQIX4xUKFR
nnTcwRAAnEY6GUySebrD1lghA/eQPHvMQHXvjuBMtkf2NqzmeFIjk+46UIsM0D4d
VCfGpqmcidACaWvu0jgkJPCZPTvLsX8DOFtXZpO3UtOqahCKK3izlNrAUJZXyqOJ
TU27B90QS1HrsBaqKUVnopRzdEs4MRolqS6m3jVLPl968rHSAkWA0u2ZY8pdV2yg
BjeCiHzmWTrVbUEVFF2kQ6Y4EeDp5XOj3qUi4pOwOkEWCdi6r88HJaOqWZSEl16s
wohc7M6RQyRBNqvJH4TMm7K7jEwVXTwI/VHwp+JLxFzjKl0AFH5C9/34ASurcsKD
4T7ec1d35MvywWr25mQ23Nht5GElmvfUXTAOGiDHiz5rPb5CZbO6UkMGUU8i7PPm
/27qw3DRVM6YtiFK8TOGyr92V+875tI6NqjUkomFYS9fxGBy4Gk/GDy5dJwUKMy/
yFajXhL5elkFUOtq87Gb7WIrskCKg9CjsyO18vdQMIP+YK50EWz1N+K3WRBPtKrQ
1qb4qoiXdi5GzUJfGYstVZheHcFDKdHGGFl9gPiIUJ1NnPUIReUIgpnXyRFcvXyv
BDzCsleHv05Y1UvwwuGnJgDJ4sKECiqDOZRmbLBnsshXBuV8yzn+j6dgqhzr+bEp
jLlV7lLC92yaQ3M19YLA3fckRu9Jpib8o4QnRXRBF5DHUQR5Jik=
=LYzs
-----END PGP SIGNATURE-----

--Apple-Mail=_F548444B-6322-453D-9620-4BB5E7313209--
