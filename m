Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:11484 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751015AbeCNJrq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Mar 2018 05:47:46 -0400
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
To: <dedekind1@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Laurence Oberman <loberman@redhat.com>
References: <20180308105358.1506-1-ming.lei@redhat.com>
 <1520515113.20980.31.camel@gmail.com> <20180308133440.GA2713@ming.t460p>
 <alpine.DEB.2.21.1803090011150.1454@nanos.tec.linutronix.de>
 <20180309012458.GD5228@ming.t460p>
 <alpine.DEB.2.21.1803091107520.1364@nanos.tec.linutronix.de>
 <20180309120833.GB30257@ming.t460p>
 <alpine.DEB.2.21.1803091531000.1364@nanos.tec.linutronix.de>
 <5e5f3852-5314-c479-245e-d0a575e533a5@cn.fujitsu.com>
 <1520926721.20980.210.camel@gmail.com> <20180313083535.GA21612@ming.t460p>
 <1520930375.20980.213.camel@gmail.com>
 <CAJZ5v0gcmkKVcgDBdt-aePgU0zvQwyf1yX5Qi_zRc1JfzaA5fg@mail.gmail.com>
 <ec20381d-b5d9-9e22-d94e-96bbb8d6278e@cn.fujitsu.com>
 <a8770022-a437-9b8c-0b2e-cd6bdc0764ef@cn.fujitsu.com>
 <1521018450.20980.220.camel@gmail.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <3c2f886e-6cb9-a8b4-5f95-ffceb039843d@cn.fujitsu.com>
Date: Wed, 14 Mar 2018 17:47:39 +0800
MIME-Version: 1.0
In-Reply-To: <1521018450.20980.220.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Artern,

At 03/14/2018 05:07 PM, Artem Bityutskiy wrote:
> On Wed, 2018-03-14 at 12:11 +0800, Dou Liyang wrote:
>>> At 03/13/2018 05:35 PM, Rafael J. Wysocki wrote:
>>>> On Tue, Mar 13, 2018 at 9:39 AM, Artem Bityutskiy
>>>>> Longer term, yeah, I agree. Kernel's notion of possible CPU
>>>>> count
>>>>> should be realistic.
>>>
>>> I did a patch for that, Artem, could you help me to test it.
>>>
>>
>> I didn't consider the nr_cpu_ids before. please ignore the old patch
>> and
>> try the following RFC patch.
> 
> Sure I can help with testing a patch, could we please:
> 
> 1. Start a new thread for this
> 2. Include ACPI forum/folks
> 

OK,  I will do that right now.

Thanks,
	dou

> Thanks,
> Artem.
> 
> 
> 
