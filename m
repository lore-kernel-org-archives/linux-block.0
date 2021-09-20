Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42EBC433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 22:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C0C261184
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 22:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhITW4P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 18:56:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:47130 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238939AbhITWyP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 18:54:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="210329891"
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="210329891"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 15:52:47 -0700
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="556519969"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 15:52:47 -0700
Date:   Mon, 20 Sep 2021 15:52:47 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-block@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: Re: [PATCH 3/3] block: warn if ->groups is set when calling add_disk
Message-ID: <20210920225246.GA3169279@iweiny-DESK2.sc.intel.com>
References: <20210920072726.1159572-1-hch@lst.de>
 <20210920072726.1159572-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920072726.1159572-4-hch@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 20, 2021 at 09:27:26AM +0200, Christoph Hellwig wrote:
> The proper API is to pass the groups to device_add_disk, but the code
> used to also allow groups being set before calling *add_disk.  Warn
> about that but keep the group pointer intact for now so that it can
> be removed again after a grace period.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Fixes: 52b85909f85d ("block: fold register_disk into device_add_disk")

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  block/genhd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 7b6e5e1cf9564..409cf608cc5bd 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -439,7 +439,8 @@ int device_add_disk(struct device *parent, struct gendisk *disk,
>  	dev_set_uevent_suppress(ddev, 1);
>  
>  	ddev->parent = parent;
> -	ddev->groups = groups;
> +	if (!WARN_ON_ONCE(ddev->groups))
> +		ddev->groups = groups;
>  	dev_set_name(ddev, "%s", disk->disk_name);
>  	if (!(disk->flags & GENHD_FL_HIDDEN))
>  		ddev->devt = MKDEV(disk->major, disk->first_minor);
> -- 
> 2.30.2
> 
