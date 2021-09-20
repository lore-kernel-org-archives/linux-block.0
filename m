Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC12C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 22:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 802B961168
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 22:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbhITWzt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 18:55:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:1504 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238977AbhITWxs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 18:53:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="223294444"
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="223294444"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 15:52:18 -0700
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="556519811"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 15:52:18 -0700
Date:   Mon, 20 Sep 2021 15:52:18 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-block@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: Re: [PATCH 1/3] nvdimm/pmem: fix creating the dax group
Message-ID: <20210920225216.GZ3169279@iweiny-DESK2.sc.intel.com>
References: <20210920072726.1159572-1-hch@lst.de>
 <20210920072726.1159572-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920072726.1159572-2-hch@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 20, 2021 at 09:27:24AM +0200, Christoph Hellwig wrote:
> The recent block layer refactoring broke the way how the pmem driver
> abused device_add_disk.  Fix this by properly passing the attribute groups
> to device_add_disk.
> 
> Fixes: 52b85909f85d ("block: fold register_disk into device_add_disk")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/nvdimm/pmem.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 72de88ff0d30d..ef4950f808326 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -380,7 +380,6 @@ static int pmem_attach_disk(struct device *dev,
>  	struct nd_pfn_sb *pfn_sb;
>  	struct pmem_device *pmem;
>  	struct request_queue *q;
> -	struct device *gendev;
>  	struct gendisk *disk;
>  	void *addr;
>  	int rc;
> @@ -489,10 +488,8 @@ static int pmem_attach_disk(struct device *dev,
>  	}
>  	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
>  	pmem->dax_dev = dax_dev;
> -	gendev = disk_to_dev(disk);
> -	gendev->groups = pmem_attribute_groups;
>  
> -	device_add_disk(dev, disk, NULL);
> +	device_add_disk(dev, disk, pmem_attribute_groups);
>  	if (devm_add_action_or_reset(dev, pmem_release_disk, pmem))
>  		return -ENOMEM;
>  
> -- 
> 2.30.2
> 
