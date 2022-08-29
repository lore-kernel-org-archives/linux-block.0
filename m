Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FFCECAAD4
	for <linux-block@archiver.kernel.org>; Mon, 29 Aug 2022 04:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiH2ELq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Aug 2022 00:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiH2ELo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Aug 2022 00:11:44 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544382A426
        for <linux-block@vger.kernel.org>; Sun, 28 Aug 2022 21:11:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=gumi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VNW3yKc_1661746300;
Received: from LR9115VM81021(mailfrom:gumi@linux.alibaba.com fp:SMTPD_---0VNW3yKc_1661746300)
          by smtp.aliyun-inc.com;
          Mon, 29 Aug 2022 12:11:41 +0800
From:   <gumi@linux.alibaba.com>
To:     "'Jens Axboe'" <axboe@kernel.dk>,
        "'Bart Van Assche'" <bvanassche@acm.org>,
        <damien.lemoal@opensource.wdc.com>
Cc:     <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] block: I/O error occurs during SATA disk stress test
Date:   Mon, 29 Aug 2022 12:11:39 +0800
Message-ID: <000701d8bb5d$710b2ca0$532185e0$@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adi7XOZQ17Wt8TBJQ0yCPnWdHtCjJA==
Content-Language: zh-cn
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 8/25/22 9:25 PM, gumi@linux.alibaba.com wrote:
> On 8/25/22 00:09, Gu Mi wrote:
>> The problem occurs in two async processes, One is when a new IO calls 
>> the blk_mq_start_request() interface to start sending,The other is 
>> that the block layer timer process calls the blk_mq_req_expired 
>> interface to check whether there is an IO timeout.
>>
>> When an instruction out of sequence occurs between blk_add_timer and
>> WRITE_ONCE(rq->state,MQ_RQ_IN_FLIGHT) in the interface 
>> blk_mq_start_request,at this time, the block timer is checking the 
>> new IO timeout, Since the req status has been set to MQ_RQ_IN_FLIGHT 
>> and
>> req->deadline is 0 at this time, the new IO will be misjudged as a
>> timeout.
>>
>> Our repair plan is for the deadline to be 0, and we do not think that 
>> a timeout occurs. At the same time, because the jiffies of the 32-bit 
>> system will be reversed shortly after the system is turned on, we 
>> will add 1 jiffies to the deadline at this time.
>>
>> Signed-off-by: Gu Mi <gumi@linux.alibaba.com>
>> ---
>> v1->v2:
>>
>> time_after_eq() can handle the overflow, so remove the change on 
>> 32-bit in blk_add_timer().
>>
>>   block/blk-mq.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c index 4b90d2d..6defaa1
>> 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1451,6 +1451,8 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
>>   		return false;
>>   
>>   	deadline = READ_ONCE(rq->deadline);
>> +	if (unlikely(deadline == 0))
>> +		return false;
>>   	if (time_after_eq(jiffies, deadline))
>>   		return true;
>>   
> 
> rq->deadline == 0 can be a valid deadline value so the above patch
> doesn't look right to me.

Gu, you need to fix your quoting of emails, these are impossible to read.

That aside, I think there's a misunderstanding here. v1 has some parts and v2 has others. Please post a v3 that has the hunk that guarantees that deadline always has the lowest bit set if assigned, and the !deadline check as well.

--
Jens Axboe


---
Hi Jens

Thanks for your reminder, I I will post a v3 patch later, my v3 patch and V1 patch are the same, please review again

Thanks,

Gu Mi



