Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn1on0072.outbound.protection.outlook.com ([157.56.110.72]:1296
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751907AbcFOThJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 15 Jun 2016 15:37:09 -0400
Subject: Re: [PATCH 02/13] irq: Introduce IRQD_AFFINITY_MANAGED flag
To: Keith Busch <keith.busch@intel.com>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-3-git-send-email-hch@lst.de>
 <0412b942-ea0d-d4eb-c724-8243d12ff6f3@sandisk.com>
 <20160615102311.GA16619@lst.de>
 <67ef7a1c-56e1-db2c-b038-f9784fc1f52f@sandisk.com>
 <20160615151415.GA1919@localhost.localdomain>
 <7f0b16bd-b39f-99e6-c1c1-6a508bf9bbbf@sandisk.com>
 <20160615160316.GB1919@localhost.localdomain>
CC: Christoph Hellwig <hch@lst.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"axboe@fb.com" <axboe@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <86aa652b-48d0-a7bb-683e-bf43939aa811@sandisk.com>
Date: Wed, 15 Jun 2016 21:36:54 +0200
MIME-Version: 1.0
In-Reply-To: <20160615160316.GB1919@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/15/2016 06:03 PM, Keith Busch wrote:
> On Wed, Jun 15, 2016 at 05:28:54PM +0200, Bart Van Assche wrote:
>> On 06/15/2016 05:14 PM, Keith Busch wrote:
>>> I think the idea is have the irq_affinity mask match the CPU mapping on
>>> the submission side context associated with that particular vector. If
>>> two identical adapters generate the same submission CPU mapping, I don't
>>> think we can do better than matching irq_affinity masks.
>>
>> Has this been verified by measurements? Sorry but I'm not convinced that
>> using the same mapping for multiple identical adapters instead of spreading
>> interrupts will result in better performance.
>
> The interrupts automatically spread based on which CPU submitted the
> work. If you want to spread interrupts across more CPUs, then you can
> spread submissions to the CPUs you want to service the interrupts.
>
> Completing work on the same CPU that submitted it is quickest with
> its cache hot access. I have equipment available to demo this. What
> affinty_mask policy would you like to see compared with the proposal?

Hello Keith,

Sorry that I had not yet this made this clear but my concern is about a 
system equipped with two or more adapters and with more CPU cores than 
the number of MSI-X interrupts per adapter. Consider e.g. a system with 
two adapters (A and B), 8 interrupts per adapter (A0..A7 and B0..B7), 32 
CPU cores and two NUMA nodes. Assuming that hyperthreading is disabled, 
will the patches from this patch series generate the following interrupt 
assignment?

0: A0 B0
1: A1 B1
2: A2 B2
3: A3 B3
4: A4 B4
5: A5 B5
6: A6 B6
7: A7 B7
8: (none)
...
31: (none)

The mapping I would like to see is as follows (assuming CPU cores 0..15 
correspond to NUMA node 0 and CPU cores 16..31 correspond to NUMA node 1):

0: A0
1: B0
2: (none)
3: (none)
4: A1
5: B1
6: (none)
7: (none)
8: A2
9: B2
10: (none)
11: (none)
12: A3
13: B3
14: (none)
15: (none)
...
31: (none)

Do you agree that - ignoring other interrupt assignments - that the 
latter interrupt assignment scheme would result in higher throughput and 
lower interrupt processing latency?

Thanks,

Bart.
