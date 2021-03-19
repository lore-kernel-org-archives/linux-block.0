Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFF6C433C1
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 18:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A84C61961
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 18:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhCSSWT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 14:22:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2720 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhCSSVw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 14:21:52 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F2Btx0ht5z680lw;
        Sat, 20 Mar 2021 02:17:13 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 19:21:50 +0100
Received: from [10.47.10.104] (10.47.10.104) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 19 Mar
 2021 18:21:49 +0000
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
 <82526e78-66e5-fc3c-7acd-38f1813ebe1e@huawei.com>
 <e0906b2e-6a2b-ce34-84a1-36eaddbb824d@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <85fd2c95-2258-9b51-02f8-01895c06f814@huawei.com>
Date:   Fri, 19 Mar 2021 18:19:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <e0906b2e-6a2b-ce34-84a1-36eaddbb824d@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.10.104]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 16/03/2021 19:59, Bart Van Assche wrote:
> On 3/16/21 10:43 AM, John Garry wrote:
>> On 16/03/2021 17:00, Bart Van Assche wrote:
>>> I agree that Jens asked at the end of 2018 not to touch the fast path
>>> to fix this use-after-free (maybe that request has been repeated more
>>> recently). If Jens or anyone else feels strongly about not clearing
>>> hctx->tags->rqs[rq->tag] from the fast path then I will make that change.

Hi Bart,

>> Is that possible for this same approach? I need to check the code more..
> If the fast path should not be modified, I'm considering to borrow patch
> 1/3 from your patch series

Fine

> and to add an rcu_barrier() between the code
> that clears the request pointers and that frees the scheduler requests.
> 
>> And don't we still have the problem that some iter callbacks may
>> sleep/block, which is not allowed in an RCU read-side critical section?
> Thanks for having brought this up. Since none of the functions that
> iterate over requests should be called from the hot path of a block
> driver, I think that we can use srcu_read_(un|)lock() inside bt_iter()
> and bt_tags_iter() instead of rcu_read_(un|)lock().

OK, but TBH, I am not so familiar with srcu - where you going to try this?

Thanks,
John
