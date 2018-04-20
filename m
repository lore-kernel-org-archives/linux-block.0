Return-Path: <linux-ide-owner@vger.kernel.org>
Date: Fri, 20 Apr 2018 13:42:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/12] PCI: remove CONFIG_PCI_BUS_ADDR_T_64BIT
Message-ID: <20180420184214.GT28657@bhelgaas-glaptop.roam.corp.google.com>
References: <20180415145947.1248-1-hch@lst.de>
 <20180415145947.1248-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180415145947.1248-10-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Sun, Apr 15, 2018 at 04:59:44PM +0200, Christoph Hellwig wrote:
> This symbol is now always identical to CONFIG_ARCH_DMA_ADDR_T_64BIT, so
> remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Please merge this along with the rest of the series; let me know if you
need anything more from me.

> ---
>  drivers/pci/Kconfig | 4 ----
>  drivers/pci/bus.c   | 4 ++--
>  include/linux/pci.h | 2 +-
>  3 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 34b56a8f8480..29a487f31dae 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -5,10 +5,6 @@
>  
>  source "drivers/pci/pcie/Kconfig"
>  
> -config PCI_BUS_ADDR_T_64BIT
> -	def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT)
> -	depends on PCI
> -
>  config PCI_MSI
>  	bool "Message Signaled Interrupts (MSI and MSI-X)"
>  	depends on PCI
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index bc2ded4c451f..35b7fc87eac5 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -120,7 +120,7 @@ int devm_request_pci_bus_resources(struct device *dev,
>  EXPORT_SYMBOL_GPL(devm_request_pci_bus_resources);
>  
>  static struct pci_bus_region pci_32_bit = {0, 0xffffffffULL};
> -#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>  static struct pci_bus_region pci_64_bit = {0,
>  				(pci_bus_addr_t) 0xffffffffffffffffULL};
>  static struct pci_bus_region pci_high = {(pci_bus_addr_t) 0x100000000ULL,
> @@ -230,7 +230,7 @@ int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
>  					  resource_size_t),
>  		void *alignf_data)
>  {
> -#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>  	int rc;
>  
>  	if (res->flags & IORESOURCE_MEM_64) {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 73178a2fcee0..55371cb827ad 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -670,7 +670,7 @@ int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
>  int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
>  		  int reg, int len, u32 val);
>  
> -#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>  typedef u64 pci_bus_addr_t;
>  #else
>  typedef u32 pci_bus_addr_t;
> -- 
> 2.17.0
> 
