Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Tue, 21 Jun 2016 16:31:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH 02/13] irq: Introduce IRQD_AFFINITY_MANAGED flag
Message-ID: <20160621143120.GA4104@lst.de>
References: <20160615102311.GA16619@lst.de>
 <67ef7a1c-56e1-db2c-b038-f9784fc1f52f@sandisk.com>
 <20160615151415.GA1919@localhost.localdomain>
 <7f0b16bd-b39f-99e6-c1c1-6a508bf9bbbf@sandisk.com>
 <20160615160316.GB1919@localhost.localdomain>
 <86aa652b-48d0-a7bb-683e-bf43939aa811@sandisk.com>
 <20160616152006.GA13615@lst.de>
 <f22e87c1-6875-9a59-94db-42a6f71663b8@sandisk.com>
 <20160620122219.GA29059@lst.de>
 <066e6b9d-34a8-5917-4ad8-cb466d3389c3@sandisk.com>
MIME-Version: 1.0
In-Reply-To: <066e6b9d-34a8-5917-4ad8-cb466d3389c3@sandisk.com>
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

On Mon, Jun 20, 2016 at 03:21:47PM +0200, Bart Van Assche wrote:
> A notification mechanism that reports interrupt mapping changes will 
> definitely help. What would also help is an API that allows drivers to 
> query the MSI-X IRQ of an adapter that is nearest given a cpumask, e.g. 
> hctx->cpumask.

This is still the wrong way around - we need to build the blk-mq queue
mappings based on the interrupts, not the other way around.

> Another function can then map that IRQ into an index in the 
> range 0..n-1 where n is the number of MSI-X interrupts for that adapter. 
> Every blk-mq/scsi-mq driver will need this functionality to decide which 
> IRQ to associate with a block layer hctx.

This is something that should be done in commmon code and is done in
common code in this series - the driver passes a cpumask to blk-mq,
and blk-mq creates a queue for every cpu that is set in the cpumask.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
