Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2534FC282CC
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 13:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02A92073D
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 13:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfBENYd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:24:33 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36972 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbfBENYd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Feb 2019 08:24:33 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BBC4D76E2761F58CA833;
        Tue,  5 Feb 2019 21:24:30 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Tue, 5 Feb 2019
 21:24:21 +0800
Subject: Re: Question on handling managed IRQs when hotplugging CPUs
To:     Hannes Reinecke <hare@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <f6f6e031-8b79-439d-c2af-8d3e76f30710@huawei.com>
 <20190129154433.GF15302@localhost.localdomain>
 <757902fc-a9ea-090b-7853-89944a0ce1b5@huawei.com>
 <20190129172059.GC17132@localhost.localdomain>
 <3fe63dab-0791-f476-69c4-9866b70e8520@huawei.com>
 <alpine.DEB.2.21.1901301338170.5537@nanos.tec.linutronix.de>
 <86d5028d-44ab-3696-f7fe-828d7655faa9@huawei.com>
 <745609be-b215-dd2d-c31f-0bd84572f49f@suse.de>
 <alpine.DEB.2.21.1902012255550.8200@nanos.tec.linutronix.de>
 <d93ff049-e96d-36ce-7e58-ec97cbb27ed0@suse.de>
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
Message-ID: <42d149c5-0380-c357-8811-81015159ac04@huawei.com>
Date:   Tue, 5 Feb 2019 13:24:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <d93ff049-e96d-36ce-7e58-ec97cbb27ed0@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/02/2019 07:12, Hannes Reinecke wrote:
> On 2/1/19 10:57 PM, Thomas Gleixner wrote:
>> On Fri, 1 Feb 2019, Hannes Reinecke wrote:
>>> Thing is, if we have _managed_ CPU hotplug (ie if the hardware
>>> provides some
>>> means of quiescing the CPU before hotplug) then the whole thing is
>>> trivial;
>>> disable SQ and wait for all outstanding commands to complete.
>>> Then trivially all requests are completed and the issue is resolved.
>>> Even with todays infrastructure.
>>>
>>> And I'm not sure if we can handle surprise CPU hotplug at all, given
>>> all the
>>> possible race conditions.
>>> But then I might be wrong.
>>
>> The kernel would completely fall apart when a CPU would vanish by
>> surprise,
>> i.e. uncontrolled by the kernel. Then the SCSI driver exploding would be
>> the least of our problems.
>>
> Hehe. As I thought.

Hi Hannes,

>
> So, as the user then has to wait for the system to declars 'ready for
> CPU remove', why can't we just disable the SQ and wait for all I/O to
> complete?
> We can make it more fine-grained by just waiting on all outstanding I/O
> on that SQ to complete, but waiting for all I/O should be good as an
> initial try.
> With that we wouldn't need to fiddle with driver internals, and could
> make it pretty generic.

I don't fully understand this idea - specifically, at which layer would 
we be waiting for all the IO to complete?

> And we could always add more detailed logic if the driver has the means
> for doing so.
>

Thanks,
John

> Cheers,
>
> Hannes


