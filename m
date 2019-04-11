Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07763C10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 07:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CAB20873
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 07:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfDKHcH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:32:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfDKHcH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 03:32:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 11F9D3086218;
        Thu, 11 Apr 2019 07:32:07 +0000 (UTC)
Received: from ming.t460p (ovpn-8-33.pek2.redhat.com [10.72.8.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 13EA560BFB;
        Thu, 11 Apr 2019 07:32:00 +0000 (UTC)
Date:   Thu, 11 Apr 2019 15:31:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 3/5] block: don't allow multiple bio_iov_iter_get_pages
 calls per bio
Message-ID: <20190411073154.GC421@ming.t460p>
References: <20190411062331.27800-1-hch@lst.de>
 <20190411062331.27800-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411062331.27800-4-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 11 Apr 2019 07:32:07 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 11, 2019 at 08:23:29AM +0200, Christoph Hellwig wrote:
> No caller uses bio_iov_iter_get_pages multiple times on a given bio,
> and that funtionality isn't all that useful.  Removing it will make
> some future changes a little easier and also simplifies the function
> a bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/bio.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index ad346082a971..c2a389b1509a 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -958,7 +958,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  {
>  	const bool is_bvec = iov_iter_is_bvec(iter);
> -	unsigned short orig_vcnt = bio->bi_vcnt;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(bio->bi_vcnt))
> +		return -EINVAL;
>  
>  	/*
>  	 * If this is a BVEC iter, then the pages are kernel pages. Don't
> @@ -968,19 +971,13 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  		bio_set_flag(bio, BIO_NO_PAGE_REF);
>  
>  	do {
> -		int ret;
> -
>  		if (is_bvec)
>  			ret = __bio_iov_bvec_add_pages(bio, iter);
>  		else
>  			ret = __bio_iov_iter_get_pages(bio, iter);
> +	} while (!ret && iov_iter_count(iter) && !bio_full(bio));
>  
> -		if (unlikely(ret))
> -			return bio->bi_vcnt > orig_vcnt ? 0 : ret;
> -
> -	} while (iov_iter_count(iter) && !bio_full(bio));
> -
> -	return 0;
> +	return bio->bi_vcnt ? 0 : ret;
>  }
>  
>  static void submit_bio_wait_endio(struct bio *bio)
> -- 
> 2.20.1
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
