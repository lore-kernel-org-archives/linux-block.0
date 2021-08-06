Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C5BC4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 07:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F0E60F25
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 07:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243255AbhHFHu4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 03:50:56 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8372 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243643AbhHFHuv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Aug 2021 03:50:51 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GgyGm6y92z84DY;
        Fri,  6 Aug 2021 15:46:40 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 15:50:32 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 6 Aug 2021 15:50:32 +0800
Subject: Re: [PATCH V7 0/4] blk-mq: fix request UAF related with iterating
 over tagset requests
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>,
        David Jeffery <djeffery@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20210511152236.763464-1-ming.lei@redhat.com>
 <678fd2c5-587d-6abe-4348-067210d4adae@huawei.com> <YQy2x5RzwveW0ROR@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <3809c299-4f40-3614-c233-184d8a39e286@huawei.com>
Date:   Fri, 6 Aug 2021 15:50:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YQy2x5RzwveW0ROR@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/06 12:12, Ming Lei wrote:
> On Fri, Aug 06, 2021 at 11:40:25AM +0800, yukuai (C) wrote:
>> On 2021/05/11 23:22, Ming Lei wrote:
>>> Hi Jens,
>>>
>>> This patchset fixes the request UAF issue by one simple approach,
>>> without clearing ->rqs[] in fast path, please consider it for 5.13.
>>>
>>> 1) grab request's ref before calling ->fn in blk_mq_tagset_busy_iter,
>>> and release it after calling ->fn, so ->fn won't be called for one
>>> request if its queue is frozen, done in 2st patch
>>>
>>> 2) clearing any stale request referred in ->rqs[] before freeing the
>>> request pool, one per-tags spinlock is added for protecting
>>> grabbing request ref vs. clearing ->rqs[tag], so UAF by refcount_inc_not_zero
>>> in bt_tags_iter() is avoided, done in 3rd patch.
>>>
>>> V7:
>>> 	- fix one null-ptr-deref during updating nr_hw_queues, because
>>> 	blk_mq_clear_flush_rq_mapping() may touch non-mapped hw queue's
>>> 	tags, only patch 4/4 is modified, reported and verified by
>>> 	Shinichiro Kawasaki
>>> 	- run blktests and not see regression
>>>
>>> V6:
>>> 	- hold spin lock when reading rq via ->rq[tag_bit], the issue is
>>> 	  added in V5
>>> 	- make blk_mq_find_and_get_req() more clean, as suggested by Bart
>>> 	- not hold tags->lock when clearing ->rqs[] for avoiding to disable
>>> 	interrupt a bit long, as suggested by Bart
>>> 	- code style change, as suggested by Christoph
>>>
>>> V5:
>>> 	- cover bt_iter() by same approach taken in bt_tags_iter(), and pass
>>> 	John's invasive test
>>> 	- add tested-by/reviewed-by tag
>>>
>>> V4:
>>> 	- remove hctx->fq-flush_rq from tags->rqs[] before freeing hw queue,
>>> 	patch 4/4 is added, which is based on David's patch.
>>>
>>> V3:
>>> 	- drop patches for completing requests started in iterator ->fn,
>>> 	  because blk-mq guarantees that valid request is passed to ->fn,
>>> 	  and it is driver's responsibility for avoiding double completion.
>>> 	  And drivers works well for not completing rq twice.
>>> 	- add one patch for avoiding double accounting of flush rq
>>>
>>> V2:
>>> 	- take Bart's suggestion to not add blk-mq helper for completing
>>> 	  requests when it is being iterated
>>> 	- don't grab rq->ref if the iterator is over static rqs because
>>> 	the use case do require to iterate over all requests no matter if
>>> 	the request is initialized or not
>>>
>>>
>>> Ming Lei (4):
>>>     block: avoid double io accounting for flush request
>>>     blk-mq: grab rq->refcount before calling ->fn in
>>>       blk_mq_tagset_busy_iter
>>>     blk-mq: clear stale request in tags->rq[] before freeing one request
>>>       pool
>>>     blk-mq: clearing flush request reference in tags->rqs[]
>>>
>>>    block/blk-flush.c  |  3 +-
>>>    block/blk-mq-tag.c | 49 ++++++++++++++++++------
>>>    block/blk-mq-tag.h |  6 +++
>>>    block/blk-mq.c     | 95 ++++++++++++++++++++++++++++++++++++++++------
>>>    block/blk-mq.h     |  1 +
>>>    5 files changed, 130 insertions(+), 24 deletions(-)
>>>
>>
>> Hi, ming
>>
>> I see this patchset was applied to fix the problem while iterating over
>> tagset, however blk_mq_tag_to_rq() is still untouched, and this
>> interface might still return freed request.
>>
>> Any reason why this interface didn't use the same solution ?
>> (hold tags->lock and return null if ref is 0)
> 
> It is driver's responsibility to cover race between normal completion
> and timeout/error handing, so driver has the knowledge if one tag is valid
> or not. In short, it is driver's responsibility to guarantee that valid 'tag'
> is passed to blk_mq_tag_to_rq().
> 

Thanks for the explanation.

Best regards,
Kuai
