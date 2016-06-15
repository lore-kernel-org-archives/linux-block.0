Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: Re: [PATCH 02/13] irq: Introduce IRQD_AFFINITY_MANAGED flag
To: Christoph Hellwig <hch@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-3-git-send-email-hch@lst.de>
 <0412b942-ea0d-d4eb-c724-8243d12ff6f3@sandisk.com>
 <20160615102311.GA16619@lst.de>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <67ef7a1c-56e1-db2c-b038-f9784fc1f52f@sandisk.com>
Date: Wed, 15 Jun 2016 12:42:53 +0200
MIME-Version: 1.0
In-Reply-To: <20160615102311.GA16619@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "tglx@linutronix.de" <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On 06/15/2016 12:23 PM, Christoph Hellwig wrote:
> Hi Bart,
>
> On Wed, Jun 15, 2016 at 10:44:37AM +0200, Bart Van Assche wrote:
>> However, is excluding these interrupts from irqbalanced really the
>> way to go?
>
> What positive effect will irqbalanced have on explcititly spread
> interrupts?
>
>> Suppose e.g. that a system is equipped with two RDMA adapters,
>> that these adapters are used by a blk-mq enabled block initiator driver and
>> that each adapter supports eight MSI-X vectors. Should the interrupts of
>> the two RDMA adapters be assigned to different CPU cores? If so, which
>> software layer should realize this? The kernel or user space?
>
> RDMA should eventually use the interrupt spreading implemented in this
> series, as should networking (RDMA actually is on my near term todo list).
>
> RDMA block protocols will then pick up the queue information from the
> HCA driver.  I've not actually implemented this yet, but my current idea
> is:
>
>  - the HCA drivers are switch to use pci_alloc_irq_vectors to spread
>    their interrupt vectors around the system
>  - the HCA drivers will expose the irq_affinity affinity array
>    in struct ib_device (we'll need to consider what do about the
>    odd completion vectors instead of irq terminology in the RDMA stack,
>    but that's not a show stopper)
>  - multiqueue aware block drivers will then feed the irq_affinity
>    cpumask from the hca driver to blk-mq.  We'll also need to ensure
>    the number of protocol queues aligns nicely to the number of hardware
>    queues.  My current thinking is that they should be the same or
>    a fraction of the hardware completion queues, but this might need
>    some careful benchmarking.

Hello Christoph,

Today irqbalanced is responsible for deciding how to assign interrupts 
from different adapters to CPU cores. Does the above mean that for 
adapters that support multiple MSI-X interrupts the kernel will have 
full responsibility for assigning interrupt vectors to CPU cores?

If two identical adapters are present in a system, will these generate 
the same irq_affinity mask? Do you agree that interrupt vectors from 
different adapters should be assigned to different CPU cores if enough 
CPU cores are available? If so, which software layer will assign 
interrupt vectors from different adapters to different CPU cores?

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
