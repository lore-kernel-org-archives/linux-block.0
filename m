Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E899C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAC420657
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfCROLO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:11:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45022 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727012AbfCROLO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 10:11:14 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5FB727D4EE27ED0219E8;
        Mon, 18 Mar 2019 22:11:10 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Mar 2019
 22:11:05 +0800
Subject: Re: [PATCH v3] block: add a new flag BLK_MQ_POLL_CLASSIC for hybrid
 poll
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "marcos.souza.org@gmail.com" <marcos.souza.org@gmail.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20190315042400.107549-1-yuyufen@huawei.com>
 <BYAPR04MB5816CEE30DB10CCF6CBE9906E7440@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   yuyufen <yuyufen@huawei.com>
Message-ID: <1541718b-ad0b-d203-fe44-1cdb722c8eac@huawei.com>
Date:   Mon, 18 Mar 2019 22:11:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816CEE30DB10CCF6CBE9906E7440@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019/3/16 0:11, Damien Le Moal wrote:
> On 2019/03/14 21:19, Yufen Yu wrote:
>> For q->poll_nsec == -1, means doing classic poll, not hybrid poll.
>> We introduce a new flag BLK_MQ_POLL_CLASSIC to replace -1, which
>> may make code much easier to read.
>>
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>> ---
>>   block/blk-mq.c         | 4 ++--
>>   block/blk-sysfs.c      | 8 ++++----
>>   include/linux/blkdev.h | 3 +++
>>   3 files changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index a9c181603cbd..1c588e5c4a02 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2857,7 +2857,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>>   	/*
>>   	 * Default to classic polling
>>   	 */
>> -	q->poll_nsec = -1;
>> +	q->poll_nsec = BLK_MQ_POLL_CLASSIC;
>>   
>>   	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
>>   	blk_mq_add_queue_tag_set(set, q);
>> @@ -3392,7 +3392,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
>>   {
>>   	struct request *rq;
>>   
>> -	if (q->poll_nsec == -1)
>> +	if (q->poll_nsec == BLK_MQ_POLL_CLASSIC)
>>   		return false;
>>   
>>   	if (!blk_qc_t_is_internal(cookie))
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index 59685918167e..cd127067998a 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -360,8 +360,8 @@ static ssize_t queue_poll_delay_show(struct request_queue *q, char *page)
>>   {
>>   	int val;
>>   
>> -	if (q->poll_nsec == -1)
>> -		val = -1;
>> +	if (q->poll_nsec == BLK_MQ_POLL_CLASSIC)
>> +		val = BLK_MQ_POLL_CLASSIC;
>>   	else
>>   		val = q->poll_nsec / 1000;
>>   
>> @@ -380,8 +380,8 @@ static ssize_t queue_poll_delay_store(struct request_queue *q, const char *page,
>>   	if (err < 0)
>>   		return err;
>>   
>> -	if (val == -1)
>> -		q->poll_nsec = -1;
>> +	if (val == BLK_MQ_POLL_CLASSIC)
>> +		q->poll_nsec = BLK_MQ_POLL_CLASSIC;
>>   	else
>>   		q->poll_nsec = val * 1000;
> You are not handling negative values other than -1 here as we discussed. Any
> reason for not adding the check ?

Oops, I send the wrong version.
Thanks again for your review and suggestion.

Yufen.
thanks

>>   
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 0de92b29f589..5c58a3b2bf00 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -50,6 +50,9 @@ struct blk_stat_callback;
>>   /* Must be consistent with blk_mq_poll_stats_bkt() */
>>   #define BLK_MQ_POLL_STATS_BKTS 16
>>   
>> +/* Doing classic polling */
>> +#define BLK_MQ_POLL_CLASSIC -1
>> +
>>   /*
>>    * Maximum number of blkcg policies allowed to be registered concurrently.
>>    * Defined here to simplify include dependency.
>>


