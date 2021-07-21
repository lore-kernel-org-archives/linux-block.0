Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352DAC636C9
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 13:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D93B61242
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 13:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238917AbhGUNIi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jul 2021 09:08:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238705AbhGUNIG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 09:08:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FAB660FF1;
        Wed, 21 Jul 2021 13:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626875322;
        bh=QKDuJ/tJFtf4bV+bZdOandh6bQNA88joil4cKFF6TrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bIkdxnLOR8U0+4xTT4bIRFHb1fOZUu5ZyXSOj6V0wv6dPwWGY1u1kowZ6SvlC5QmL
         3nB+hhON1j9duLDXoq3iENyN2Bubr6K/ay8NOQlPM9mZLJ1wgZqQmVBxZ7IiVPAi46
         adBoqXnUSQO7bl/7K78f4gq4qoWvM+UueUstNcdM=
Date:   Wed, 21 Jul 2021 15:48:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 1/3] driver core: add device_has_managed_msi_irq
Message-ID: <YPglty/1YLI0DW4q@kroah.com>
References: <20210721091723.1152456-1-ming.lei@redhat.com>
 <20210721091723.1152456-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721091723.1152456-2-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 21, 2021 at 05:17:21PM +0800, Ming Lei wrote:
> irq vector allocation with managed affinity may be used by driver, and
> blk-mq needs this info for draining queue because genirq core will shutdown
> managed irq when all CPUs in the affinity mask are offline.
> 
> The info of using managed irq is often produced by drivers, and it is
> consumed by blk-mq, so different subsystems are involved in this info flow.
> 
> Address this issue by adding one helper of device_has_managed_msi_irq()
> which is suggested by John Garry.
> 
> Suggested-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/base/core.c    | 15 +++++++++++++++
>  include/linux/device.h |  2 ++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index cadcade65825..41daf9fabdfb 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -29,6 +29,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/sysfs.h>
>  #include <linux/dma-map-ops.h> /* for dma_default_coherent */
> +#include <linux/msi.h> /* for device_has_managed_irq */
>  
>  #include "base.h"
>  #include "power/power.h"
> @@ -4797,3 +4798,17 @@ int device_match_any(struct device *dev, const void *unused)
>  	return 1;
>  }
>  EXPORT_SYMBOL_GPL(device_match_any);
> +
> +bool device_has_managed_msi_irq(struct device *dev)
> +{
> +	struct msi_desc *desc;
> +
> +	if (IS_ENABLED(CONFIG_GENERIC_MSI_IRQ)) {
> +		for_each_msi_entry(desc, dev) {
> +			if (desc->affinity && desc->affinity->is_managed)
> +				return true;
> +		}
> +	}
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(device_has_managed_msi_irq);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 59940f1744c1..b1255524ce8b 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -981,4 +981,6 @@ extern long sysfs_deprecated;
>  #define sysfs_deprecated 0
>  #endif
>  
> +bool device_has_managed_msi_irq(struct device *dev);

This really belongs in msi.h, not device.h, as it is very MSI specific.

Same for the .c change.

thanks,

greg k-h
