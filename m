Return-Path: <SRS0=NI9l=Y6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1577C5DF62
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 12:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8605C217F4
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 12:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfKFMBF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:01:05 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48964 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729659AbfKFMBE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Nov 2019 07:01:04 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4D3B354F2F99509B1C5B;
        Wed,  6 Nov 2019 20:01:03 +0800 (CST)
Received: from [127.0.0.1] (10.133.210.141) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 6 Nov 2019
 20:00:56 +0800
Subject: Re: [RFC] io_uring: stop only support read/write for ctx with
 IORING_SETUP_IOPOLL
To:     Jens Axboe <axboe@kernel.dk>, Bob Liu <bob.liu@oracle.com>,
        <linux-block@vger.kernel.org>
CC:     <houtao1@huawei.com>, <yi.zhang@huawei.com>
References: <20191104085608.44816-1-yangerkun@huawei.com>
 <a01cc299-69e7-daa2-6894-1c60aaa64e67@oracle.com>
 <3fd0dee1-52d6-4ea8-53d8-2c88b7fedce6@huawei.com>
 <50de6a43-fc11-aada-40e6-f3fee6523d49@kernel.dk>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <aedaf337-ab16-b16e-fe49-d2511fb5f5ea@huawei.com>
Date:   Wed, 6 Nov 2019 20:00:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <50de6a43-fc11-aada-40e6-f3fee6523d49@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.210.141]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019/11/4 22:01, Jens Axboe wrote:
> On 11/4/19 4:46 AM, yangerkun wrote:
>>
>>
>> On 2019/11/4 18:09, Bob Liu wrote:
>>> On 11/4/19 4:56 PM, yangerkun wrote:
>>>> There is no problem to support other type request for the ctx with
>>>> IORING_SETUP_IOPOLL.
>>>
>>> Could you describe the benefit of doing this?
>>
>> Hi,
>>
>> I am trying to replace libaio with io_uring in InnoDB/MariaDB(which
>> build on xfs/nvme). And in order to simulate the timeout mechanism
>> like io_getevents, firstly, to use the poll function of io_uring's fd
>> has been selected and it really did work. But while trying to enable
>> IORING_SETUP_IOPOLL since xfs has iopoll function interface, the
>> mechanism will fail since io_uring_poll does check the cq.head between
>> cached_cq_tail, which will not update until we call io_uring_enter and
>> do the poll. So, instead, I decide to use timeout requests in
>> io_uring but will return -EINVAL since we enable IORING_SETUP_IOPOLL
>> at the same time. I think this combination is a normal scene so as
>> the other combination descibed in this patch. I am not sure does it a
>> good solution for this problem, and maybe there exists some better way.
> 
> I think we can support timeouts pretty easily with SETUP_IOPOLL, but we
> can't mix and match everything. Pretty sure I've written at length about
> that before, but the tldr is that for purely polled commands, we won't
> have an IRQ event. That's the case for nvme if it's misconfigured, but
> for an optimal setup where nvme is loaded with poll queues, there will
> never be an interrupt for the command. This means that we can never wait
> in io_cqring_wait(), we must always call the iopoll poller, because if
> we wait we might very well be waiting for events that will never happen
> unless we actively poll for them.
> 
> This could be supported if we accounted requests, but I don't want to
> add that kind of overhead. Same with the lock+irqdisable you had to add
> for this, it's not acceptable overhead.
> 
> Sounds like you just need timeout support for polling? If so, then that

Hi,

Yeah, the thing I need add is the timeout support for polling.

> is supportable as we know that these events will trigger an async event
> when they happen. Either that, or it triggers when we poll for
> completions. So it's safe to support, and we can definitely do that.

I am a little confuse. What you describe is once enable SETUP_IOPOLL
and there is a async call of io_timeout_fn, we should not call
io_cqring_fill_event directly, but leave io_iopoll_check to do this?
Or, the parallel running for io_iopoll_check may trigger some problem
since they can going to io_cqring_fill_event.

Thanks,
Kun.

> 
> But don't mix polled IO with "normal" IO, it just won't work without
> extra additions that I'm not willing to pay the cost of.
> 
> 

