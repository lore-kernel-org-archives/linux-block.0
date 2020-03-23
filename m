Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39D2C4332B
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 14:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A880220780
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 14:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgCWOJM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 10:09:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49328 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728378AbgCWOJL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 10:09:11 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F15DA89CAE8D36E7464F;
        Mon, 23 Mar 2020 22:08:56 +0800 (CST)
Received: from [10.173.220.74] (10.173.220.74) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 23 Mar 2020 22:08:51 +0800
Subject: Re: [PATCH] nbd: make starting request more reasonable
To:     Ming Lei <ming.lei@redhat.com>
CC:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200303130843.12065-1-yuyufen@huawei.com>
 <9cdba8b1-f0e5-a079-8d44-0078478dd4d8@huawei.com>
 <20200316153033.GA11016@ming.t460p>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <b990c260-ddf6-efa9-0856-9110aa4dd8a4@huawei.com>
Date:   Mon, 23 Mar 2020 22:08:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200316153033.GA11016@ming.t460p>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.74]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Ming

On 2020/3/16 23:30, Ming Lei wrote:
> On Mon, Mar 16, 2020 at 08:26:35PM +0800, Yufen Yu wrote:
>> Ping and Cc to more expert in blk-mq.
>>
>> On 2020/3/3 21:08, Yufen Yu wrote:
>>> Our test robot reported a warning for refcount_dec trying to decrease
>>> value '0'. The reason is that blk_mq_dispatch_rq_list() try to complete
>>> the failed request from nbd driver, while the request have finished in
>>> nbd timeout handle function. The race as following:
>>>
>>> CPU1                             CPU2
>>>
>>> //req->ref = 1
>>> blk_mq_dispatch_rq_list
>>> nbd_queue_rq
>>>     nbd_handle_cmd
>>>       blk_mq_start_request
>>>                                    blk_mq_check_expired
>>>                                      //req->ref = 2
>>>                                      blk_mq_rq_timed_out
>>>                                        nbd_xmit_timeout
> 
> This shouldn't happen in reality, given rq->deadline is just updated
> in blk_mq_start_request(), suppose you use the default 30 sec timeout.
> How can the race be triggered in so short time? >
> Could you explain a bit your test case?
>
In fact, this is reported by syzkaller. We have not actually test case.
But, I think nbd driver should not start request in case of failure. So fix it.

Thanks,
Yufen
