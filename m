Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:41316 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932396AbeDWUKH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Apr 2018 16:10:07 -0400
Date: Mon, 23 Apr 2018 16:09:30 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>, sstabellini@kernel.org
Cc: iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/12] arm: don't build swiotlb by default
Message-ID: <20180423200930.GB5215@char.us.oracle.com>
References: <20180423170419.20330-1-hch@lst.de>
 <20180423170419.20330-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180423170419.20330-11-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Apr 23, 2018 at 07:04:17PM +0200, Christoph Hellwig wrote:
> swiotlb is only used as a library of helper for xen-swiotlb if Xen support
> is enabled on arm, so don't build it by default.
> 

CCing Stefano
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index aa1c187d756d..90b81a3a28a7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1774,7 +1774,7 @@ config SECCOMP
>  	  defined by each seccomp mode.
>  
>  config SWIOTLB
> -	def_bool y
> +	bool
>  
>  config PARAVIRT
>  	bool "Enable paravirtualization code"
> @@ -1807,6 +1807,7 @@ config XEN
>  	depends on MMU
>  	select ARCH_DMA_ADDR_T_64BIT
>  	select ARM_PSCI
> +	select SWIOTLB
>  	select SWIOTLB_XEN
>  	select PARAVIRT
>  	help
> -- 
> 2.17.0
> 
