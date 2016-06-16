Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: Re: automatic interrupt affinity for MSI/MSI-X capable devices V2
To: Christoph Hellwig <hch@lst.de>, <tglx@linutronix.de>, <axboe@fb.com>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <b8cdfc80-fa77-b7cc-69b8-fb6037114087@sandisk.com>
Date: Thu, 16 Jun 2016 11:45:55 +0200
MIME-Version: 1.0
In-Reply-To: <1465934346-20648-1-git-send-email-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On 06/14/2016 09:58 PM, Christoph Hellwig wrote:
> This series enhances the irq and PCI code to allow spreading around MSI and
> MSI-X vectors so that they have per-cpu affinity if possible, or at least
> per-node.  For that it takes the algorithm from blk-mq, moves it to
> a common place, and makes it available through a vastly simplified PCI
> interrupt allocation API.  It then switches blk-mq to be able to pick up
> the queue mapping from the device if available, and demonstrates all this
> using the NVMe driver.

Hello Christoph,

Is my interpretation correct that for an adapter that supports two 
interrupts and on a system with eight CPU cores and no hyperthreading 
this patch series will assign interrupt vector 0 to CPU 0 and interrupt 
vector 1 to CPU 1? Are you aware that drivers like ib_srp assume that 
interrupts have been spread evenly, that means assigning vector 0 to CPU 
0 and vector 1 to CPU 4?

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
