Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2AEC169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 17:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC4B20B1F
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 17:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfAaRsU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:48:20 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:51468 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725849AbfAaRsU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 12:48:20 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 60DD867F5522B6745ED4;
        Fri,  1 Feb 2019 01:48:17 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Feb 2019
 01:48:09 +0800
Subject: Re: Question on handling managed IRQs when hotplugging CPUs
To:     Thomas Gleixner <tglx@linutronix.de>
References: <f6f6e031-8b79-439d-c2af-8d3e76f30710@huawei.com>
 <20190129154433.GF15302@localhost.localdomain>
 <757902fc-a9ea-090b-7853-89944a0ce1b5@huawei.com>
 <20190129172059.GC17132@localhost.localdomain>
 <3fe63dab-0791-f476-69c4-9866b70e8520@huawei.com>
 <alpine.DEB.2.21.1901301338170.5537@nanos.tec.linutronix.de>
CC:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <86d5028d-44ab-3696-f7fe-828d7655faa9@huawei.com>
Date:   Thu, 31 Jan 2019 17:48:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901301338170.5537@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 30/01/2019 12:43, Thomas Gleixner wrote:
> On Wed, 30 Jan 2019, John Garry wrote:
>> On 29/01/2019 17:20, Keith Busch wrote:
>>> On Tue, Jan 29, 2019 at 05:12:40PM +0000, John Garry wrote:
>>>> On 29/01/2019 15:44, Keith Busch wrote:
>>>>>
>>>>> Hm, we used to freeze the queues with CPUHP_BLK_MQ_PREPARE callback,
>>>>> which would reap all outstanding commands before the CPU and IRQ are
>>>>> taken offline. That was removed with commit 4b855ad37194f ("blk-mq:
>>>>> Create hctx for each present CPU"). It sounds like we should bring
>>>>> something like that back, but make more fine grain to the per-cpu
>>>>> context.
>>>>>
>>>>
>>>> Seems reasonable. But we would need it to deal with drivers where they
>>>> only
>>>> expose a single queue to BLK MQ, but use many queues internally. I think
>>>> megaraid sas does this, for example.
>>>>
>>>> I would also be slightly concerned with commands being issued from the
>>>> driver unknown to blk mq, like SCSI TMF.
>>>
>>> I don't think either of those descriptions sound like good candidates
>>> for using managed IRQ affinities.
>>
>> I wouldn't say that this behaviour is obvious to the developer. I can't see
>> anything in Documentation/PCI/MSI-HOWTO.txt
>>
>> It also seems that this policy to rely on upper layer to flush+freeze queues
>> would cause issues if managed IRQs are used by drivers in other subsystems.
>> Networks controllers may have multiple queues and unsoliciated interrupts.
>
> It's doesn't matter which part is managing flush/freeze of queues as long
> as something (either common subsystem code, upper layers or the driver
> itself) does it.
>
> So for the megaraid SAS example the BLK MQ layer obviously can't do
> anything because it only sees a single request queue. But the driver could,
> if the the hardware supports it. tell the device to stop queueing
> completions on the completion queue which is associated with a particular
> CPU (or set of CPUs) during offline and then wait for the on flight stuff
> to be finished. If the hardware does not allow that, then managed
> interrupts can't work for it.
>

A rough audit of current SCSI drivers tells that these set 
PCI_IRQ_AFFINITY in some path but don't set Scsi_host.nr_hw_queues at all:
aacraid, be2iscsi, csiostor, megaraid, mpt3sas

I don't know specific driver details, like changing completion queue.

Thanks,
John

> Thanks,
>
> 	tglx
>
> .
>


