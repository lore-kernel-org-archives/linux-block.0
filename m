Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5995 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753932AbcLSPm5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Dec 2016 10:42:57 -0500
Date: Mon, 19 Dec 2016 08:42:56 -0700
From: Jon Derrick <jonathan.derrick@intel.com>
To: Stephen Bates <sbates@raithlin.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, axboe@fb.com, sagi@grimberg.me,
        james_p_freyensee@linux.intel.com
Subject: Re: [PATCH 2/2] nvme: improve cmb sysfs reporting
Message-ID: <20161219154256.GB3512@localhost.localdomain>
References: <1481914491-21456-1-git-send-email-sbates@raithlin.com>
 <1481914491-21456-3-git-send-email-sbates@raithlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481914491-21456-3-git-send-email-sbates@raithlin.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Minor nit below

On Fri, Dec 16, 2016 at 11:54:51AM -0700, Stephen Bates wrote:
> Add more information to the NVMe CMB sysfs entry. This includes
> information about the CMB size, location and capabilities.
> 
> Signed-off-by: Stephen Bates <sbates@raithlin.com>
> ---
>  drivers/nvme/host/pci.c | 31 +++++++++++++++++++++++++++++--
>  include/linux/nvme.h    |  8 ++++++++
>  2 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index be10860..1f70630 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -98,6 +98,7 @@ struct nvme_dev {
>  	void __iomem *cmb;
>  	dma_addr_t cmb_dma_addr;
>  	u64 cmb_size;
> +	u64 cmb_offset;
>  	u32 cmbsz;
>  	u32 cmbloc;
>  	struct nvme_ctrl ctrl;
> @@ -1326,14 +1327,39 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
>  	return ret >= 0 ? 0 : ret;
>  }
>  
> +static const char * const cmb_caps[] = {
> +	[NVME_CMB_CAP_SQS] = "SQS",
> +	[NVME_CMB_CAP_CQS] = "CQS",
> +	[NVME_CMB_CAP_LISTS] = "LISTS",
> +	[NVME_CMB_CAP_RDS] = "RDS",
> +	[NVME_CMB_CAP_WDS] = "WDS",
> +};
> +
>  static ssize_t nvme_cmb_show(struct device *dev,
>  			     struct device_attribute *attr,
>  			     char *buf)
>  {
>  	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
> +	unsigned int i, len = 0;
> +
> +	len += scnprintf(buf+len, PAGE_SIZE-len,
> +			"cmbloc  : 0x%08x\ncmbsz   : 0x%08x\n\n",
> +			ndev->cmbloc, ndev->cmbsz);
> +
> +	len += scnprintf(buf+len, PAGE_SIZE-len,
> +			"OFFSET   : 0x%016llx\nSIZE     : %llu Bytes\n" \
> +			"DMA ADDR : %pad\n\n",
> +			ndev->cmb_offset, ndev->cmb_size,
> +			&ndev->cmb_dma_addr);
> +
> +	for (i = NVME_CMB_CAP_SQS; i <= NVME_CMB_CAP_WDS; i++)
I'd prefer seeing (i = 0; i < ARRAY_SIZE(..); i++) because it provides
automatic bounds checking against future code.

> +		len += scnprintf(buf+len, PAGE_SIZE-len, "%-7s: %s\n",
> +				 cmb_caps[i],
> +				 ((ndev->cmbsz) & (1<<i)) ? "SUPPORTED" :
> +				 "NOT SUPPORTED");
> +
> +	return len;
>  
> -	return scnprintf(buf, PAGE_SIZE, "cmbloc : x%08x\ncmbsz  : x%08x\n",
> -		       ndev->cmbloc, ndev->cmbsz);
>  }
>  static DEVICE_ATTR(cmb, S_IRUGO, nvme_cmb_show, NULL);
>  
> @@ -1376,6 +1402,7 @@ static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
>  
>  	dev->cmb_dma_addr = dma_addr;
>  	dev->cmb_size = size;
> +	dev->cmb_offset = offset;
>  	return cmb;
>  }
>  
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index fc3c242..cd0d324 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -121,6 +121,14 @@ enum {
>  #define NVME_CMB_CQS(cmbsz)	((cmbsz) & 0x2)
>  #define NVME_CMB_SQS(cmbsz)	((cmbsz) & 0x1)
>  
> +enum {
> +	NVME_CMB_CAP_SQS = 0,
> +	NVME_CMB_CAP_CQS,
> +	NVME_CMB_CAP_LISTS,
> +	NVME_CMB_CAP_RDS,
> +	NVME_CMB_CAP_WDS,
> +};
> +
>  /*
>   * Submission and Completion Queue Entry Sizes for the NVM command set.
>   * (In bytes and specified as a power of two (2^n)).
> -- 
> 2.1.4
> 
