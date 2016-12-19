Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:45553 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755303AbcLSPUQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Dec 2016 10:20:16 -0500
Date: Mon, 19 Dec 2016 08:20:14 -0700
From: Jon Derrick <jonathan.derrick@intel.com>
To: Stephen Bates <sbates@raithlin.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, axboe@fb.com, sagi@grimberg.me,
        james_p_freyensee@linux.intel.com
Subject: Re: [PATCH 1/2] nvme : Use correct scnprintf in cmb show
Message-ID: <20161219152013.GA3512@localhost.localdomain>
References: <1481914491-21456-1-git-send-email-sbates@raithlin.com>
 <1481914491-21456-2-git-send-email-sbates@raithlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481914491-21456-2-git-send-email-sbates@raithlin.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good. Thanks Stephen.

Reviewed-by Jon Derrick: <jonathan.derrick@intel.com>

On Fri, Dec 16, 2016 at 11:54:50AM -0700, Stephen Bates wrote:
> Make sure we are using the correct scnprintf in the sysfs show
> function for the CMB.
> 
> Signed-off-by: Stephen Bates <sbates@raithlin.com>
> ---
>  drivers/nvme/host/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5e52034..be10860 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -50,7 +50,7 @@
>  #define NVME_AQ_DEPTH		256
>  #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
>  #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
> -		
> +
>  /*
>   * We handle AEN commands ourselves and don't even let the
>   * block layer know about them.
> @@ -1332,7 +1332,7 @@ static ssize_t nvme_cmb_show(struct device *dev,
>  {
>  	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
>  
> -	return snprintf(buf, PAGE_SIZE, "cmbloc : x%08x\ncmbsz  : x%08x\n",
> +	return scnprintf(buf, PAGE_SIZE, "cmbloc : x%08x\ncmbsz  : x%08x\n",
>  		       ndev->cmbloc, ndev->cmbsz);
>  }
>  static DEVICE_ATTR(cmb, S_IRUGO, nvme_cmb_show, NULL);
> -- 
> 2.1.4
> 
