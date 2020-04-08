Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3A0C2D0EA
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 13:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BCE2082D
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 13:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgDHNaR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:30:17 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2643 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbgDHNaR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Apr 2020 09:30:17 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 1664F90280493B0ECB92;
        Wed,  8 Apr 2020 14:30:16 +0100 (IST)
Received: from [127.0.0.1] (10.210.166.224) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 8 Apr 2020
 14:30:14 +0100
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
From:   John Garry <john.garry@huawei.com>
Message-ID: <fce90f4b-1d23-a352-c48c-d80253b7a4b2@huawei.com>
Date:   Wed, 8 Apr 2020 14:29:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200408131030.456mq6kjxscex7ql@beryllium.lan>
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

On 08/04/2020 14:10, Daniel Wagner wrote:
> Hi John,
> 
> On Wed, Apr 08, 2020 at 02:01:11PM +0100, John Garry wrote:
>> Is stress-cpu-hotplug an ltp test? or from Steven Rostedt -  I saw some
>> threads where he mentioned some script?
> 
> My bad. It's the script from Steven, which toggle binary the cpus on/off:
> 
> [...]
> 2432 disabling cpu16 disabling cpu17 disabling cpu2
> 2433 disabling cpu1 enabling cpu16 enabling cpu17 enabling cpu2
> 2434 disabling cpu10 disabling cpu16 disabling cpu17 disabling cpu2
> 2435 enabling cpu1 enabling cpu10 enabling cpu16 enabling cpu17 enabling cpu2
> 2436 disabling cpu11 disabling cpu16 disabling cpu17 disabling cpu2
> 2437 disabling cpu1 enabling cpu11 enabling cpu16 enabling cpu17 enabling cpu2
> 2438 disabling cpu10 disabling cpu11 disabling cpu16 disabling cpu17 disabling cpu2
> [..]
> 

ok, but to really test this you need to ensure that all the cpus for a 
managed interrupt affinity mask are offlined together for some period of 
time greater than the IO timeout. Otherwise the hw queue's managed 
interrupt would not be shut down, and you're not verifying that the 
queues are fully drained.

>> Will the fio processes migrate back onto cpus which have been onlined again?
> 
> Hmm, good question. I've tried to assign them to a specific CPU via
> --cpus_allowed_policy=split and --cpus_allowed.
> 
>    fio --rw=randwrite --name=test --size=50M --iodepth=32 --direct=1 \
>        --bs=4k --numjobs=40 --time_based --runtime=1h --ioengine=libaio \
>        --group_reporting --cpus_allowed_policy=split --cpus_allowed=0-40
> 
> Though I haven't verified what happens when the CPU get's back online.

Maybe this will work since you're offlining patterns of cpus and the fio 
processes have to migrate somewhere. But see above.

> 
>> What is the block driver NVMe?
> 
> I've used a qla2xxx device. Hannes asked my to retry it with a megasas
> device.
> 

Thanks,
John

