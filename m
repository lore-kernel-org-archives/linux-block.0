Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bl2on0081.outbound.protection.outlook.com ([65.55.169.81]:50048
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753840AbcFPPjX (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 16 Jun 2016 11:39:23 -0400
Subject: Re: [PATCH 02/13] irq: Introduce IRQD_AFFINITY_MANAGED flag
To: Christoph Hellwig <hch@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-3-git-send-email-hch@lst.de>
 <0412b942-ea0d-d4eb-c724-8243d12ff6f3@sandisk.com>
 <20160615102311.GA16619@lst.de>
 <67ef7a1c-56e1-db2c-b038-f9784fc1f52f@sandisk.com>
 <20160615151415.GA1919@localhost.localdomain>
 <7f0b16bd-b39f-99e6-c1c1-6a508bf9bbbf@sandisk.com>
 <20160615160316.GB1919@localhost.localdomain>
 <86aa652b-48d0-a7bb-683e-bf43939aa811@sandisk.com>
 <20160616152006.GA13615@lst.de>
CC: Keith Busch <keith.busch@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"axboe@fb.com" <axboe@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <f22e87c1-6875-9a59-94db-42a6f71663b8@sandisk.com>
Date: Thu, 16 Jun 2016 17:39:07 +0200
MIME-Version: 1.0
In-Reply-To: <20160616152006.GA13615@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/16/2016 05:20 PM, Christoph Hellwig wrote:
> On Wed, Jun 15, 2016 at 09:36:54PM +0200, Bart Van Assche wrote:
>> Do you agree that - ignoring other interrupt assignments - that the latter
>> interrupt assignment scheme would result in higher throughput and lower
>> interrupt processing latency?
>
> Probably.  Once we've got it in the core IRQ code we can tweak the
> algorithm to be optimal.

Sorry but I'm afraid that we are embedding policy in the kernel, 
something we should not do. I know that there are workloads for which 
dedicating some CPU cores to interrupt processing and other CPU cores to 
running kernel threads improves throughput, probably because this 
results in less cache eviction on the CPU cores that run kernel threads 
and some degree of interrupt coalescing on the CPU cores that process 
interrupts. My concern is that I doubt that there is an interrupt 
assignment scheme that works optimally for all workloads. Hence my 
request to preserve the ability to modify interrupt affinity from user 
space.

Bart.
