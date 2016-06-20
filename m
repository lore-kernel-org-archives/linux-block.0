Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Mon, 20 Jun 2016 14:22:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH 02/13] irq: Introduce IRQD_AFFINITY_MANAGED flag
Message-ID: <20160620122219.GA29059@lst.de>
References: <1465934346-20648-3-git-send-email-hch@lst.de>
 <0412b942-ea0d-d4eb-c724-8243d12ff6f3@sandisk.com>
 <20160615102311.GA16619@lst.de>
 <67ef7a1c-56e1-db2c-b038-f9784fc1f52f@sandisk.com>
 <20160615151415.GA1919@localhost.localdomain>
 <7f0b16bd-b39f-99e6-c1c1-6a508bf9bbbf@sandisk.com>
 <20160615160316.GB1919@localhost.localdomain>
 <86aa652b-48d0-a7bb-683e-bf43939aa811@sandisk.com>
 <20160616152006.GA13615@lst.de>
 <f22e87c1-6875-9a59-94db-42a6f71663b8@sandisk.com>
MIME-Version: 1.0
In-Reply-To: <f22e87c1-6875-9a59-94db-42a6f71663b8@sandisk.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "axboe@fb.com" <axboe@fb.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@intel.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 16, 2016 at 05:39:07PM +0200, Bart Van Assche wrote:
> On 06/16/2016 05:20 PM, Christoph Hellwig wrote:
>> On Wed, Jun 15, 2016 at 09:36:54PM +0200, Bart Van Assche wrote:
>>> Do you agree that - ignoring other interrupt assignments - that the latter
>>> interrupt assignment scheme would result in higher throughput and lower
>>> interrupt processing latency?
>>
>> Probably.  Once we've got it in the core IRQ code we can tweak the
>> algorithm to be optimal.
>
> Sorry but I'm afraid that we are embedding policy in the kernel, something 
> we should not do. I know that there are workloads for which dedicating some 
> CPU cores to interrupt processing and other CPU cores to running kernel 
> threads improves throughput, probably because this results in less cache 
> eviction on the CPU cores that run kernel threads and some degree of 
> interrupt coalescing on the CPU cores that process interrupts.

And you can still easily set this use case up by chosing less queues
(aka interrupts) than CPUs and assining your workload to the other
cores.

> My concern 
> is that I doubt that there is an interrupt assignment scheme that works 
> optimally for all workloads. Hence my request to preserve the ability to 
> modify interrupt affinity from user space.

I'd say let's do such an interface incrementall based on the use
case - especially after we get networking over to use common code
to distribute the interrupts.  If you were doing something like this
with the current blk-mq code it wouldn't work very well due to the
fact that you'd have a mismatch between the assigned interrupt and
the blk-mq queue mapping anyway.

It might be a good idea to start brainstorming how we'd want to handle
this change - we'd basically need a per-device notification that the
interrupt mapping changes so that we can rebuild the queue mapping,
which is somewhat similar to the lib/cpu_rmap.c code used by a few
networking drivers.  This would also help with dealing with cpu
hotplug events that change the cpu mapping.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
