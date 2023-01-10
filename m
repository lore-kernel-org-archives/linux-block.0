Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14B4C54EBE
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 09:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjAJJVY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 04:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjAJJUe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 04:20:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D44544C1
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 01:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yRITYnKzKHesgY22DT+4pPbZs/Qlnf6QQP+PzDqvR+4=; b=AF8+ERVXR1X8zlM5bXgvN5VC+E
        MKR4xEB9DtqQ4APbM52EBS095mXO9XXuOMkcAbwDhqZ1Wm6Z9tP6QwvX1mOxRmvtFDanzsd//AIkv
        YOb0GGuqy79R1fmMf30eGTmt7l2dZE9dsQ/pf5QUgF7dn3J2t1vk1+Fc6Q9q2VqITJIK283xLTqNH
        fVIvawKvcmJmwNKXA+uiWkJxgNt54wNLrEGyapQV2pzfAkpnHBY8Ty2wsRKuTlakNYkOpTQjyVsAG
        Vxx0sINSelH82Y4+kt7vhLOT74lyDFHaPPsp8JCOstvOeNaEsBC7M0kc1HlhOyzy0iZZcVjozeqV7
        a2bK0rIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFAny-0063pJ-Qr; Tue, 10 Jan 2023 09:20:26 +0000
Date:   Tue, 10 Jan 2023 01:20:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH 1/2] block: handle bio_split_to_limits() NULL return
Message-ID: <Y70t2r+fOadEnDpE@infradead.org>
References: <20230104160938.62636-1-axboe@kernel.dk>
 <20230104160938.62636-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104160938.62636-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 04, 2023 at 09:09:37AM -0700, Jens Axboe wrote:
> This can't happen right now, but in preparation for allowing
> bio_split_to_limits() returning NULL if it ended the bio, check for it
> in all the callers.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-merge.c             | 4 +++-
>  block/blk-mq.c                | 5 ++++-
>  drivers/block/drbd/drbd_req.c | 2 ++
>  drivers/block/ps3vram.c       | 2 ++
>  drivers/md/dm.c               | 2 ++
>  drivers/md/md.c               | 2 ++
>  drivers/nvme/host/multipath.c | 2 ++
>  drivers/s390/block/dcssblk.c  | 2 ++
>  8 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 35a8f75cc45d..071c5f8cf0cf 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -358,11 +358,13 @@ struct bio *__bio_split_to_limits(struct bio *bio,
>  	default:
>  		split = bio_split_rw(bio, lim, nr_segs, bs,
>  				get_max_io_size(bio, lim) << SECTOR_SHIFT);
> +		if (IS_ERR(split))
> +			return NULL;

Can we decide on either passing an ERR_PTR or NULL and do it through
the whole stack? 

> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> index eb14ec8ec04c..e36216d50753 100644
> --- a/drivers/block/drbd/drbd_req.c
> +++ b/drivers/block/drbd/drbd_req.c
> @@ -1607,6 +1607,8 @@ void drbd_submit_bio(struct bio *bio)
>  	struct drbd_device *device = bio->bi_bdev->bd_disk->private_data;
>  
>  	bio = bio_split_to_limits(bio);
> +	if (!bio)
> +		return;

So for the callers in drivers, do we need thee checks for drivers
that don't even support REQ_NOWAIT? 
