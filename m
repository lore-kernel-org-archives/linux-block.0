Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10363C10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 07:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99CD20873
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 07:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfDKHgU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:36:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfDKHgU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 03:36:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD2F0308794A;
        Thu, 11 Apr 2019 07:36:19 +0000 (UTC)
Received: from ming.t460p (ovpn-8-33.pek2.redhat.com [10.72.8.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3534B5D961;
        Thu, 11 Apr 2019 07:36:14 +0000 (UTC)
Date:   Thu, 11 Apr 2019 15:36:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/5] block: change how we get page references in
 bio_iov_iter_get_pages
Message-ID: <20190411073608.GD421@ming.t460p>
References: <20190411062331.27800-1-hch@lst.de>
 <20190411062331.27800-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411062331.27800-5-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 11 Apr 2019 07:36:19 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 11, 2019 at 08:23:30AM +0200, Christoph Hellwig wrote:
> Instead of needing a special macro to iterate over all pages in
> a bvec just do a second passs over the whole bio.  This also matches
> what we do on the release side.  The release side helper is moved
> up to where we need the get helper to clearly express the symmetry.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c          | 51 ++++++++++++++++++++++----------------------
>  include/linux/bvec.h |  5 -----
>  2 files changed, 25 insertions(+), 31 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index c2a389b1509a..d3490aeb1a7e 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -861,6 +861,26 @@ int bio_add_page(struct bio *bio, struct page *page,
>  }
>  EXPORT_SYMBOL(bio_add_page);
>  
> +static void bio_get_pages(struct bio *bio)
> +{
> +	struct bvec_iter_all iter_all;
> +	struct bio_vec *bvec;
> +	int i;
> +
> +	bio_for_each_segment_all(bvec, bio, i, iter_all)
> +		get_page(bvec->bv_page);
> +}
> +
> +static void bio_release_pages(struct bio *bio)
> +{
> +	struct bvec_iter_all iter_all;
> +	struct bio_vec *bvec;
> +	int i;
> +
> +	bio_for_each_segment_all(bvec, bio, i, iter_all)
> +		put_page(bvec->bv_page);
> +}
> +
>  static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
>  {
>  	const struct bio_vec *bv = iter->bvec;
> @@ -875,15 +895,6 @@ static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
>  				bv->bv_offset + iter->iov_offset);
>  	if (unlikely(size != len))
>  		return -EINVAL;
> -
> -	if (!bio_flagged(bio, BIO_NO_PAGE_REF)) {
> -		struct page *page;
> -		int i;
> -
> -		mp_bvec_for_each_page(page, bv, i)
> -			get_page(page);
> -	}
> -
>  	iov_iter_advance(iter, size);
>  	return 0;
>  }
> @@ -963,13 +974,6 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	if (WARN_ON_ONCE(bio->bi_vcnt))
>  		return -EINVAL;
>  
> -	/*
> -	 * If this is a BVEC iter, then the pages are kernel pages. Don't
> -	 * release them on IO completion, if the caller asked us to.
> -	 */
> -	if (is_bvec && iov_iter_bvec_no_ref(iter))
> -		bio_set_flag(bio, BIO_NO_PAGE_REF);
> -
>  	do {
>  		if (is_bvec)
>  			ret = __bio_iov_bvec_add_pages(bio, iter);
> @@ -977,6 +981,11 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  			ret = __bio_iov_iter_get_pages(bio, iter);
>  	} while (!ret && iov_iter_count(iter) && !bio_full(bio));
>  
> +	if (iov_iter_bvec_no_ref(iter))
> +		bio_set_flag(bio, BIO_NO_PAGE_REF);
> +	else
> +		bio_get_pages(bio);
> +
>  	return bio->bi_vcnt ? 0 : ret;
>  }
>  
> @@ -1670,16 +1679,6 @@ void bio_set_pages_dirty(struct bio *bio)
>  	}
>  }
>  
> -static void bio_release_pages(struct bio *bio)
> -{
> -	struct bio_vec *bvec;
> -	int i;
> -	struct bvec_iter_all iter_all;
> -
> -	bio_for_each_segment_all(bvec, bio, i, iter_all)
> -		put_page(bvec->bv_page);
> -}
> -
>  /*
>   * bio_check_pages_dirty() will check that all the BIO's pages are still dirty.
>   * If they are, then fine.  If, however, some pages are clean then they must
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index f6275c4da13a..307bbda62b7b 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -189,9 +189,4 @@ static inline void mp_bvec_last_segment(const struct bio_vec *bvec,
>  	}
>  }
>  
> -#define mp_bvec_for_each_page(pg, bv, i)				\
> -	for (i = (bv)->bv_offset / PAGE_SIZE;				\
> -		(i <= (((bv)->bv_offset + (bv)->bv_len - 1) / PAGE_SIZE)) && \
> -		(pg = bvec_nth_page((bv)->bv_page, i)); i += 1)
> -
>  #endif /* __LINUX_BVEC_ITER_H */
> -- 
> 2.20.1
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
