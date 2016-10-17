Return-Path: <jthumshirn@suse.de>
Date: Mon, 17 Oct 2016 09:34:28 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: martin.petersen@oracle.com, don.brace@microsemi.com, axboe@kernel.dk,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] smartpqi: switch to pci_alloc_irq_vectors
Message-ID: <20161017073428.27xzw6du4j3r4qro@linux-x5ow.site>
References: <1476521241-32765-1-git-send-email-hch@lst.de>
 <1476521241-32765-4-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1476521241-32765-4-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Sat, Oct 15, 2016 at 10:47:21AM +0200, Christoph Hellwig wrote:
> Which cleans up a lot of the MSI-X handling, and allows us to use the
> PCI IRQ layer provided vector mapping, which we can then expose to blk-mq.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
