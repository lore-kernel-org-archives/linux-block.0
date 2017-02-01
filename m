Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:34052 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751420AbdBAJek (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Feb 2017 04:34:40 -0500
Date: Wed, 1 Feb 2017 10:34:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Shaohua Li <shli@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        hch@lst.de, axboe@fb.com
Subject: Re: [PATCH 2/2] nvme: allocate nvme_queue in correct node
Message-ID: <20170201093437.GB1189@lst.de>
References: <1c91ab2c0073598592f66f007ff72cfa58a17a54.1485922654.git.shli@fb.com> <7119c172f8916bd21aeffc006b04cd73281afb25.1485922654.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7119c172f8916bd21aeffc006b04cd73281afb25.1485922654.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> +		mask = pci_irq_get_affinity(to_pci_dev(dev->dev), i);
> +		if (mask) {
> +			node = cpu_to_node(cpumask_first(mask));
> +			node = local_memory_node(node);
> +		}

Can you move this to a PCI-layer helper, e.g. something like:

int pci_irq_get_node(struct pci_dev *dev, unsigned vec)
{
	const struct cpumask *mask = pci_irq_get_affinity(dev), i);
	if (mask)
		return local_memory_node(cpu_to_node(cpumask_first(mask)));
	return dev_to_node(&dev->dev);
}

Otherwise this looks fine.
