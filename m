Return-Path: <jthumshirn@suse.de>
Date: Tue, 8 Nov 2016 09:24:42 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] pci/msi: Propagate irq affinity description through
 the MSI code
Message-ID: <20161108082442.o42kmlyvsizvayk2@linux-x5ow.site>
References: <1478544462-9549-1-git-send-email-hch@lst.de>
 <1478544462-9549-5-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1478544462-9549-5-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Nov 07, 2016 at 10:47:39AM -0800, Christoph Hellwig wrote:
> From: Christogh Hellwig <hch@lst.de>
> 
> No API change yet, just pass it down all the way from
> pci_alloc_irq_vectors to the core MSI code.
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
