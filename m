Return-Path: <jthumshirn@suse.de>
Date: Tue, 8 Nov 2016 09:19:17 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] genirq/affinity: Introduce struct irq_affinity
Message-ID: <20161108081917.xgakcmof2koldr6n@linux-x5ow.site>
References: <1478544462-9549-1-git-send-email-hch@lst.de>
 <1478544462-9549-2-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1478544462-9549-2-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Nov 07, 2016 at 10:47:36AM -0800, Christoph Hellwig wrote:
> From: Christogh Hellwig <hch@lst.de>
> 
> Some drivers (various network and RDMA adapter for example) have a MSI-X
> vector layout where most of the vectors are used for I/O queues and should
> have CPU affinity assigned to them, but some (usually 1 but sometimes more)
> at the beginning or end are used for low-performance admin or configuration
> work and should not have any explicit affinity assigned to them.
> 
> This adds a new irq_affinity structure, which will be passed through a
> variant of pci_irq_alloc_vectors that allows to specify these
> requirements (and is extensible to any future quirks in that area) so that
> the core IRQ affinity algorithm can take this quirks into account.
> 
> Signed-off-by: Christogh Hellwig <hch@lst.de>
> ---

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
