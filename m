Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F811C433DB
	for <linux-block@archiver.kernel.org>; Sat, 16 Jan 2021 09:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E7023AFD
	for <linux-block@archiver.kernel.org>; Sat, 16 Jan 2021 09:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbhAPJAh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Jan 2021 04:00:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11100 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbhAPJAg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Jan 2021 04:00:36 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DHsRG2ZSyz15dSk;
        Sat, 16 Jan 2021 16:58:50 +0800 (CST)
Received: from [10.174.177.185] (10.174.177.185) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 16 Jan 2021 16:59:47 +0800
Subject: Re: question about relative control for sync io using bfq
From:   "yukuai (C)" <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, <hch@lst.de>,
        <linux-block@vger.kernel.org>, chenzhou <chenzhou10@huawei.com>,
        "houtao (A)" <houtao1@huawei.com>
References: <b4163392-0462-ff6f-b958-1f96f33d69e6@huawei.com>
Message-ID: <d2ea385c-1b19-002e-665a-6bfd23ff1c6e@huawei.com>
Date:   Sat, 16 Jan 2021 16:59:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b4163392-0462-ff6f-b958-1f96f33d69e6@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.185]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping...

On 2021/01/11 21:15, yukuai (C) wrote:
> Hi,
> 
> We found a performance problem:
> 
> kernel version: 5.10
> disk: ssd
> scheduler: bfq
> arch: arm64 / x86_64
> test param: direct=1, ioengine=psync, bs=4k, rw=randread, numjobs=32
> 
> We are using 32 threads here, test results showed that iops is equal
> to single thread.
> 
> After digging into the problem, I found root cause of the problem is 
> strange:
> 
> bfq_add_request
>   bfq_bfqq_handle_idle_busy_switch
>    bfq_add_bfqq_busy
>     bfq_activate_bfq
>      bfq_activate_requeue_entity
>       __bfq_activate_requeue_entity
>        __bfq_activate_entity
>         if (!bfq_entity_to_bfqq(entity))
>          if (!entity->in_groups_with_pending_reqs)
>           entity->in_groups_with_pending_reqs = true;
>           bfqd->num_groups_with_pending_reqs++
> 
> If test process is not in root cgroup, num_groups_with_pending_reqs will
> be increased after request was instered to bfq.
> 
> bfq_select_queue
>   bfq_better_to_idle
>    idling_needed_for_service_guarantees
>     bfq_asymmetric_scenario
>      return varied_queue_weights || multiple_classes_busy || 
> bfqd->num_groups_with_pending_reqs > 0
> 
> After issuing IO to driver, num_groups_with_pending_reqs is ensured to
> be nonzero, thus bfq won't expire the queue. This is the root cause of
> degradating to single-process performance.
> 
> One the other hand, if I set slice_idle to zero, bfq_better_to_idle will
> return false early, and the problem will disapear. However, relative
> control will be inactive.
> 
> My question is that, is this a known flaw for bfq? If not, as cfq don't
> have such problem, is there a suitable solution?
> 
> Thanks!
> Yu Kuai
> such problem,
