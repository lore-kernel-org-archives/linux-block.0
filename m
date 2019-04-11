Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C95C10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 07:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C790217D4
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 07:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfDKHKP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:10:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfDKHKO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 03:10:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D67F937E7B;
        Thu, 11 Apr 2019 07:10:13 +0000 (UTC)
Received: from ming.t460p (ovpn-8-33.pek2.redhat.com [10.72.8.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B86BC5D962;
        Thu, 11 Apr 2019 07:10:07 +0000 (UTC)
Date:   Thu, 11 Apr 2019 15:10:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 2/5] block: refactor __bio_iov_bvec_add_pages
Message-ID: <20190411071001.GB421@ming.t460p>
References: <20190411062331.27800-1-hch@lst.de>
 <20190411062331.27800-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411062331.27800-3-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 11 Apr 2019 07:10:13 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 11, 2019 at 08:23:28AM +0200, Christoph Hellwig wrote:
> Return early on error, and add an unlikely annotation for that case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/bio.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index c2592c5d70b9..ad346082a971 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -873,20 +873,19 @@ static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
>  	len = min_t(size_t, bv->bv_len - iter->iov_offset, iter->count);
>  	size = bio_add_page(bio, bv->bv_page, len,
>  				bv->bv_offset + iter->iov_offset);
> -	if (size == len) {
> -		if (!bio_flagged(bio, BIO_NO_PAGE_REF)) {
> -			struct page *page;
> -			int i;
> +	if (unlikely(size != len))
> +		return -EINVAL;
>  
> -			mp_bvec_for_each_page(page, bv, i)
> -				get_page(page);
> -		}
> +	if (!bio_flagged(bio, BIO_NO_PAGE_REF)) {
> +		struct page *page;
> +		int i;
>  
> -		iov_iter_advance(iter, size);
> -		return 0;
> +		mp_bvec_for_each_page(page, bv, i)
> +			get_page(page);
>  	}
>  
> -	return -EINVAL;
> +	iov_iter_advance(iter, size);
> +	return 0;
>  }
>  
>  #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
> -- 
> 2.20.1
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
