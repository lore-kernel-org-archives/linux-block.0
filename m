Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD8AC5519F
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 09:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE69208C3
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 09:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKYJPN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 04:15:13 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:42535 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726442AbgKYJPN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 04:15:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UGUgl2G_1606295708;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UGUgl2G_1606295708)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Nov 2020 17:15:09 +0800
Subject: Re: [PATCH v6] block: disable iopoll for split bio
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com, hch@infradead.org
References: <20201125064147.25389-1-jefflexu@linux.alibaba.com>
 <20201125071944.GA24725@T590>
 <f8f52efa-a99e-5fbb-dd92-597a13fd4a2f@linux.alibaba.com>
 <20201125081937.GA28463@T590>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <cbf6e735-26e7-86c2-6592-a1a54b1393ca@linux.alibaba.com>
Date:   Wed, 25 Nov 2020 17:15:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201125081937.GA28463@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/25/20 4:19 PM, Ming Lei wrote:
> On Wed, Nov 25, 2020 at 04:05:10PM +0800, JeffleXu wrote:
>>
>>
>> On 11/25/20 3:19 PM, Ming Lei wrote:
>>> On Wed, Nov 25, 2020 at 02:41:47PM +0800, Jeffle Xu wrote:
>>>> iopoll is initially for small size, latency sensitive IO. It doesn't
>>>> work well for big IO, especially when it needs to be split to multiple
>>>> bios. In this case, the returned cookie of __submit_bio_noacct_mq() is
>>>> indeed the cookie of the last split bio. The completion of *this* last
>>>> split bio done by iopoll doesn't mean the whole original bio has
>>>> completed. Callers of iopoll still need to wait for completion of other
>>>> split bios.
>>>>
>>>> Besides bio splitting may cause more trouble for iopoll which isn't
>>>> supposed to be used in case of big IO.
>>>>
>>>> iopoll for split bio may cause potential race if CPU migration happens
>>>> during bio submission. Since the returned cookie is that of the last
>>>> split bio, polling on the corresponding hardware queue doesn't help
>>>> complete other split bios, if these split bios are enqueued into
>>>> different hardware queues. Since interrupts are disabled for polling
>>>> queues, the completion of these other split bios depends on timeout
>>>> mechanism, thus causing a potential hang.
>>>>
>>>> iopoll for split bio may also cause hang for sync polling. Currently
>>>> both the blkdev and iomap-based fs (ext4/xfs, etc) support sync polling
>>>> in direct IO routine. These routines will submit bio without REQ_NOWAIT
>>>> flag set, and then start sync polling in current process context. The
>>>> process may hang in blk_mq_get_tag() if the submitted bio has to be
>>>> split into multiple bios and can rapidly exhaust the queue depth. The
>>>> process are waiting for the completion of the previously allocated
>>>> requests, which should be reaped by the following polling, and thus
>>>> causing a deadlock.
>>>>
>>>> To avoid these subtle trouble described above, just disable iopoll for
>>>> split bio.
>>>>
>>>> Suggested-by: Ming Lei <ming.lei@redhat.com>
>>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>> ---
>>>>  block/bio.c               |  2 ++
>>>>  block/blk-merge.c         | 12 ++++++++++++
>>>>  block/blk-mq.c            |  3 +++
>>>>  include/linux/blk_types.h |  1 +
>>>>  4 files changed, 18 insertions(+)
>>>>
>>>> diff --git a/block/bio.c b/block/bio.c
>>>> index fa01bef35bb1..7f7ddc22a30d 100644
>>>> --- a/block/bio.c
>>>> +++ b/block/bio.c
>>>> @@ -684,6 +684,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
>>>>  	bio_set_flag(bio, BIO_CLONED);
>>>>  	if (bio_flagged(bio_src, BIO_THROTTLED))
>>>>  		bio_set_flag(bio, BIO_THROTTLED);
>>>> +	if (bio_flagged(bio_src, BIO_SPLIT))
>>>> +		bio_set_flag(bio, BIO_SPLIT);
>>>>  	bio->bi_opf = bio_src->bi_opf;
>>>>  	bio->bi_ioprio = bio_src->bi_ioprio;
>>>>  	bio->bi_write_hint = bio_src->bi_write_hint;
>>>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>>>> index bcf5e4580603..a2890cebf99f 100644
>>>> --- a/block/blk-merge.c
>>>> +++ b/block/blk-merge.c
>>>> @@ -279,6 +279,18 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>>>>  	return NULL;
>>>>  split:
>>>>  	*segs = nsegs;
>>>> +
>>>> +	/*
>>>> +	 * Bio splitting may cause subtle trouble such as hang when doing sync
>>>> +	 * iopoll in direct IO routine. Given performance gain of iopoll for
>>>> +	 * big IO can be trival, disable iopoll when split needed. We need
>>>> +	 * BIO_SPLIT to identify bios need this workaround. Since currently
>>>> +	 * only normal IO under mq routine may suffer this issue, BIO_SPLIT is
>>>> +	 * only marked here.
>>>> +	 */
>>>> +	bio->bi_opf &= ~REQ_HIPRI;
>>>> +	bio_set_flag(bio, BIO_SPLIT);
>>>> +
>>>>  	return bio_split(bio, sectors, GFP_NOIO, bs);
>>>>  }
>>>>  
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index 55bcee5dc032..ce1f3628e4c2 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -2265,6 +2265,9 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>>>>  		blk_mq_sched_insert_request(rq, false, true, true);
>>>>  	}
>>>>  
>>>> +	if (bio_flagged(bio, BIO_SPLIT))
>>>> +		return BLK_QC_T_NONE;
>>>> +
>>>
>>> Not sure the new bio flag is really required for this case, just wondering
>>> why not take the following simple way? BTW we are really going to run
>>> out of bio flag.
>>>
>>
>> Please consider the following case:
>>
>> One big bio got split into two split bios. At the first call of
>> blk_mq_submit_bio(), the input @bio (actually the original big bio)
>> indeed gets split. The split bio gets enqueued to hw queue and the
>> returned cookie is BLK_QC_T_NONE, while the remained bio gets buffered
>> in bio_list. So far so good.
> 
> When this bio gets splitted, REQ_HIPRI is cleared for this bio, and
> all splitted bios won't set this flag too.
> 
That's true, at least in terms of my patch.

>>
>> Then when calling blk_mq_submit_bio() the second time, the input @bio is
>> indeed the remained bio. At this time, it will not get split and you
>> will get a *valid* cookie. And since the cookie of last split bio will
>> actually overrides the previous cookie, you will get a *valid* cookie as
>> a result.
> 
> Then valid cookie can be returned only for bio with REQ_HIPRI.
Sounds reasonable. The side effect is that original IO without REQ_HIPRI
now also returns BLK_QC_T_NONE. But it may not be a big problem, since
the returned cookie is not used at all for IO without REQ_HIPRI.

-- 
Thanks,
Jeffle
