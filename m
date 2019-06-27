Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6929C48BD6
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 07:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B8A205ED
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 07:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfF0Hre (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:47:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfF0Hre (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 03:47:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1F153083391;
        Thu, 27 Jun 2019 07:47:33 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81E415D71C;
        Thu, 27 Jun 2019 07:47:25 +0000 (UTC)
Date:   Thu, 27 Jun 2019 15:47:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V4 1/3] block: Allow mapping of vmalloc-ed buffers
Message-ID: <20190627074720.GB24671@ming.t460p>
References: <20190627024910.23987-1-damien.lemoal@wdc.com>
 <20190627024910.23987-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627024910.23987-2-damien.lemoal@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 27 Jun 2019 07:47:34 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 27, 2019 at 11:49:08AM +0900, Damien Le Moal wrote:
> To allow the SCSI subsystem scsi_execute_req() function to issue
> requests using large buffers that are better allocated with vmalloc()
> rather than kmalloc(), modify bio_map_kern() and bio_copy_kern() to
> allow passing a buffer allocated with vmalloc(). To do so, detect
> vmalloc-ed buffers using is_vmalloc_addr(). For vmalloc-ed buffers,
> flush the buffer using flush_kernel_vmap_range(), use vmalloc_to_page()
> instead of virt_to_page() to obtain the pages of the buffer, and
> invalidate the buffer addresses with invalidate_kernel_vmap_range() on
> completion of read BIOs. This last point is executed using the function
> bio_invalidate_vmalloc_pages() which is defined only if the
> architecture defines ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE, that is, if the
> architecture actually needs the invalidation done.
> 
> Fixes: 515ce6061312 ("scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation")
> Fixes: e76239a3748c ("block: add a report_zones method")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  block/bio.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index ce797d73bb43..1c21d1e7f1b8 100644
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
> @@ -1479,8 +1480,26 @@ void bio_unmap_user(struct bio *bio)
>  	bio_put(bio);
>  }
>  
> +#ifdef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
> +static void bio_invalidate_vmalloc_pages(struct bio *bio)
> +{
> +	if (bio->bi_private) {
> +		struct bvec_iter_all iter_all;
> +		struct bio_vec *bvec;
> +		unsigned long len = 0;
> +
> +		bio_for_each_segment_all(bvec, bio, iter_all)
> +			len += bvec->bv_len;
> +		invalidate_kernel_vmap_range(bio->bi_private, len);
> +	}
> +}
> +#else
> +static void bio_invalidate_vmalloc_pages(struct bio *bio) {}
> +#endif
> +
>  static void bio_map_kern_endio(struct bio *bio)
>  {
> +	bio_invalidate_vmalloc_pages(bio);
>  	bio_put(bio);
>  }
>  
> @@ -1501,6 +1520,8 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
>  	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	unsigned long start = kaddr >> PAGE_SHIFT;
>  	const int nr_pages = end - start;
> +	bool is_vmalloc = is_vmalloc_addr(data);
> +	struct page *page;
>  	int offset, i;
>  	struct bio *bio;
>  
> @@ -1508,6 +1529,12 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
>  	if (!bio)
>  		return ERR_PTR(-ENOMEM);
>  
> +	if (is_vmalloc) {
> +		flush_kernel_vmap_range(data, len);
> +		if ((!op_is_write(bio_op(bio))))
> +			bio->bi_private = data;
> +	}
> +
>  	offset = offset_in_page(kaddr);
>  	for (i = 0; i < nr_pages; i++) {
>  		unsigned int bytes = PAGE_SIZE - offset;
> @@ -1518,7 +1545,11 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
>  		if (bytes > len)
>  			bytes = len;
>  
> -		if (bio_add_pc_page(q, bio, virt_to_page(data), bytes,
> +		if (!is_vmalloc)
> +			page = virt_to_page(data);
> +		else
> +			page = vmalloc_to_page(data);
> +		if (bio_add_pc_page(q, bio, page, bytes,
>  				    offset) < bytes) {
>  			/* we don't support partial mappings */
>  			bio_put(bio);
> @@ -1531,6 +1562,7 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
>  	}
>  
>  	bio->bi_end_io = bio_map_kern_endio;
> +
>  	return bio;
>  }
>  EXPORT_SYMBOL(bio_map_kern);
> @@ -1543,6 +1575,7 @@ static void bio_copy_kern_endio(struct bio *bio)
>  
>  static void bio_copy_kern_endio_read(struct bio *bio)
>  {
> +	unsigned long len = 0;
>  	char *p = bio->bi_private;
>  	struct bio_vec *bvec;
>  	struct bvec_iter_all iter_all;
> @@ -1550,8 +1583,12 @@ static void bio_copy_kern_endio_read(struct bio *bio)
>  	bio_for_each_segment_all(bvec, bio, iter_all) {
>  		memcpy(p, page_address(bvec->bv_page), bvec->bv_len);
>  		p += bvec->bv_len;
> +		len += bvec->bv_len;
>  	}
>  
> +	if (is_vmalloc_addr(bio->bi_private))
> +		invalidate_kernel_vmap_range(bio->bi_private, len);
> +
>  	bio_copy_kern_endio(bio);
>  }
>  
> @@ -1572,6 +1609,7 @@ struct bio *bio_copy_kern(struct request_queue *q, void *data, unsigned int len,
>  	unsigned long kaddr = (unsigned long)data;
>  	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	unsigned long start = kaddr >> PAGE_SHIFT;
> +	bool is_vmalloc = is_vmalloc_addr(data);
>  	struct bio *bio;
>  	void *p = data;
>  	int nr_pages = 0;
> @@ -1587,6 +1625,9 @@ struct bio *bio_copy_kern(struct request_queue *q, void *data, unsigned int len,
>  	if (!bio)
>  		return ERR_PTR(-ENOMEM);
>  
> +	if (is_vmalloc)
> +		flush_kernel_vmap_range(data, len);
> +

Are your sure that invalidate[|flush]_kernel_vmap_range is needed for
bio_copy_kernel? The vmalloc buffer isn't involved in IO, and only
accessed by CPU.

Thanks,
Ming
