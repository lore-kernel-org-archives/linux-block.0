Return-Path: <SRS0=c8VV=ZU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4F2C432C3
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 10:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBB021775
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 10:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfK1KqO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:46:14 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2133 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbfK1KqO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Nov 2019 05:46:14 -0500
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 286EB80CB985A98A0398;
        Thu, 28 Nov 2019 10:46:12 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 28 Nov 2019 10:45:50 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 28 Nov
 2019 10:45:51 +0000
Subject: Re: [PATCH V4 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
To:     Ming Lei <ming.lei@redhat.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
References: <20191014015043.25029-1-ming.lei@redhat.com>
 <b3d90798-484f-09f5-a22f-f3ed3701f0d4@hisilicon.com>
 <20191128020205.GB3277@ming.t460p>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3c0d8630-8774-809e-47b1-bf71e51834f0@huawei.com>
Date:   Thu, 28 Nov 2019 10:45:49 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191128020205.GB3277@ming.t460p>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 28/11/2019 02:02, Ming Lei wrote:
> On Thu, Nov 28, 2019 at 09:09:13AM +0800, chenxiang (M) wrote:
>> Hi,
>>
>> 在 2019/10/14 9:50, Ming Lei 写道:
>>> Hi,
>>>
>>> Thomas mentioned:
>>>       "
>>>        That was the constraint of managed interrupts from the very beginning:
>>>         The driver/subsystem has to quiesce the interrupt line and the associated
>>>         queue _before_ it gets shutdown in CPU unplug and not fiddle with it
>>>         until it's restarted by the core when the CPU is plugged in again.
>>>       "
>>>
>>> But no drivers or blk-mq do that before one hctx becomes dead(all
>>> CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
>>> to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
>>>
>>> This patchset tries to address the issue by two stages:
>>>
>>> 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
>>>
>>> - mark the hctx as internal stopped, and drain all in-flight requests
>>> if the hctx is going to be dead.
>>>
>>> 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx becomes dead
>>>
>>> - steal bios from the request, and resubmit them via generic_make_request(),
>>> then these IO will be mapped to other live hctx for dispatch
>>>
>>> Please comment & review, thanks!
>>>
>>> John, I don't add your tested-by tag since V3 have some changes,
>>> and I appreciate if you may run your test on V3.
>>
>> I tested those patchset with John's testcase, except dump_stack() in
>> function __blk_mq_run_hw_queue() sometimes occurs  which don't
>> affect the function, it solves the CPU hotplug issue, so add tested-by for
>> those patchset:
>>
>> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
> 
> Thanks for your test.

So I had to give up testing as my board experienced some SCSI timeout 
even without hotplugging or including this patchset.

FWIW, I did test NVMe successfully though.

> 
> I plan to post a new version for 5.6 cycle, and there is still some
> small race window related with requeue to be covered.
> 

thanks!

> Thanks,
> Ming
> 
> .
> 

