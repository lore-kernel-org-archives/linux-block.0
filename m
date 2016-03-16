Return-Path: <vkuznets@redhat.com>
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Dan Williams <dan.j.williams@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sagi Grimberg <sagig@mellanox.com>, Mike Snitzer <snitzer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Cathy Avery <cavery@redhat.com>, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH RFC] block: fix bio merge checks when virt_boundary is set
References: <1458055076-2175-1-git-send-email-vkuznets@redhat.com>
	<CACVXFVMs-fOaNVUyedg66T83MiOc7a+op3LeHVt6ogVBQnYdeQ@mail.gmail.com>
Date: Wed, 16 Mar 2016 17:26:28 +0100
In-Reply-To: <CACVXFVMs-fOaNVUyedg66T83MiOc7a+op3LeHVt6ogVBQnYdeQ@mail.gmail.com>
	(Ming Lei's message of "Wed, 16 Mar 2016 23:40:02 +0800")
Message-ID: <87oaae4cej.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Ming Lei <tom.leiming@gmail.com> writes:

> On Tue, Mar 15, 2016 at 11:17 PM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> Hyper-V storage driver, which switched to using virt_boundary some time
>> ago, experiences significant slowdown on non-page-aligned IO. E.g.
>>
>> With virt_boundary set:
>>  # time mkfs.ntfs -Q -s 512 /dev/sdc1
>>  ...
>>  real   0m9.406s
>>  user   0m0.014s
>>  sys    0m0.672s
>>
>> Without virt_boundary set (unsafe):
>>  # time mkfs.ntfs -Q -s 512 /dev/sdc1
>>  ...
>>  real   0m6.657s
>>  user   0m0.012s
>>  sys    0m6.423s
>>
>> The reason of the slowdown is the fact that bios don't get merged and we
>> end up sending many short requests to the host. My investigation led me to
>> the following code (__bvec_gap_to_prev()):
>>
>>     return offset ||
>>            ((bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q));
>>
>> Here is an example: we have two bio_vec with the following content:
>>     bprv.bv_offset = 512
>>     bprv.bv_len = 512
>>
>>     bnxt.bv_offset = 1024
>>     bnxt.bv_len = 512
>>
>>     bprv.bv_page == bnxt.bv_page
>>     virt_boundary is set to PAGE_SIZE-1
>>
>> The above mentioned code will report that a gap will appear if we merge
>> these two (as offset = 1024) but this doesn't look sane. On top of that,
>> we have the following optimization in bio_add_pc_page():
>>
>>     if (page == prev->bv_page &&
>>         offset == prev->bv_offset + prev->bv_len) {
>>             prev->bv_len += len;
>>             bio->bi_iter.bi_size += len;
>>             goto done;
>>         }
>>
>> But we don't have such check in other places, which check virt_boundary.
>
> We do have the above merge in bio_add_page(), so the two bios in
> your above example shouldn't have been observed if the two buffers
> are added to bio via the bio_add_page().
>
> If you see short bios in above example, maybe you need to check ntfs code:
>
> - if bio_add_page() is used to add buffer
> - if using one standalone bio to transfer each 512byte, even they
> are in same page and the sector is continuous

I'm not using ntfs, mkfs.ntfs is a userspace application which shows the
regression when virt_boundary is in place. I should have avoided
mentioning bio_add_pc_page() here as it is unrelated to the issue.

In particular, I'm concearned about the following call sites:
blk_bio_segment_split()
ll_back_merge_fn()
ll_front_merge_fn()

>> Modify the check in __bvec_gap_to_prev() to the following:
>> 1) Report no gap in case bnxt->bv_offset == bprv->bv_offset + bprv->bv_len
>>    when bprv.bv_page == bnxt.bv_page.
>> 2) Continue reporting no gap in (bprv->bv_offset + bprv->bv_len) &
>>    queue_virt_boundary(q) case.
>>
>> Reported-by: John R. Kozee II <jkozee@bowser-morner.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> - The condition I'm changing was there since SG_GAPS so I may be missing
>>   something important, thus RFC.
>> ---
>>  block/bio-integrity.c  |  7 +++++--
>>  block/bio.c            |  4 +++-
>>  block/blk-merge.c      |  2 +-
>>  include/linux/blkdev.h | 17 +++++++++--------
>>  4 files changed, 18 insertions(+), 12 deletions(-)
>>
>> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
>> index 711e4d8d..f8560da 100644
>> --- a/block/bio-integrity.c
>> +++ b/block/bio-integrity.c
>> @@ -136,7 +136,7 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
>>                            unsigned int len, unsigned int offset)
>>  {
>>         struct bio_integrity_payload *bip = bio_integrity(bio);
>> -       struct bio_vec *iv;
>> +       struct bio_vec *iv, bv;
>>
>>         if (bip->bip_vcnt >= bip->bip_max_vcnt) {
>>                 printk(KERN_ERR "%s: bip_vec full\n", __func__);
>> @@ -144,10 +144,13 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
>>         }
>>
>>         iv = bip->bip_vec + bip->bip_vcnt;
>> +       bv.bv_page = page;
>> +       bv.bv_len = len;
>> +       bv.bv_offset = offset;
>>
>>         if (bip->bip_vcnt &&
>>             bvec_gap_to_prev(bdev_get_queue(bio->bi_bdev),
>> -                            &bip->bip_vec[bip->bip_vcnt - 1], offset))
>> +                            &bip->bip_vec[bip->bip_vcnt - 1], &bv))
>>                 return 0;
>>
>>         iv->bv_page = page;
>> diff --git a/block/bio.c b/block/bio.c
>> index cf75915..1583581 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -730,6 +730,8 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
>>          */
>>         if (bio->bi_vcnt > 0) {
>>                 struct bio_vec *prev = &bio->bi_io_vec[bio->bi_vcnt - 1];
>> +               struct bio_vec bv = {.bv_page = page, .bv_len = len,
>> +                                    .bv_offset = offset};
>>
>>                 if (page == prev->bv_page &&
>>                     offset == prev->bv_offset + prev->bv_len) {
>> @@ -742,7 +744,7 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
>>                  * If the queue doesn't support SG gaps and adding this
>>                  * offset would create a gap, disallow it.
>>                  */
>> -               if (bvec_gap_to_prev(q, prev, offset))
>> +               if (bvec_gap_to_prev(q, prev, &bv))
>>                         return 0;
>>         }
>>
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 2613531..8c6c3e2 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -100,7 +100,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>>                  * If the queue doesn't support SG gaps and adding this
>>                  * offset would create a gap, disallow it.
>>                  */
>> -               if (bvprvp && bvec_gap_to_prev(q, bvprvp, bv.bv_offset))
>> +               if (bvprvp && bvec_gap_to_prev(q, bvprvp, &bv))
>>                         goto split;
>>
>>                 if (sectors + (bv.bv_len >> 9) > max_sectors) {
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 413c84f..b4fa29d 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1373,10 +1373,11 @@ static inline void put_dev_sector(Sector p)
>>  }
>>
>>  static inline bool __bvec_gap_to_prev(struct request_queue *q,
>> -                               struct bio_vec *bprv, unsigned int offset)
>> +                               struct bio_vec *bprv, struct bio_vec *bnxt)
>>  {
>> -       return offset ||
>> -               ((bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q));
>> +       if (bprv->bv_page == bnxt->bv_page)
>> +               return bnxt->bv_offset != bprv->bv_offset + bprv->bv_len;
>> +       return (bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q);
>
> Why do you remove check on 'offset'?
>

Because this check is wrong in my opinion and that's what's causing the
issue.

Let me try to give my example again.

We have two bios,

     bprv.bv_offset = 512
     bprv.bv_len = 512

     bnxt.bv_offset = 1024
     bnxt.bv_len = 512

     bprv.bv_page == bnxt.bv_page
     virt_boundary is set to PAGE_SIZE-1

we call __bvec_gap_to_prev(q, &bprv, bnxt.offset) and 'offset' check
will report that a gap will appear if we merge these two bios. This
seems wrong.

>>  }
>>
>>  /*
>> @@ -1384,11 +1385,11 @@ static inline bool __bvec_gap_to_prev(struct request_queue *q,
>>   * the SG list. Most drivers don't care about this, but some do.
>>   */
>>  static inline bool bvec_gap_to_prev(struct request_queue *q,
>> -                               struct bio_vec *bprv, unsigned int offset)
>> +                               struct bio_vec *bprv, struct bio_vec *bnxt)
>>  {
>>         if (!queue_virt_boundary(q))
>>                 return false;
>> -       return __bvec_gap_to_prev(q, bprv, offset);
>> +       return __bvec_gap_to_prev(q, bprv, bnxt);
>>  }
>>
>>  static inline bool bio_will_gap(struct request_queue *q, struct bio *prev,
>> @@ -1400,7 +1401,7 @@ static inline bool bio_will_gap(struct request_queue *q, struct bio *prev,
>>                 bio_get_last_bvec(prev, &pb);
>>                 bio_get_first_bvec(next, &nb);
>>
>> -               return __bvec_gap_to_prev(q, &pb, nb.bv_offset);
>> +               return __bvec_gap_to_prev(q, &pb, &nb);
>>         }
>>
>>         return false;
>> @@ -1545,7 +1546,7 @@ static inline bool integrity_req_gap_back_merge(struct request *req,
>>         struct bio_integrity_payload *bip_next = bio_integrity(next);
>>
>>         return bvec_gap_to_prev(req->q, &bip->bip_vec[bip->bip_vcnt - 1],
>> -                               bip_next->bip_vec[0].bv_offset);
>> +                               &bip_next->bip_vec[0]);
>>  }
>>
>>  static inline bool integrity_req_gap_front_merge(struct request *req,
>> @@ -1555,7 +1556,7 @@ static inline bool integrity_req_gap_front_merge(struct request *req,
>>         struct bio_integrity_payload *bip_next = bio_integrity(req->bio);
>>
>>         return bvec_gap_to_prev(req->q, &bip->bip_vec[bip->bip_vcnt - 1],
>> -                               bip_next->bip_vec[0].bv_offset);
>> +                               &bip_next->bip_vec[0]);
>>  }
>>
>>  #else /* CONFIG_BLK_DEV_INTEGRITY */
>> --
>> 2.5.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-block" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
  Vitaly
