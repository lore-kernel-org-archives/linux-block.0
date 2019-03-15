Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76790C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3930E21872
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfCOJwW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:52:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:14697 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbfCOJwW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 05:52:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 02:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,481,1544515200"; 
   d="scan'208";a="214424429"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.249.44.203]) ([10.249.44.203])
  by orsmga001.jf.intel.com with ESMTP; 15 Mar 2019 02:52:19 -0700
Subject: Re: [PATCH 03/18] lightnvm: pblk: simplify partial read path
To:     Heiner Litz <hlitz@ucsc.edu>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-4-igor.j.konopko@intel.com>
 <CAJbgVnWkM1V9VaoQGR4NwUBEbQZxt7e6L0CoBnLXoGvtY2qZfA@mail.gmail.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <6ce1fb9a-a076-10c2-98e9-64505ae7d61f@intel.com>
Date:   Fri, 15 Mar 2019 10:52:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CAJbgVnWkM1V9VaoQGR4NwUBEbQZxt7e6L0CoBnLXoGvtY2qZfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 14.03.2019 22:35, Heiner Litz wrote:
> On Thu, Mar 14, 2019 at 9:07 AM Igor Konopko <igor.j.konopko@intel.com> wrote:
>>
>> This patch changes the approach to handling partial read path.
>>
>> In old approach merging of data from round buffer and drive was fully
>> made by drive. This had some disadvantages - code was complex and
>> relies on bio internals, so it was hard to maintain and was strongly
>> dependent on bio changes.
>>
>> In new approach most of the handling is done mostly by block layer
>> functions such as bio_split(), bio_chain() and generic_make request()
>> and generally is less complex and easier to maintain. Below some more
>> details of the new approach.
>>
>> When read bio arrives, it is cloned for pblk internal purposes. All
>> the L2P mapping, which includes copying data from round buffer to bio
>> and thus bio_advance() calls is done on the cloned bio, so the original
>> bio is untouched. Later if we found that we have partial read case, we
>> still have original bio untouched, so we can split it and continue to
>> process only first 4K of it in current context, when the rest will be
>> called as separate bio request which is passed to generic_make_request()
>> for further processing.
>>
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> ---
>>   drivers/lightnvm/pblk-read.c | 242 ++++++++-----------------------------------
>>   drivers/lightnvm/pblk.h      |  12 ---
>>   2 files changed, 41 insertions(+), 213 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
>> index 6569746..54422a2 100644
>> --- a/drivers/lightnvm/pblk-read.c
>> +++ b/drivers/lightnvm/pblk-read.c
>> @@ -222,171 +222,6 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
>>          __pblk_end_io_read(pblk, rqd, true);
>>   }
>>
>> -static void pblk_end_partial_read(struct nvm_rq *rqd)
>> -{
>> -       struct pblk *pblk = rqd->private;
>> -       struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
>> -       struct pblk_pr_ctx *pr_ctx = r_ctx->private;
>> -       struct pblk_sec_meta *meta;
>> -       struct bio *new_bio = rqd->bio;
>> -       struct bio *bio = pr_ctx->orig_bio;
>> -       struct bio_vec src_bv, dst_bv;
>> -       void *meta_list = rqd->meta_list;
>> -       int bio_init_idx = pr_ctx->bio_init_idx;
>> -       unsigned long *read_bitmap = pr_ctx->bitmap;
>> -       int nr_secs = pr_ctx->orig_nr_secs;
>> -       int nr_holes = nr_secs - bitmap_weight(read_bitmap, nr_secs);
>> -       void *src_p, *dst_p;
>> -       int hole, i;
>> -
>> -       if (unlikely(nr_holes == 1)) {
>> -               struct ppa_addr ppa;
>> -
>> -               ppa = rqd->ppa_addr;
>> -               rqd->ppa_list = pr_ctx->ppa_ptr;
>> -               rqd->dma_ppa_list = pr_ctx->dma_ppa_list;
>> -               rqd->ppa_list[0] = ppa;
>> -       }
>> -
>> -       for (i = 0; i < nr_secs; i++) {
>> -               meta = pblk_get_meta(pblk, meta_list, i);
>> -               pr_ctx->lba_list_media[i] = le64_to_cpu(meta->lba);
>> -               meta->lba = cpu_to_le64(pr_ctx->lba_list_mem[i]);
>> -       }
>> -
>> -       /* Fill the holes in the original bio */
>> -       i = 0;
>> -       hole = find_first_zero_bit(read_bitmap, nr_secs);
>> -       do {
>> -               struct pblk_line *line;
>> -
>> -               line = pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
>> -               kref_put(&line->ref, pblk_line_put);
>> -
>> -               meta = pblk_get_meta(pblk, meta_list, hole);
>> -               meta->lba = cpu_to_le64(pr_ctx->lba_list_media[i]);
>> -
>> -               src_bv = new_bio->bi_io_vec[i++];
>> -               dst_bv = bio->bi_io_vec[bio_init_idx + hole];
>> -
>> -               src_p = kmap_atomic(src_bv.bv_page);
>> -               dst_p = kmap_atomic(dst_bv.bv_page);
>> -
>> -               memcpy(dst_p + dst_bv.bv_offset,
>> -                       src_p + src_bv.bv_offset,
>> -                       PBLK_EXPOSED_PAGE_SIZE);
>> -
>> -               kunmap_atomic(src_p);
>> -               kunmap_atomic(dst_p);
>> -
>> -               mempool_free(src_bv.bv_page, &pblk->page_bio_pool);
>> -
>> -               hole = find_next_zero_bit(read_bitmap, nr_secs, hole + 1);
>> -       } while (hole < nr_secs);
>> -
>> -       bio_put(new_bio);
>> -       kfree(pr_ctx);
>> -
>> -       /* restore original request */
>> -       rqd->bio = NULL;
>> -       rqd->nr_ppas = nr_secs;
>> -
>> -       pblk_end_user_read(bio, rqd->error);
>> -       __pblk_end_io_read(pblk, rqd, false);
>> -}
>> -
>> -static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
>> -                           unsigned int bio_init_idx,
>> -                           unsigned long *read_bitmap,
>> -                           int nr_holes)
>> -{
>> -       void *meta_list = rqd->meta_list;
>> -       struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
>> -       struct pblk_pr_ctx *pr_ctx;
>> -       struct bio *new_bio, *bio = r_ctx->private;
>> -       int nr_secs = rqd->nr_ppas;
>> -       int i;
>> -
>> -       new_bio = bio_alloc(GFP_KERNEL, nr_holes);
>> -
>> -       if (pblk_bio_add_pages(pblk, new_bio, GFP_KERNEL, nr_holes))
>> -               goto fail_bio_put;
>> -
>> -       if (nr_holes != new_bio->bi_vcnt) {
>> -               WARN_ONCE(1, "pblk: malformed bio\n");
>> -               goto fail_free_pages;
>> -       }
>> -
>> -       pr_ctx = kzalloc(sizeof(struct pblk_pr_ctx), GFP_KERNEL);
>> -       if (!pr_ctx)
>> -               goto fail_free_pages;
>> -
>> -       for (i = 0; i < nr_secs; i++) {
>> -               struct pblk_sec_meta *meta = pblk_get_meta(pblk, meta_list, i);
>> -
>> -               pr_ctx->lba_list_mem[i] = le64_to_cpu(meta->lba);
>> -       }
>> -
>> -       new_bio->bi_iter.bi_sector = 0; /* internal bio */
>> -       bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
>> -
>> -       rqd->bio = new_bio;
>> -       rqd->nr_ppas = nr_holes;
>> -
>> -       pr_ctx->orig_bio = bio;
>> -       bitmap_copy(pr_ctx->bitmap, read_bitmap, NVM_MAX_VLBA);
>> -       pr_ctx->bio_init_idx = bio_init_idx;
>> -       pr_ctx->orig_nr_secs = nr_secs;
>> -       r_ctx->private = pr_ctx;
>> -
>> -       if (unlikely(nr_holes == 1)) {
>> -               pr_ctx->ppa_ptr = rqd->ppa_list;
>> -               pr_ctx->dma_ppa_list = rqd->dma_ppa_list;
>> -               rqd->ppa_addr = rqd->ppa_list[0];
>> -       }
>> -       return 0;
>> -
>> -fail_free_pages:
>> -       pblk_bio_free_pages(pblk, new_bio, 0, new_bio->bi_vcnt);
>> -fail_bio_put:
>> -       bio_put(new_bio);
>> -
>> -       return -ENOMEM;
>> -}
>> -
>> -static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
>> -                                unsigned int bio_init_idx,
>> -                                unsigned long *read_bitmap, int nr_secs)
>> -{
>> -       int nr_holes;
>> -       int ret;
>> -
>> -       nr_holes = nr_secs - bitmap_weight(read_bitmap, nr_secs);
>> -
>> -       if (pblk_setup_partial_read(pblk, rqd, bio_init_idx, read_bitmap,
>> -                                   nr_holes))
>> -               return NVM_IO_ERR;
>> -
>> -       rqd->end_io = pblk_end_partial_read;
>> -
>> -       ret = pblk_submit_io(pblk, rqd);
>> -       if (ret) {
>> -               bio_put(rqd->bio);
>> -               pblk_err(pblk, "partial read IO submission failed\n");
>> -               goto err;
>> -       }
>> -
>> -       return NVM_IO_OK;
>> -
>> -err:
>> -       pblk_err(pblk, "failed to perform partial read\n");
>> -
>> -       /* Free allocated pages in new bio */
>> -       pblk_bio_free_pages(pblk, rqd->bio, 0, rqd->bio->bi_vcnt);
>> -       __pblk_end_io_read(pblk, rqd, false);
>> -       return NVM_IO_ERR;
>> -}
>> -
>>   static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
>>                           sector_t lba, unsigned long *read_bitmap)
>>   {
>> @@ -432,11 +267,11 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
>>   {
>>          struct nvm_tgt_dev *dev = pblk->dev;
>>          struct request_queue *q = dev->q;
>> +       struct bio *split_bio, *int_bio;
>>          sector_t blba = pblk_get_lba(bio);
>>          unsigned int nr_secs = pblk_get_secs(bio);
>>          struct pblk_g_ctx *r_ctx;
>>          struct nvm_rq *rqd;
>> -       unsigned int bio_init_idx;
>>          DECLARE_BITMAP(read_bitmap, NVM_MAX_VLBA);
>>          int ret = NVM_IO_ERR;
>>
>> @@ -456,61 +291,66 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
>>          r_ctx = nvm_rq_to_pdu(rqd);
>>          r_ctx->start_time = jiffies;
>>          r_ctx->lba = blba;
>> -       r_ctx->private = bio; /* original bio */
>>
>> -       /* Save the index for this bio's start. This is needed in case
>> -        * we need to fill a partial read.
>> +       /* Clone read bio to deal with:
>> +        * -usage of bio_advance() when memcpy data from round buffer
>> +        * -read errors in case of reading from device
>>           */
>> -       bio_init_idx = pblk_get_bi_idx(bio);
>> +       int_bio = bio_clone_fast(bio, GFP_KERNEL, &pblk_bio_set);
>> +       if (!int_bio)
>> +               return NVM_IO_ERR;
>>
>>          if (pblk_alloc_rqd_meta(pblk, rqd))
>>                  goto fail_rqd_free;
>>
>>          if (nr_secs > 1)
>> -               pblk_read_ppalist_rq(pblk, rqd, bio, blba, read_bitmap);
>> +               pblk_read_ppalist_rq(pblk, rqd, int_bio, blba, read_bitmap);
>>          else
>> -               pblk_read_rq(pblk, rqd, bio, blba, read_bitmap);
>> +               pblk_read_rq(pblk, rqd, int_bio, blba, read_bitmap);
>> +
>> +split_retry:
>> +       r_ctx->private = bio; /* original bio */
>>
>> -       if (bitmap_full(read_bitmap, nr_secs)) {
>> +       if (bitmap_full(read_bitmap, rqd->nr_ppas)) {
>> +               bio_put(int_bio);
>>                  atomic_inc(&pblk->inflight_io);
>>                  __pblk_end_io_read(pblk, rqd, false);
>>                  return NVM_IO_DONE;
>>          }
>>
>> -       /* All sectors are to be read from the device */
>> -       if (bitmap_empty(read_bitmap, rqd->nr_ppas)) {
>> -               struct bio *int_bio = NULL;
>> +       if (!bitmap_empty(read_bitmap, rqd->nr_ppas)) {
>> +               /* The read bio request could be partially filled by the write
>> +                * buffer, but there are some holes that need to be read from
>> +                * the drive. In order to handle this, we will use block layer
>> +                * mechanism to split this request in to smaller ones.
>> +                */
>> +               split_bio = bio_split(bio, NR_PHY_IN_LOG, GFP_KERNEL,
>> +                                       &pblk_bio_set);
> 
> This is quite inefficient. If you have an rqd with 63 sectors on the device and
> the 64th is cached, you are splitting 63 times whereas a single split
> would be sufficient.

Yeah, definitely, it would be better to find how many contiguous sectors 
in cache/on drive are and splitting based on it. Will improve that in v2.

> 
>> +               bio_chain(split_bio, bio);
> 
> I am not sure if it's needed but in blk_queue_split() these flags are set
> before making the request:
>          split->bi_opf |= REQ_NOMERGE;
>          bio_set_flag(*bio, BIO_QUEUE_ENTERED);
> 
>> +               generic_make_request(bio);
> 
> pblk_lookup_l2p_seq() increments line->ref. You have to release the krefs before
> requeing the request.
> 
I completely forgot about it, will fix that of course, thanks!

> You might consider introducing a pblk_lookup_l2p_uncached() which returns when
> it finds a cached sector and returns its index. Doing so you can avoid obtaining
> superfluous line->refs and we could also get rid of the read_bitmap
> entirely. This
> index could also be used to split the bio at the right position.
> 
>> +
>> +               /* Retry after split with new bio and existing rqd */
>> +               bio = split_bio;
>> +               rqd->nr_ppas = 1;
>> +               rqd->ppa_addr = rqd->ppa_list[0];
>>
>> -               /* Clone read bio to deal with read errors internally */
>> +               /* Recreate int_bio for the retry needs */
>> +               bio_put(int_bio);
>>                  int_bio = bio_clone_fast(bio, GFP_KERNEL, &pblk_bio_set);
>> -               if (!int_bio) {
>> -                       pblk_err(pblk, "could not clone read bio\n");
>> -                       goto fail_end_io;
>> -               }
>> -
>> -               rqd->bio = int_bio;
>> -
>> -               if (pblk_submit_io(pblk, rqd)) {
>> -                       pblk_err(pblk, "read IO submission failed\n");
>> -                       ret = NVM_IO_ERR;
>> -                       goto fail_end_io;
>> -               }
>> -
>> -               return NVM_IO_OK;
>> +               if (!int_bio)
>> +                       return NVM_IO_ERR;
>> +               goto split_retry;
>>          }
>>
>> -       /* The read bio request could be partially filled by the write buffer,
>> -        * but there are some holes that need to be read from the drive.
>> -        */
>> -       ret = pblk_partial_read_bio(pblk, rqd, bio_init_idx, read_bitmap,
>> -                                   nr_secs);
>> -       if (ret)
>> -               goto fail_meta_free;
>> -
>> +       /* All sectors are to be read from the device */
>> +       rqd->bio = int_bio;
>> +       if (pblk_submit_io(pblk, rqd)) {
>> +               pblk_err(pblk, "read IO submission failed\n");
>> +               ret = NVM_IO_ERR;
>> +               goto fail_end_io;
>> +       }
>>          return NVM_IO_OK;
>>
>> -fail_meta_free:
>> -       nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
>>   fail_rqd_free:
>>          pblk_free_rqd(pblk, rqd, PBLK_READ);
>>          return ret;
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index 381f074..0a85990 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -123,18 +123,6 @@ struct pblk_g_ctx {
>>          u64 lba;
>>   };
>>
>> -/* partial read context */
>> -struct pblk_pr_ctx {
>> -       struct bio *orig_bio;
>> -       DECLARE_BITMAP(bitmap, NVM_MAX_VLBA);
>> -       unsigned int orig_nr_secs;
>> -       unsigned int bio_init_idx;
>> -       void *ppa_ptr;
>> -       dma_addr_t dma_ppa_list;
>> -       u64 lba_list_mem[NVM_MAX_VLBA];
>> -       u64 lba_list_media[NVM_MAX_VLBA];
>> -};
>> -
>>   /* Pad context */
>>   struct pblk_pad_rq {
>>          struct pblk *pblk;
>> --
>> 2.9.5
>>
