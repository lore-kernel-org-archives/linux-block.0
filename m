Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39679 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932689AbeGHKv1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Jul 2018 06:51:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id h20-v6so2108124wmb.4
        for <linux-block@vger.kernel.org>; Sun, 08 Jul 2018 03:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <1530871929-986-1-git-send-email-hlitz@ucsc.edu>
 <412824a1-d853-c104-08ca-d308cf719be1@lightnvm.io> <9e824089-9a52-cf00-dc32-d60360d66afd@intel.com>
In-Reply-To: <9e824089-9a52-cf00-dc32-d60360d66afd@intel.com>
From: Heiner Litz <hlitz@ucsc.edu>
Date: Sun, 8 Jul 2018 12:51:14 +0200
Message-ID: <CAJbgVnX3QrPu6okNQZC4vwq5j=HgpWx4Hz+2FwkSA8TqNKm4sQ@mail.gmail.com>
Subject: Re: [PATCH v3] lightnvm: pblk: add asynchronous partial read
To: igor.j.konopko@intel.com
Cc: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, Javier Gonzalez <javier@cnexlabs.com>,
        marcin.dziegielewski@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Thank you Igor! Nice catch. If this is the only issue I'll send another pat=
ch.
On Fri, Jul 6, 2018 at 7:51 PM Igor Konopko <igor.j.konopko@intel.com> wrot=
e:
>
>
>
> On 06.07.2018 05:18, Matias Bj=C3=B8rling wrote:
> > On 07/06/2018 12:12 PM, Heiner Litz wrote:
> >> In the read path, partial reads are currently performed synchronously
> >> which affects performance for workloads that generate many partial
> >> reads. This patch adds an asynchronous partial read path as well as
> >> the required partial read ctx.
> >>
> >> Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
> >>
> >> ---
> >>
> >> v3: rebase to head, incorporate 64-bit read bitmap
> >>
> >> ---
> >>   drivers/lightnvm/pblk-read.c | 183
> >> ++++++++++++++++++++++++++++---------------
> >>   drivers/lightnvm/pblk.h      |  10 +++
> >>   2 files changed, 130 insertions(+), 63 deletions(-)
> >>
> >> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read=
.c
> >> index 9c9362b..4a44076 100644
> >> --- a/drivers/lightnvm/pblk-read.c
> >> +++ b/drivers/lightnvm/pblk-read.c
> >> @@ -231,74 +231,36 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
> >>       __pblk_end_io_read(pblk, rqd, true);
> >>   }
> >> -static int pblk_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
> >> -                 struct bio *orig_bio, unsigned int bio_init_idx,
> >> -                 unsigned long *read_bitmap)
> >> +static void pblk_end_partial_read(struct nvm_rq *rqd)
> >>   {
> >> -    struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> >> -    struct bio *new_bio;
> >> +    struct pblk *pblk =3D rqd->private;
> >> +    struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
> >> +    struct pblk_pr_ctx *pr_ctx =3D r_ctx->private;
> >> +    struct bio *new_bio =3D rqd->bio;
> >> +    struct bio *bio =3D pr_ctx->orig_bio;
> >>       struct bio_vec src_bv, dst_bv;
> >> -    void *ppa_ptr =3D NULL;
> >> -    void *src_p, *dst_p;
> >> -    dma_addr_t dma_ppa_list =3D 0;
> >> -    __le64 *lba_list_mem, *lba_list_media;
> >> -    int nr_secs =3D rqd->nr_ppas;
> >> +    struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> >> +    int bio_init_idx =3D pr_ctx->bio_init_idx;
> >> +    unsigned long *read_bitmap =3D &pr_ctx->bitmap;
> >> +    int nr_secs =3D pr_ctx->orig_nr_secs;
> >>       int nr_holes =3D nr_secs - bitmap_weight(read_bitmap, nr_secs);
> >> -    int i, ret, hole;
> >> -
> >> -    /* Re-use allocated memory for intermediate lbas */
> >> -    lba_list_mem =3D (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
> >> -    lba_list_media =3D (((void *)rqd->ppa_list) + 2 * pblk_dma_ppa_si=
ze);
> >> -
> >> -    new_bio =3D bio_alloc(GFP_KERNEL, nr_holes);
> >> -
> >> -    if (pblk_bio_add_pages(pblk, new_bio, GFP_KERNEL, nr_holes))
> >> -        goto fail_add_pages;
> >> -
> >> -    if (nr_holes !=3D new_bio->bi_vcnt) {
> >> -        pblk_err(pblk, "malformed bio\n");
> >> -        goto fail;
> >> -    }
> >> -
> >> -    for (i =3D 0; i < nr_secs; i++)
> >> -        lba_list_mem[i] =3D meta_list[i].lba;
> >> -
> >> -    new_bio->bi_iter.bi_sector =3D 0; /* internal bio */
> >> -    bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
> >> -
> >> -    rqd->bio =3D new_bio;
> >> -    rqd->nr_ppas =3D nr_holes;
> >> -    rqd->flags =3D pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
> >> -
> >> -    if (unlikely(nr_holes =3D=3D 1)) {
> >> -        ppa_ptr =3D rqd->ppa_list;
> >> -        dma_ppa_list =3D rqd->dma_ppa_list;
> >> -        rqd->ppa_addr =3D rqd->ppa_list[0];
> >> -    }
> >> -
> >> -    ret =3D pblk_submit_io_sync(pblk, rqd);
> >> -    if (ret) {
> >> -        bio_put(rqd->bio);
> >> -        pblk_err(pblk, "sync read IO submission failed\n");
> >> -        goto fail;
> >> -    }
> >> -
> >> -    if (rqd->error) {
> >> -        atomic_long_inc(&pblk->read_failed);
> >> -#ifdef CONFIG_NVM_PBLK_DEBUG
> >> -        pblk_print_failed_rqd(pblk, rqd, rqd->error);
> >> -#endif
> >> -    }
> >> +    __le64 *lba_list_mem, *lba_list_media;
> >> +    void *src_p, *dst_p;
> >> +    int hole, i;
> >>       if (unlikely(nr_holes =3D=3D 1)) {
> >>           struct ppa_addr ppa;
> >>           ppa =3D rqd->ppa_addr;
> >> -        rqd->ppa_list =3D ppa_ptr;
> >> -        rqd->dma_ppa_list =3D dma_ppa_list;
> >> +        rqd->ppa_list =3D pr_ctx->ppa_ptr;
> >> +        rqd->dma_ppa_list =3D pr_ctx->dma_ppa_list;
> >>           rqd->ppa_list[0] =3D ppa;
> >>       }
> >> +    /* Re-use allocated memory for intermediate lbas */
> >> +    lba_list_mem =3D (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
> >> +    lba_list_media =3D (((void *)rqd->ppa_list) + 2 * pblk_dma_ppa_si=
ze);
> >> +
> >>       for (i =3D 0; i < nr_secs; i++) {
> >>           lba_list_media[i] =3D meta_list[i].lba;
> >>           meta_list[i].lba =3D lba_list_mem[i];
> >> @@ -316,7 +278,7 @@ static int pblk_partial_read(struct pblk *pblk,
> >> struct nvm_rq *rqd,
> >>           meta_list[hole].lba =3D lba_list_media[i];
> >>           src_bv =3D new_bio->bi_io_vec[i++];
> >> -        dst_bv =3D orig_bio->bi_io_vec[bio_init_idx + hole];
> >> +        dst_bv =3D bio->bi_io_vec[bio_init_idx + hole];
> >>           src_p =3D kmap_atomic(src_bv.bv_page);
> >>           dst_p =3D kmap_atomic(dst_bv.bv_page);
> >> @@ -334,19 +296,107 @@ static int pblk_partial_read(struct pblk *pblk,
> >> struct nvm_rq *rqd,
> >>       } while (hole < nr_secs);
> >>       bio_put(new_bio);
> >> +    kfree(pr_ctx);
> >>       /* restore original request */
> >>       rqd->bio =3D NULL;
> >>       rqd->nr_ppas =3D nr_secs;
> >> +    bio_endio(bio);
> >>       __pblk_end_io_read(pblk, rqd, false);
> >> -    return NVM_IO_DONE;
> >> +}
> >> -fail:
> >> -    /* Free allocated pages in new bio */
> >> +static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq
> >> *rqd,
> >> +                unsigned int bio_init_idx,
> >> +                unsigned long *read_bitmap,
> >> +                int nr_holes)
> >> +{
> >> +    struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> >> +    struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
> >> +    struct pblk_pr_ctx *pr_ctx;
> >> +    struct bio *new_bio, *bio =3D r_ctx->private;
> >> +    __le64 *lba_list_mem;
> >> +    int nr_secs =3D rqd->nr_ppas;
> >> +    int i;
> >> +
> >> +    /* Re-use allocated memory for intermediate lbas */
> >> +    lba_list_mem =3D (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
> >> +
> >> +    new_bio =3D bio_alloc(GFP_KERNEL, nr_holes);
> >> +
> >> +    if (pblk_bio_add_pages(pblk, new_bio, GFP_KERNEL, nr_holes))
> >> +        goto fail_bio_put;
> >> +
> >> +    if (nr_holes !=3D new_bio->bi_vcnt) {
> >> +        WARN_ONCE(1, "pblk: malformed bio\n");
> >> +        goto fail_free_pages;
> >> +    }
> >> +
> >> +    pr_ctx =3D kmalloc(sizeof(struct pblk_pr_ctx), GFP_KERNEL);
> >> +    if (!pr_ctx)
> >> +        goto fail_free_pages;
> >> +
> >> +    for (i =3D 0; i < nr_secs; i++)
> >> +        lba_list_mem[i] =3D meta_list[i].lba;
> >> +
> >> +    new_bio->bi_iter.bi_sector =3D 0; /* internal bio */
> >> +    bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
> >> +
> >> +    rqd->bio =3D new_bio;
> >> +    rqd->nr_ppas =3D nr_holes;
> >> +    rqd->flags =3D pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
> >> +
> >> +    pr_ctx->ppa_ptr =3D NULL;
> >> +    pr_ctx->orig_bio =3D bio;
> >> +    pr_ctx->bitmap =3D *read_bitmap;
>
> read_bitmap is declared with DECLARE_BITMAP() macro inside caller
> function and will be really an array with 2 unsigned longs elements for
> 32 bits architecture, so we will loose part of bits here.
>
> >> +    pr_ctx->bio_init_idx =3D bio_init_idx;
> >> +    pr_ctx->orig_nr_secs =3D nr_secs;
> >> +    r_ctx->private =3D pr_ctx;
> >> +
> >> +    if (unlikely(nr_holes =3D=3D 1)) {
> >> +        pr_ctx->ppa_ptr =3D rqd->ppa_list;
> >> +        pr_ctx->dma_ppa_list =3D rqd->dma_ppa_list;
> >> +        rqd->ppa_addr =3D rqd->ppa_list[0];
> >> +    }
> >> +    return 0;
> >> +
> >> +fail_free_pages:
> >>       pblk_bio_free_pages(pblk, new_bio, 0, new_bio->bi_vcnt);
> >> -fail_add_pages:
> >> +fail_bio_put:
> >> +    bio_put(new_bio);
> >> +
> >> +    return -ENOMEM;
> >> +}
> >> +
> >> +static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rq=
d,
> >> +                 unsigned int bio_init_idx,
> >> +                 unsigned long *read_bitmap, int nr_secs)
> >> +{
> >> +    int nr_holes;
> >> +    int ret;
> >> +
> >> +    nr_holes =3D nr_secs - bitmap_weight(read_bitmap, nr_secs);
> >> +
> >> +    if (pblk_setup_partial_read(pblk, rqd, bio_init_idx, read_bitmap,
> >> +                    nr_holes))
> >> +        return NVM_IO_ERR;
> >> +
> >> +    rqd->end_io =3D pblk_end_partial_read;
> >> +
> >> +    ret =3D pblk_submit_io(pblk, rqd);
> >> +    if (ret) {
> >> +        bio_put(rqd->bio);
> >> +        pblk_err(pblk, "partial read IO submission failed\n");
> >> +        goto err;
> >> +    }
> >> +
> >> +    return NVM_IO_OK;
> >> +
> >> +err:
> >>       pblk_err(pblk, "failed to perform partial read\n");
> >> +
> >> +    /* Free allocated pages in new bio */
> >> +    pblk_bio_free_pages(pblk, rqd->bio, 0, rqd->bio->bi_vcnt);
> >>       __pblk_end_io_read(pblk, rqd, false);
> >>       return NVM_IO_ERR;
> >>   }
> >> @@ -480,8 +530,15 @@ int pblk_submit_read(struct pblk *pblk, struct
> >> bio *bio)
> >>       /* The read bio request could be partially filled by the write
> >> buffer,
> >>        * but there are some holes that need to be read from the drive.
> >>        */
> >> -    return pblk_partial_read(pblk, rqd, bio, bio_init_idx, read_bitma=
p);
> >> +    ret =3D pblk_partial_read_bio(pblk, rqd, bio_init_idx, read_bitma=
p,
> >> +                    nr_secs);
> >> +    if (ret)
> >> +        goto fail_meta_free;
> >> +
> >> +    return NVM_IO_OK;
> >> +fail_meta_free:
> >> +    nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list)=
;
> >>   fail_rqd_free:
> >>       pblk_free_rqd(pblk, rqd, PBLK_READ);
> >>       return ret;
> >> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> >> index 5c6904e..6ebd2e5 100644
> >> --- a/drivers/lightnvm/pblk.h
> >> +++ b/drivers/lightnvm/pblk.h
> >> @@ -119,6 +119,16 @@ struct pblk_g_ctx {
> >>       u64 lba;
> >>   };
> >> +/* partial read context */
> >> +struct pblk_pr_ctx {
> >> +    struct bio *orig_bio;
> >> +    unsigned long bitmap;
>
> This is related to my previous comments.
> Shouldn't you use DECLARE_BITMAP(bitmap, 64) here in order to align with
> latest changes introduced by Matias to support non-64 bits arch?
> And ensure that all the elements are properly copied in
> pblk_setup_partial_read() function then.
>
> >> +    unsigned int orig_nr_secs;
> >> +    unsigned int bio_init_idx;
> >> +    void *ppa_ptr;
> >> +    dma_addr_t dma_ppa_list;
> >> +};
> >> +
> >>   /* Pad context */
> >>   struct pblk_pad_rq {
> >>       struct pblk *pblk;
> >>
> >
> > Looks good to me. I'll pick up if no one else finds something. Thanks!
> >
