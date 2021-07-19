Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EE1C07E95
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 15:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF77B61279
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 15:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbhGSOzq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jul 2021 10:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238617AbhGSOxp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 10:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626708863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s5wHwi5go6kVQ1/3z+CMH208OpxLH6Tm0+h2A2CCndo=;
        b=QAqlSbO5J6HaYoliWylmsHAhBYrb1I8xRHkRh4yQ5cV0ITbk4/4/gMkyhkMs9mQhqtw13k
        7vtHndJHbwwWTYO79+VWEzf0P3HUcSwBwm81V4UehWpuQ47Z3Jpw0dRfhzK/UN6lWHtF1U
        Bfw+xJei+bqV8sAJfmKP52/aC63uxE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-_6oVHLOTNEyqRN8Yp4JD8w-1; Mon, 19 Jul 2021 11:34:22 -0400
X-MC-Unique: _6oVHLOTNEyqRN8Yp4JD8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80927100C661;
        Mon, 19 Jul 2021 15:34:21 +0000 (UTC)
Received: from T590 (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A72105D6BA;
        Mon, 19 Jul 2021 15:34:14 +0000 (UTC)
Date:   Mon, 19 Jul 2021 23:34:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC] bio: fix page leak bio_add_hw_page failure
Message-ID: <YPWbcdcpcD/lBmL9@T590>
References: <1edfa6a2ffd66d55e6345a477df5387d2c1415d0.1626653825.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1edfa6a2ffd66d55e6345a477df5387d2c1415d0.1626653825.git.asml.silence@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 19, 2021 at 11:53:00AM +0100, Pavel Begunkov wrote:
> __bio_iov_append_get_pages() doesn't put not appended pages on
> bio_add_hw_page() failure, so potentially leaking them, fix it. Also, do
> the same for __bio_iov_iter_get_pages(), even though it looks like it
> can't be triggered by userspace in this case.
> 
> Fixes: 0512a75b98f8 ("block: Introduce REQ_OP_ZONE_APPEND")
> Cc: stable@vger.kernel.org # 5.8+
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
> 
> I haven't tested the fail path, thus RFC. Would be great if someone can
> do it or take over the fix.
> 
>  block/bio.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 1fab762e079b..d95e3456ba0c 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -979,6 +979,14 @@ static int bio_iov_bvec_set_append(struct bio *bio, struct iov_iter *iter)
>  	return 0;
>  }
>  
> +static void bio_put_pages(struct page **pages, size_t size, size_t off)
> +{
> +	size_t i, nr = DIV_ROUND_UP(size + (off & ~PAGE_MASK), PAGE_SIZE);
> +
> +	for (i = 0; i < nr; i++)
> +		put_page(pages[i]);
> +}
> +
>  #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
>  
>  /**
> @@ -1023,8 +1031,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  			if (same_page)
>  				put_page(page);
>  		} else {
> -			if (WARN_ON_ONCE(bio_full(bio, len)))
> -                                return -EINVAL;
> +			if (WARN_ON_ONCE(bio_full(bio, len))) {
> +				bio_put_pages(pages + i, left, offset);
> +				return -EINVAL;
> +			}

It is unlikely to happen:

        unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
        struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
        struct page **pages = (struct page **)bv;

		pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
		size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);


>  			__bio_add_page(bio, page, len, offset);
>  		}
>  		offset = 0;
> @@ -1069,6 +1079,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
>  		len = min_t(size_t, PAGE_SIZE - offset, left);
>  		if (bio_add_hw_page(q, bio, page, len, offset,
>  				max_append_sectors, &same_page) != len) {
> +			bio_put_pages(pages + i, left, offset);

Same with above.


Thanks,
Ming

