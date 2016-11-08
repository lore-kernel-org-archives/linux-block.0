Return-Path: <hch@lst.de>
Date: Tue, 8 Nov 2016 23:30:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] genirq/affinity: Introduce struct irq_affinity
Message-ID: <20161108223056.GA26112@lst.de>
References: <1478544462-9549-1-git-send-email-hch@lst.de> <1478544462-9549-2-git-send-email-hch@lst.de> <20161108212526.GF14322@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161108212526.GF14322@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 08, 2016 at 03:25:27PM -0600, Bjorn Helgaas wrote:
> What tree would you prefer?  I vote for the IRQ tree since that seems
> to be where the interesting parts are, and I think I acked all the PCI
> bits.

Yes, that would be my preference to.

> 
> > + * struct irq_affinity - Description for auto irq affinity assignements
> > + * @pre_vectors:	Reserved vectors at the beginning of the MSIX
> > + *			vector space
> > + * @post_vectors:	Reserved vectors at the end of the MSIX
> > + *			vector space
> 
> Maybe include something more informative than just "reserved", e.g.,
> "Don't apply affinity to @pre_vectors at beginning of MSI-X vector
> space" or "Vectors at beginning of MSI-X vector space that are exempt
> from affinity"?

Sure.
