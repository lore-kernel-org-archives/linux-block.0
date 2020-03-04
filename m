Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA4BC3F2C6
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 02:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D5D2073B
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 02:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgCDCKJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:10:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44102 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727854AbgCDCKJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Mar 2020 21:10:09 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1DC294C4CB9512ADFBC6;
        Wed,  4 Mar 2020 10:10:07 +0800 (CST)
Received: from [10.173.220.74] (10.173.220.74) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Mar 2020 10:10:05 +0800
Subject: Re: [PATCH] nbd: make starting request more reasonable
To:     Josef Bacik <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>
References: <20200303130843.12065-1-yuyufen@huawei.com>
 <2976065c-ae72-08d4-32ca-89b0f24ded74@toxicpanda.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <5ef229b8-bd78-b635-a01f-0e6e06bdbf4e@huawei.com>
Date:   Wed, 4 Mar 2020 10:10:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <2976065c-ae72-08d4-32ca-89b0f24ded74@toxicpanda.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.74]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Josef

On 2020/3/4 5:18, Josef Bacik wrote:
> On 3/3/20 8:08 AM, Yufen Yu wrote:
>> Our test robot reported a warning for refcount_dec trying to decrease
>> value '0'. The reason is that blk_mq_dispatch_rq_list() try to complete
>> the failed request from nbd driver, while the request have finished in
>> nbd timeout handle function. The race as following:
>>
>> CPU1                             CPU2
>>
>> //req->ref = 1
>> blk_mq_dispatch_rq_list
>> nbd_queue_rq
>>    nbd_handle_cmd
>>      blk_mq_start_request
>>                                   blk_mq_check_expired
>>                                     //req->ref = 2
>>                                     blk_mq_rq_timed_out
>>                                       nbd_xmit_timeout
>>                                         blk_mq_complete_request
>>                                           //req->ref = 1
>>                                           refcount_dec_and_test(&req->ref)
>>
>>                                     refcount_dec_and_test(&req->ref)
>>                                     //req->ref = 0
>>                                       __blk_mq_free_request(req)
>>    ret = BLK_STS_IOERR
>> blk_mq_end_request
>> // req->ref = 0, req have been free
>> refcount_dec_and_test(&rq->ref)
>>
>> In fact, the bug also have been reported by syzbot:
>>    https://lkml.org/lkml/2018/12/5/1308
>>
>> Since the request have been freed by timeout handle, it can be reused
>> by others. Then, blk_mq_end_request() may get the re-initialized request
>> and free it, which is unexpected.
>>
>> To fix the problem, we move blk_mq_start_request() down until the driver
>> will handle the request actully. If .queue_rq return something error in
>> preparation phase, timeout handle may don't need. Thus, moving start
>> request down may be more reasonable. Then, nbd_queue_rq() will not return
>> BLK_STS_IOERR after starting request.
>>
> 
> This won't work, you have to have the request started if you return an error because of this in blk_mq_dispatch_rq_list >
>                  if (unlikely(ret != BLK_STS_OK)) {
>                          errors++;
>                          blk_mq_end_request(rq, BLK_STS_IOERR);
>                          continue;
>                  }
> 
> The request has to be started before we return an error, pushing it down means we have all of these error cases where we haven't started the reques
IMO, the reason that we need to start request after issuing is for timeout
handle function could trace the request. Here, we should make sure the request
started before the driver process (e.g sock_xmit()). Right?

Before that, if something errors occur in nbd_handle_cmd(), like -EIO, -EINVAL,
that means the request have not actually been handled. So, we also don't need
timeout handler trace it. And the dispatcher function blk_mq_dispatch_rq_list()
or blk_mq_try_issue_directly() is responsible for ending the request.

BTW, other drivers, such as nvme_queue_rq(), scsi_queue_rq(), also start request
before processing it actually. If I get it wrong, please point it out.

Thanks,
Yufen


