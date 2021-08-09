Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF7BC4338F
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 07:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B9760F35
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 07:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhHIHIv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 03:08:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7810 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhHIHIv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Aug 2021 03:08:51 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GjnH41nFGzYmZN;
        Mon,  9 Aug 2021 15:08:16 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 15:08:28 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 9 Aug 2021 15:08:27 +0800
Subject: Re: [PATCH v2 2/2] nbd: convert to use blk_mq_get_rq_by_tag()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <bvanassche@acm.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yi.zhang@huawei.com>
References: <20210809030927.1946162-1-yukuai3@huawei.com>
 <20210809030927.1946162-3-yukuai3@huawei.com> <YRDK9tBFscK5ScK8@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <47e5faa8-f8e5-86db-05a1-559e3b3c04b5@huawei.com>
Date:   Mon, 9 Aug 2021 15:08:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YRDK9tBFscK5ScK8@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/09 14:28, Ming Lei wrote:
> On Mon, Aug 09, 2021 at 11:09:27AM +0800, Yu Kuai wrote:
>> blk_mq_tag_to_rq() might return freed request, use
>> blk_mq_get_rq_by_tag() instead.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/block/nbd.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index c38317979f74..9e56975a8eee 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -713,11 +713,10 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
>>   	tag = nbd_handle_to_tag(handle);
>>   	hwq = blk_mq_unique_tag_to_hwq(tag);
>>   	if (hwq < nbd->tag_set.nr_hw_queues)
>> -		req = blk_mq_tag_to_rq(nbd->tag_set.tags[hwq],
>> -				       blk_mq_unique_tag_to_tag(tag));
>> -	if (!req || !blk_mq_request_started(req)) {
>> -		dev_err(disk_to_dev(nbd->disk), "Unexpected reply (%d) %p\n",
>> -			tag, req);
>> +		req = blk_mq_get_rq_by_tag(nbd->tag_set.tags[hwq],
>> +					   blk_mq_unique_tag_to_tag(tag));
>> +	if (!req) {
>> +		dev_err(disk_to_dev(nbd->disk), "Unexpected reply %d\n", tag);
>>   		return ERR_PTR(-ENOENT);
>>   	}
>>   	trace_nbd_header_received(req, handle);
>> @@ -779,6 +778,8 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
>>   	}
>>   out:
>>   	trace_nbd_payload_received(req, handle);
>> +	if (req)
>> +		blk_mq_put_rq_ref(req);
>>   	mutex_unlock(&cmd->lock);
>>   	return ret ? ERR_PTR(ret) : cmd;
> 
> After blk_mq_put_rq_ref() returns, this request may have been freed,
> so the returned 'cmd' may have been freed too.
> 
> As I replied in your another thread, it is driver's responsibility to
> cover race between normal completion and timeout/error handling, that
> means the caller of blk_mq_tag_to_rq need to make sure that the request
> represented by the passed 'tag' can't be freed.

Hi, Ming

There are two problems here in nbd, both reported by our syzkaller.

The first is that blk_mq_tag_to_rq() returned a freed request, which is
because tags->static_rq[] is freed without clearing tags->rq[].
Syzkaller log shows that a reply package is sent to client without
the client's request package. And this patch is trying to solve this
problem.

The second is that flush_end_io() decrement it's refcount to -1. I guess
this is because nbd_clear_que concurrent with normal completion /
timeout / error handling, and somehow trigger the problem.
However I'm still trying to understand the logic in nbd. I tried to
add a check in flush_end_io() to fix this, as you replied, it's
driver's responsibility to fix the problem.

It seems that the two problems are not related. And this patch is ok
to fix the first problem. Any suggestions?

Thanks
Kuai
> 
> I'd suggest to understand why nbd_read_stat()/blk_mq_tag_to_rq() may return
> one freed request first, who frees the request and how when calling
> blk_mq_tag_to_rq() before figuring out solutions.
