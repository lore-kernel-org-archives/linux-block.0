Return-Path: <jthumshirn@suse.de>
Date: Tue, 8 Nov 2016 09:27:02 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] pci/msi: Provide pci_alloc_irq_vectors_affinity()
Message-ID: <20161108082702.jzxyczz5qeyvn7dk@linux-x5ow.site>
References: <1478544462-9549-1-git-send-email-hch@lst.de>
 <1478544462-9549-6-git-send-email-hch@lst.de>
 <7cf222db-cb37-9ef3-29bf-00f36663ea6d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <7cf222db-cb37-9ef3-29bf-00f36663ea6d@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 08, 2016 at 09:17:33AM +0100, Hannes Reinecke wrote:
> On 11/07/2016 07:47 PM, Christoph Hellwig wrote:
> > From: Christogh Hellwig <hch@lst.de>
> > 
> > This is a variant of pci_alloc_irq_vectors() that allows passing a
> > struct irq_affinity to provide fine-grainded IRQ affinity control.
> > For now this means being able to exclude vectors at the beginning or
> > end of the MSI vector space, but it could also be used for any other
> > quirks needed in the future (e.g. more vectors than CPUs, or exluding
> > CPUs from the spreading).
> > 
> > Signed-off-by: Christogh Hellwig <hch@lst.de>
> > ---

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
