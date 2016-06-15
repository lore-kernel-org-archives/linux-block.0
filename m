Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn1bn0100.outbound.protection.outlook.com ([157.56.110.100]:42122
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753237AbcFOIos (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 15 Jun 2016 04:44:48 -0400
Subject: Re: [PATCH 02/13] irq: Introduce IRQD_AFFINITY_MANAGED flag
To: Christoph Hellwig <hch@lst.de>, <tglx@linutronix.de>,
	<axboe@fb.com>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-3-git-send-email-hch@lst.de>
CC: <linux-block@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <0412b942-ea0d-d4eb-c724-8243d12ff6f3@sandisk.com>
Date: Wed, 15 Jun 2016 10:44:37 +0200
MIME-Version: 1.0
In-Reply-To: <1465934346-20648-3-git-send-email-hch@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/14/2016 09:58 PM, Christoph Hellwig wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Interupts marked with this flag are excluded from user space interrupt
> affinity changes. Contrary to the IRQ_NO_BALANCING flag, the kernel internal
> affinity mechanism is not blocked.
>
> This flag will be used for multi-queue device interrupts.

It's great to see that the goal of this patch series is to configure 
interrupt affinity automatically for adapters that support multiple 
MSI-X vectors. However, is excluding these interrupts from irqbalanced 
really the way to go? Suppose e.g. that a system is equipped with two 
RDMA adapters, that these adapters are used by a blk-mq enabled block 
initiator driver and that each adapter supports eight MSI-X vectors. 
Should the interrupts of the two RDMA adapters be assigned to different 
CPU cores? If so, which software layer should realize this? The kernel 
or user space?

Sorry that I missed the first version of this patch series.

Thanks,

Bart.
