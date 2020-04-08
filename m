Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D22C2D0EA
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 13:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E71B206F7
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 13:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgDHNBh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:01:37 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727896AbgDHNBh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Apr 2020 09:01:37 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 976F3C556FD4BE171BCF;
        Wed,  8 Apr 2020 14:01:35 +0100 (IST)
Received: from [127.0.0.1] (10.210.166.224) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 8 Apr 2020
 14:01:34 +0100
Subject: Re: [PATCH V6 0/8] blk-mq: improvement CPU hotplug
To:     Daniel Wagner <dwagner@suse.de>, Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200407092901.314228-1-ming.lei@redhat.com>
 <20200408124017.g6wizq5bljzwb2gq@beryllium.lan>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d441e96f-2450-6fc7-c5ab-b8bb9f98f3be@huawei.com>
Date:   Wed, 8 Apr 2020 14:01:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200408124017.g6wizq5bljzwb2gq@beryllium.lan>
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

On 08/04/2020 13:40, Daniel Wagner wrote:
> Hi Ming,
> 
> On Tue, Apr 07, 2020 at 05:28:53PM +0800, Ming Lei wrote:
>> Hi,
>>
>> Thomas mentioned:
>>      "
>>       That was the constraint of managed interrupts from the very beginning:
>>      
>>        The driver/subsystem has to quiesce the interrupt line and the associated
>>        queue _before_ it gets shutdown in CPU unplug and not fiddle with it
>>        until it's restarted by the core when the CPU is plugged in again.
>>      "
>>
>> But no drivers or blk-mq do that before one hctx becomes inactive(all
>> CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
>> to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
>>
>> This patchset tries to address the issue by two stages:
>>
>> 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
>>
>> - mark the hctx as internal stopped, and drain all in-flight requests
>> if the hctx is going to be dead.
>>
>> 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx becomes dead
>>
>> - steal bios from the request, and resubmit them via generic_make_request(),
>> then these IO will be mapped to other live hctx for dispatch
>>
>> Please comment & review, thanks!
> 
> FWIW, I've stress test this series by running the stress-cpu-hotplug
> with a fio workload in the background. Nothing exploded, all just
> worked fine.

Hi Daniel,

Is stress-cpu-hotplug an ltp test? or from Steven Rostedt -  I saw some 
threads where he mentioned some script?

Will the fio processes migrate back onto cpus which have been onlined again?

What is the block driver NVMe?

Thanks,
john
