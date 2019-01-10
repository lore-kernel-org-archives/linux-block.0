Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812A5C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB2C214C6
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfAJJoJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:44:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727863AbfAJJoJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 04:44:09 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 28774CAA8C;
        Thu, 10 Jan 2019 09:44:09 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B7F45D6AA;
        Thu, 10 Jan 2019 09:44:01 +0000 (UTC)
Date:   Thu, 10 Jan 2019 17:43:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 03/16] block: add bio_set_polled() helper
Message-ID: <20190110094355.GA13512@ming.t460p>
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108165645.19311-4-axboe@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 10 Jan 2019 09:44:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 08, 2019 at 09:56:32AM -0700, Jens Axboe wrote:
> For the upcoming async polled IO, we can't sleep allocating requests.
> If we do, then we introduce a deadlock where the submitter already
> has async polled IO in-flight, but can't wait for them to complete
> since polled requests must be active found and reaped.
> 
> Utilize the helper in the blockdev DIRECT_IO code.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/block_dev.c      |  4 ++--
>  include/linux/bio.h | 14 ++++++++++++++
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 5415579f3e14..2ebd2a0d7789 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -233,7 +233,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>  		task_io_account_write(ret);
>  	}
>  	if (iocb->ki_flags & IOCB_HIPRI)
> -		bio.bi_opf |= REQ_HIPRI;
> +		bio_set_polled(&bio, iocb);
>  
>  	qc = submit_bio(&bio);
>  	for (;;) {
> @@ -401,7 +401,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>  		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
>  		if (!nr_pages) {
>  			if (iocb->ki_flags & IOCB_HIPRI)
> -				bio->bi_opf |= REQ_HIPRI;
> +				bio_set_polled(bio, iocb);
>  
>  			qc = submit_bio(bio);
>  			WRITE_ONCE(iocb->ki_cookie, qc);
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 7380b094dcca..f6f0a2b3cbc8 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -823,5 +823,19 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
>  
>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>  
> +/*
> + * Mark a bio as polled. Note that for async polled IO, the caller must
> + * expect -EWOULDBLOCK if we cannot allocate a request (or other resources).
> + * We cannot block waiting for requests on polled IO, as those completions
> + * must be found by the caller. This is different than IRQ driven IO, where
> + * it's safe to wait for IO to complete.
> + */
> +static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
> +{
> +	bio->bi_opf |= REQ_HIPRI;
> +	if (!is_sync_kiocb(kiocb))
> +		bio->bi_opf |= REQ_NOWAIT;
> +}
> +

REQ_NOWAIT doesn't cover allocating split bio, is that a issue?

BTW, could you explain a bit about the deadlock in case of sleep from
request allocation?

Thanks,
Ming
