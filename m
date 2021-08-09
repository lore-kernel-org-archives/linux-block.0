Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F302C4338F
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 14:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E50F460F35
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 14:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhHIOE5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 10:04:57 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13406 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhHIOE5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Aug 2021 10:04:57 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GjyRC3s7NzclyL;
        Mon,  9 Aug 2021 22:00:55 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 22:04:33 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 9 Aug 2021 22:04:32 +0800
Subject: Re: [PATCH v2 2/2] nbd: convert to use blk_mq_get_rq_by_tag()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <bvanassche@acm.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yi.zhang@huawei.com>
References: <20210809030927.1946162-1-yukuai3@huawei.com>
 <20210809030927.1946162-3-yukuai3@huawei.com> <YRDK9tBFscK5ScK8@T590>
 <47e5faa8-f8e5-86db-05a1-559e3b3c04b5@huawei.com> <YRD5krmF/C7JxchE@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <3adf6183-bf40-10cd-b8ed-552120028ca3@huawei.com>
Date:   Mon, 9 Aug 2021 22:04:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YRD5krmF/C7JxchE@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/09 17:46, Ming Lei wrote:
> On Mon, Aug 09, 2021 at 03:08:26PM +0800, yukuai (C) wrote:
>> On 2021/08/09 14:28, Ming Lei wrote:
>>> On Mon, Aug 09, 2021 at 11:09:27AM +0800, Yu Kuai wrote:
>>>> blk_mq_tag_to_rq() might return freed request, use
>>>> blk_mq_get_rq_by_tag() instead.
>>>>
>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>> ---
>>>>    drivers/block/nbd.c | 11 ++++++-----
>>>>    1 file changed, 6 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>>>> index c38317979f74..9e56975a8eee 100644
>>>> --- a/drivers/block/nbd.c
>>>> +++ b/drivers/block/nbd.c
>>>> @@ -713,11 +713,10 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
>>>>    	tag = nbd_handle_to_tag(handle);
>>>>    	hwq = blk_mq_unique_tag_to_hwq(tag);
>>>>    	if (hwq < nbd->tag_set.nr_hw_queues)
>>>> -		req = blk_mq_tag_to_rq(nbd->tag_set.tags[hwq],
>>>> -				       blk_mq_unique_tag_to_tag(tag));
>>>> -	if (!req || !blk_mq_request_started(req)) {
>>>> -		dev_err(disk_to_dev(nbd->disk), "Unexpected reply (%d) %p\n",
>>>> -			tag, req);
>>>> +		req = blk_mq_get_rq_by_tag(nbd->tag_set.tags[hwq],
>>>> +					   blk_mq_unique_tag_to_tag(tag));
>>>> +	if (!req) {
>>>> +		dev_err(disk_to_dev(nbd->disk), "Unexpected reply %d\n", tag);
>>>>    		return ERR_PTR(-ENOENT);
>>>>    	}
>>>>    	trace_nbd_header_received(req, handle);
>>>> @@ -779,6 +778,8 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
>>>>    	}
>>>>    out:
>>>>    	trace_nbd_payload_received(req, handle);
>>>> +	if (req)
>>>> +		blk_mq_put_rq_ref(req);
>>>>    	mutex_unlock(&cmd->lock);
>>>>    	return ret ? ERR_PTR(ret) : cmd;
>>>
>>> After blk_mq_put_rq_ref() returns, this request may have been freed,
>>> so the returned 'cmd' may have been freed too.
>>>
>>> As I replied in your another thread, it is driver's responsibility to
>>> cover race between normal completion and timeout/error handling, that
>>> means the caller of blk_mq_tag_to_rq need to make sure that the request
>>> represented by the passed 'tag' can't be freed.
>>
>> Hi, Ming
>>
>> There are two problems here in nbd, both reported by our syzkaller.
>>
>> The first is that blk_mq_tag_to_rq() returned a freed request, which is
>> because tags->static_rq[] is freed without clearing tags->rq[].
>> Syzkaller log shows that a reply package is sent to client without
>> the client's request package. And this patch is trying to solve this
>> problem.
> 
> It is still driver's problem:
> 
> ->static_rq is freed in blk_mq_free_tag_set() which is called after
> blk_cleanup_disk() returns. Once blk_cleanup_disk() returns, there
> shouldn't be any driver activity, including calling blk_mq_tag_to_rq()
> by passing one invalid tag.
> 

Hi, Ming

I understand if static_rq is freed through blk_mq_free_tag_set(),
drivers should not use static_rq anymore.

By the way, I was thinking about another path:

blk_mq_update_nr_requests
  if (!hctx->sched_tags) -> if this is true
   ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr, false)
    blk_mq_free_rqs -> static_rq is freed here

If this path concurrent with nbd_read_stat(), nbd_read_stat() can
get a freed request by blk_mq_tag_to_rq(), since tags->lock is not
held.

t1: nbd_read_stat	  t2: blk_mq_update_nr_requests
rq = blk_mq_tag_to_rq()
			  blk_mq_free_rqs

By holding tags->lock, we can check that rq state is idle, and it's
ref is 0.

Thanks
Kuai
