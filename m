Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:7497 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdJERTQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Oct 2017 13:19:16 -0400
Subject: Re: [Question] on blk_mq_map_queues()
To: Christoph Hellwig <hch@lst.de>
References: <f5280c3c-ffd9-bc3a-7e0b-226c4a1232c9@huawei.com>
 <20171005155901.GA30575@lst.de>
 <9f1e7e62-7d9d-199f-cb78-3dc4039b3042@huawei.com>
 <20171005162758.GA31439@lst.de>
CC: <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        <maxg@mellanox.com>, Linuxarm <linuxarm@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <6123a5fd-f856-1f4d-d427-771e83e1ada6@huawei.com>
Date: Thu, 5 Oct 2017 18:19:00 +0100
MIME-Version: 1.0
In-Reply-To: <20171005162758.GA31439@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/10/2017 17:27, Christoph Hellwig wrote:
> On Thu, Oct 05, 2017 at 05:06:54PM +0100, John Garry wrote:
>> It's a HiSilicon hip07 (D05) platform. For this platform, the integrated
>> SAS controller is a platform device. This controller supports 16 hw queues.
>
> That's v1 or v2 in drivers/scsi/hisi_sas?

That's v2 drivers/scsi/hisi_sas.

>
> Seems like you need to implement the equivalent of the
> pci_alloc_irq_vectors vector spreading for platform devices to get
> your vectors properly assigned, and the have a blk_mq_of_map_queues
> equivalent to blk_mq_pci_map_queues to map the queues based on the
> interrupt assignment.
>
> .

Right, I'll have a look.

But I am still interested in patch "blk-mq: map all HWQ also in 
hyperthreaded system" and what it is the intended mapping behaviour of 
blk_mq_of_map_queues() supposed to be. As I said originally, it does not 
always seem to follow the general principle of assigning close cores to 
the same queue.

Cheers,
John
