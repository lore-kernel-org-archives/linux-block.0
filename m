Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3995CC433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 08:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC0164FE2
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 08:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhCJIyl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 03:54:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2674 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCJIye (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 03:54:34 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DwQhy5LHPz67xN2;
        Wed, 10 Mar 2021 16:48:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 10 Mar 2021 09:54:32 +0100
Received: from [10.47.10.208] (10.47.10.208) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Wed, 10 Mar
 2021 08:54:31 +0000
Subject: Re: [RFC PATCH v3 3/3] blk-mq: Lockout tagset iterator when exiting
 elevator
To:     Bart Van Assche <bvanassche@acm.org>, <hare@suse.de>,
        <ming.lei@redhat.com>, <axboe@kernel.dk>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pragalla@codeaurora.org>, <kashyap.desai@broadcom.com>,
        <yuyufen@huawei.com>
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-4-git-send-email-john.garry@huawei.com>
 <48a3cf78-3f6d-c13c-bca2-1f8277817b45@acm.org>
 <9c9360bf-7ca9-5c8f-c61d-441044f9c78f@huawei.com>
 <784a3686-cb54-561d-740c-30e0b3f46df8@acm.org>
 <f60dc68f-9206-2bfb-950e-cb312f1c4c8b@huawei.com>
 <de3dec73-c8fc-d14f-5bbb-7023ccc6b57e@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b4e39d48-3524-ac34-c20e-0dadcf15e3d6@huawei.com>
Date:   Wed, 10 Mar 2021 08:52:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <de3dec73-c8fc-d14f-5bbb-7023ccc6b57e@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.10.208]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09/03/2021 19:21, Bart Van Assche wrote:
> On 3/9/21 9:47 AM, John Garry wrote:
>> This does fall over if some tags are allocated without associated
>> request queue, which I do not know exists.
> 

Hi Bart,

> The only tag allocation mechanism I know of is blk_mq_get_tag(). The
> only blk_mq_get_tag() callers I know of are __blk_mq_alloc_request() and
> blk_mq_alloc_request_hctx(). So I think all allocated tags are
> associated with a request queue.
> 

ok, good.

> Regarding this patch series, I have shared the feedback I wanted to
> share so I would appreciate it if someone else could also take a look.
> 

So I can incorporate any changes and suggestions so far and send a 
non-RFC version - that may get more attention if none extra comes.

As mentioned on the cover letter, if patch 2+3/3 are accepted, then 
patch 1/3 could be simplified. But I plan to leave as is.

BTW, any issue with putting your suggested-by on patch 2/3?

Thanks,
John

