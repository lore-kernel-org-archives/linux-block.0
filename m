Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B730C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 01:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE96F2080C
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 01:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE96F2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeKSMT7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 07:19:59 -0500
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:9924 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727033AbeKSMT7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 07:19:59 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 19 Nov 2018 12:27:54 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gOYp0-0007iy-1s; Mon, 19 Nov 2018 12:57:54 +1100
Date:   Mon, 19 Nov 2018 12:57:54 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] aio: add support for file based polled IO
Message-ID: <20181119015753.GP6311@dastard>
References: <20181117235317.7366-1-axboe@kernel.dk>
 <20181117235317.7366-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117235317.7366-6-axboe@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 17, 2018 at 04:53:17PM -0700, Jens Axboe wrote:
> Needs further work, but this should work fine on normal setups
> with a file system on a pollable block device.

What should work fine? I've got no idea what this patch is actually
providing....

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/aio.c       | 2 ++
>  fs/direct-io.c | 4 +++-
>  fs/iomap.c     | 7 +++++--
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 500da3ffc376..e02085fe10d7 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1310,6 +1310,8 @@ static struct block_device *aio_bdev_host(struct kiocb *req)
>  
>  	if (S_ISBLK(inode->i_mode))
>  		return I_BDEV(inode);
> +	else if (inode->i_sb && inode->i_sb->s_bdev)
> +		return inode->i_sb->s_bdev;

XFS might be doing AIO to files on real-time device, not
inode->i_sb->s_bdev. So this may well be the wrong block device
for the IO being submitted.

>  
>  	return NULL;
>  }
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index a5a4e5a1423e..34de494e9061 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -477,8 +477,10 @@ static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
>  	if (sdio->submit_io) {
>  		sdio->submit_io(bio, dio->inode, sdio->logical_offset_in_bio);
>  		dio->bio_cookie = BLK_QC_T_NONE;
> -	} else
> +	} else {
>  		dio->bio_cookie = submit_bio(bio);
> +		WRITE_ONCE(dio->iocb->ki_blk_qc, dio->bio_cookie);
> +	}
>  
>  	sdio->bio = NULL;
>  	sdio->boundary = 0;
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 74c1f37f0fd6..4cf412b6230a 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -1555,6 +1555,7 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
>  	struct page *page = ZERO_PAGE(0);
>  	int flags = REQ_SYNC | REQ_IDLE;
>  	struct bio *bio;
> +	blk_qc_t qc;
>  
>  	bio = bio_alloc(GFP_KERNEL, 1);
>  	bio_set_dev(bio, iomap->bdev);
> @@ -1570,7 +1571,9 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
>  	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
>  
>  	atomic_inc(&dio->ref);
> -	return submit_bio(bio);
> +	qc = submit_bio(bio);
> +	WRITE_ONCE(dio->iocb->ki_blk_qc, qc);
> +	return qc;
>  }

Why is this added to sub-block zeroing IO calls? It gets overwritten
by the data IO submission, so this value is going to change as the
IO progresses. What does making these partial IOs visible provide,
especially as they then get overwritten by the next submissions?
Indeed, how does one wait on all IOs in the DIO to complete if we
are only tracking one of many?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
