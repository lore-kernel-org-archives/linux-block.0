Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D89C433E1
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 12:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E03C208E4
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 12:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbgHZM6d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:58:33 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730021AbgHZM6b (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 08:58:31 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id BB42D3C2BFC21C77F543;
        Wed, 26 Aug 2020 13:58:29 +0100 (IST)
Received: from [127.0.0.1] (10.47.10.200) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 26 Aug
 2020 13:58:29 +0100
Subject: Re: [PATCH 0/5] blk-mq: fix use-after-free on stale request
To:     Ming Lei <ming.lei@redhat.com>
CC:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@lst.de>
References: <20200820180335.3109216-1-ming.lei@redhat.com>
 <accb98d8-8186-2e74-a5c3-e0f09ce2b3ff@acm.org>
 <20200821024949.GA3110165@T590>
 <e42f1c04-eb34-63aa-c9c8-57c58d4b28b0@huawei.com>
 <20200826122407.GA126130@T590> <20200826123453.GA126923@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <10331543-9e45-ae63-8cdb-17e5a2a3b7ef@huawei.com>
Date:   Wed, 26 Aug 2020 13:56:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200826123453.GA126923@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.10.200]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26/08/2020 13:34, Ming Lei wrote:
>>>> Meantime the reference in tags->rqs[] may stay a bit long, and RCU can't cover this
>>>> case.
>>>>
>>>> Also we can't reset the related tags->rqs[tag] simply somewhere, cause it may
>>>> race with new driver tag allocation.
>>> How about iterate all tags->rqs[] for all scheduler tags when exiting the
>>> scheduler, etc, and clear any scheduler requests references, like this:
>>>
>>> cmpxchg(&hctx->tags->rqs[tag], scheduler_rq, 0);
>>>
>>> So we NULLify any tags->rqs[] entries which contain a scheduler request of
>>> concern atomically, cleaning up any references.
>> Looks this approach can work given cmpxchg() will prevent new store on
>> this address.
> Another process may still be reading this to-be-freed request via
> blk_mq_queue_tag_busy_iter or blk_mq_tagset_busy_iter(), meantime NULLify is done
> and all requests of this scheduler are freed.
> 

That seems like another deeper problem. If there is no mechanism to 
guard against this, maybe some reference, sema, etc. needs to be taken 
at the beginning of the iterators to temporarily block anything which 
would mean that the requests are freed.

Thanks,
John
