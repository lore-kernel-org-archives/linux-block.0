Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751322AbdBXWg1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Feb 2017 17:36:27 -0500
Date: Fri, 24 Feb 2017 16:29:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        bhelgaas@google.com, hch@lst.de, axboe@fb.com
Subject: Re: [PATCH V2 2/3] PCI: add an API to get node from vector
Message-ID: <20170224222943.GB26430@bhelgaas-glaptop.roam.corp.google.com>
References: <a52afb3e09691267f2240331ef0b9962f793703d.1485971427.git.shli@fb.com>
 <d0f9b1bda8c27f058c95f88015e013b9d8131dc0.1485971427.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d0f9b1bda8c27f058c95f88015e013b9d8131dc0.1485971427.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Feb 01, 2017 at 09:53:15AM -0800, Shaohua Li wrote:
> Next patch will use the API to get the node from vector for nvme device
> 
> Signed-off-by: Shaohua Li <shli@fb.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Sorry I missed this; I normally work from the linux-pci patchwork, and
this didn't show up there because it wasn't cc'd to linux-pci.  But I
should have noticed anyway.

> ---
>  drivers/pci/msi.c   | 16 ++++++++++++++++
>  include/linux/pci.h |  6 ++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 50c5003..ab7aee7 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1313,6 +1313,22 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
>  }
>  EXPORT_SYMBOL(pci_irq_get_affinity);
>  
> +/**
> + * pci_irq_get_node - return the numa node of a particular msi vector
> + * @pdev:	PCI device to operate on
> + * @vec:	device-relative interrupt vector index (0-based).
> + */
> +int pci_irq_get_node(struct pci_dev *pdev, int vec)
> +{
> +	const struct cpumask *mask;
> +
> +	mask = pci_irq_get_affinity(pdev, vec);
> +	if (mask)
> +		return local_memory_node(cpu_to_node(cpumask_first(mask)));
> +	return dev_to_node(&pdev->dev);
> +}
> +EXPORT_SYMBOL(pci_irq_get_node);
> +
>  struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
>  {
>  	return to_pci_dev(desc->dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e2d1a12..df2c649 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1334,6 +1334,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  void pci_free_irq_vectors(struct pci_dev *dev);
>  int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
>  const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
> +int pci_irq_get_node(struct pci_dev *pdev, int vec);
>  
>  #else
>  static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
> @@ -1384,6 +1385,11 @@ static inline const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev,
>  {
>  	return cpu_possible_mask;
>  }
> +
> +static inline int pci_irq_get_node(struct pci_dev *pdev, int vec)
> +{
> +	return first_online_node;
> +}
>  #endif
>  
>  static inline int
> -- 
> 2.9.3
> 
