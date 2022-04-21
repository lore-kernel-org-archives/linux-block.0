Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F6DC433FE
	for <linux-block@archiver.kernel.org>; Thu, 21 Apr 2022 11:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354671AbiDULvz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Apr 2022 07:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347714AbiDULvz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 07:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2135227163
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 04:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650541744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qJj2EnC4G6QPvmNYS+A3b06EQY18U3AZjlnPkgR7O5Q=;
        b=eIRIzqrR3KdfdKKXt52hwrsy6/x/UuNHUhz7LdGXFWXh/eczfD6y7PyknIJs3Y3OQBEGMP
        xmMfI2tkLZULtM8Ya1+EVE0syOC63jcJd3qPea/pN+CJjtiGk+O+T9KsXjw2a/2s9V9+lA
        GXqCMs7/1B6GUZVSsrb/R0APKfpth+Y=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-UyE-LC16Oq-fc99BiVwasQ-1; Thu, 21 Apr 2022 07:49:03 -0400
X-MC-Unique: UyE-LC16Oq-fc99BiVwasQ-1
Received: by mail-pl1-f198.google.com with SMTP id w14-20020a1709027b8e00b0015386056d2bso2429320pll.5
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 04:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJj2EnC4G6QPvmNYS+A3b06EQY18U3AZjlnPkgR7O5Q=;
        b=0Ylm7luvS8AdDJCs8ScbPyKNU8LtivUU1mvi4buxA5lBFTVTgndzRr6dRreJQNiXyY
         7fhzXe/CmegQasgCmG9CTv+fs0Dws9+DydpSYznRUhW8GkoAE7WTbj72Fqe/RM31xIh4
         ODozLVdk9Hg9cVq2ELfnxrzFJ5/26LhkIfqyrTpeRPNFCjzr25N3sRQM1t6bKRHAPjW1
         9evryuJkJT8eZWEywBkfdfHjxvojZHkLsmAx/g7hF1ntfLO1OtXlHg/7c+iaUikgxpyW
         gu1CufuDxPEGnKPenrYPBc3VgdhKHU9kfvC3Bxdm/CJQsg59SvSSWBSzyHjmSaoQYLrW
         7aYw==
X-Gm-Message-State: AOAM533uG8FSn5v3YOgmQOjqOeuUH3zxpu/c2FKhkNy5PWLtv1wuc3Ap
        PdUa4GWfilsWbwLV24vMf9VuFuTvekVB6JQZE5UzE4MqbbihrWp4j1fmOSt0rTrw5OnsrA6NZ4m
        XLOuIV4eJ82WiESSyN+nszb0eC4yFg79WEGV21no=
X-Received: by 2002:a17:90b:17ce:b0:1d2:75cc:d6c7 with SMTP id me14-20020a17090b17ce00b001d275ccd6c7mr10050151pjb.162.1650541741643;
        Thu, 21 Apr 2022 04:49:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfYLhbaJDyRd/mNR2y/0DfkcUWAGEN4FhbGiNUEYUQIYwH7fWZzRXjXArdBQcGCG2LWNR9jzUc8wImDdal8lo=
X-Received: by 2002:a17:90b:17ce:b0:1d2:75cc:d6c7 with SMTP id
 me14-20020a17090b17ce00b001d275ccd6c7mr10050126pjb.162.1650541741325; Thu, 21
 Apr 2022 04:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220420143110.2679002-1-ming.lei@redhat.com>
In-Reply-To: <20220420143110.2679002-1-ming.lei@redhat.com>
From:   Changhui Zhong <czhong@redhat.com>
Date:   Thu, 21 Apr 2022 19:48:50 +0800
Message-ID: <CAGVVp+XFhe28q2vYDxWJFw4=o=PvyCrFjuBfj1dwmhfpXisuNg@mail.gmail.com>
Subject: Re: [PATCH V2] block: ignore RWF_HIPRI hint for sync dio
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Test pass with this patch,
Thanks Ming and Christoph !

Tested-by: Changhui Zhong <czhong@redhat.com>



On Wed, Apr 20, 2022 at 10:31 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> So far bio is marked as REQ_POLLED if RWF_HIPRI/IOCB_HIPRI is passed
> from userspace sync io interface, then block layer tries to poll until
> the bio is completed. But the current implementation calls
> blk_io_schedule() if bio_poll() returns 0, and this way causes io hang or
> timeout easily.
>
> But looks no one reports this kind of issue, which should have been
> triggered in normal io poll sanity test or blktests block/007 as
> observed by Changhui, that means it is very likely that no one uses it
> or no one cares it.
>
> Also after io_uring is invented, io poll for sync dio becomes legacy
> interface.
>
> So ignore RWF_HIPRI hint for sync dio.
>
> CC: linux-mm@kvack.org
> Cc: linux-xfs@vger.kernel.org
> Reported-by: Changhui Zhong <czhong@redhat.com>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
>         - avoid to break io_uring async polling as pointed by Chritoph
>
>  block/fops.c         | 22 +---------------------
>  fs/iomap/direct-io.c |  7 +++----
>  mm/page_io.c         |  4 +---
>  3 files changed, 5 insertions(+), 28 deletions(-)
>
> diff --git a/block/fops.c b/block/fops.c
> index e3643362c244..b9b83030e0df 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -44,14 +44,6 @@ static unsigned int dio_bio_write_op(struct kiocb *iocb)
>
>  #define DIO_INLINE_BIO_VECS 4
>
> -static void blkdev_bio_end_io_simple(struct bio *bio)
> -{
> -       struct task_struct *waiter = bio->bi_private;
> -
> -       WRITE_ONCE(bio->bi_private, NULL);
> -       blk_wake_io_task(waiter);
> -}
> -
>  static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
>                 struct iov_iter *iter, unsigned int nr_pages)
>  {
> @@ -83,8 +75,6 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
>                 bio_init(&bio, bdev, vecs, nr_pages, dio_bio_write_op(iocb));
>         }
>         bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
> -       bio.bi_private = current;
> -       bio.bi_end_io = blkdev_bio_end_io_simple;
>         bio.bi_ioprio = iocb->ki_ioprio;
>
>         ret = bio_iov_iter_get_pages(&bio, iter);
> @@ -97,18 +87,8 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
>
>         if (iocb->ki_flags & IOCB_NOWAIT)
>                 bio.bi_opf |= REQ_NOWAIT;
> -       if (iocb->ki_flags & IOCB_HIPRI)
> -               bio_set_polled(&bio, iocb);
>
> -       submit_bio(&bio);
> -       for (;;) {
> -               set_current_state(TASK_UNINTERRUPTIBLE);
> -               if (!READ_ONCE(bio.bi_private))
> -                       break;
> -               if (!(iocb->ki_flags & IOCB_HIPRI) || !bio_poll(&bio, NULL, 0))
> -                       blk_io_schedule();
> -       }
> -       __set_current_state(TASK_RUNNING);
> +       submit_bio_wait(&bio);
>
>         bio_release_pages(&bio, should_dirty);
>         if (unlikely(bio.bi_status))
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 62da020d02a1..80f9b047aa1b 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -56,7 +56,8 @@ static void iomap_dio_submit_bio(const struct iomap_iter *iter,
>  {
>         atomic_inc(&dio->ref);
>
> -       if (dio->iocb->ki_flags & IOCB_HIPRI) {
> +       /* Sync dio can't be polled reliably */
> +       if ((dio->iocb->ki_flags & IOCB_HIPRI) && !is_sync_kiocb(dio->iocb)) {
>                 bio_set_polled(bio, dio->iocb);
>                 dio->submit.poll_bio = bio;
>         }
> @@ -653,9 +654,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>                         if (!READ_ONCE(dio->submit.waiter))
>                                 break;
>
> -                       if (!dio->submit.poll_bio ||
> -                           !bio_poll(dio->submit.poll_bio, NULL, 0))
> -                               blk_io_schedule();
> +                       blk_io_schedule();
>                 }
>                 __set_current_state(TASK_RUNNING);
>         }
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 89fbf3cae30f..3fbdab6a940e 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -360,7 +360,6 @@ int swap_readpage(struct page *page, bool synchronous)
>          * attempt to access it in the page fault retry time check.
>          */
>         if (synchronous) {
> -               bio->bi_opf |= REQ_POLLED;
>                 get_task_struct(current);
>                 bio->bi_private = current;
>         }
> @@ -372,8 +371,7 @@ int swap_readpage(struct page *page, bool synchronous)
>                 if (!READ_ONCE(bio->bi_private))
>                         break;
>
> -               if (!bio_poll(bio, NULL, 0))
> -                       blk_io_schedule();
> +               blk_io_schedule();
>         }
>         __set_current_state(TASK_RUNNING);
>         bio_put(bio);
> --
> 2.31.1

