Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4155EC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0721D20989
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0721D20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbeLFTLN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:11:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbeLFTLN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Dec 2018 14:11:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 052B13001589;
        Thu,  6 Dec 2018 19:11:13 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 586AF1001640;
        Thu,  6 Dec 2018 19:11:12 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
Subject: Re: [PATCH 03/26] block: wire up block device iopoll method
References: <20181204233729.26776-1-axboe@kernel.dk>
        <20181204233729.26776-4-axboe@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 06 Dec 2018 14:11:11 -0500
In-Reply-To: <20181204233729.26776-4-axboe@kernel.dk> (Jens Axboe's message of
        "Tue, 4 Dec 2018 16:37:06 -0700")
Message-ID: <x49a7lih3n4.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 06 Dec 2018 19:11:13 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> From: Christoph Hellwig <hch@lst.de>
>
> Just call blk_poll on the iocb cookie, we can derive the block device
> from the inode trivially.

Does this work for multi-device file systems?

-Jeff

>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/block_dev.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index e1886cc7048f..6de8d35f6e41 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -281,6 +281,14 @@ struct blkdev_dio {
>  
>  static struct bio_set blkdev_dio_pool;
>  
> +static int blkdev_iopoll(struct kiocb *kiocb, bool wait)
> +{
> +	struct block_device *bdev = I_BDEV(kiocb->ki_filp->f_mapping->host);
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), wait);
> +}
> +
>  static void blkdev_bio_end_io(struct bio *bio)
>  {
>  	struct blkdev_dio *dio = bio->bi_private;
> @@ -398,6 +406,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>  				bio->bi_opf |= REQ_HIPRI;
>  
>  			qc = submit_bio(bio);
> +			WRITE_ONCE(iocb->ki_cookie, qc);
>  			break;
>  		}
>  
> @@ -2070,6 +2079,7 @@ const struct file_operations def_blk_fops = {
>  	.llseek		= block_llseek,
>  	.read_iter	= blkdev_read_iter,
>  	.write_iter	= blkdev_write_iter,
> +	.iopoll		= blkdev_iopoll,
>  	.mmap		= generic_file_mmap,
>  	.fsync		= blkdev_fsync,
>  	.unlocked_ioctl	= block_ioctl,
