Return-Path: <helgaas@kernel.org>
Date: Mon, 7 May 2018 18:00:34 -0500
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
	Alex Williamson <alex.williamson@redhat.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v4 01/14] PCI/P2PDMA: Support peer-to-peer memory
Message-ID: <20180507230034.GE161390@bhelgaas-glaptop.roam.corp.google.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180423233046.21476-2-logang@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 23, 2018 at 05:30:33PM -0600, Logan Gunthorpe wrote:
> Some PCI devices may have memory mapped in a BAR space that's
> intended for use in peer-to-peer transactions. In order to enable
> such transactions the memory must be registered with ZONE_DEVICE pages
> so it can be used by DMA interfaces in existing drivers.
> 
> Add an interface for other subsystems to find and allocate chunks of P2P
> memory as necessary to facilitate transfers between two PCI peers:
> 
> int pci_p2pdma_add_client();
> struct pci_dev *pci_p2pmem_find();
> void *pci_alloc_p2pmem();
> 
> The new interface requires a driver to collect a list of client devices
> involved in the transaction with the pci_p2pmem_add_client*() functions
> then call pci_p2pmem_find() to obtain any suitable P2P memory. Once
> this is done the list is bound to the memory and the calling driver is
> free to add and remove clients as necessary (adding incompatible clients
> will fail). With a suitable p2pmem device, memory can then be
> allocated with pci_alloc_p2pmem() for use in DMA transactions.
> 
> Depending on hardware, using peer-to-peer memory may reduce the bandwidth
> of the transfer but can significantly reduce pressure on system memory.
> This may be desirable in many cases: for example a system could be designed
> with a small CPU connected to a PCI switch by a small number of lanes

s/PCI/PCIe/

> which would maximize the number of lanes available to connect to NVMe
> devices.
> 
> The code is designed to only utilize the p2pmem device if all the devices
> involved in a transfer are behind the same root port (typically through

s/root port/PCI bridge/

> a network of PCIe switches). This is because we have no way of knowing
> whether peer-to-peer routing between PCIe Root Ports is supported
> (PCIe r4.0, sec 1.3.1).  Additionally, the benefits of P2P transfers that
> go through the RC is limited to only reducing DRAM usage and, in some
> cases, coding convenience. The PCI-SIG may be exploring adding a new
> capability bit to advertise whether this is possible for future
> hardware.
> 
> This commit includes significant rework and feedback from Christoph
> Hellwig.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/Kconfig        |  17 ++
>  drivers/pci/Makefile       |   1 +
>  drivers/pci/p2pdma.c       | 694 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/memremap.h   |  18 ++
>  include/linux/pci-p2pdma.h | 100 +++++++
>  include/linux/pci.h        |   4 +
>  6 files changed, 834 insertions(+)
>  create mode 100644 drivers/pci/p2pdma.c
>  create mode 100644 include/linux/pci-p2pdma.h
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 34b56a8f8480..b2396c22b53e 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -124,6 +124,23 @@ config PCI_PASID
>  
>  	  If unsure, say N.
>  
> +config PCI_P2PDMA
> +	bool "PCI peer-to-peer transfer support"
> +	depends on PCI && ZONE_DEVICE && EXPERT
> +	select GENERIC_ALLOCATOR
> +	help
> +	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
> +	  BARs that are exposed in other devices that are the part of
> +	  the hierarchy where peer-to-peer DMA is guaranteed by the PCI
> +	  specification to work (ie. anything below a single PCI bridge).
> +
> +	  Many PCIe root complexes do not support P2P transactions and
> +	  it's hard to tell which support it at all, so at this time, DMA
> +	  transations must be between devices behind the same root port.

s/DMA transactions/PCIe DMA transactions/

(Theoretically P2P should work on conventional PCI, and this sentence only
applies to PCIe.)

> +	  (Typically behind a network of PCIe switches).

Not sure this last sentence adds useful information.

> +++ b/drivers/pci/p2pdma.c
> @@ -0,0 +1,694 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCI Peer 2 Peer DMA support.
> + *
> + * Copyright (c) 2016-2018, Logan Gunthorpe
> + * Copyright (c) 2016-2017, Microsemi Corporation
> + * Copyright (c) 2017, Christoph Hellwig
> + * Copyright (c) 2018, Eideticom Inc.
> + *

Nit: unnecessary blank line.

> +/*
> + * If a device is behind a switch, we try to find the upstream bridge
> + * port of the switch. This requires two calls to pci_upstream_bridge():
> + * one for the upstream port on the switch, one on the upstream port
> + * for the next level in the hierarchy. Because of this, devices connected
> + * to the root port will be rejected.
> + */
> +static struct pci_dev *get_upstream_bridge_port(struct pci_dev *pdev)

This function doesn't seem to be used anymore.  Thanks for all your hard
work to get rid of it!

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
> +/*
> + * Find the distance through the nearest common upstream bridge between
> + * two PCI devices.
> + *
> + * If the two devices are the same device then 0 will be returned.
> + *
> + * If there are two virtual functions of the same device behind the same
> + * bridge port then 2 will be returned (one step down to the bridge then

s/bridge/PCIe switch/

> + * one step back to the same device).
> + *
> + * In the case where two devices are connected to the same PCIe switch, the
> + * value 4 will be returned. This corresponds to the following PCI tree:
> + *
> + *     -+  Root Port
> + *      \+ Switch Upstream Port
> + *       +-+ Switch Downstream Port
> + *       + \- Device A
> + *       \-+ Switch Downstream Port
> + *         \- Device B
> + *
> + * The distance is 4 because we traverse from Device A through the downstream
> + * port of the switch, to the common upstream port, back up to the second
> + * downstream port and then to Device B.
> + *
> + * Any two devices that don't have a common upstream bridge will return -1.
> + * In this way devices on seperate root ports will be rejected, which

s/seperate/separate/
s/root port/PCIe root ports/
(Again, since P2P should work on conventional PCI)

> + * is what we want for peer-to-peer seeing there's no way to determine
> + * if the root complex supports forwarding between root ports.

s/seeing there's no way.../
  seeing each PCIe root port defines a separate hierarchy domain and
  there's no way to determine whether the root complex supports forwarding
  between them./

> + *
> + * In the case where two devices are connected to different PCIe switches
> + * this function will still return a positive distance as long as both
> + * switches evenutally have a common upstream bridge. Note this covers
> + * the case of using multiple PCIe switches to achieve a desired level of
> + * fan-out from a root port. The exact distance will be a function of the
> + * number of switches between Device A and Device B.
> + *

Nit: unnecessary blank line.

> + */
> +static int upstream_bridge_distance(struct pci_dev *a, > +				    struct pci_dev *b)
