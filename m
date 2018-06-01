Return-Path: <javigon.napster@gmail.com>
Return-Path: <javigon.napster@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] lightnvm: pblk: remove unnecessary bio_get/put
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javigon.napster@gmail.com>
In-Reply-To: <eff06ff6-f4fd-59e6-6376-c41deb923e00@lightnvm.io>
Date: Fri, 1 Jun 2018 12:48:10 +0200
Cc: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <D8627075-E2D2-4493-8259-3DF14F79C73C@gmail.com>
References: <1523874157-5216-1-git-send-email-javier@cnexlabs.com> <4453F92A-4B78-4D2B-B438-3C807DF13514@javigon.com> <eff06ff6-f4fd-59e6-6376-c41deb923e00@lightnvm.io>
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
List-ID: <linux-block@vger.kernel.org>


> On 1 Jun 2018, at 12.42, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
>> On 06/01/2018 12:22 PM, Javier Gonz=C3=A1lez wrote:
>> Hi Matias,
>> I see that you did not pick up this patch for 4.18. Any reason for it?
>> Thanks,
>> Javier
>>> On 16 Apr 2018, at 12.22, Javier Gonz=C3=A1lez <javier@javigon.com> wrot=
e:
>>>=20
>>> In the read path, pblk gets a reference to the incoming bio and puts it
>>> after ending the bio. Though this behavior is correct, it is unnecessary=

>>> since pblk is the one putting the bio, therefore, it cannot disappear
>>> underneath it.
>>>=20
>>> Removing this reference, allows to clean up rqd->bio and avoid pointer
>>> bouncing for the different read paths. Now, the incoming bio always
>>> resides in the read context and pblk's internal bios (if any) reside in
>>> rqd->bio.
>>>=20
>>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>>> ---
>>> drivers/lightnvm/pblk-read.c | 57 +++++++++++++++++++-------------------=
------
>>> 1 file changed, 24 insertions(+), 33 deletions(-)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c=

>>> index 2f8224354c62..5464e4177c87 100644
>>> --- a/drivers/lightnvm/pblk-read.c
>>> +++ b/drivers/lightnvm/pblk-read.c
>>> @@ -39,10 +39,10 @@ static int pblk_read_from_cache(struct pblk *pblk, s=
truct bio *bio,
>>> }
>>>=20
>>> static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
>>> -                 sector_t blba, unsigned long *read_bitmap)
>>> +                 struct bio *bio, sector_t blba,
>>> +                 unsigned long *read_bitmap)
>>> {
>>>    struct pblk_sec_meta *meta_list =3D rqd->meta_list;
>>> -    struct bio *bio =3D rqd->bio;
>>>    struct ppa_addr ppas[PBLK_MAX_REQ_ADDRS];
>>>    int nr_secs =3D rqd->nr_ppas;
>>>    bool advanced_bio =3D false;
>>> @@ -189,7 +189,6 @@ static void pblk_end_user_read(struct bio *bio)
>>>    WARN_ONCE(bio->bi_status, "pblk: corrupted read bio\n");
>>> #endif
>>>    bio_endio(bio);
>>> -    bio_put(bio);
>>> }
>>>=20
>>> static void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd,
>>> @@ -197,23 +196,18 @@ static void __pblk_end_io_read(struct pblk *pblk, s=
truct nvm_rq *rqd,
>>> {
>>>    struct nvm_tgt_dev *dev =3D pblk->dev;
>>>    struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
>>> -    struct bio *bio =3D rqd->bio;
>>> +    struct bio *int_bio =3D rqd->bio;
>>>    unsigned long start_time =3D r_ctx->start_time;
>>>=20
>>>    generic_end_io_acct(dev->q, READ, &pblk->disk->part0, start_time);
>>>=20
>>>    if (rqd->error)
>>>        pblk_log_read_err(pblk, rqd);
>>> -#ifdef CONFIG_NVM_DEBUG
>>> -    else
>>> -        WARN_ONCE(bio->bi_status, "pblk: corrupted read error\n");
>>> -#endif
>>>=20
>>>    pblk_read_check_seq(pblk, rqd, r_ctx->lba);
>>>=20
>>> -    bio_put(bio);
>>> -    if (r_ctx->private)
>>> -        pblk_end_user_read((struct bio *)r_ctx->private);
>>> +    if (int_bio)
>>> +        bio_put(int_bio);
>>>=20
>>>    if (put_line)
>>>        pblk_read_put_rqd_kref(pblk, rqd);
>>> @@ -230,16 +224,19 @@ static void __pblk_end_io_read(struct pblk *pblk, s=
truct nvm_rq *rqd,
>>> static void pblk_end_io_read(struct nvm_rq *rqd)
>>> {
>>>    struct pblk *pblk =3D rqd->private;
>>> +    struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
>>> +    struct bio *bio =3D (struct bio *)r_ctx->private;
>>>=20
>>> +    pblk_end_user_read(bio);
>>>    __pblk_end_io_read(pblk, rqd, true);
>>> }
>>>=20
>>> -static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,=

>>> -                 unsigned int bio_init_idx,
>>> -                 unsigned long *read_bitmap)
>>> +static int pblk_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
>>> +                 struct bio *orig_bio, unsigned int bio_init_idx,
>>> +                 unsigned long *read_bitmap)
>>> {
>>> -    struct bio *new_bio, *bio =3D rqd->bio;
>>>    struct pblk_sec_meta *meta_list =3D rqd->meta_list;
>>> +    struct bio *new_bio;
>>>    struct bio_vec src_bv, dst_bv;
>>>    void *ppa_ptr =3D NULL;
>>>    void *src_p, *dst_p;
>>> @@ -319,7 +316,7 @@ static int pblk_partial_read_bio(struct pblk *pblk, s=
truct nvm_rq *rqd,
>>>        meta_list[hole].lba =3D lba_list_media[i];
>>>=20
>>>        src_bv =3D new_bio->bi_io_vec[i++];
>>> -        dst_bv =3D bio->bi_io_vec[bio_init_idx + hole];
>>> +        dst_bv =3D orig_bio->bi_io_vec[bio_init_idx + hole];
>>>=20
>>>        src_p =3D kmap_atomic(src_bv.bv_page);
>>>        dst_p =3D kmap_atomic(dst_bv.bv_page);
>>> @@ -338,28 +335,26 @@ static int pblk_partial_read_bio(struct pblk *pblk=
, struct nvm_rq *rqd,
>>>=20
>>>    bio_put(new_bio);
>>>=20
>>> -    /* Complete the original bio and associated request */
>>> -    bio_endio(bio);
>>> -    rqd->bio =3D bio;
>>> +    /* restore original request */
>>> +    rqd->bio =3D NULL;
>>>    rqd->nr_ppas =3D nr_secs;
>>>=20
>>>    __pblk_end_io_read(pblk, rqd, false);
>>> -    return NVM_IO_OK;
>>> +    return NVM_IO_DONE;
>>>=20
>>> err:
>>>    pr_err("pblk: failed to perform partial read\n");
>>>=20
>>>    /* Free allocated pages in new bio */
>>> -    pblk_bio_free_pages(pblk, bio, 0, new_bio->bi_vcnt);
>>> +    pblk_bio_free_pages(pblk, orig_bio, 0, new_bio->bi_vcnt);
>>>    __pblk_end_io_read(pblk, rqd, false);
>>>    return NVM_IO_ERR;
>>> }
>>>=20
>>> -static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd,
>>> +static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct b=
io *bio,
>>>             sector_t lba, unsigned long *read_bitmap)
>>> {
>>>    struct pblk_sec_meta *meta_list =3D rqd->meta_list;
>>> -    struct bio *bio =3D rqd->bio;
>>>    struct ppa_addr ppa;
>>>=20
>>>    pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
>>> @@ -423,14 +418,15 @@ int pblk_submit_read(struct pblk *pblk, struct bio=
 *bio)
>>>    rqd =3D pblk_alloc_rqd(pblk, PBLK_READ);
>>>=20
>>>    rqd->opcode =3D NVM_OP_PREAD;
>>> -    rqd->bio =3D bio;
>>>    rqd->nr_ppas =3D nr_secs;
>>> +    rqd->bio =3D NULL; /* cloned bio if needed */
>>>    rqd->private =3D pblk;
>>>    rqd->end_io =3D pblk_end_io_read;
>>>=20
>>>    r_ctx =3D nvm_rq_to_pdu(rqd);
>>>    r_ctx->start_time =3D jiffies;
>>>    r_ctx->lba =3D blba;
>>> +    r_ctx->private =3D bio; /* original bio */
>>>=20
>>>    /* Save the index for this bio's start. This is needed in case
>>>     * we need to fill a partial read.
>>> @@ -448,17 +444,15 @@ int pblk_submit_read(struct pblk *pblk, struct bio=
 *bio)
>>>        rqd->ppa_list =3D rqd->meta_list + pblk_dma_meta_size;
>>>        rqd->dma_ppa_list =3D rqd->dma_meta_list + pblk_dma_meta_size;
>>>=20
>>> -        pblk_read_ppalist_rq(pblk, rqd, blba, &read_bitmap);
>>> +        pblk_read_ppalist_rq(pblk, rqd, bio, blba, &read_bitmap);
>>>    } else {
>>> -        pblk_read_rq(pblk, rqd, blba, &read_bitmap);
>>> +        pblk_read_rq(pblk, rqd, bio, blba, &read_bitmap);
>>>    }
>>>=20
>>> -    bio_get(bio);
>>>    if (bitmap_full(&read_bitmap, nr_secs)) {
>>> -        bio_endio(bio);
>>>        atomic_inc(&pblk->inflight_io);
>>>        __pblk_end_io_read(pblk, rqd, false);
>>> -        return NVM_IO_OK;
>>> +        return NVM_IO_DONE;
>>>    }
>>>=20
>>>    /* All sectors are to be read from the device */
>>> @@ -473,13 +467,10 @@ int pblk_submit_read(struct pblk *pblk, struct bio=
 *bio)
>>>        }
>>>=20
>>>        rqd->bio =3D int_bio;
>>> -        r_ctx->private =3D bio;
>>>=20
>>>        ret =3D pblk_submit_io(pblk, rqd);
>>>        if (ret) {
>>>            pr_err("pblk: read IO submission failed\n");
>>> -            if (int_bio)
>>> -                bio_put(int_bio);
>>>            goto fail_end_io;
>>>        }
>>>=20
>>> @@ -489,7 +480,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *=
bio)
>>>    /* The read bio request could be partially filled by the write buffer=
,
>>>     * but there are some holes that need to be read from the drive.
>>>     */
>>> -    return pblk_partial_read_bio(pblk, rqd, bio_init_idx, &read_bitmap)=
;
>>> +    return pblk_partial_read(pblk, rqd, bio, bio_init_idx, &read_bitmap=
);
>>>=20
>>> fail_rqd_free:
>>>    pblk_free_rqd(pblk, rqd, PBLK_READ);
>>> --
>>> 2.7.4
>=20
> You sent a larger patch serie afterwards that I thought took precedent (an=
d not included in for-4.18/pblk).  Feel free to rebase and resend.


Sounds good. I thought you had some comments on it - that=E2=80=99s why I wa=
ited a couple of days after you sent the PR. I=E2=80=99ll resend now. Can yo=
u apply it to the 4.18 PR?

Thanks!
Javier.=20=
