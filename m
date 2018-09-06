Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr720057.outbound.protection.outlook.com ([40.107.72.57]:55763
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727636AbeIFRo6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Sep 2018 13:44:58 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
CC: "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] lightnvm: pblk-recovery: lightnvm: pblk: Fix two
 sleep-in-atomic-context bugs
Date: Thu, 6 Sep 2018 13:09:20 +0000
Message-ID: <C958C918-4EF4-4AB8-AFC2-4B5B76FCE9F3@cnexlabs.com>
References: <20180905084017.27593-1-baijiaju1990@gmail.com>
 <CANr-nt3AS_p9n7R54045iGAd=woK+S66d85Q8SLgVTBFhZgVPA@mail.gmail.com>
In-Reply-To: <CANr-nt3AS_p9n7R54045iGAd=woK+S66d85Q8SLgVTBFhZgVPA@mail.gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_39A441F6-071B-4937-A37F-158932A537BC";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_39A441F6-071B-4937-A37F-158932A537BC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 6 Sep 2018, at 00.51, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> On Wed, Sep 5, 2018 at 10:40 AM Jia-Ju Bai <baijiaju1990@gmail.com> =
wrote:
>> The driver may sleep with holding a spinlock.
>>=20
>> The function call paths (from bottom to top) in Linux-4.16 are:
>>=20
>> [FUNC] nvm_dev_dma_alloc(GFP_KERNEL)
>> drivers/lightnvm/pblk-core.c, 754:
>>        nvm_dev_dma_alloc in pblk_line_submit_smeta_io
>> drivers/lightnvm/pblk-core.c, 1048:
>>        pblk_line_submit_smeta_io in pblk_line_init_bb
>> drivers/lightnvm/pblk-core.c, 1434:
>>        pblk_line_init_bb in pblk_line_replace_data
>> drivers/lightnvm/pblk-recovery.c, 980:
>>        pblk_line_replace_data in pblk_recov_l2p
>> drivers/lightnvm/pblk-recovery.c, 976:
>>        spin_lock in pblk_recov_l2p
>>=20
>> [FUNC] bio_map_kern(GFP_KERNEL)
>> drivers/lightnvm/pblk-core.c, 762:
>>        bio_map_kern in pblk_line_submit_smeta_io
>> drivers/lightnvm/pblk-core.c, 1048:
>>        pblk_line_submit_smeta_io in pblk_line_init_bb
>> drivers/lightnvm/pblk-core.c, 1434:
>>        pblk_line_init_bb in pblk_line_replace_data
>> drivers/lightnvm/pblk-recovery.c, 980:
>>        pblk_line_replace_data in pblk_recov_l2p
>> drivers/lightnvm/pblk-recovery.c, 976:
>>        spin_lock in pblk_recov_l2p
>>=20
>> To fix these bugs, the call to pblk_line_replace_data()
>> is moved out of the spinlock protection.
>>=20
>> These bugs are found by my static analysis tool DSAC.
>>=20
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>> v2:
>> * Move the call to pblk_line_replace_data() out of the spinlock
>>  protection, instead of v1 that changes GFP_KERNEL to GFP_ATOMIC in
>>  the calls to bio_map_kern() and nvm_dev_dma_alloc().
>>  Thanks Javier for good advice.
>> ---
>> drivers/lightnvm/pblk-recovery.c | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
>> index 3a5069183859..5fde414d78bb 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -955,12 +955,14 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
>>                }
>>        }
>>=20
>> -       spin_lock(&l_mg->free_lock);
>>        if (!open_lines) {
>> +               spin_lock(&l_mg->free_lock);
>>                WARN_ON_ONCE(!test_and_clear_bit(meta_line,
>>                                                        =
&l_mg->meta_bitmap));
>> +               spin_unlock(&l_mg->free_lock);
>>                pblk_line_replace_data(pblk);
>>        } else {
>> +               spin_lock(&l_mg->free_lock);
>>                /* Allocate next line for preparation */
>>                l_mg->data_next =3D pblk_line_get(pblk);
>>                if (l_mg->data_next) {
>> @@ -968,8 +970,8 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
>>                        l_mg->data_next->type =3D PBLK_LINETYPE_DATA;
>>                        is_next =3D 1;
>>                }
>> +               spin_unlock(&l_mg->free_lock);
>>        }
>> -       spin_unlock(&l_mg->free_lock);
>=20
> Wouldn't the most straight forward solution here to not take the lock?
>=20
> As pblk is doing all the recovery sequentially during initialization,
> I don't see the
> reason for grabbing the lock.
>=20

We start doing GC as we recover and, even though right now there is no
interference, the code might change. For such a little change, I would
rather maintain lock consistency than being smart about where we can
avoid locking - specially when this is not the fast path.

Javier


--Apple-Mail=_39A441F6-071B-4937-A37F-158932A537BC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluRJwgACgkQIX4xUKFR
nnQ4gg/+J8tfR2p9n1eE8pmXZrAz25yjjWJjiVOv7eaEFtfoSyY8QhG81EV5F+F1
64pLvb0zxcCUKw058ElNqtu3vzgMUXecLKL9G8sUhix2Toj9krq/GGbgw5/wEeJ6
fRLUhduUMhTcMc/8axYlfID74fca6ZOj8vRiIhY3NJO6bEZirAdJo9J/f5RLNiAi
vI1zXp9zTGsO+dEj3sgTWfKZlcvc+6ItHdW6q9R3TKKgYscQ/BtFQiaVeK8GoSkT
iQBcAeha/hUHt0TZ50+H4YT5d+/8IBPxKUsq5cnOyrnwfgqlmWVybUQFLzb6gj7t
9lvkXpq8Z0evQt5rZxyNffREoNyEMLqz4eyQOB/m2AE15VIUCqae6wbkxVf8lfGp
hkdCiYuTMYMcI35dyrbl42QafUzhahAfRDj3GU7VF5P1g334RC++X7o1+sDReDQE
K/ze2Jrmxh/FdORt3DKnyhuP00BL+31zrQO24XWc0KM2w7pLgpiu/Sp25A6WxTY7
QicQPbS42w2Ue+0c2x4x9EPf2A+S1SQ8iZfPlr2hgH22v01DT2CtW0o5wAmcDSP7
sDbIy9YjalCZCMLDcSzig+JQBSzxVdNqKne/pYcxZc+EpuOeVMr4VistpngSlqg5
o/D9Z26kv1zAhq9SKHN+IjiF1W1PYRFe8B9KsXH5KoBdsoUqOBQ=
=/hCW
-----END PGP SIGNATURE-----

--Apple-Mail=_39A441F6-071B-4937-A37F-158932A537BC--
