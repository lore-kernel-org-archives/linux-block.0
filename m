Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B91C433DB
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 01:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D55223C8
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 01:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725275AbhAVBrJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 20:47:09 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2984 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbhAVBrG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 20:47:06 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DMMXB4Q27zR666;
        Fri, 22 Jan 2021 09:45:14 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 22 Jan 2021 09:46:16 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Fri, 22
 Jan 2021 09:46:15 +0800
Subject: Re: [PATCH v3 1/5] blk-mq: introduce blk_mq_set_request_complete
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
        <axboe@fb.com>, <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>
References: <20210121070330.19701-1-lengchao@huawei.com>
 <20210121070330.19701-2-lengchao@huawei.com> <20210121084059.GA25963@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <e053944e-e8de-187e-78f2-21974fb97dbf@huawei.com>
Date:   Fri, 22 Jan 2021 09:46:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210121084059.GA25963@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/1/21 16:40, Christoph Hellwig wrote:
> On Thu, Jan 21, 2021 at 03:03:26PM +0800, Chao Leng wrote:
>> nvme drivers need to set the state of request to MQ_RQ_COMPLETE when
>> directly complete request in queue_rq.
>> So add blk_mq_set_request_complete.
> 
> So I'm not happy with this helper.  It should at least:
> 
>   a) be named and documented to only apply for the ->queue_rq faіlure case
Although blk_mq_complete_request_remote can set the markup directly,
blk_mq_complete_request_remote can also use this helper. This helper do
not need special processing for ->queue_rq failure.
>   b) check that the request is in MQ_RQ_IDLE state
No, the request may also be in MQ_RQ_IN_FLIGHT state. Do not need to
care whether the original state is MQ_RQ_IDLE or MQ_RQ_IN_FLIGHT.
> .
> 
