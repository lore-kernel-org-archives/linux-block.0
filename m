Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn1bon0068.outbound.protection.outlook.com ([157.56.111.68]:55937
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753504AbcFOP3O (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 15 Jun 2016 11:29:14 -0400
Subject: Re: [PATCH 02/13] irq: Introduce IRQD_AFFINITY_MANAGED flag
To: Keith Busch <keith.busch@intel.com>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-3-git-send-email-hch@lst.de>
 <0412b942-ea0d-d4eb-c724-8243d12ff6f3@sandisk.com>
 <20160615102311.GA16619@lst.de>
 <67ef7a1c-56e1-db2c-b038-f9784fc1f52f@sandisk.com>
 <20160615151415.GA1919@localhost.localdomain>
CC: Christoph Hellwig <hch@lst.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"axboe@fb.com" <axboe@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <7f0b16bd-b39f-99e6-c1c1-6a508bf9bbbf@sandisk.com>
Date: Wed, 15 Jun 2016 17:28:54 +0200
MIME-Version: 1.0
In-Reply-To: <20160615151415.GA1919@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/15/2016 05:14 PM, Keith Busch wrote:
> On Wed, Jun 15, 2016 at 12:42:53PM +0200, Bart Van Assche wrote:
>> If two identical adapters are present in a system, will these generate the
>> same irq_affinity mask? Do you agree that interrupt vectors from different
>> adapters should be assigned to different CPU cores if enough CPU cores are
>> available? If so, which software layer will assign interrupt vectors from
>> different adapters to different CPU cores?
>
> I think the idea is have the irq_affinity mask match the CPU mapping on
> the submission side context associated with that particular vector. If
> two identical adapters generate the same submission CPU mapping, I don't
> think we can do better than matching irq_affinity masks.

Has this been verified by measurements? Sorry but I'm not convinced that 
using the same mapping for multiple identical adapters instead of 
spreading interrupts will result in better performance.

Bart.
