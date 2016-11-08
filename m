Return-Path: <helgaas@kernel.org>
Date: Tue, 8 Nov 2016 15:17:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] pci/msi: Provide pci_alloc_irq_vectors_affinity()
Message-ID: <20161108211732.GC14322@bhelgaas-glaptop.roam.corp.google.com>
References: <1478544462-9549-1-git-send-email-hch@lst.de>
 <1478544462-9549-6-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478544462-9549-6-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Nov 07, 2016 at 10:47:40AM -0800, Christoph Hellwig wrote:
> From: Christogh Hellwig <hch@lst.de>

s/Christogh/Christoph/ (also below)

> This is a variant of pci_alloc_irq_vectors() that allows passing a
> struct irq_affinity to provide fine-grainded IRQ affinity control.

s/grainded/grained/

> For now this means being able to exclude vectors at the beginning or
> end of the MSI vector space, but it could also be used for any other
> quirks needed in the future (e.g. more vectors than CPUs, or exluding

s/exluding/excluding/

> CPUs from the spreading).
> 
> Signed-off-by: Christogh Hellwig <hch@lst.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> +int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
> +				   unsigned int max_vecs, unsigned int flags,
> +				   const struct irq_affinity *affd)

> +int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
> +				   unsigned int max_vecs, unsigned int flags,
> +				   const struct irq_affinity *affd);

> +static inline int
> +pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
> +			       unsigned int max_vecs, unsigned int flags,
> +			       const struct irq_affinity *aff_desc)

Maybe use the same formal parameter name as in the definition and
declaration above?
