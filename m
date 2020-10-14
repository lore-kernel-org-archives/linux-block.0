Return-Path: <SRS0=vf5w=DV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3AEC433DF
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 08:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC70E214D8
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 08:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgJNIbu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Oct 2020 04:31:50 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:41855 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726459AbgJNIbu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Oct 2020 04:31:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UC..yZm_1602664309;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UC..yZm_1602664309)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 14 Oct 2020 16:31:50 +0800
Subject: Re: [PATCH] block: set NOWAIT for sync polling
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com, xiaoguang.wang@linux.alibaba.com,
        Christoph Hellwig <hch@lst.de>
References: <20201013084051.27255-1-jefflexu@linux.alibaba.com>
 <20201013120913.GA614668@T590>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <17357ee1-7662-f20b-0a49-2fb3fdf01ebc@linux.alibaba.com>
Date:   Wed, 14 Oct 2020 16:31:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201013120913.GA614668@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

What about just disabling HIPRI in preadv2(2)/pwritev2(2)? Christoph 
Hellwig disabled HIPRI for libaio in

commit 154989e45fd8de9bfb52bbd6e5ea763e437e54c5 ("aio: clear 
IOCB_HIPRI"). What do you think, @Christoph?

(cc Christoph Hellwig)


>   static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
>   {
> -	bio->bi_opf |= REQ_HIPRI;
> -	if (!is_sync_kiocb(kiocb))
> -		bio->bi_opf |= REQ_NOWAIT;
> +	bio->bi_opf |= REQ_HIPRI | REQ_NOWAIT;
>   }

The original patch indeed could not fix the problem. Though it could fix 
the potential deadlock,

the VFS code read(2)/write(2) is not ready by handling the returned 
-EAGAIN gracefully. Currently

read(2)/write(2) will just return -EAGAIN to user space.



On 10/13/20 8:09 PM, Ming Lei wrote:
> On Tue, Oct 13, 2020 at 04:40:51PM +0800, Jeffle Xu wrote:
>> Sync polling also needs REQ_NOWAIT flag. One sync read/write may be
>> split into several bios (and thus several requests), and can used up the
>> queue depth sometimes. Thus the following bio in the same sync
>> read/write will wait for usable request if REQ_NOWAIT flag not set, in
>> which case the following sync polling will cause a deadlock.
>>
>> One case (maybe the only case) for above situation is preadv2/pwritev2
>> + direct + highpri. Two conditions need to be satisfied to trigger the
>> deadlock.
>>
>> 1. HIPRI IO in sync routine. Normal read(2)/pread(2)/readv(2)/preadv(2)
>> and corresponding write family syscalls don't support high-priority IO and
>> thus won't trigger polling routine. Only preadv2(2)/pwritev2(2) supports
>> high-priority IO by RWF_HIPRI flag of @flags parameter.
>>
>> 2. Polling support in sync routine. Currently both the blkdev and
>> iomap-based fs (ext4/xfs, etc) support polling in direct IO routine. The
>> general routine is described as follows.
>>
>> submit_bio
>>    wait for blk_mq_get_tag(), waiting for requests completion, which
>>    should be done by the following polling, thus causing a deadlock.
> Another blocking point is rq_qos_throttle(),

What is the issue here in rq_qos_throttle()? More details?


> so I guess falling back to
> REQ_NOWAIT may not fix the issue completely.



> Given iopoll isn't supposed to in case of big IO, another solution
> may be to disable iopoll when bio splitting is needed, something
> like the following change:
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index bcf5e4580603..8e762215660b 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -279,6 +279,12 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>   	return NULL;
>   split:
>   	*segs = nsegs;
> +
> +	/*
> +	 * bio splitting may cause more trouble for iopoll which isn't supposed
> +	 * to be used in case of big IO
> +	 */
> +	bio->bi_opf &= ~REQ_HIPRI;
>   	return bio_split(bio, sectors, GFP_NOIO, bs);
>   }

Actually split is not only from blk_mq_submit_bio->__blk_queue_split. In 
__blkdev_direct_IO,

one input iov_iter could be split to several bios.

```

__blkdev_direct_IO:

for (;;) {
         ret = bio_iov_iter_get_pages(bio, iter);
         submit_bio(bio);
}

for (;;) {
         blk_poll()

         ...

}

```

Since  one single bio can contain at most BIO_MAX_PAGES, i.e. 256 
bio_vec in @bio->bi_io_vec,

if the @iovcnt parameter of preadv2(2)/pwritev2(2) is larger than 256, 
then one call of

preadv2(2)/pwritev2(2) can be split into several bios. These bios are 
submitted at once, and then

start sync polling in the process context.


If the number of bios split from one call of preadv2(2)/pwritev2(2) is 
larger than the queue depth,

bios from single preadv2(2)/pwritev2(2) call can exhaust the queue depth 
and thus cause deadlock.

Fortunately the maximum of @iovcnt parameter of preadv2(2)/pwritev2(2) 
is UIO_MAXIOV, i.e. 1024,

and the minimum of queue depth is BLKDEV_MIN_RQ i.e. 4. That means one 
preadv2(2)/pwritev2(2)

call can submit at most 4 bios, which will fill up the queue depth 
exactly and there's no deadlock in this

case. I'm not sure if the setting of 
UIO_MAXIOV/BIO_MAX_PAGES/BLKDEV_MIN_RQ is coincident or

deliberately tuned. At least it will not cause deadlock currently , 
though the constraint may be a little fragile.


By the way, this patch could fix the potential hang I mentioned in

https://patchwork.kernel.org/project/linux-block/patch/20200911032958.125068-1-jefflexu@linux.alibaba.com/


>   
>
>
> Thanks,
> Ming
