Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:26062 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751767AbdFTXUj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2017 19:20:39 -0400
Date: Tue, 20 Jun 2017 19:29:14 -0400
From: Keith Busch <keith.busch@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-block@vger.kernel.org,
        stable@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci/vmd: Move srcu cleanup after bus/irq domain removal
Message-ID: <20170620232913.GF24415@localhost.localdomain>
References: <1497996784-9177-1-git-send-email-jonathan.derrick@intel.com>
 <a2ea4fb0-f451-ab6e-05db-1bf0a7a74807@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a2ea4fb0-f451-ab6e-05db-1bf0a7a74807@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> On 06/20/2017 04:13 PM, Jon Derrick wrote:
> Recent __call_srcu changes have exposed that we need to cleanup srcu
> structures after pci_stop_root_bus calls into vmd_msi_free.

Adding the obligatory:

Fixes: 3906b91844d6 ("PCI: vmd: Use SRCU as a local RCU to prevent delaying global RCU")
 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> Acked-by: Keith Busch <keith.busch@intel.com>
> Cc: <stable@vger.kernel.org> # 4.11
> ---
>  drivers/pci/host/vmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
> index e27ad2a..642a182 100644
> --- a/drivers/pci/host/vmd.c
> +++ b/drivers/pci/host/vmd.c
> @@ -733,10 +733,10 @@ static void vmd_remove(struct pci_dev *dev)
>  	struct vmd_dev *vmd = pci_get_drvdata(dev);
>  
>  	vmd_detach_resources(vmd);
> -	vmd_cleanup_srcu(vmd);
>  	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
>  	pci_stop_root_bus(vmd->bus);
>  	pci_remove_root_bus(vmd->bus);
> +	vmd_cleanup_srcu(vmd);
>  	vmd_teardown_dma_ops(vmd);
>  	irq_domain_remove(vmd->irq_domain);
>  }
> 
