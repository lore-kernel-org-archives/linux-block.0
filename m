Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34940 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754480AbdDDPUM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 11:20:12 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 7/7] Guard bvec iteration logic v2
In-Reply-To: <CACVXFVPWe0ABh5CsXryqXi7Umtvvzcq=jp2n+t=JDRWSZJsbFA@mail.gmail.com>
References: <1491204212-9952-1-git-send-email-dmonakhov@openvz.org> <1491204212-9952-8-git-send-email-dmonakhov@openvz.org> <CACVXFVPWe0ABh5CsXryqXi7Umtvvzcq=jp2n+t=JDRWSZJsbFA@mail.gmail.com>
Date: Tue, 04 Apr 2017 18:19:59 +0300
Message-ID: <871st8kxnk.fsf@dmlp.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Ming Lei <tom.leiming@gmail.com> writes:

> On Mon, Apr 3, 2017 at 3:23 PM, Dmitry Monakhov <dmonakhov@openvz.org> wrote:
>> Currently if some one try to advance bvec beyond it's size we simply
>> dump WARN_ONCE and continue to iterate beyond bvec array boundaries.
>> This simply means that we endup dereferencing/corrupting random memory
>> region.
>>
>> Sane reaction would be to propagate error back to calling context
>> But bvec_iter_advance's calling context is not always good for error
>> handling. For safity reason let truncate iterator size to zero which
>
> IMO, we can avoid continuing to iterate by checking the return value,
> and looks it is rude to just set iterator size as 0.
But situation itself is horrible already. IMHO this is BUG_ON situation,
but since Linus hate bugons, I try to replace with something loud, but
very safe. Since there is no guarantee that caller will ignore an error
and try to dereference bvec the only safe thing we can to is to clamp
iterator to zero to prevent any possible usage in future.
>
>> will break external iteration loop which prevent us from unpredictable
>> memory range corruption. And even it caller ignores an error, it will
>> corrupt it's own bvecs, not others.
>>
>> This patch does:
>> - Return error back to caller with hope that it will react on this
>> - Truncate iterator size
>>
>> Code was added long time ago here 4550dd6c, luckily no one hit it
>> in real life :)
>>
>> changes since V1:
>>  - Replace  BUG_ON with error logic.
>>
>> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
>> ---
>>  drivers/nvdimm/blk.c |  4 +++-
>>  drivers/nvdimm/btt.c |  4 +++-
>>  include/linux/bio.h  |  8 ++++++--
>>  include/linux/bvec.h | 11 ++++++++---
>>  4 files changed, 20 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
>> index 1edb3f3..04c3075 100644
>> --- a/drivers/nvdimm/blk.c
>> +++ b/drivers/nvdimm/blk.c
>> @@ -106,7 +106,9 @@ static int nd_blk_rw_integrity(struct nd_namespace_blk *nsblk,
>>
>>                 len -= cur_len;
>>                 dev_offset += cur_len;
>> -               bvec_iter_advance(bip->bip_vec, &bip->bip_iter, cur_len);
>> +               err = bvec_iter_advance(bip->bip_vec, &bip->bip_iter, cur_len);
>> +               if (err)
>> +                       return err;
>>         }
>>
>>         return err;
>> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
>> index 03ded8d..3f3aa7b 100644
>> --- a/drivers/nvdimm/btt.c
>> +++ b/drivers/nvdimm/btt.c
>> @@ -942,7 +942,9 @@ static int btt_rw_integrity(struct btt *btt, struct bio_integrity_payload *bip,
>>
>>                 len -= cur_len;
>>                 meta_nsoff += cur_len;
>> -               bvec_iter_advance(bip->bip_vec, &bip->bip_iter, cur_len);
>> +               ret = bvec_iter_advance(bip->bip_vec, &bip->bip_iter, cur_len);
>> +               if (ret)
>> +                       return ret;
>>         }
>>
>>         return ret;
>> diff --git a/include/linux/bio.h b/include/linux/bio.h
>> index 0c1c95c..8bf1564 100644
>> --- a/include/linux/bio.h
>> +++ b/include/linux/bio.h
>> @@ -168,8 +168,12 @@ static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
>>
>>         if (bio_no_advance_iter(bio))
>>                 iter->bi_size -= bytes;
>> -       else
>> -               bvec_iter_advance(bio->bi_io_vec, iter, bytes);
>> +       else {
>> +               int err;
>> +               err = bvec_iter_advance(bio->bi_io_vec, iter, bytes);
>> +               if (unlikely(err))
>> +                       bio->bi_error = err;
>> +       }
>>  }
>>
>>  #define __bio_for_each_segment(bvl, bio, iter, start)                  \
>> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
>> index 89b65b8..c117f1a 100644
>> --- a/include/linux/bvec.h
>> +++ b/include/linux/bvec.h
>> @@ -22,6 +22,7 @@
>>
>>  #include <linux/kernel.h>
>>  #include <linux/bug.h>
>> +#include <linux/errno.h>
>>
>>  /*
>>   * was unsigned short, but we might as well be ready for > 64kB I/O pages
>> @@ -66,12 +67,15 @@ struct bvec_iter {
>>         .bv_offset      = bvec_iter_offset((bvec), (iter)),     \
>>  })
>>
>> -static inline void bvec_iter_advance(const struct bio_vec *bv,
>> +static inline int bvec_iter_advance(const struct bio_vec *bv,
>>                                      struct bvec_iter *iter,
>>                                      unsigned bytes)
>>  {
>> -       WARN_ONCE(bytes > iter->bi_size,
>> -                 "Attempted to advance past end of bvec iter\n");
>> +       if(unlikely(bytes > iter->bi_size)) {
>> +               WARN(1, "Attempted to advance past end of bvec iter\n");
>> +               iter->bi_size = 0;
>> +               return -EINVAL;
>> +       }
>>
>>         while (bytes) {
>>                 unsigned iter_len = bvec_iter_len(bv, *iter);
>> @@ -86,6 +90,7 @@ static inline void bvec_iter_advance(const struct bio_vec *bv,
>>                         iter->bi_idx++;
>>                 }
>>         }
>> +       return 0;
>>  }
>>
>>  #define for_each_bvec(bvl, bio_vec, iter, start)                       \
>> --
>> 2.9.3
>>
>
>
>
> -- 
> Ming Lei
