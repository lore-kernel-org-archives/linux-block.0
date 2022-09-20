Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F344C54EE9
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 03:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiITDFY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Sep 2022 23:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiITDEu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2022 23:04:50 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88E6D87;
        Mon, 19 Sep 2022 20:04:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQH2xuw_1663643071;
Received: from 30.97.56.91(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQH2xuw_1663643071)
          by smtp.aliyun-inc.com;
          Tue, 20 Sep 2022 11:04:32 +0800
Message-ID: <5383bd34-4f61-f3b0-0a75-a8a2eb75d7ef@linux.alibaba.com>
Date:   Tue, 20 Sep 2022 11:04:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V3 4/7] ublk_drv: requeue rqs with recovery feature
 enabled
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
 <20220913041707.197334-5-ZiyangZhang@linux.alibaba.com>
 <YyfoQuw18kOynxcC@T590>
 <ff61718d-da2d-f754-5e56-b58a3e57820f@linux.alibaba.com>
 <Yyhi/kavaq1aLAQY@T590>
 <84b99294-6859-f49f-d529-c6e3899f2aa2@linux.alibaba.com>
 <Yykn7q/T9CUzZpxH@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <Yykn7q/T9CUzZpxH@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/9/20 10:39, Ming Lei wrote:
> On Tue, Sep 20, 2022 at 09:31:54AM +0800, Ziyang Zhang wrote:
>> On 2022/9/19 20:39, Ming Lei wrote:
>>> On Mon, Sep 19, 2022 at 05:12:21PM +0800, Ziyang Zhang wrote:
>>>> On 2022/9/19 11:55, Ming Lei wrote:
>>>>> On Tue, Sep 13, 2022 at 12:17:04PM +0800, ZiyangZhang wrote:
>>>>>> With recovery feature enabled, in ublk_queue_rq or task work
>>>>>> (in exit_task_work or fallback wq), we requeue rqs instead of
>>>>>> ending(aborting) them. Besides, No matter recovery feature is enabled
>>>>>> or disabled, we schedule monitor_work immediately.
>>>>>>
>>>>>> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
>>>>>> ---
>>>>>>  drivers/block/ublk_drv.c | 34 ++++++++++++++++++++++++++++++++--
>>>>>>  1 file changed, 32 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>>>>>> index 23337bd7c105..b067f33a1913 100644
>>>>>> --- a/drivers/block/ublk_drv.c
>>>>>> +++ b/drivers/block/ublk_drv.c
>>>>>> @@ -682,6 +682,21 @@ static void ubq_complete_io_cmd(struct ublk_io *io, int res)
>>>>>>  
>>>>>>  #define UBLK_REQUEUE_DELAY_MS	3
>>>>>>  
>>>>>> +static inline void __ublk_abort_rq_in_task_work(struct ublk_queue *ubq,
>>>>>> +		struct request *rq)
>>>>>> +{
>>>>>> +	pr_devel("%s: %s q_id %d tag %d io_flags %x.\n", __func__,
>>>>>> +			(ublk_queue_can_use_recovery(ubq)) ? "requeue" : "abort",
>>>>>> +			ubq->q_id, rq->tag, ubq->ios[rq->tag].flags);
>>>>>> +	/* We cannot process this rq so just requeue it. */
>>>>>> +	if (ublk_queue_can_use_recovery(ubq)) {
>>>>>> +		blk_mq_requeue_request(rq, false);
>>>>>> +		blk_mq_delay_kick_requeue_list(rq->q, UBLK_REQUEUE_DELAY_MS);
>>>>>
>>>>> Here you needn't to kick requeue list since we know it can't make
>>>>> progress. And you can do that once before deleting gendisk
>>>>> or the queue is recovered.
>>>>
>>>> No, kicking rq here is necessary.
>>>>
>>>> Consider USER_RECOVERY is enabled and everything goes well.
>>>> User sends STOP_DEV, and we have kicked requeue list in
>>>> ublk_stop_dev() and are going to call del_gendisk().
>>>> However, a crash happens now. Then rqs may be still requeued
>>>> by ublk_queue_rq() because ublk_queue_rq() sees a dying
>>>> ubq_daemon. So del_gendisk() will hang because there are
>>>> rqs leaving in requeue list and no one kicks them.
>>>
>>> Why can't you kick requeue list before calling del_gendisk().
>>
>> Yes, we can kick requeue list once before calling del_gendisk().
>> But a crash may happen just after kicking but before del_gendisk().
>> So some rqs may be requeued at this moment. But we have already
>> kicked the requeue list! Then del_gendisk() will hang, right?
> 
> ->force_abort is set before kicking in ublk_unquiesce_dev(), so
> all new requests are failed immediately instead of being requeued,
> right?
> 

->force_abort is not heplful here because there may be fallback wq running
which can requeue rqs after kicking requeue list.

In ublk_unquiesce_dev(), I simply disable recovery feature
if ub's state is UBLK_S_DEV_LIVE while stopping ublk_dev.

Note: We can make sure fallback wq does not run if we wait until all rqs with
ACTIVE flag set are requeued. This is done in quiesce_work(). But it cannot
run while ublk_stop_dev() is running...


Regards,
Zhang.

