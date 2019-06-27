Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F655C48BD7
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 14:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696A92064A
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 14:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfF0OLv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:11:51 -0400
Received: from verein.lst.de ([213.95.11.210]:39030 "EHLO newverein.lst.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfF0OLv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 10:11:51 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jun 2019 10:11:51 EDT
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E2F0468C4E; Thu, 27 Jun 2019 16:06:32 +0200 (CEST)
Date:   Thu, 27 Jun 2019 16:06:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V5 1/3] block: Allow mapping of vmalloc-ed buffers
Message-ID: <20190627140632.GA6209@lst.de>
References: <20190627092944.20957-1-damien.lemoal@wdc.com> <20190627092944.20957-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627092944.20957-2-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 27, 2019 at 06:29:42PM +0900, Damien Le Moal wrote:
> To allow the SCSI subsystem scsi_execute_req() function to issue
> requests using large buffers that are better allocated with vmalloc()
> rather than kmalloc(), modify bio_map_kern() to allow passing a buffer
> allocated with vmalloc().
> 
> To do so, detect vmalloc-ed buffers using is_vmalloc_addr(). For
> vmalloc-ed buffers, flush the buffer using flush_kernel_vmap_range(),
> use vmalloc_to_page() instead of virt_to_page() to obtain the pages of
> the buffer, and invalidate the buffer addresses with
> invalidate_kernel_vmap_range() on completion of read BIOs. This last
> point is executed using the function bio_invalidate_vmalloc_pages()
> which is defined only if the architecture defines
> ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE, that is, if the architecture
> actually needs the invalidation done.
> 
> Fixes: 515ce6061312 ("scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation")
> Fixes: e76239a3748c ("block: add a report_zones method")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  block/bio.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index ce797d73bb43..bbba5f08b2ef 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -16,6 +16,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/cgroup.h>
>  #include <linux/blk-cgroup.h>
> +#include <linux/highmem.h>
>  
>  #include <trace/events/block.h>
>  #include "blk.h"
> @@ -1479,8 +1480,22 @@ void bio_unmap_user(struct bio *bio)
>  	bio_put(bio);
>  }
>  
> +static void bio_invalidate_vmalloc_pages(struct bio *bio)
> +{
> +#ifdef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
> +	if (bio->bi_private && !op_is_write(bio_op(bio))) {
> +		unsigned long i, len = 0;
> +
> +		for (i = 0; i < bio->bi_vcnt; i++)
> +			len += bio->bi_io_vec[i].bv_len;
> +		invalidate_kernel_vmap_range(bio->bi_private, len);
> +	}
> +#endif
> +}

Normal Linux style is to keep the ifdefs outside the functions,
or use IS_ENABLED, although the latter would require
ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE to be a config option.  Not that
I personally care much.

> @@ -1531,6 +1557,7 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
>  	}
>  
>  	bio->bi_end_io = bio_map_kern_endio;
> +
>  	return bio;
>  }

Superflous whitespace change.

Otherwise look good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
