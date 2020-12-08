Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4EBC4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 11:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E385F23A31
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 11:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgLHLiQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 06:38:16 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2221 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbgLHLiQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 06:38:16 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cqykd5SJwz67NFV;
        Tue,  8 Dec 2020 19:34:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 8 Dec 2020 12:37:33 +0100
Received: from [10.210.169.98] (10.210.169.98) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 11:37:32 +0000
Subject: Re: [RFC PATCH] blk-mq: Clean up references when freeing rqs
From:   John Garry <john.garry@huawei.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hch@lst.de>, <hare@suse.de>,
        <ppvk@codeaurora.org>, <bvanassche@acm.org>,
        <kashyap.desai@broadcom.com>
References: <1606827738-238646-1-git-send-email-john.garry@huawei.com>
 <20201202033134.GD494805@T590>
 <aaf77015-3039-6b04-3417-d376e3467444@huawei.com>
 <20201203005505.GB540033@T590>
 <fa222311-2184-0041-61ab-b3d70fb92585@huawei.com>
Message-ID: <7beb86a2-5c4b-bdc0-9fce-1b583548c6d0@huawei.com>
Date:   Tue, 8 Dec 2020 11:36:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <fa222311-2184-0041-61ab-b3d70fb92585@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.98]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/12/2020 09:26, John Garry wrote:
> On 03/12/2020 00:55, Ming Lei wrote:
> 
> Hi Ming,
> 
>>> Yeah, so I said that was another problem which you mentioned there, 
>>> which
>>> I'm not addressing, but I don't think that I'm making thing worse here.
>> The thing is that this patch does not fix the issue completely.
>>
>>> So AFAICS, the blk-mq/sched code doesn't wait for any "readers" to be
>>> finished, such as those running blk_mq_queue_tag_busy_iter or
>>> blk_mq_tagset_busy_iter() in another context.
>>>
>>> So how about the idea of introducing some synchronization primitive, 
>>> such as
>>> semaphore, which those "readers" must grab and release at start and 
>>> end (of
>>> iter), to ensure the requests are not freed during the iteration?
>> It looks good, however devil is in details, please make into patch for
>> review.
> 
> OK, but another thing to say is that I need to find a somewhat reliable 
> reproducer for the potential problem you mention. So far this patch 
> solves the issue I see (in that kasan stops warning). Let me analyze 
> this a bit further.
> 

Hi Ming,

I am just looking at this again, and have some doubt on your concern [0].

 From checking blk_mq_queue_tag_busy_iter() specifically, don't we 
actually guard against this with the q->q_usage_counter mechanism? That 
is, an agent needs to grab a q counter ref when attempting the iter. 
This will fail when the queue IO sched is being changed, as we freeze 
the queue during this time, which is when the requests are freed, so no 
agent can hold a reference to a freed request then. And same goes for 
blk_mq_update_nr_requests(), where we freeze the queue.

But I didn't see such a guard for blk_mq_tagset_busy_iter().

Thanks,
John

[0] https://lore.kernel.org/linux-block/20200826123453.GA126923@T590/

Ps. sorry for sending twice
