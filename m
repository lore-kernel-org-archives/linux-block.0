Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn1bon0097.outbound.protection.outlook.com ([157.56.111.97]:15722
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751683AbcFPJF6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 16 Jun 2016 05:05:58 -0400
Subject: Re: [PATCH 01/13] irq/msi: Remove unused MSI_FLAG_IDENTITY_MAP
To: Christoph Hellwig <hch@lst.de>, <tglx@linutronix.de>,
	<axboe@fb.com>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-2-git-send-email-hch@lst.de>
CC: <linux-block@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <4686a1f6-3cda-282a-f307-78ece3206b83@sandisk.com>
Date: Thu, 16 Jun 2016 11:05:46 +0200
MIME-Version: 1.0
In-Reply-To: <1465934346-20648-2-git-send-email-hch@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/14/2016 09:58 PM, Christoph Hellwig wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> No user and we definitely don't want to grow one.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
