Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37486 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756235AbeFOSMa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jun 2018 14:12:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id r125-v6so5349573wmg.2
        for <linux-block@vger.kernel.org>; Fri, 15 Jun 2018 11:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <1528782812-23562-1-git-send-email-hlitz@ucsc.edu>
 <C27BF28D-74A2-4BEE-B198-2B8A0C4D49B3@cnexlabs.com> <7d58be0d-a1f3-032b-119f-ac645e56f123@lightnvm.io>
 <0e9c1ad2-023f-ced9-ea66-66c5882283ca@intel.com>
In-Reply-To: <0e9c1ad2-023f-ced9-ea66-66c5882283ca@intel.com>
From: Heiner Litz <hlitz@ucsc.edu>
Date: Fri, 15 Jun 2018 11:12:17 -0700
Message-ID: <CAJbgVnVx7n0mP5zPoy+bFiUHFvrz-fCMPgv7RQMcybGoW9ip9Q@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: add asynchronous partial read
To: igor.j.konopko@intel.com
Cc: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Javier Gonzalez <javier@cnexlabs.com>,
        marcin.dziegielewski@intel.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Igor,

thanks for testing. You are correct with goto fail_pages

I will fix, rebase on top of 4-19 and resend the patch.

Heiner

On Wed, Jun 13, 2018 at 10:49 AM Igor Konopko <igor.j.konopko@intel.com> wr=
ote:
>
>
>
> On 12.06.2018 10:09, Matias Bj=C3=B8rling wrote:
> > On 06/12/2018 04:59 PM, Javier Gonzalez wrote:
> >>> On 11 Jun 2018, at 22.53, Heiner Litz <hlitz@ucsc.edu> wrote:
> >>>
> >>> In the read path, partial reads are currently performed synchronously
> >>> which affects performance for workloads that generate many partial
> >>> reads. This patch adds an asynchronous partial read path as well as
> >>> the required partial read ctx.
> >>>
> >>> Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
> >>> ---
> >>> drivers/lightnvm/pblk-read.c | 179
> >>> ++++++++++++++++++++++++++++---------------
> >>> drivers/lightnvm/pblk.h      |  10 +++
> >>> 2 files changed, 128 insertions(+), 61 deletions(-)
> >>>
> >>> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-rea=
d.c
> >>> index 7570ff6..026c708 100644
> >>> --- a/drivers/lightnvm/pblk-read.c
> >>> +++ b/drivers/lightnvm/pblk-read.c
> >>> @@ -231,74 +231,36 @@ static void pblk_end_io_read(struct nvm_rq *rqd=
)
> >>>     __pblk_end_io_read(pblk, rqd, true);
> >>> }
> >>>
> >>> -static int pblk_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
> >>> -                 struct bio *orig_bio, unsigned int bio_init_idx,
> >>> -                 unsigned long *read_bitmap)
> >>> +static void pblk_end_partial_read(struct nvm_rq *rqd)
> >>> {
> >>> -    struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> >>> -    struct bio *new_bio;
> >>> +    struct pblk *pblk =3D rqd->private;
> >>> +    struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
> >>> +    struct pblk_pr_ctx *pr_ctx =3D r_ctx->private;
> >>> +    struct bio *new_bio =3D rqd->bio;
> >>> +    struct bio *bio =3D pr_ctx->orig_bio;
> >>>     struct bio_vec src_bv, dst_bv;
> >>> -    void *ppa_ptr =3D NULL;
> >>> -    void *src_p, *dst_p;
> >>> -    dma_addr_t dma_ppa_list =3D 0;
> >>> -    __le64 *lba_list_mem, *lba_list_media;
> >>> -    int nr_secs =3D rqd->nr_ppas;
> >>> +    struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> >>> +    int bio_init_idx =3D pr_ctx->bio_init_idx;
> >>> +    unsigned long *read_bitmap =3D &pr_ctx->bitmap;
> >>> +    int nr_secs =3D pr_ctx->orig_nr_secs;
> >>>     int nr_holes =3D nr_secs - bitmap_weight(read_bitmap, nr_secs);
> >>> -    int i, ret, hole;
> >>> -
> >>> -    /* Re-use allocated memory for intermediate lbas */
> >>> -    lba_list_mem =3D (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
> >>> -    lba_list_media =3D (((void *)rqd->ppa_list) + 2 * pblk_dma_ppa_s=
ize);
> >>> -
> >>> -    new_bio =3D bio_alloc(GFP_KERNEL, nr_holes);
> >>> -
> >>> -    if (pblk_bio_add_pages(pblk, new_bio, GFP_KERNEL, nr_holes))
> >>> -        goto err;
> >>> -
> >>> -    if (nr_holes !=3D new_bio->bi_vcnt) {
> >>> -        pr_err("pblk: malformed bio\n");
> >>> -        goto err;
> >>> -    }
> >>> -
> >>> -    for (i =3D 0; i < nr_secs; i++)
> >>> -        lba_list_mem[i] =3D meta_list[i].lba;
> >>> -
> >>> -    new_bio->bi_iter.bi_sector =3D 0; /* internal bio */
> >>> -    bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
> >>> -
> >>> -    rqd->bio =3D new_bio;
> >>> -    rqd->nr_ppas =3D nr_holes;
> >>> -    rqd->flags =3D pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
> >>> -
> >>> -    if (unlikely(nr_holes =3D=3D 1)) {
> >>> -        ppa_ptr =3D rqd->ppa_list;
> >>> -        dma_ppa_list =3D rqd->dma_ppa_list;
> >>> -        rqd->ppa_addr =3D rqd->ppa_list[0];
> >>> -    }
> >>> -
> >>> -    ret =3D pblk_submit_io_sync(pblk, rqd);
> >>> -    if (ret) {
> >>> -        bio_put(rqd->bio);
> >>> -        pr_err("pblk: sync read IO submission failed\n");
> >>> -        goto err;
> >>> -    }
> >>> -
> >>> -    if (rqd->error) {
> >>> -        atomic_long_inc(&pblk->read_failed);
> >>> -#ifdef CONFIG_NVM_DEBUG
> >>> -        pblk_print_failed_rqd(pblk, rqd, rqd->error);
> >>> -#endif
> >>> -    }
> >>> +    __le64 *lba_list_mem, *lba_list_media;
> >>> +    void *src_p, *dst_p;
> >>> +    int hole, i;
> >>>
> >>>     if (unlikely(nr_holes =3D=3D 1)) {
> >>>         struct ppa_addr ppa;
> >>>
> >>>         ppa =3D rqd->ppa_addr;
> >>> -        rqd->ppa_list =3D ppa_ptr;
> >>> -        rqd->dma_ppa_list =3D dma_ppa_list;
> >>> +        rqd->ppa_list =3D pr_ctx->ppa_ptr;
> >>> +        rqd->dma_ppa_list =3D pr_ctx->dma_ppa_list;
> >>>         rqd->ppa_list[0] =3D ppa;
> >>>     }
> >>>
> >>> +    /* Re-use allocated memory for intermediate lbas */
> >>> +    lba_list_mem =3D (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
> >>> +    lba_list_media =3D (((void *)rqd->ppa_list) + 2 * pblk_dma_ppa_s=
ize);
> >>> +
> >>>     for (i =3D 0; i < nr_secs; i++) {
> >>>         lba_list_media[i] =3D meta_list[i].lba;
> >>>         meta_list[i].lba =3D lba_list_mem[i];
> >>> @@ -316,7 +278,7 @@ static int pblk_partial_read(struct pblk *pblk,
> >>> struct nvm_rq *rqd,
> >>>         meta_list[hole].lba =3D lba_list_media[i];
> >>>
> >>>         src_bv =3D new_bio->bi_io_vec[i++];
> >>> -        dst_bv =3D orig_bio->bi_io_vec[bio_init_idx + hole];
> >>> +        dst_bv =3D bio->bi_io_vec[bio_init_idx + hole];
> >>>
> >>>         src_p =3D kmap_atomic(src_bv.bv_page);
> >>>         dst_p =3D kmap_atomic(dst_bv.bv_page);
> >>> @@ -334,19 +296,107 @@ static int pblk_partial_read(struct pblk
> >>> *pblk, struct nvm_rq *rqd,
> >>>     } while (hole < nr_secs);
> >>>
> >>>     bio_put(new_bio);
> >>> +    kfree(pr_ctx);
> >>>
> >>>     /* restore original request */
> >>>     rqd->bio =3D NULL;
> >>>     rqd->nr_ppas =3D nr_secs;
> >>>
> >>> +    bio_endio(bio);
> >>>     __pblk_end_io_read(pblk, rqd, false);
> >>> -    return NVM_IO_DONE;
> >>> +}
> >>> +
> >>> +static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq
> >>> *rqd,
> >>> +                unsigned int bio_init_idx,
> >>> +                unsigned long *read_bitmap,
> >>> +                int nr_holes)
> >>> +{
> >>> +    struct pblk_sec_meta *meta_list =3D rqd->meta_list;
> >>> +    struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
> >>> +    struct pblk_pr_ctx *pr_ctx;
> >>> +    struct bio *new_bio, *bio =3D r_ctx->private;
> >>> +    __le64 *lba_list_mem;
> >>> +    int nr_secs =3D rqd->nr_ppas;
> >>> +    int i;
> >>> +
> >>> +    /* Re-use allocated memory for intermediate lbas */
> >>> +    lba_list_mem =3D (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
> >>> +
> >>> +    new_bio =3D bio_alloc(GFP_KERNEL, nr_holes);
> >>> +
> >>> +    if (pblk_bio_add_pages(pblk, new_bio, GFP_KERNEL, nr_holes))
> >>> +        goto fail;
> >>> +
> >>> +    if (nr_holes !=3D new_bio->bi_vcnt) {
> >>> +        pr_err("pblk: malformed bio\n");
> >>> +        goto fail;
> Shouldn't we use goto fail_pages since we already allocate bio pages
> correctly?
> >>> +    }
> >>> +
> >>> +    pr_ctx =3D kmalloc(sizeof(struct pblk_pr_ctx), GFP_KERNEL);
> >>> +    if (!pr_ctx)
> >>> +        goto fail_pages;
> >>> +
> >>> +    for (i =3D 0; i < nr_secs; i++)
> >>> +        lba_list_mem[i] =3D meta_list[i].lba;
> >>> +
> >>> +    new_bio->bi_iter.bi_sector =3D 0; /* internal bio */
> >>> +    bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
> >>> +
> >>> +    rqd->bio =3D new_bio;
> >>> +    rqd->nr_ppas =3D nr_holes;
> >>> +    rqd->flags =3D pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
> >>> +
> >>> +    pr_ctx->ppa_ptr =3D NULL;
> >>> +    pr_ctx->orig_bio =3D bio;
> >>> +    pr_ctx->bitmap =3D *read_bitmap;
> >>> +    pr_ctx->bio_init_idx =3D bio_init_idx;
> >>> +    pr_ctx->orig_nr_secs =3D nr_secs;
> >>> +    r_ctx->private =3D pr_ctx;
> >>> +
> >>> +    if (unlikely(nr_holes =3D=3D 1)) {
> >>> +        pr_ctx->ppa_ptr =3D rqd->ppa_list;
> >>> +        pr_ctx->dma_ppa_list =3D rqd->dma_ppa_list;
> >>> +        rqd->ppa_addr =3D rqd->ppa_list[0];
> >>> +    }
> >>> +    return 0;
> >>> +
> >>> +fail_pages:
> >>> +    pblk_bio_free_pages(pblk, new_bio, 0, new_bio->bi_vcnt);
> >>> +fail:
> >>> +    bio_put(new_bio);
> >>> +
> >>> +    return -ENOMEM;
> >>> +}
> >>> +
> >>> +static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *r=
qd,
> >>> +                 unsigned int bio_init_idx,
> >>> +                 unsigned long *read_bitmap, int nr_secs)
> >>> +{
> >>> +    int nr_holes;
> >>> +    int ret;
> >>> +
> >>> +    nr_holes =3D nr_secs - bitmap_weight(read_bitmap, nr_secs);
> >>> +
> >>> +    if (pblk_setup_partial_read(pblk, rqd, bio_init_idx, read_bitmap=
,
> >>> +                    nr_holes))
> >>> +        return NVM_IO_ERR;
> >>> +
> >>> +    rqd->end_io =3D pblk_end_partial_read;
> >>> +
> >>> +    ret =3D pblk_submit_io(pblk, rqd);
> >>> +    if (ret) {
> >>> +        bio_put(rqd->bio);
> >>> +        pr_err("pblk: partial read IO submission failed\n");
> >>> +        goto err;
> >>> +    }
> >>> +
> >>> +    return NVM_IO_OK;
> >>>
> >>> err:
> >>>     pr_err("pblk: failed to perform partial read\n");
> >>>
> >>>     /* Free allocated pages in new bio */
> >>> -    pblk_bio_free_pages(pblk, orig_bio, 0, new_bio->bi_vcnt);
> >>> +    pblk_bio_free_pages(pblk, rqd->bio, 0, rqd->bio->bi_vcnt);
> >>>     __pblk_end_io_read(pblk, rqd, false);
> >>>     return NVM_IO_ERR;
> >>> }
> >>> @@ -480,8 +530,15 @@ int pblk_submit_read(struct pblk *pblk, struct
> >>> bio *bio)
> >>>     /* The read bio request could be partially filled by the write
> >>> buffer,
> >>>      * but there are some holes that need to be read from the drive.
> >>>      */
> >>> -    return pblk_partial_read(pblk, rqd, bio, bio_init_idx,
> >>> &read_bitmap);
> >>> +    ret =3D pblk_partial_read_bio(pblk, rqd, bio_init_idx, &read_bit=
map,
> >>> +                    nr_secs);
> >>> +    if (ret)
> >>> +        goto fail_meta_free;
> >>> +
> >>> +    return NVM_IO_OK;
> >>>
> >>> +fail_meta_free:
> >>> +    nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list=
);
> >>> fail_rqd_free:
> >>>     pblk_free_rqd(pblk, rqd, PBLK_READ);
> >>>     return ret;
> >>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> >>> index 25ad026..4b28900 100644
> >>> --- a/drivers/lightnvm/pblk.h
> >>> +++ b/drivers/lightnvm/pblk.h
> >>> @@ -119,6 +119,16 @@ struct pblk_g_ctx {
> >>>     u64 lba;
> >>> };
> >>>
> >>> +/* partial read context */
> >>> +struct pblk_pr_ctx {
> >>> +    struct bio *orig_bio;
> >>> +    unsigned long bitmap;
> >>> +    unsigned int orig_nr_secs;
> >>> +    unsigned int bio_init_idx;
> >>> +    void *ppa_ptr;
> >>> +    dma_addr_t dma_ppa_list;
> >>> +};
> >>> +
> >>> /* Pad context */
> >>> struct pblk_pad_rq {
> >>>     struct pblk *pblk;
> >>> --
> >>> 2.7.4
> >>
> >> Thanks Heiner. The patch looks good.
> >>
> >> Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
> >>
> >
> > + Marcin & Igor. Could you give this a spin with your drive and see if
> > it works for you?
> It looks that it does not apply on top of for-4.19/core, but after some
> changes I was able to test it. Except of one minor comment above it
> looks good for me.
>
> Tested-by: Igor Konopko <igor.j.konopko@intel.com>
