Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5577CC433DF
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 20:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A9B204EF
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 20:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgE0Uch (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 16:32:37 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2251 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbgE0Uch (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 16:32:37 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D651632BE812A1728E8A;
        Wed, 27 May 2020 21:32:35 +0100 (IST)
Received: from [127.0.0.1] (10.47.6.244) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 27 May
 2020 21:32:35 +0100
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v4
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200527180644.514302-1-hch@lst.de>
 <e70a1d79-4bc4-53a4-d8ad-b5d61225f736@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5080b470-02c9-aba8-c9f4-83002dc26df8@huawei.com>
Date:   Wed, 27 May 2020 21:31:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <e70a1d79-4bc4-53a4-d8ad-b5d61225f736@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.6.244]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27/05/2020 21:07, Bart Van Assche wrote:
> On 2020-05-27 11:06, Christoph Hellwig wrote:
>> this series ensures I/O is quiesced before a cpu and thus the managed
>> interrupt handler is shut down.
>>
>> This patchset tries to address the issue by the following approach:
>>
>>   - before the last cpu in hctx->cpumask is going to offline, mark this
>>     hctx as inactive
>>
>>   - disable preempt during allocating tag for request, and after tag is
>>     allocated, check if this hctx is inactive. If yes, give up the
>>     allocation and try remote allocation from online CPUs
>>
>>   - before hctx becomes inactive, drain all allocated requests on this
>>     hctx
>>
>> The guts of the changes are from Ming Lei, I just did a bunch of prep
>> cleanups so that they can fit in more nicely.  The series also depends
>> on my "avoid a few q_usage_counter roundtrips v3" series.
>>
>> Thanks John Garry for running lots of tests on arm64 with this previous
>> version patches and co-working on investigating all kinds of issues.
> 
> Hi Christoph,
> 
> Thanks for having prepared and posted this new patch series. After v3
> was posted and before v4 was posted I had a closer look at the IRQ core.
> My conclusions (which may be incorrect) are as follows:
> * The only function that sets the 'is_managed' member of struct
>    irq_affinity_desc to 1 is irq_create_affinity_masks().
> * There are two ways to cause that function to be called: setting the
>    PCI_IRQ_AFFINITY flag when calling pci_alloc_irq_vectors_affinity() or
>    passing the 'affd' argument. pci_alloc_irq_vectors() calls
>    pci_alloc_irq_vectors_affinity().
> * The following drivers pass an affinity domain argument when allocating
>    interrupts: virtio_blk, nvme, be2iscsi, csiostor, hisi_sas, megaraid,
>    mpt3sas, qla2xxx, virtio_scsi.
> * The following drivers set the PCI_IRQ_AFFINITY flag but do not pass an
>    affinity domain: aacraid, hpsa, lpfc, smartqpi, virtio_pci_common.
> 
> What is not clear to me is why managed interrupts are shut down if the
> last CPU in their affinity mask is shut down? Has it been considered to
> modify the IRQ core such that managed PCIe interrupts are assigned to
> another CPU if the last CPU in their affinity mask is shut down? 

I think Thomas answered that here already:
https://lore.kernel.org/lkml/alpine.DEB.2.21.1901291717370.1513@nanos.tec.linutronix.de/

(vector space exhaustion)

Would
> that make it unnecessary to drain hardware queues during CPU
> hotplugging? Or is there perhaps something in the PCI or PCIe
> specifications or in one of the architectures supported by Linux that
> prevents doing this?
> 
> Is this the commit that introduced shutdown of managed interrupts:
> c5cb83bb337c ("genirq/cpuhotplug: Handle managed IRQs on CPU hotplug")?
> 
> Some of my knowledge about non-managed and managed interrupts comes from
> https://lore.kernel.org/lkml/alpine.DEB.2.20.1710162106400.2037@nanos/
> 
> Thanks,
> 
> Bart.
> .
> 

