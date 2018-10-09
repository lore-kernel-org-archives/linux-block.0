Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr690087.outbound.protection.outlook.com ([40.107.69.87]:54307
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726600AbeJITxS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Oct 2018 15:53:18 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>
Subject: Re: [PATCH 3/5] lightnvm: Flexible DMA pool entry size
Date: Tue, 9 Oct 2018 12:36:25 +0000
Message-ID: <6F3973DD-EE38-4250-9D0A-094EAFEF5C20@cnexlabs.com>
References: <20181005133437.25255-1-igor.j.konopko@intel.com>
 <20181005133437.25255-4-igor.j.konopko@intel.com>
 <CANr-nt2xoSM60je_EpK0UAvhf2-0=9GPiUsisppoMfNKYT_dhA@mail.gmail.com>
 <76a225ff-b375-4464-c184-a642be3c27c0@intel.com>
 <CANr-nt3doDy2mPmrrgR3aSbG7pPAct+OBRTWGL5s+fQf+h+NuA@mail.gmail.com>
In-Reply-To: <CANr-nt3doDy2mPmrrgR3aSbG7pPAct+OBRTWGL5s+fQf+h+NuA@mail.gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_9F543E76-F649-46FD-A229-C6D7D03DE032";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_9F543E76-F649-46FD-A229-C6D7D03DE032
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 9 Oct 2018, at 21.10, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> On Tue, Oct 9, 2018 at 12:03 PM Igor Konopko =
<igor.j.konopko@intel.com> wrote:
>> On 09.10.2018 11:16, Hans Holmberg wrote:
>>> On Fri, Oct 5, 2018 at 3:38 PM Igor Konopko =
<igor.j.konopko@intel.com> wrote:
>>>> Currently whole lightnvm and pblk uses single DMA pool,
>>>> for which entry size is always equal to PAGE_SIZE.
>>>> PPA list always needs 8b*64, so there is only 56b*64
>>>> space for OOB meta. Since NVMe OOB meta can be bigger,
>>>> such as 128b, this solution is not robustness.
>>>>=20
>>>> This patch add the possiblity to support OOB meta above
>>>> 56b by creating separate DMA pool for PBLK with entry
>>>> size which is big enough to store both PPA list and such
>>>> a OOB metadata.
>>>>=20
>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>> ---
>>>>  drivers/lightnvm/core.c          | 33 =
+++++++++++++++++++++++---------
>>>>  drivers/lightnvm/pblk-core.c     | 19 +++++++++---------
>>>>  drivers/lightnvm/pblk-init.c     | 11 +++++++++++
>>>>  drivers/lightnvm/pblk-read.c     |  3 ++-
>>>>  drivers/lightnvm/pblk-recovery.c |  9 +++++----
>>>>  drivers/lightnvm/pblk.h          | 11 ++++++++++-
>>>>  drivers/nvme/host/lightnvm.c     |  6 ++++--
>>>>  include/linux/lightnvm.h         |  8 +++++---
>>>>  8 files changed, 71 insertions(+), 29 deletions(-)
>>>>=20
>>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>>>> index efb976a863d2..48db7a096257 100644
>>>> --- a/drivers/lightnvm/core.c
>>>> +++ b/drivers/lightnvm/core.c
>>>> @@ -641,20 +641,33 @@ void nvm_unregister_tgt_type(struct =
nvm_tgt_type *tt)
>>>>  }
>>>>  EXPORT_SYMBOL(nvm_unregister_tgt_type);
>>>>=20
>>>> -void *nvm_dev_dma_alloc(struct nvm_dev *dev, gfp_t mem_flags,
>>>> -                                                       dma_addr_t =
*dma_handler)
>>>> +void *nvm_dev_dma_alloc(struct nvm_dev *dev, void *pool,
>>>> +                               gfp_t mem_flags, dma_addr_t =
*dma_handler)
>>>>  {
>>>> -       return dev->ops->dev_dma_alloc(dev, dev->dma_pool, =
mem_flags,
>>>> -                                                               =
dma_handler);
>>>> +       return dev->ops->dev_dma_alloc(dev, pool ?: dev->dma_pool,
>>>> +                                               mem_flags, =
dma_handler);
>>>>  }
>>>>  EXPORT_SYMBOL(nvm_dev_dma_alloc);
>>>>=20
>>>> -void nvm_dev_dma_free(struct nvm_dev *dev, void *addr, dma_addr_t =
dma_handler)
>>>> +void nvm_dev_dma_free(struct nvm_dev *dev, void *pool,
>>>> +                               void *addr, dma_addr_t dma_handler)
>>>>  {
>>>> -       dev->ops->dev_dma_free(dev->dma_pool, addr, dma_handler);
>>>> +       dev->ops->dev_dma_free(pool ?: dev->dma_pool, addr, =
dma_handler);
>>>>  }
>>>>  EXPORT_SYMBOL(nvm_dev_dma_free);
>>>>=20
>>>> +void *nvm_dev_dma_create(struct nvm_dev *dev, int size, char =
*name)
>>>> +{
>>>> +       return dev->ops->create_dma_pool(dev, name, size);
>>>> +}
>>>> +EXPORT_SYMBOL(nvm_dev_dma_create);
>>>> +
>>>> +void nvm_dev_dma_destroy(struct nvm_dev *dev, void *pool)
>>>> +{
>>>> +       dev->ops->destroy_dma_pool(pool);
>>>> +}
>>>> +EXPORT_SYMBOL(nvm_dev_dma_destroy);
>>>> +
>>>>  static struct nvm_dev *nvm_find_nvm_dev(const char *name)
>>>>  {
>>>>         struct nvm_dev *dev;
>>>> @@ -682,7 +695,8 @@ static int nvm_set_rqd_ppalist(struct =
nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
>>>>         }
>>>>=20
>>>>         rqd->nr_ppas =3D nr_ppas;
>>>> -       rqd->ppa_list =3D nvm_dev_dma_alloc(dev, GFP_KERNEL, =
&rqd->dma_ppa_list);
>>>> +       rqd->ppa_list =3D nvm_dev_dma_alloc(dev, NULL, GFP_KERNEL,
>>>> +                                               =
&rqd->dma_ppa_list);
>>>>         if (!rqd->ppa_list) {
>>>>                 pr_err("nvm: failed to allocate dma memory\n");
>>>>                 return -ENOMEM;
>>>> @@ -708,7 +722,8 @@ static void nvm_free_rqd_ppalist(struct =
nvm_tgt_dev *tgt_dev,
>>>>         if (!rqd->ppa_list)
>>>>                 return;
>>>>=20
>>>> -       nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, =
rqd->dma_ppa_list);
>>>> +       nvm_dev_dma_free(tgt_dev->parent, NULL, rqd->ppa_list,
>>>> +                               rqd->dma_ppa_list);
>>>>  }
>>>>=20
>>>>  static int nvm_set_flags(struct nvm_geo *geo, struct nvm_rq *rqd)
>>>> @@ -1145,7 +1160,7 @@ int nvm_register(struct nvm_dev *dev)
>>>>         if (!dev->q || !dev->ops)
>>>>                 return -EINVAL;
>>>>=20
>>>> -       dev->dma_pool =3D dev->ops->create_dma_pool(dev, =
"ppalist");
>>>> +       dev->dma_pool =3D dev->ops->create_dma_pool(dev, "ppalist", =
PAGE_SIZE);
>>>>         if (!dev->dma_pool) {
>>>>                 pr_err("nvm: could not create dma pool\n");
>>>>                 return -ENOMEM;
>>>=20
>>> Why hack the nvm_dev_ interfaces when you are not using the dev pool =
anyway?
>>> Wouldn't it be more straightforward to use dma_pool_* instead?
>>=20
>> In order to call dma_pool_create() I need NVMe device structure, =
which
>> in my understanding is not public, so this is why I decided to reuse
>> plumbing which was available in nvm_dev_* interfaces.
>=20
> Hmm, yes, I see now.
>=20
>> If there is some easy way to call dma_pool_create() from pblk module =
and
>> I'm missing that - let me know. I can rewrite this part, if there is
>> some better way to do so.
>=20
> Create and destroy needs to go through dev->ops, but once you have
> allocated the pool, there is no need for going through the dev->ops
> for allocate/free as far as I can see.
> Matias: can't we just replace .dev_dma_alloc / .dev_dma_free  by calls
> to dma_pool_alloc/free ?
>=20

When we implemented this, we thought we might need some extra driver
specific code, but it has not been the case.

I'm ok with making the allocations directly once your have the pool
provided by the driver lightnvm bits.

Igor: can you integrate this on the patches for next revision (still
some extra feedback to come though).

Thanks,
Javier

--Apple-Mail=_9F543E76-F649-46FD-A229-C6D7D03DE032
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlu8oMUACgkQIX4xUKFR
nnT6Jg//RPV2yjq1xebWk1y1jcS/OYTjWu9bRsyCyKb2t3hm+GTRFyEJXFD9rOfR
hoPYQSXUH6BPwr2SKv8ZscewIfmYWAP1g5fYKunRfeC11MdNAYqoFd4hxmlAQPMQ
bZ0BYKJ0yXnGr/OzkHo24OzXXU1W1IAxxv0KsWddqzPSX6l268/Z9Ylv4mCgy/b0
oJ2As62VsRhiP44JdqiQu1Dulm8X8SPwCo7lQgw8JH9rj9QKAFfc3Sx87IboJcGX
1yeVW6MkCdR9EJ6/2q5v1F82xrcEEWw/x0oxtqrCAt2CF9A7cFBJIQyWtqiFu3fI
HY5E9Z+HLdN1SZbu67GDyl++mWUWVIQETrcsQMsfnk4NQdq1FB4qun+hERRwO+F1
K3+sTBFETo3Bl11/8M9GnHPzLtRXC4tMwBO4E1R7lKhIsMdK42taicjqsFf1AI7E
jFxFC8a1pfoAkMoOqp9Q2R5EgE1Vd0sXEpJPLyhnmSwT0Z8Rq5dwgjls3pD1EdPm
gVyjGmMaIro+am0t5UVFMbba6IaAyrllyerqNwWqhW9MGbsaun9lt3eYfz8JlCfg
A5XPato3ltDGcsyrNYRDBYnXSZYRxCz0mXO4CfGti3z54uJCArJNf2GY9DjDg3od
JSnGTCBVGdiYBpkwHyvgbG1qnwjpSPOR8ZYV4VTnApJVC2ca6Wk=
=gzDZ
-----END PGP SIGNATURE-----

--Apple-Mail=_9F543E76-F649-46FD-A229-C6D7D03DE032--
