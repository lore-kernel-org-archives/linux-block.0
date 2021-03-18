Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4495EC433DB
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 15:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01EE064E89
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 15:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhCRPNi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 11:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhCRPNM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 11:13:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4228364F18;
        Thu, 18 Mar 2021 15:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616080392;
        bh=Xyd4sj6+Dv/DIDIRM+OMfclc4GP5EO7nmdjsZtmXzJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rlVIx7nWCwk9E+e7SFQKCDtUWZNqZ4oJmcDi1jR8E3t8RL/Drwb9U3aZ0MuqQIewv
         E/7wyyJvCQfFGUB/GGH5owRQpJWFuG0R44Z1hMpdYRtBW/A5Yn/k7g88fEBW04RCXX
         fsbx1hnpxM+n1fcP7IR6CZbsM4qLLc92N6fKapYzJHdzs4xGymxgh/lc+QOyep3wVB
         HKeq9lICcRCXLaQQnqNPGVWFQXCEfHCER6roRP9gz2SSd19zFebCDT/BFuEYM4QVnW
         ycq9JITVGl2wdTJe24E4gzpWMZuEddTsUIBAo2M2bQ7WmqhLcfjXkA+5FIdtBf+DNv
         nDGaLZYPbp76Q==
Date:   Fri, 19 Mar 2021 00:13:05 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        keescook@chromium.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: do not copy data to user when bi_status is error
Message-ID: <20210318151305.GB31228@redsun51.ssa.fujisawa.hgst.com>
References: <20210318122621.330010-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318122621.330010-1-yanaijie@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 18, 2021 at 08:26:21PM +0800, Jason Yan wrote:
> When the user submitted a request with unaligned buffer, we will
> allocate a new page and try to copy data to or from the new page.
> If it is a reading request, we always copy back the data to user's
> buffer, whether the result is good or error. So if the driver or
> hardware returns an error, garbage data is copied to the user space.
> This is a potential security issue which makes kernel info leaks.
> 
> So do not copy the uninitalized data to user's buffer if the
> bio->bi_status is not BLK_STS_OK in bio_copy_kern_endio_read().

If we're using copy_kern routines, doesn't that mean it's a kernel
request rather than user space?

I think the patch is probably good, though. The only minor concern I
have is if anyone wanted to observe a partial data transfer on error.
The caller currently gets that data, but this patch will prevent it. I
don't know of anyone actually depending on that behavior, so it may not
be a real concern.


> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  block/blk-map.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 1ffef782fcf2..c2e2162d54d9 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -439,9 +439,11 @@ static void bio_copy_kern_endio_read(struct bio *bio)
>  	struct bio_vec *bvec;
>  	struct bvec_iter_all iter_all;
>  
> -	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		memcpy(p, page_address(bvec->bv_page), bvec->bv_len);
> -		p += bvec->bv_len;
> +	if (!bio->bi_status) {
> +		bio_for_each_segment_all(bvec, bio, iter_all) {
> +			memcpy(p, page_address(bvec->bv_page), bvec->bv_len);
> +			p += bvec->bv_len;
> +		}
>  	}
>  
>  	bio_copy_kern_endio(bio);
