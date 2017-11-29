Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:2236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750783AbdK2Fkd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Nov 2017 00:40:33 -0500
Subject: Re: [PATCH V2 0/2] block: fix queue freeze and cleanup
To: Ming Lei <ming.lei@redhat.com>
References: <20171123044800.25251-1-ming.lei@redhat.com>
 <20171127124147.GA16095@ming.t460p>
 <fb185d60-9489-d841-c86d-07de5e5f561d@hisilicon.com>
 <20171129045408.GB11430@ming.t460p>
CC: Jens Axboe <axboe@fb.com>, <linux-block@vger.kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Linuxarm <linuxarm@huawei.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <4dced54f-639f-c2b3-729a-458c4444ee88@hisilicon.com>
Date: Wed, 29 Nov 2017 13:40:14 +0800
MIME-Version: 1.0
In-Reply-To: <20171129045408.GB11430@ming.t460p>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

在 2017/11/29 12:54, Ming Lei 写道:
> Hi Chenxiang,
>
> On Wed, Nov 29, 2017 at 10:57:06AM +0800, chenxiang (M) wrote:
>> 在 2017/11/27 20:41, Ming Lei 写道:
>>> On Thu, Nov 23, 2017 at 12:47:58PM +0800, Ming Lei wrote:
>>>> Hi Jens,
>>>>
>>>> The 1st patch runs queue in blk_freeze_queue_start() for fixing one
>>>> regression by 055f6e18e08f("block: Make q_usage_counter also track legacy
>>>> requests").
>>>>
>>>> The 2nd patch drians blkcg part of request_queue for both blk-mq and
>>>> legacy, which can be a fix on blk-mq's queue cleanup.
>>>>
>>>> V2:
>>>> 	- follow Bart's suggestion to use run queue instead of drain queue
>>>> 	- drians blkcg part of request_queue for blk-mq
>>>>
>>> Hi Jens,
>>>
>>> Without this patchset, IO hang can be triggered in Mauricio's disk
>>> pull test, and this IO hang won't happen any more after this patchset
>>> is applied.
>>>
>>> So could you make it in V4.15 if you are fine with the two patches?
>> Hi Lei Ming,
>>
>> I applied this v2 patchset to kernel 4.15-rc1, running fio on a SATA disk,
>> then disable the disk with sysfs interface
> I guess it is a SAS disk?

My test is on SATA disk. Our driver is SAS driver, and it supports SATA 
disk and SAS disk.

>
>> (echo 0 > /sys/class/sas_phy/phy-1:0:1/enable), and find system is hung. But
>> with v1 patch, it doesn't
>> has this issue. Please have a check.
> Thanks for your test!
>
> Then looks even though V2 can fix Mauricio's issue, it still can't fix
> yours, which is a regression caused by 055f6e18e08f("block: Make q_usage_counter
> also track legacy requests").
>
> Given V1 can fix both your issue and Mauricio's, I will post V3 which falls
> back to original V1.
>
>
> Thanks,
> Ming
>
> .
>
