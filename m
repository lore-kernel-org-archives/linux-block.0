Return-Path: <helgaas@kernel.org>
Date: Thu, 1 Mar 2018 11:37:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
	Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Dan Williams <dan.j.williams@intel.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 01/10] PCI/P2PDMA: Support peer to peer memory
Message-ID: <20180301173752.GE13722@bhelgaas-glaptop.roam.corp.google.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180228234006.21093-2-logang@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

s/peer to peer/peer-to-peer/ to match text below and in spec.

On Wed, Feb 28, 2018 at 04:39:57PM -0700, Logan Gunthorpe wrote:
> Some PCI devices may have memory mapped in a BAR space that's
> intended for use in Peer-to-Peer transactions. In order to enable
> such transactions the memory must be registered with ZONE_DEVICE pages
> so it can be used by DMA interfaces in existing drivers.

s/Peer-to-Peer/peer-to-peer/ to match spec and typical usage.

Is there anything about this memory that makes it specifically
intended for peer-to-peer transactions?  I assume the device can't
really tell whether a transaction is from a CPU or a peer.

> A kernel interface is provided so that other subsystems can find and
> allocate chunks of P2P memory as necessary to facilitate transfers
> between two PCI peers. Depending on hardware, this may reduce the
> bandwidth of the transfer but would significantly reduce pressure
> on system memory. This may be desirable in many cases: for example a
> system could be designed with a small CPU connected to a PCI switch by a
> small number of lanes which would maximize the number of lanes available
> to connect to NVME devices.

"A kernel interface is provided" could mean "the kernel provides an
interface", independent of anything this patch does, but I think you
mean *this patch specifically* adds the interface.

Maybe something like:

  Add interfaces for other subsystems to find and allocate ...:

    int pci_p2pdma_add_client();
    struct pci_dev *pci_p2pmem_find();
    void *pci_alloc_p2pmem();

  This may reduce bandwidth of the transfer but significantly reduce
  ...

BTW, maybe there could be some kind of guide for device driver writers
in Documentation/PCI/?

> The interface requires a user driver to collect a list of client devices
> involved in the transaction with the pci_p2pmem_add_client*() functions
> then call pci_p2pmem_find() to obtain any suitable P2P memory. Once
> this is done the list is bound to the memory and the calling driver is
> free to add and remove clients as necessary. The ACS bits on the
> downstream switch port will be managed for all the registered clients.
> 
> The code is designed to only utilize the p2pmem device if all the devices
> involved in a transfer are behind the same PCI switch. This is because
> using P2P transactions through the PCI root complex can have performance
> limitations or, worse, might not work at all. Finding out how well a
> particular RC supports P2P transfers is non-trivial. Additionally, the
> benefits of P2P transfers that go through the RC is limited to only
> reducing DRAM usage.

I think it would be clearer and sufficient to simply say that we have
no way to know whether peer-to-peer routing between PCIe Root Ports is
supported (PCIe r4.0, sec 1.3.1).

The fact that you use the PCIe term "switch" suggests that a PCIe
Switch is required, but isn't it sufficient for the peers to be below
the same "PCI bridge", which would include PCIe Root Ports, PCIe
Switch Downstream Ports, and conventional PCI bridges?

The comments at get_upstream_bridge_port() suggest that this isn't
enough, and the peers actually do have to be below the same PCIe
Switch, but I don't know why.

> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 34b56a8f8480..840831418cbd 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -124,6 +124,22 @@ config PCI_PASID
>  
>  	  If unsure, say N.
>  
> +config PCI_P2PDMA
> +	bool "PCI Peer to Peer transfer support"
> +	depends on ZONE_DEVICE
> +	select GENERIC_ALLOCATOR
> +	help
> +	  Enableѕ drivers to do PCI peer to peer transactions to and from

s/peer to peer/peer-to-peer/ (in bool and help text)

> +	  BARs that are exposed in other devices that are the part of
> +	  the hierarchy where peer-to-peer DMA is guaranteed by the PCI
> +	  specification to work (ie. anything below a single PCI bridge).
> +
> +	  Many PCIe root complexes do not support P2P transactions and
> +	  it's hard to tell which support it with good performance, so
> +	  at this time you will need a PCIe switch.

Until we have a way to figure out which of them support P2P,
performance is a don't-care.

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> new file mode 100644
> index 000000000000..ec0a6cb9e500
> --- /dev/null
> +++ b/drivers/pci/p2pdma.c
> @@ -0,0 +1,568 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * PCI Peer 2 Peer DMA support.

s/Peer 2 Peer/peer-to-peer/

> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.

I think the SPDX tag is meant to remove the need for including the
license text, so you should be able to remove this.  Oh, and one
trivial and annoying nit, I think for the SPDX tag, we're supposed to
use "//" in .c files and "/* */" in .h files.

> + * pci_p2pdma_add_resource - add memory for use as p2p memory
> + * @pci: the device to add the memory to

s/@pci/@pdev/

> + * @bar: PCI BAR to add
> + * @size: size of the memory to add, may be zero to use the whole BAR
> + * @offset: offset into the PCI BAR
> + *
> + * The memory will be given ZONE_DEVICE struct pages so that it may
> + * be used with any dma request.

s/dma/DMA/

> +int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
> +			    u64 offset)
> +{
> +	struct dev_pagemap *pgmap;
> +	void *addr;
> +	int error;
> +
> +	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
> +		return -EINVAL;
> +
> +	if (offset >= pci_resource_len(pdev, bar))
> +		return -EINVAL;
> +
> +	if (!size)
> +		size = pci_resource_len(pdev, bar) - offset;
> +
> +	if (size + offset > pci_resource_len(pdev, bar))
> +		return -EINVAL;
> +
> +	if (!pdev->p2pdma) {
> +		error = pci_p2pdma_setup(pdev);
> +		if (error)
> +			return error;
> +	}
> +
> +	pgmap = devm_kzalloc(&pdev->dev, sizeof(*pgmap), GFP_KERNEL);
> +	if (!pgmap)
> +		return -ENOMEM;
> +
> +	pgmap->res.start = pci_resource_start(pdev, bar) + offset;
> +	pgmap->res.end = pgmap->res.start + size - 1;
> +	pgmap->res.flags = pci_resource_flags(pdev, bar);
> +	pgmap->ref = &pdev->p2pdma->devmap_ref;
> +	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
> +
> +	addr = devm_memremap_pages(&pdev->dev, pgmap);
> +	if (IS_ERR(addr))

Free pgmap here?  And in the other error case below?  Or maybe this
happens via the devm_* magic?  If so, when would that actually happen?
Would pgmap be effectively leaked until the pdev is destroyed?

> +		return PTR_ERR(addr);
> +
> +	error = gen_pool_add_virt(pdev->p2pdma->pool, (uintptr_t)addr,
> +			pci_bus_address(pdev, bar) + offset,
> +			resource_size(&pgmap->res), dev_to_node(&pdev->dev));
> +	if (error)
> +		return error;
> +
> +	error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_percpu_kill,
> +					  &pdev->p2pdma->devmap_ref);
> +	if (error)
> +		return error;
> +
> +	dev_info(&pdev->dev, "added peer-to-peer DMA memory %pR\n",
> +		 &pgmap->res);

s/dev_info/pci_info/ (also similar usages below, except for the one or
two cases where you don't have a pci_dev).

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_add_resource);

> + * If a device is behind a switch, we try to find the upstream bridge
> + * port of the switch. This requires two calls to pci_upstream_bridge:
> + * one for the upstream port on the switch, one on the upstream port
> + * for the next level in the hierarchy. Because of this, devices connected
> + * to the root port will be rejected.

s/pci_upstream_bridge/pci_upstream_bridge()/

This whole thing is confusing to me.  Why do you want to reject peers
directly connected to the same root port?  Why do you require the same
Switch Upstream Port?  You don't exclude conventional PCI, but it
looks like you would require peers to share *two* upstream PCI-to-PCI
bridges?  I would think a single shared upstream bridge (conventional,
PCIe Switch Downstream Port, or PCIe Root Port) would be sufficient?

Apologies if you've answered this before; maybe just include a little
explanation here so I don't ask again :)

> +static struct pci_dev *get_upstream_bridge_port(struct pci_dev *pdev)
> +{
> +	struct pci_dev *up1, *up2;
> +
> +	if (!pdev)
> +		return NULL;
> +
> +	up1 = pci_dev_get(pci_upstream_bridge(pdev));
> +	if (!up1)
> +		return NULL;
> +
> +	up2 = pci_dev_get(pci_upstream_bridge(up1));
> +	pci_dev_put(up1);
> +
> +	return up2;
> +}
> +
> +static bool __upstream_bridges_match(struct pci_dev *upstream,
> +				     struct pci_dev *client)
> +{
> +	struct pci_dev *dma_up;
> +	bool ret = true;
> +
> +	dma_up = get_upstream_bridge_port(client);
> +
> +	if (!dma_up) {
> +		dev_dbg(&client->dev, "not a PCI device behind a bridge\n");
> +		ret = false;
> +		goto out;
> +	}
> +
> +	if (upstream != dma_up) {
> +		dev_dbg(&client->dev,
> +			"does not reside on the same upstream bridge\n");
> +		ret = false;
> +		goto out;
> +	}
> +
> +out:
> +	pci_dev_put(dma_up);
> +	return ret;
> +}
> +
> +static bool upstream_bridges_match(struct pci_dev *pdev,
> +				   struct pci_dev *client)
> +{
> +	struct pci_dev *upstream;
> +	bool ret;
> +
> +	upstream = get_upstream_bridge_port(pdev);
> +	if (!upstream) {
> +		dev_warn(&pdev->dev, "not behind a PCI bridge\n");
> +		return false;
> +	}
> +
> +	ret = __upstream_bridges_match(upstream, client);
> +
> +	pci_dev_put(upstream);
> +
> +	return ret;
> +}
> +
> +struct pci_p2pdma_client {
> +	struct list_head list;
> +	struct pci_dev *client;
> +	struct pci_dev *p2pdma;

Maybe call this "peer" or something instead of "p2pdma", since p2pdma
is also used for struct pci_p2pdma things?

> + * pci_p2pdma_add_client - allocate a new element in a client device list
> + * @head: list head of p2pdma clients
> + * @dev: device to add to the list
> + *
> + * This adds @dev to a list of clients used by a p2pdma device.
> + * This list should be passed to p2pmem_find(). Once p2pmem_find() has
> + * been called successfully, the list will be bound to a specific p2pdma
> + * device and new clients can only be added to the list if they are
> + * supported by that p2pdma device.
> + *
> + * The caller is expected to have a lock which protects @head as necessary
> + * so that none of the pci_p2p functions can be called concurrently
> + * on that list.
> + *
> + * Returns 0 if the client was successfully added.
> + */
> +int pci_p2pdma_add_client(struct list_head *head, struct device *dev)
> +{
> +	struct pci_p2pdma_client *item, *new_item;
> +	struct pci_dev *p2pdma = NULL;
> +	struct pci_dev *client;
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_DMA_VIRT_OPS) && dev->dma_ops == &dma_virt_ops) {
> +		dev_warn(dev,
> +			 "cannot be used for peer-to-peer DMA because the driver makes use of dma_virt_ops\n");
> +		return -ENODEV;
> +	}
> +
> +
> +	client = find_parent_pci_dev(dev);

Since "pci_p2pdma_add_client()" includes "pci_" in its name, it seems
sort of weird that callers supply a non-PCI device and then we look up
a PCI device here.  I assume you have some reason for this; if you
added a writeup in Documentation/PCI, that would be a good place to
elaborate on that, maybe with a one-line clue here.

> +	if (!client) {
> +		dev_warn(dev,
> +			 "cannot be used for peer-to-peer DMA as it is not a PCI device\n");
> +		return -ENODEV;
> +	}
> +
> +	item = list_first_entry_or_null(head, struct pci_p2pdma_client, list);
> +	if (item && item->p2pdma) {
> +		p2pdma = item->p2pdma;
> +
> +		if (!upstream_bridges_match(p2pdma, client)) {
> +			ret = -EXDEV;
> +			goto put_client;
> +		}
> +	}
> +
> +	new_item = kzalloc(sizeof(*new_item), GFP_KERNEL);
> +	if (!new_item) {
> +		ret = -ENOMEM;
> +		goto put_client;
> +	}
> +
> +	new_item->client = client;
> +	new_item->p2pdma = pci_dev_get(p2pdma);
> +
> +	list_add_tail(&new_item->list, head);
> +
> +	return 0;
> +
> +put_client:
> +	pci_dev_put(client);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_add_client);

> + * pci_alloc_p2p_mem - allocate peer-to-peer DMA memory
> + * @pdev:	the device to allocate memory from
> + * @size:	number of bytes to allocate
> + *
> + * Returns the allocated memory or NULL on error.
> + */
> +void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
> +{
> +	void *ret;
> +
> +	if (unlikely(!pdev->p2pdma))

Is this a hot path?  I'm not sure it's worth cluttering
non-performance paths with likely/unlikely.

> +		return NULL;
> +
> +	if (unlikely(!percpu_ref_tryget_live(&pdev->p2pdma->devmap_ref)))
> +		return NULL;
> +
> +	ret = (void *)(uintptr_t)gen_pool_alloc(pdev->p2pdma->pool, size);

Why the double cast?  Wouldn't "(void *)" be sufficient?

> +	if (unlikely(!ret))
> +		percpu_ref_put(&pdev->p2pdma->devmap_ref);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_alloc_p2pmem);
> +
> +/**
> + * pci_free_p2pmem - allocate peer-to-peer DMA memory
> + * @pdev:	the device the memory was allocated from
> + * @addr:	address of the memory that was allocated
> + * @size:	number of bytes that was allocated
> + */
> +void pci_free_p2pmem(struct pci_dev *pdev, void *addr, size_t size)
> +{
> +	gen_pool_free(pdev->p2pdma->pool, (uintptr_t)addr, size);

In v4.6-rc1, gen_pool_free() takes "unsigned long addr".  I know this
is based on -rc3; is this something that changed between -rc1 and
-rc3?

> +	percpu_ref_put(&pdev->p2pdma->devmap_ref);
> +}
> +EXPORT_SYMBOL_GPL(pci_free_p2pmem);
> +
> +/**
> + * pci_virt_to_bus - return the PCI bus address for a given virtual
> + *	address obtained with pci_alloc_p2pmem

s/pci_alloc_p2pmem/pci_alloc_p2pmem()/

> + * @pdev:	the device the memory was allocated from
> + * @addr:	address of the memory that was allocated
> + */
> +pci_bus_addr_t pci_p2pmem_virt_to_bus(struct pci_dev *pdev, void *addr)
> +{
> +	if (!addr)
> +		return 0;
> +	if (!pdev->p2pdma)
> +		return 0;
> +
> +	/*
> +	 * Note: when we added the memory to the pool we used the PCI
> +	 * bus address as the physical address. So gen_pool_virt_to_phys()
> +	 * actually returns the bus address despite the misleading name.
> +	 */
> +	return gen_pool_virt_to_phys(pdev->p2pdma->pool, (unsigned long)addr);
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pmem_virt_to_bus);
> +
> +/**
> + * pci_p2pmem_alloc_sgl - allocate peer-to-peer DMA memory in an scatterlist

s/an scatterlist/a scatterlist/

> + * @pdev:	the device to allocate memory from
> + * @sgl:	the allocated scatterlist
> + * @nents:      the number of SG entries in the list
> + * @length:     number of bytes to allocate
> + *
> + * Returns 0 on success
> + */
> +int pci_p2pmem_alloc_sgl(struct pci_dev *pdev, struct scatterlist **sgl,
> +			 unsigned int *nents, u32 length)
> +{
> +	struct scatterlist *sg;
> +	void *addr;
> +
> +	sg = kzalloc(sizeof(*sg), GFP_KERNEL);
> +	if (!sg)
> +		return -ENOMEM;
> +
> +	sg_init_table(sg, 1);
> +
> +	addr = pci_alloc_p2pmem(pdev, length);
> +	if (!addr)
> +		goto out_free_sg;
> +
> +	sg_set_buf(sg, addr, length);
> +	*sgl = sg;
> +	*nents = 1;
> +	return 0;
> +
> +out_free_sg:
> +	kfree(sg);
> +	return -ENOMEM;
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pmem_alloc_sgl);
> +
> +/**
> + * pci_p2pmem_free_sgl - free a scatterlist  allocated by pci_p2pmem_alloc_sgl

s/  allocated/ allocated/ (remove extra space)
s/pci_p2pmem_alloc_sgl/pci_p2pmem_alloc_sgl()/

> + * @pdev:	the device to allocate memory from
> + * @sgl:	the allocated scatterlist
> + * @nents:      the number of SG entries in the list
> + */
> +void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl,
> +			 unsigned int nents)
> +{
> +	struct scatterlist *sg;
> +	int count;
> +
> +	if (!sgl || !nents)
> +		return;
> +
> +	for_each_sg(sgl, sg, nents, count)
> +		pci_free_p2pmem(pdev, sg_virt(sg), sg->length);
> +	kfree(sgl);
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pmem_free_sgl);
> +
> +/**
> + * pci_p2pmem_publish - publish the peer-to-peer DMA memory for use by
> + *	other devices with pci_p2pmem_find

s/pci_p2pmem_find/pci_p2pmem_find()/

> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> new file mode 100644
> index 000000000000..c0dde3d3aac4
> --- /dev/null
> +++ b/include/linux/pci-p2pdma.h
> @@ -0,0 +1,87 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2016-2017, Microsemi Corporation
> + * Copyright (c) 2017, Christoph Hellwig.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.

Remove license text.
