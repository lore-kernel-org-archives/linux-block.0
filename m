Return-Path: <linux-block-owner@vger.kernel.org>
Received: from m12-15.163.com ([220.181.12.15]:34053 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeIKOhJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 10:37:09 -0400
Subject: Re: Affinity managed interrupts vs non-managed interrupts
To: Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
References: <602cee6381b9f435a938bbaf852d07f9@mail.gmail.com>
 <alpine.DEB.2.21.1809021357000.1349@nanos.tec.linutronix.de>
 <66256272c020be186becdd7a3f049302@mail.gmail.com>
 <alpine.DEB.2.21.1809031719460.1383@nanos.tec.linutronix.de>
 <dd1c5df55aa99cf4a37bcc58e77e840a@mail.gmail.com>
 <f436fa6a-b865-fadb-4f77-44309ff84405@163.com>
 <c0f779f1d5ef131c39f9397f97d453e8@mail.gmail.com>
 <alpine.DEB.2.21.1809051235180.1416@nanos.tec.linutronix.de>
 <d2a6f7cf-31df-de17-82e3-eccb9cc73ed8@163.com>
 <alpine.DEB.2.21.1809061244151.1570@nanos.tec.linutronix.de>
 <20180911091354.GA9898@lst.de>
From: Dou Liyang <dou_liyang@163.com>
Message-ID: <876cd3e2-7519-eab9-7da6-2a672256365e@163.com>
Date: Tue, 11 Sep 2018 17:38:19 +0800
MIME-Version: 1.0
In-Reply-To: <20180911091354.GA9898@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,
At 09/11/2018 05:13 PM, Christoph Hellwig wrote:
> On Thu, Sep 06, 2018 at 01:46:46PM +0200, Thomas Gleixner wrote:
>>
>> I think the right solution for these pre/post vectors is to _NOT_ mark
>> them managed and leave them as regular interrupts which can be affinity
>> controlled and also can move freely on hotplug.
> 
> Yes, agreed.  Marking the pre/post vector as managed was a mistake
> (and I don't think it even was intentional, at least on my part).
> 
Got it !

And, I am trying to fix this by:

  -Don't set affinity for pre/post vectors in
   irq_create_affinity_masks().

  -And do not setup the desc->affinity of pre/post vectors in
   alloc_msi_entry().

So, the affinity in alloc_descs() will be NULL, and the interrupt won't
be marked as IRQD_AFFINITY_MANAGED.

Is it OK? and I will show the codes after testing it.

Thanks,
	dou
