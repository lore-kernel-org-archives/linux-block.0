Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D42C2D0F4
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 16:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3904B20730
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 16:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbgDHQ5P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:57:15 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729456AbgDHQ5P (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Apr 2020 12:57:15 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 00F6D9F3B650D1797C8B;
        Wed,  8 Apr 2020 17:57:13 +0100 (IST)
Received: from [127.0.0.1] (10.210.166.224) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 8 Apr 2020
 17:57:12 +0100
Subject: Re: [PATCH V6 0/8] blk-mq: improvement CPU hotplug
To:     Daniel Wagner <dwagner@suse.de>
CC:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200407092901.314228-1-ming.lei@redhat.com>
 <20200408124017.g6wizq5bljzwb2gq@beryllium.lan>
 <d441e96f-2450-6fc7-c5ab-b8bb9f98f3be@huawei.com>
 <20200408131030.456mq6kjxscex7ql@beryllium.lan>
 <fce90f4b-1d23-a352-c48c-d80253b7a4b2@huawei.com>
 <20200408151416.ecpcpsq4psdbkufk@beryllium.lan>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8dade35b-6fd6-4438-25b1-b4620d4982ba@huawei.com>
Date:   Wed, 8 Apr 2020 17:56:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200408151416.ecpcpsq4psdbkufk@beryllium.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.166.224]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/04/2020 16:14, Daniel Wagner wrote:
> On Wed, Apr 08, 2020 at 02:29:51PM +0100, John Garry wrote:
>> On 08/04/2020 14:10, Daniel Wagner wrote:
>> ok, but to really test this you need to ensure that all the cpus for a
>> managed interrupt affinity mask are offlined together for some period of
>> time greater than the IO timeout. Otherwise the hw queue's managed interrupt
>> would not be shut down, and you're not verifying that the queues are fully
>> drained.
> 

Hi Daniel,

> Not sure if I understand you correctly: Are you saying that the IRQ
> related resources are not freed/moved from the offlining CPU?

This series tries to drain the hw queue when all cpus in the queue (IRQ) 
affinity mask are being offlined. This is because when all the cpus are 
offlined, the managed IRQ for that hw queue is shutdown - so there are 
no cpus remaining online to service the completion interrupt for 
in-flight IOs. The cover letter may explain this better.

> 
>>>> Will the fio processes migrate back onto cpus which have been onlined again?
>>>
>>> Hmm, good question. I've tried to assign them to a specific CPU via
>>> --cpus_allowed_policy=split and --cpus_allowed.
>>>
>>>     fio --rw=randwrite --name=test --size=50M --iodepth=32 --direct=1 \
>>>         --bs=4k --numjobs=40 --time_based --runtime=1h --ioengine=libaio \
>>>         --group_reporting --cpus_allowed_policy=split --cpus_allowed=0-40
>>>
>>> Though I haven't verified what happens when the CPU get's back online.
>>
>> Maybe this will work since you're offlining patterns of cpus and the fio
>> processes have to migrate somewhere. But see above.
> 
> At least after the initial setup a fio thread will be migrated away
> from the offlining CPU.
> 
> A quick test shows, that the affinity mask for a fio thread will be
> cleared when the CPU goes offline. There seems to be a discussion
> going on about the cpu hotplug and the affinity mask:
> 
> https://lore.kernel.org/lkml/1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com
> 
> TL;DR: it can be scheduled back if affinity is tweaked via
> e.g. taskset, it won't if it's via cpusets

I just avoid any of this in my test by looping in a sequence of onlining 
all cpus, start fio for short period, and then offline cpus.

BTW, you mentioned earlier that you would test megaraid_sas. As things 
stand, I don't think that series will help there as that driver still 
just exposes a single HW queue to blk-mq. I think qla2xxx driver does 
expose >1 queues, i.e. it sets Scsi_Host.nr_hq_queues, so may be a 
better option.

Cheers,
John

