Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D58C433E1
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 01:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D16120855
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 01:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgHUBgF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Aug 2020 21:36:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56900 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725859AbgHUBgF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 21:36:05 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 397FD12346B85F17258D;
        Fri, 21 Aug 2020 09:36:03 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 21 Aug 2020
 09:36:02 +0800
Subject: Re: [PATCH 1/3] nvme-core: improve avoiding false remove namespace
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <kbusch@kernel.org>, <axboe@fb.com>
References: <20200820035357.1634-1-lengchao@huawei.com>
 <ead8ccd0-d89d-b47e-0a6f-22c976a3b3a6@grimberg.me>
 <20200820082918.GA12926@lst.de>
 <0630bc93-539d-df78-c1e8-ec136cb7dd36@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <e84fed3d-1cb6-a548-9917-7d7dd884d0f9@huawei.com>
Date:   Fri, 21 Aug 2020 09:36:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0630bc93-539d-df78-c1e8-ec136cb7dd36@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/8/20 23:44, Sagi Grimberg wrote:
> 
>>> We really need to take a step back here, I really don't like how
>>> we are growing implicit assumptions on how statuses are interpreted.
>>>
>>> Why don't we remove the -ENODEV error propagation back and instead
>>> take care of it in the specific call-sites where we want to ignore
>>> errors with proper quirks?
>>
>> So the one thing I'm not even sure about is if just ignoring the
>> errors was a good idea to start with.  They obviously are if we just
>> did a rescan and did run into an error while rescanning a namespace
>> that didn't change.  But what if it actually did change?
> 
> Right, we don't know, so if we failed without DNR, we assume that
> we will retry again and ignore the error. The assumption is that
> we will retry when we will reconnect as we don't have a retry mechanism
> for these requests.
Except DNR or ENODEV, we can not know namespace change or not. This is
a low-probability event. In accordance with the principle of minor
influence and no suspicion, we assume namespace not change, maybe
a good choice. If the namespace is changed, the corresponding processing
is performed during the access, which does not cause any problem.
> 
>> So I think a logic like in this patch kinda makes sense, but I think
>> we also need to retry and scan again on these kinds of errors.
> 
> So you are OK with keeping nvme_submit_sync_cmd returning -ENODEV for
> cancelled requests and have the scan flow assume that these are
> cancelled requests?
> 
> At the very least we need a good comment to say what is going on there.
> 
>    Btw,
>> did you ever actually see -ENOMEM in practice?  With the small
>> allocations that we do it really should not happen normally, so
>> special casing for it always felt a little strange.
Agree.
Not only ENOMEM, If we do not know namespace change or not, assume
namespace not change maybe a good choice.
> 
> Never seen it, it's there just because we have allocations in the path.
> 
>> FYI, I've started rebasing various bits of work I've done to start
>> untangling the mess.  Here is my current WIP, which in this form
>> is completely untested:
>>
>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/nvme-scanning-cleanup
> 
> This does not yet contain sorting out what is discussed here correct?
> .
