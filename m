Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bl2on0076.outbound.protection.outlook.com ([65.55.169.76]:11663
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751061AbcFOUvH (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 15 Jun 2016 16:51:07 -0400
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
 <86aa652b-48d0-a7bb-683e-bf43939aa811@sandisk.com>
 <20160615200655.GB7637@localhost.localdomain>
 <20160615201213.GC7637@localhost.localdomain>
CC: Christoph Hellwig <hch@lst.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"axboe@fb.com" <axboe@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <7a61fe73-2808-70b4-e3b2-b6a924559d9d@sandisk.com>
Date: Wed, 15 Jun 2016 22:50:53 +0200
MIME-Version: 1.0
In-Reply-To: <20160615201213.GC7637@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/15/2016 10:12 PM, Keith Busch wrote:
> On Wed, Jun 15, 2016 at 04:06:55PM -0400, Keith Busch wrote:
>>>
>>> 0: A0 B0
>>> 1: A1 B1
>>> 2: A2 B2
>>> 3: A3 B3
>>> 4: A4 B4
>>> 5: A5 B5
>>> 6: A6 B6
>>> 7: A7 B7
>>> 8: (none)
>>> ...
>>> 31: (none)
>>
>> I'll need to look at the follow on patches do to confirm, but that's
>> not what this should do. All CPU's should have a vector assigned because
>> every CPU needs to be assigned a submission context using a vector. In
>> your example, every vector's affinity mask should be assigned to 4 CPUs:
>> vector '8' starts over with A0 B0, '9' gets A1 B1, and so on.
>
>   ^^^^^^
>
> Sorry, I meant "CPU '8'", not "vector '8'".

Hello Keith,

Does it matter on x86 systems whether or not these interrupt vectors are 
also associated with a CPU with a higher CPU number? Although multiple 
bits can be set in /proc/irq/<n>/smp_affinity only the first bit counts 
on x86 platforms. In default_cpu_mask_to_apicid_and() it is easy to see 
that only the first bit that has been set in that mask counts on x86 
systems.

Bart.
