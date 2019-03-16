Return-Path: <SRS0=01oL=RT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1107DC43381
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 22:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A3D218D4
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 22:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="OJF2ksOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfCPW2i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:28:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39020 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfCPW2h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Mar 2019 18:28:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id i20so8720972pfo.6
        for <linux-block@vger.kernel.org>; Sat, 16 Mar 2019 15:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ta5TOrPhlrVxnLxy2K+BXlx4FviYxxOxamTEqizFfoU=;
        b=OJF2ksOO66zhQXytMgo6D1h96I2VUbNdoyJSho92vN6evsmramfser6eAZ7QBk3+oc
         slo3j6fUHMtMph5ctePBDQ3MwrCy9w56ROWpLchgEeesaQbKZzaN0khXPQFsGLifLJOx
         71g4w8K/zldjlwu5a6Gg8JCoVp8+AzHJkFtHwEJPojfqWxDZa6e5jzxKiFNi2b1Y9FUg
         v7Ly0Cj9lCJmYVypHj3GoIpsN0xWwSTVk/cF4Pb2xrPJ6wkDhAFi5M+kDAZR8SG9c9zH
         M8Tk8RBdynnoeeEXLazy+3KGjRokILvCeKZdH04cETZ4SqgE2wSQwrNSxJUrOSTUGewc
         10Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ta5TOrPhlrVxnLxy2K+BXlx4FviYxxOxamTEqizFfoU=;
        b=N0HSK4NnN0n0yYIzFUVyarAJnxNjN77mJNjlXNGPBzOWpxDIVp7ASDFdlWKvXmb5St
         kimrVIHGnEsJYjJQ8SHxVk61dmnlaiqY0Uzmsg1rh9tGxTKtg9frsAXXQJMLOoxcBIhI
         7/0NisSgUiwgY6mXxCmbns/igp47bosAu43CkeJgYFFZ2gaGM3ZZgDvnPCEIl2cL9A0C
         yPkr2NbsCGEeVb2ZnfLRmFNbUD++nLnSpX4SzYSYypU6vRjUND1Mo71hggveVh1I+VCH
         a4fYggz/3DiL6q7jYLj7JInoLrtOObHQhE9m0//EjfaDiyJsAMn6N2K+bIAY3YYRv/Il
         ZInw==
X-Gm-Message-State: APjAAAXOgnGIhYLbL48I/wLJiQu46JtJmHz0zk+2oEEHfk80V1Vmvd4O
        wrQeTxzLd7AsBvANkoOjDpvlV5jrA6awXNd+
X-Google-Smtp-Source: APXvYqzvVEHeC/27mVH8kX1KKrGtbjkjnpOW92m6f2unsXtKnGxekLD+EVThQaiOnABEcti/zPB4rQ==
X-Received: by 2002:a63:6e4c:: with SMTP id j73mr3399985pgc.276.1552775316613;
        Sat, 16 Mar 2019 15:28:36 -0700 (PDT)
Received: from [172.26.35.188] ([76.14.1.154])
        by smtp.gmail.com with ESMTPSA id x19sm7694829pfm.108.2019.03.16.15.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 15:28:35 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <FBF04275-1824-4661-A823-8551E5262ED7@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_F5036062-0CC4-4C92-8A39-0F199F087400";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 03/18] lightnvm: pblk: simplify partial read path
Date:   Sat, 16 Mar 2019 15:28:34 -0700
In-Reply-To: <6ce1fb9a-a076-10c2-98e9-64505ae7d61f@intel.com>
Cc:     Heiner Litz <hlitz@ucsc.edu>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-4-igor.j.konopko@intel.com>
 <CAJbgVnWkM1V9VaoQGR4NwUBEbQZxt7e6L0CoBnLXoGvtY2qZfA@mail.gmail.com>
 <6ce1fb9a-a076-10c2-98e9-64505ae7d61f@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_F5036062-0CC4-4C92-8A39-0F199F087400
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 15 Mar 2019, at 02.52, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
>=20
>=20
> On 14.03.2019 22:35, Heiner Litz wrote:
>> On Thu, Mar 14, 2019 at 9:07 AM Igor Konopko =
<igor.j.konopko@intel.com> wrote:
>>> This patch changes the approach to handling partial read path.
>>>=20
>>> In old approach merging of data from round buffer and drive was =
fully
>>> made by drive. This had some disadvantages - code was complex and
>>> relies on bio internals, so it was hard to maintain and was strongly
>>> dependent on bio changes.
>>>=20
>>> In new approach most of the handling is done mostly by block layer
>>> functions such as bio_split(), bio_chain() and generic_make =
request()
>>> and generally is less complex and easier to maintain. Below some =
more
>>> details of the new approach.
>>>=20
>>> When read bio arrives, it is cloned for pblk internal purposes. All
>>> the L2P mapping, which includes copying data from round buffer to =
bio
>>> and thus bio_advance() calls is done on the cloned bio, so the =
original
>>> bio is untouched. Later if we found that we have partial read case, =
we
>>> still have original bio untouched, so we can split it and continue =
to
>>> process only first 4K of it in current context, when the rest will =
be
>>> called as separate bio request which is passed to =
generic_make_request()
>>> for further processing.
>>>=20
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> ---
>>>  drivers/lightnvm/pblk-read.c | 242 =
++++++++-----------------------------------
>>>  drivers/lightnvm/pblk.h      |  12 ---
>>>  2 files changed, 41 insertions(+), 213 deletions(-)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
>>> index 6569746..54422a2 100644
>>> --- a/drivers/lightnvm/pblk-read.c
>>> +++ b/drivers/lightnvm/pblk-read.c
>>> @@ -222,171 +222,6 @@ static void pblk_end_io_read(struct nvm_rq =
*rqd)
>>>         __pblk_end_io_read(pblk, rqd, true);
>>>  }
>>>=20
>>> -static void pblk_end_partial_read(struct nvm_rq *rqd)
>>> -{
>>> -       struct pblk *pblk =3D rqd->private;
>>> -       struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
>>> -       struct pblk_pr_ctx *pr_ctx =3D r_ctx->private;
>>> -       struct pblk_sec_meta *meta;
>>> -       struct bio *new_bio =3D rqd->bio;
>>> -       struct bio *bio =3D pr_ctx->orig_bio;
>>> -       struct bio_vec src_bv, dst_bv;
>>> -       void *meta_list =3D rqd->meta_list;
>>> -       int bio_init_idx =3D pr_ctx->bio_init_idx;
>>> -       unsigned long *read_bitmap =3D pr_ctx->bitmap;
>>> -       int nr_secs =3D pr_ctx->orig_nr_secs;
>>> -       int nr_holes =3D nr_secs - bitmap_weight(read_bitmap, =
nr_secs);
>>> -       void *src_p, *dst_p;
>>> -       int hole, i;
>>> -
>>> -       if (unlikely(nr_holes =3D=3D 1)) {
>>> -               struct ppa_addr ppa;
>>> -
>>> -               ppa =3D rqd->ppa_addr;
>>> -               rqd->ppa_list =3D pr_ctx->ppa_ptr;
>>> -               rqd->dma_ppa_list =3D pr_ctx->dma_ppa_list;
>>> -               rqd->ppa_list[0] =3D ppa;
>>> -       }
>>> -
>>> -       for (i =3D 0; i < nr_secs; i++) {
>>> -               meta =3D pblk_get_meta(pblk, meta_list, i);
>>> -               pr_ctx->lba_list_media[i] =3D =
le64_to_cpu(meta->lba);
>>> -               meta->lba =3D cpu_to_le64(pr_ctx->lba_list_mem[i]);
>>> -       }
>>> -
>>> -       /* Fill the holes in the original bio */
>>> -       i =3D 0;
>>> -       hole =3D find_first_zero_bit(read_bitmap, nr_secs);
>>> -       do {
>>> -               struct pblk_line *line;
>>> -
>>> -               line =3D pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
>>> -               kref_put(&line->ref, pblk_line_put);
>>> -
>>> -               meta =3D pblk_get_meta(pblk, meta_list, hole);
>>> -               meta->lba =3D =
cpu_to_le64(pr_ctx->lba_list_media[i]);
>>> -
>>> -               src_bv =3D new_bio->bi_io_vec[i++];
>>> -               dst_bv =3D bio->bi_io_vec[bio_init_idx + hole];
>>> -
>>> -               src_p =3D kmap_atomic(src_bv.bv_page);
>>> -               dst_p =3D kmap_atomic(dst_bv.bv_page);
>>> -
>>> -               memcpy(dst_p + dst_bv.bv_offset,
>>> -                       src_p + src_bv.bv_offset,
>>> -                       PBLK_EXPOSED_PAGE_SIZE);
>>> -
>>> -               kunmap_atomic(src_p);
>>> -               kunmap_atomic(dst_p);
>>> -
>>> -               mempool_free(src_bv.bv_page, &pblk->page_bio_pool);
>>> -
>>> -               hole =3D find_next_zero_bit(read_bitmap, nr_secs, =
hole + 1);
>>> -       } while (hole < nr_secs);
>>> -
>>> -       bio_put(new_bio);
>>> -       kfree(pr_ctx);
>>> -
>>> -       /* restore original request */
>>> -       rqd->bio =3D NULL;
>>> -       rqd->nr_ppas =3D nr_secs;
>>> -
>>> -       pblk_end_user_read(bio, rqd->error);
>>> -       __pblk_end_io_read(pblk, rqd, false);
>>> -}
>>> -
>>> -static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq =
*rqd,
>>> -                           unsigned int bio_init_idx,
>>> -                           unsigned long *read_bitmap,
>>> -                           int nr_holes)
>>> -{
>>> -       void *meta_list =3D rqd->meta_list;
>>> -       struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
>>> -       struct pblk_pr_ctx *pr_ctx;
>>> -       struct bio *new_bio, *bio =3D r_ctx->private;
>>> -       int nr_secs =3D rqd->nr_ppas;
>>> -       int i;
>>> -
>>> -       new_bio =3D bio_alloc(GFP_KERNEL, nr_holes);
>>> -
>>> -       if (pblk_bio_add_pages(pblk, new_bio, GFP_KERNEL, nr_holes))
>>> -               goto fail_bio_put;
>>> -
>>> -       if (nr_holes !=3D new_bio->bi_vcnt) {
>>> -               WARN_ONCE(1, "pblk: malformed bio\n");
>>> -               goto fail_free_pages;
>>> -       }
>>> -
>>> -       pr_ctx =3D kzalloc(sizeof(struct pblk_pr_ctx), GFP_KERNEL);
>>> -       if (!pr_ctx)
>>> -               goto fail_free_pages;
>>> -
>>> -       for (i =3D 0; i < nr_secs; i++) {
>>> -               struct pblk_sec_meta *meta =3D pblk_get_meta(pblk, =
meta_list, i);
>>> -
>>> -               pr_ctx->lba_list_mem[i] =3D le64_to_cpu(meta->lba);
>>> -       }
>>> -
>>> -       new_bio->bi_iter.bi_sector =3D 0; /* internal bio */
>>> -       bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
>>> -
>>> -       rqd->bio =3D new_bio;
>>> -       rqd->nr_ppas =3D nr_holes;
>>> -
>>> -       pr_ctx->orig_bio =3D bio;
>>> -       bitmap_copy(pr_ctx->bitmap, read_bitmap, NVM_MAX_VLBA);
>>> -       pr_ctx->bio_init_idx =3D bio_init_idx;
>>> -       pr_ctx->orig_nr_secs =3D nr_secs;
>>> -       r_ctx->private =3D pr_ctx;
>>> -
>>> -       if (unlikely(nr_holes =3D=3D 1)) {
>>> -               pr_ctx->ppa_ptr =3D rqd->ppa_list;
>>> -               pr_ctx->dma_ppa_list =3D rqd->dma_ppa_list;
>>> -               rqd->ppa_addr =3D rqd->ppa_list[0];
>>> -       }
>>> -       return 0;
>>> -
>>> -fail_free_pages:
>>> -       pblk_bio_free_pages(pblk, new_bio, 0, new_bio->bi_vcnt);
>>> -fail_bio_put:
>>> -       bio_put(new_bio);
>>> -
>>> -       return -ENOMEM;
>>> -}
>>> -
>>> -static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq =
*rqd,
>>> -                                unsigned int bio_init_idx,
>>> -                                unsigned long *read_bitmap, int =
nr_secs)
>>> -{
>>> -       int nr_holes;
>>> -       int ret;
>>> -
>>> -       nr_holes =3D nr_secs - bitmap_weight(read_bitmap, nr_secs);
>>> -
>>> -       if (pblk_setup_partial_read(pblk, rqd, bio_init_idx, =
read_bitmap,
>>> -                                   nr_holes))
>>> -               return NVM_IO_ERR;
>>> -
>>> -       rqd->end_io =3D pblk_end_partial_read;
>>> -
>>> -       ret =3D pblk_submit_io(pblk, rqd);
>>> -       if (ret) {
>>> -               bio_put(rqd->bio);
>>> -               pblk_err(pblk, "partial read IO submission =
failed\n");
>>> -               goto err;
>>> -       }
>>> -
>>> -       return NVM_IO_OK;
>>> -
>>> -err:
>>> -       pblk_err(pblk, "failed to perform partial read\n");
>>> -
>>> -       /* Free allocated pages in new bio */
>>> -       pblk_bio_free_pages(pblk, rqd->bio, 0, rqd->bio->bi_vcnt);
>>> -       __pblk_end_io_read(pblk, rqd, false);
>>> -       return NVM_IO_ERR;
>>> -}
>>> -
>>>  static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, =
struct bio *bio,
>>>                          sector_t lba, unsigned long *read_bitmap)
>>>  {
>>> @@ -432,11 +267,11 @@ int pblk_submit_read(struct pblk *pblk, struct =
bio *bio)
>>>  {
>>>         struct nvm_tgt_dev *dev =3D pblk->dev;
>>>         struct request_queue *q =3D dev->q;
>>> +       struct bio *split_bio, *int_bio;
>>>         sector_t blba =3D pblk_get_lba(bio);
>>>         unsigned int nr_secs =3D pblk_get_secs(bio);
>>>         struct pblk_g_ctx *r_ctx;
>>>         struct nvm_rq *rqd;
>>> -       unsigned int bio_init_idx;
>>>         DECLARE_BITMAP(read_bitmap, NVM_MAX_VLBA);
>>>         int ret =3D NVM_IO_ERR;
>>>=20
>>> @@ -456,61 +291,66 @@ int pblk_submit_read(struct pblk *pblk, struct =
bio *bio)
>>>         r_ctx =3D nvm_rq_to_pdu(rqd);
>>>         r_ctx->start_time =3D jiffies;
>>>         r_ctx->lba =3D blba;
>>> -       r_ctx->private =3D bio; /* original bio */
>>>=20
>>> -       /* Save the index for this bio's start. This is needed in =
case
>>> -        * we need to fill a partial read.
>>> +       /* Clone read bio to deal with:
>>> +        * -usage of bio_advance() when memcpy data from round =
buffer
>>> +        * -read errors in case of reading from device
>>>          */
>>> -       bio_init_idx =3D pblk_get_bi_idx(bio);
>>> +       int_bio =3D bio_clone_fast(bio, GFP_KERNEL, &pblk_bio_set);
>>> +       if (!int_bio)
>>> +               return NVM_IO_ERR;
>>>=20
>>>         if (pblk_alloc_rqd_meta(pblk, rqd))
>>>                 goto fail_rqd_free;
>>>=20
>>>         if (nr_secs > 1)
>>> -               pblk_read_ppalist_rq(pblk, rqd, bio, blba, =
read_bitmap);
>>> +               pblk_read_ppalist_rq(pblk, rqd, int_bio, blba, =
read_bitmap);
>>>         else
>>> -               pblk_read_rq(pblk, rqd, bio, blba, read_bitmap);
>>> +               pblk_read_rq(pblk, rqd, int_bio, blba, read_bitmap);
>>> +
>>> +split_retry:
>>> +       r_ctx->private =3D bio; /* original bio */
>>>=20
>>> -       if (bitmap_full(read_bitmap, nr_secs)) {
>>> +       if (bitmap_full(read_bitmap, rqd->nr_ppas)) {
>>> +               bio_put(int_bio);
>>>                 atomic_inc(&pblk->inflight_io);
>>>                 __pblk_end_io_read(pblk, rqd, false);
>>>                 return NVM_IO_DONE;
>>>         }
>>>=20
>>> -       /* All sectors are to be read from the device */
>>> -       if (bitmap_empty(read_bitmap, rqd->nr_ppas)) {
>>> -               struct bio *int_bio =3D NULL;
>>> +       if (!bitmap_empty(read_bitmap, rqd->nr_ppas)) {
>>> +               /* The read bio request could be partially filled by =
the write
>>> +                * buffer, but there are some holes that need to be =
read from
>>> +                * the drive. In order to handle this, we will use =
block layer
>>> +                * mechanism to split this request in to smaller =
ones.
>>> +                */
>>> +               split_bio =3D bio_split(bio, NR_PHY_IN_LOG, =
GFP_KERNEL,
>>> +                                       &pblk_bio_set);
>> This is quite inefficient. If you have an rqd with 63 sectors on the =
device and
>> the 64th is cached, you are splitting 63 times whereas a single split
>> would be sufficient.
>=20
> Yeah, definitely, it would be better to find how many contiguous =
sectors in cache/on drive are and splitting based on it. Will improve =
that in v2.
>=20
>>> +               bio_chain(split_bio, bio);
>> I am not sure if it's needed but in blk_queue_split() these flags are =
set
>> before making the request:
>>         split->bi_opf |=3D REQ_NOMERGE;
>>         bio_set_flag(*bio, BIO_QUEUE_ENTERED);
>>> +               generic_make_request(bio);
>> pblk_lookup_l2p_seq() increments line->ref. You have to release the =
krefs before
>> requeing the request.
> I completely forgot about it, will fix that of course, thanks!
>=20
>> You might consider introducing a pblk_lookup_l2p_uncached() which =
returns when
>> it finds a cached sector and returns its index. Doing so you can =
avoid obtaining
>> superfluous line->refs and we could also get rid of the read_bitmap
>> entirely. This
>> index could also be used to split the bio at the right position.


I think you can also get rid of the read_bitmap. This would help
removing one of the 64 lba dependencies in pblk, which I think is useful
as we move forward.


--Apple-Mail=_F5036062-0CC4-4C92-8A39-0F199F087400
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyNeJIACgkQPEYBfS0l
eOCPmw/9EBJ+BzibvrJWFt73Y8bwHo/cw/kC7Jb+nzv9wR1cU4f97isKN5bTQAEs
mopVlUj3WvXCj5a6XO+wRTKY+dOB8Ce37CIUMF/dw0aUf7vl9z7aDvzNYW0568Lf
sZIEI3bHNeyaGZrWAOLZbJ5ceHHZRGJyf5nFVODMqoKXYtvFroCu/CgN+xx55RZQ
ZfyZ+m1mS2vo8j9hONOD+7xOpvyph4xKfwFKknUFmunqSvJS6jtx2T4hZUvezcmW
SXa1loqPT4EAsjaos08W3DXaSpf5942nYZL8AQWSyA0G+kRnHjZQe4PLO1IxaFXQ
EdCmq1bkJDJz4YZiw55TNL8PH0Wdowtxi5ArIf5c/UF5dK+AeyT+eNj6BVm07dts
833dAc3kWnBHY6jPGEx+t5vxviy+MZ2KgVPx8GskE8FwbvmH/rEUAzOx/tZwSvUH
xWvvS8Bktedi7FLd+251Fv+DifiJ6MQJZXntGfDlaku6/QHOKwUkO0qPD3sl928N
/Tz8xJ5dk9heM6yNT6ZsDtma3S6DaMzP2GWItcR7W/6MlQHLA3V7h63R6MJzrNlt
s1U4v91gQ5xAeOoWKAQTVNqIBQRZADjEEYGGUaWx1Qexwj2L/FedF1UeEnPND8BN
W53YHIhOFmJLyp/1r8sKtGQrdpn3Ls5juHvXL1vD041ELgOS5fE=
=iljp
-----END PGP SIGNATURE-----

--Apple-Mail=_F5036062-0CC4-4C92-8A39-0F199F087400--
