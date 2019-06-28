Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D52C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 00:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919E52084B
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 00:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1acp849"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfF1AM0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:12:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52872 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF1AM0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 20:12:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so7326229wms.2;
        Thu, 27 Jun 2019 17:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6A5DdWssKcMJqU8jJ4+ldhQjK6u4VCdf4h/8qoyEITo=;
        b=e1acp849SUhRbKbOZA1US5sCdUgaFmD1ydXI5AKiuIXAjY9jhwq+EbRmvpzDjZyyJF
         KAdayvOXBm7ASTS/dFbxrBnXxJwTB40GRJcCPnRv9GS+Al6/YW62YjpjLJiFAVp4tJO9
         63ywDW7xTlHoib5K/SAuMzwZxTtSMeHLgP89N/yHCuC+s4Bk0/T3+B171FTOtQr6jUy3
         QY1IME3EgP3DmHpuvpjy7dzq6iuNCcG/CVUN2YcqePfSEKfkWSfGHKBnsC09e0YbjS9O
         E705R/KoGu6eCNMcCnEz9lSWVXqPdHY4HUA0UsqcGJdqODDlXZVUy20gXTdrsbP0WLwM
         8RUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6A5DdWssKcMJqU8jJ4+ldhQjK6u4VCdf4h/8qoyEITo=;
        b=ijLEC1zPtbeTd7uLTAtsctTP64bT7zE1/6ulR4fIHrV4g6YBHu65Q8nn8m6erBDgOZ
         lIxtr/x64szeJEjNWU785/mw3fntBS6S/fYwAnjFyOFfUEuYZSbvoIVZBFkLmE2drLYY
         FjBnpPHXUEyOyly2jnrns4CD9zCKHrj3XOmrFmWRmYR5O4cUlgumfXe+7i7Ep2HtYJIT
         J+wO+osigjdrl8bX4lldgS8KQKtRISA91uVpHB8VA48rwJxWKWJCoHJk1sQSuYm00pO8
         WbgAFnMFWBQyr8kq9pig8LegHjm1VWPCG0n9S1Qm4hB+0s7AyX1N1kL32gbX9YEq6EJ1
         EX8w==
X-Gm-Message-State: APjAAAVL4oLeQJyDMeJ5US4k9KQXfmQ78rbG/tuqt0bk/pjd3TbinseF
        vtj4raYnklBpqN45H0QNvAyGG2Lq6QvjUjMMS8A=
X-Google-Smtp-Source: APXvYqy+Nf+gi6LTn/5IPEdcOcHUr7oN+Kkfulo7BoxMddF4Mog5W+xbuT9SAMoBdayS9XPwpRKR9za3zGkffH9sZFw=
X-Received: by 2002:a05:600c:204c:: with SMTP id p12mr4841587wmg.121.1561680744175;
 Thu, 27 Jun 2019 17:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190627092944.20957-1-damien.lemoal@wdc.com> <20190627092944.20957-2-damien.lemoal@wdc.com>
In-Reply-To: <20190627092944.20957-2-damien.lemoal@wdc.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 28 Jun 2019 08:12:12 +0800
Message-ID: <CACVXFVP-VvtmEADFfOAOTAbE6q_NTfE9JL21CuWYLwXzRA=BBA@mail.gmail.com>
Subject: Re: [PATCH V5 1/3] block: Allow mapping of vmalloc-ed buffers
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 27, 2019 at 5:31 PM Damien Le Moal <damien.lemoal@wdc.com> wrote:
>
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
>         bio_put(bio);
>  }
>
> +static void bio_invalidate_vmalloc_pages(struct bio *bio)
> +{
> +#ifdef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
> +       if (bio->bi_private && !op_is_write(bio_op(bio))) {
> +               unsigned long i, len = 0;
> +
> +               for (i = 0; i < bio->bi_vcnt; i++)
> +                       len += bio->bi_io_vec[i].bv_len;
> +               invalidate_kernel_vmap_range(bio->bi_private, len);
> +       }
> +#endif
> +}
> +
>  static void bio_map_kern_endio(struct bio *bio)
>  {
> +       bio_invalidate_vmalloc_pages(bio);
>         bio_put(bio);
>  }
>
> @@ -1501,6 +1516,8 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
>         unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
>         unsigned long start = kaddr >> PAGE_SHIFT;
>         const int nr_pages = end - start;
> +       bool is_vmalloc = is_vmalloc_addr(data);
> +       struct page *page;
>         int offset, i;
>         struct bio *bio;
>
> @@ -1508,6 +1525,11 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
>         if (!bio)
>                 return ERR_PTR(-ENOMEM);
>
> +       if (is_vmalloc) {
> +               flush_kernel_vmap_range(data, len);
> +               bio->bi_private = data;
> +       }
> +
>         offset = offset_in_page(kaddr);
>         for (i = 0; i < nr_pages; i++) {
>                 unsigned int bytes = PAGE_SIZE - offset;
> @@ -1518,7 +1540,11 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
>                 if (bytes > len)
>                         bytes = len;
>
> -               if (bio_add_pc_page(q, bio, virt_to_page(data), bytes,
> +               if (!is_vmalloc)
> +                       page = virt_to_page(data);
> +               else
> +                       page = vmalloc_to_page(data);
> +               if (bio_add_pc_page(q, bio, page, bytes,
>                                     offset) < bytes) {
>                         /* we don't support partial mappings */
>                         bio_put(bio);
> @@ -1531,6 +1557,7 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
>         }
>
>         bio->bi_end_io = bio_map_kern_endio;
> +
>         return bio;
>  }
>  EXPORT_SYMBOL(bio_map_kern);
> --
> 2.21.0
>

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming Lei
