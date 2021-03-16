Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C346AC433E6
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 17:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 991CC6511D
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 17:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbhCPRqR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 13:46:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2705 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239017AbhCPRpt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 13:45:49 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F0LBt3QFQz67yt6;
        Wed, 17 Mar 2021 01:39:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Mar 2021 18:45:46 +0100
Received: from [10.210.172.72] (10.210.172.72) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Mar 2021 17:45:45 +0000
Subject: Re: [RFC PATCH v3 2/3] blk-mq: Freeze and quiesce all queues for
 tagset in elevator_exit()
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
CC:     "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pragalla@codeaurora.org" <pragalla@codeaurora.org>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>,
        yuyufen <yuyufen@huawei.com>
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-3-git-send-email-john.garry@huawei.com>
 <YElrSFGyim3rjDN+@T590> <8c6c6783-6152-2332-2f50-14c409e40320@huawei.com>
 <2b0c66ba-03b3-844c-1684-f8e80d11cdbb@acm.org>
 <4ffaba53-100a-43a5-8746-b753d4153be5@huawei.com>
 <fff92b15-d483-ad6a-bb01-ef61117b7cbd@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <82526e78-66e5-fc3c-7acd-38f1813ebe1e@huawei.com>
Date:   Tue, 16 Mar 2021 17:43:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <fff92b15-d483-ad6a-bb01-ef61117b7cbd@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.172.72]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 16/03/2021 17:00, Bart Van Assche wrote:
> On 3/16/21 9:15 AM, John Garry wrote:
>> I'll have a look at this ASAP -  a bit busy.
>>
>> But a quick scan and I notice this:
>>
>>  > @@ -226,6 +226,7 @@ static inline void 
>> __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
>>  >                          struct request *rq)
>>  >   {
>>  >       blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
>>  > +    rcu_assign_pointer(hctx->tags->rqs[rq->tag], NULL);
>>
>> Wasn't a requirement to not touch the fastpath at all, including even 
>> if only NULLifying a pointer?
>>
>> IIRC, Kashyap some time ago had a patch like above (but without RCU 
>> usage), but the request from Jens was to not touch the fastpath.
>>
>> Maybe I'm mistaken - I will try to dig up the thread.
> 

Hi Bart,

> 
> I agree that Jens asked at the end of 2018 not to touch the fast path to 
> fix this use-after-free (maybe that request has been repeated more 
> recently). If Jens or anyone else feels strongly about not clearing 
> hctx->tags->rqs[rq->tag] from the fast path then I will make that 
> change. 

Is that possible for this same approach? I need to check the code more..

And don't we still have the problem that some iter callbacks may 
sleep/block, which is not allowed in an RCU read-side critical section?

> My motivation for clearing these pointers from the fast path is 
> as follows:
> - This results in code that is easier to read and easier to maintain.
> - Every modern CPU pipelines store instructions so the performance 
> impact of adding an additional store should be small.
> - Since the block layer has a tendency to reuse tags that have been 
> freed recently, it is likely that hctx->tags->rqs[rq->tag] will be used 
> for a next request and hence that it will have to be loaded into the CPU 
> cache anyway.
> 

Those points make sense to me, but obviously it's the maintainers call.

Thanks,
john

