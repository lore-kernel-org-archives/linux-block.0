Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3200C433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 13:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FAC2100A
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 13:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgE2N0N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 09:26:13 -0400
Received: from verein.lst.de ([213.95.11.211]:33007 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgE2N0N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 09:26:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 90E4368B02; Fri, 29 May 2020 15:26:09 +0200 (CEST)
Date:   Fri, 29 May 2020 15:26:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v4
Message-ID: <20200529132609.GA32309@lst.de>
References: <20200527180644.514302-1-hch@lst.de> <e70a1d79-4bc4-53a4-d8ad-b5d61225f736@acm.org> <5080b470-02c9-aba8-c9f4-83002dc26df8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5080b470-02c9-aba8-c9f4-83002dc26df8@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 27, 2020 at 09:31:30PM +0100, John Garry wrote:
>> Thanks for having prepared and posted this new patch series. After v3
>> was posted and before v4 was posted I had a closer look at the IRQ core.
>> My conclusions (which may be incorrect) are as follows:
>> * The only function that sets the 'is_managed' member of struct
>>    irq_affinity_desc to 1 is irq_create_affinity_masks().
>> * There are two ways to cause that function to be called: setting the
>>    PCI_IRQ_AFFINITY flag when calling pci_alloc_irq_vectors_affinity() or
>>    passing the 'affd' argument. pci_alloc_irq_vectors() calls
>>    pci_alloc_irq_vectors_affinity().
>> * The following drivers pass an affinity domain argument when allocating
>>    interrupts: virtio_blk, nvme, be2iscsi, csiostor, hisi_sas, megaraid,
>>    mpt3sas, qla2xxx, virtio_scsi.
>> * The following drivers set the PCI_IRQ_AFFINITY flag but do not pass an
>>    affinity domain: aacraid, hpsa, lpfc, smartqpi, virtio_pci_common.
>>
>> What is not clear to me is why managed interrupts are shut down if the
>> last CPU in their affinity mask is shut down? Has it been considered to
>> modify the IRQ core such that managed PCIe interrupts are assigned to
>> another CPU if the last CPU in their affinity mask is shut down? 
>
> I think Thomas answered that here already:
> https://lore.kernel.org/lkml/alpine.DEB.2.21.1901291717370.1513@nanos.tec.linutronix.de/
>
> (vector space exhaustion)

Exactly.
