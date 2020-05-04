Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07A3C3A5A9
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 09:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E202071C
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 09:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgEDJ6G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 05:58:06 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2155 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728079AbgEDJ6F (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 05:58:05 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 4DFA7D4BA2B49E0EB57B;
        Mon,  4 May 2020 10:58:04 +0100 (IST)
Received: from [127.0.0.1] (10.210.171.25) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 4 May 2020
 10:58:03 +0100
Subject: Re: [PATCH V9 00/11] blk-mq: improvement CPU hotplug
From:   John Garry <john.garry@huawei.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200502235454.1118520-1-ming.lei@redhat.com>
 <5db8635b-b606-3dd9-ce1d-5280097acbd3@huawei.com>
 <20200504083831.GA1139563@T590>
 <4892e8d0-0a4b-2f35-130c-eae23d578549@huawei.com>
Message-ID: <6e4c4382-c52b-14ac-8538-71e683dce47e@huawei.com>
Date:   Mon, 4 May 2020 10:57:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <4892e8d0-0a4b-2f35-130c-eae23d578549@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.171.25]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/05/2020 10:07, John Garry wrote:
> On 04/05/2020 09:38, Ming Lei wrote:
>>> [67.602937]  refcount_warn_saturate+0x6c/0x13c
>>> [67.607369]  aio_complete_rw+0x350/0x384
>>> [67.611279]  blkdev_bio_end_io+0xc4/0x12c
>>> [67.615276]  bio_endio+0x104/0x130
>>> [67.618665]  blk_update_request+0x98/0x37c
>>> [67.622748]  blk_mq_end_request+0x24/0x138
>>> [67.626831]  blk_mq_resubmit_end_rq+0x40/0x58
>>> [67.631174]  __blk_mq_end_request+0xb0/0x10c
>>> [67.635432]  scsi_end_request+0xdc/0x20c
>> Looks an old issue, I believe the following patch can fix the issue:
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 12dee4ecd5cc..3fc79d4b2fe0 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2415,6 +2415,10 @@ static void blk_mq_resubmit_rq(struct request *rq)
>>       nrq->bio = rq->bio;
>>       nrq->biotail = rq->biotail;
>> +    /* Now all bios ownership is transfered to 'nrq' */
>> +    rq->bio = rq->biotail = NULL;
>> +    rq->__data_len = 0;
>> +
>>       if (blk_insert_cloned_request(nrq->q, nrq) != BLK_STS_OK)
>>           blk_mq_request_bypass_insert(nrq, false, true);
>>   }
> 
> ok, looks much better.
> 
> I'll test this a bit more now.

looks pretty solid now. I assume we'll see a v10, so please add:

Tested-by: John Garry <john.garry@huawei.com>

> 
> cheers
> 
> .

