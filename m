Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E5BC433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 01:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C87720771
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 01:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgGABYm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:24:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7320 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725937AbgGABYm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 21:24:42 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8EE556A0211A0AE2C43A;
        Wed,  1 Jul 2020 09:24:36 +0800 (CST)
Received: from [10.133.219.224] (10.133.219.224) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 1 Jul 2020 09:24:33 +0800
Subject: Re: [PATCH 1/1] blk-mq: remove the pointless call of list_entry_rq()
 in hctx_show_busy_rq()
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20200427131250.13725-1-houtao1@huawei.com>
 <244626f4-3469-1127-377c-d54c589d829b@acm.org>
 <51b569f8-57a0-58bb-4f41-ab1f10363918@huawei.com>
Message-ID: <80f57663-c5b3-015a-d0f8-7c354f424a6a@huawei.com>
Date:   Wed, 1 Jul 2020 09:24:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <51b569f8-57a0-58bb-4f41-ab1f10363918@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.224]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping ?

On 2020/5/25 14:32, Hou Tao wrote:
> ping ?
> 
> On 2020/4/28 1:27, Bart Van Assche wrote:
>> On 2020-04-27 06:12, Hou Tao wrote:
>>> And use rq directly.
>>>
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>> ---
>>>  block/blk-mq-debugfs.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>>> index b3f2ba483992..7a79db81a63f 100644
>>> --- a/block/blk-mq-debugfs.c
>>> +++ b/block/blk-mq-debugfs.c
>>> @@ -400,8 +400,7 @@ static bool hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
>>>  	const struct show_busy_params *params = data;
>>>  
>>>  	if (rq->mq_hctx == params->hctx)
>>> -		__blk_mq_debugfs_rq_show(params->m,
>>> -					 list_entry_rq(&rq->queuelist));
>>> +		__blk_mq_debugfs_rq_show(params->m, rq);
>>>  
>>>  	return true;
>>>  }
>>
>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>>
>>
> 
> 
> 
