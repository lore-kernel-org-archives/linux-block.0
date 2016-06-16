Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn1on0082.outbound.protection.outlook.com ([157.56.110.82]:30216
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751323AbcFPJJA (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 16 Jun 2016 05:09:00 -0400
Subject: Re: [PATCH 02/13] irq: Introduce IRQD_AFFINITY_MANAGED flag
To: Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>, <axboe@fb.com>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-3-git-send-email-hch@lst.de>
CC: <linux-block@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <d368370a-1601-e127-4f61-458e6839fa28@sandisk.com>
Date: Thu, 16 Jun 2016 11:08:48 +0200
MIME-Version: 1.0
In-Reply-To: <1465934346-20648-3-git-send-email-hch@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/14/2016 09:58 PM, Christoph Hellwig wrote:
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index 4d758a7..49d66d1 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -197,6 +197,7 @@ struct irq_data {
>   * IRQD_IRQ_INPROGRESS		- In progress state of the interrupt
>   * IRQD_WAKEUP_ARMED		- Wakeup mode armed
>   * IRQD_FORWARDED_TO_VCPU	- The interrupt is forwarded to a VCPU
> + * IRQD_AFFINITY_MANAGED	- Affinity is managed automatically
>   */

Does "managed automatically" mean managed by software? If so, I think it 
would help to mention which software manages IRQ affinity if the 
IRQD_AFFINITY_MANAGED flag has been set.

Thanks,

Bart.
