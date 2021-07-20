Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC25C12002
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 02:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57066611F2
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 02:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhGTBgk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jul 2021 21:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344045AbhGTBbb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 21:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626747122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eqGuHp1HKSG0GPFfrBDLDpiAize0HiuxXfzP/FRBwzY=;
        b=VrJG36CSSUp3pFVaZwkUPl+Ak1ZtDuwGv2bX5i/M9SjoJ47ijenZIQYZGEgP6HUibWhx7K
        soMMgCXjMXEdMkg9FgSR5i2emSLS+FQ1JeIeUk/otK1p+lmfqSu7CHUFCaI1XiRdKLMvyv
        tCpEXt0uWvasHZ301lySUZDToYa4X8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-H99VbPTbO-qNro5dClhRIg-1; Mon, 19 Jul 2021 22:12:00 -0400
X-MC-Unique: H99VbPTbO-qNro5dClhRIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73BBD804142;
        Tue, 20 Jul 2021 02:11:59 +0000 (UTC)
Received: from T590 (ovpn-12-229.pek2.redhat.com [10.72.12.229])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FE52100F49F;
        Tue, 20 Jul 2021 02:11:52 +0000 (UTC)
Date:   Tue, 20 Jul 2021 10:11:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC] bio: fix page leak bio_add_hw_page failure
Message-ID: <YPYw5Ma4QC9jFPYV@T590>
References: <1edfa6a2ffd66d55e6345a477df5387d2c1415d0.1626653825.git.asml.silence@gmail.com>
 <YPWbcdcpcD/lBmL9@T590>
 <90d2a028-c458-c260-c2c3-4870576ba370@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90d2a028-c458-c260-c2c3-4870576ba370@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 19, 2021 at 06:06:49PM +0100, Pavel Begunkov wrote:
> On 7/19/21 4:34 PM, Ming Lei wrote:
> > On Mon, Jul 19, 2021 at 11:53:00AM +0100, Pavel Begunkov wrote:
> >> __bio_iov_append_get_pages() doesn't put not appended pages on
> >> bio_add_hw_page() failure, so potentially leaking them, fix it. Also, do
> >> the same for __bio_iov_iter_get_pages(), even though it looks like it
> >> can't be triggered by userspace in this case.
> >>
> >> Fixes: 0512a75b98f8 ("block: Introduce REQ_OP_ZONE_APPEND")
> >> Cc: stable@vger.kernel.org # 5.8+
> >> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >> ---
> >>
> >> I haven't tested the fail path, thus RFC. Would be great if someone can
> >> do it or take over the fix.
> >>
> >>  block/bio.c | 15 +++++++++++++--
> >>  1 file changed, 13 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/block/bio.c b/block/bio.c
> >> index 1fab762e079b..d95e3456ba0c 100644
> >> --- a/block/bio.c
> >> +++ b/block/bio.c
> >> @@ -979,6 +979,14 @@ static int bio_iov_bvec_set_append(struct bio *bio, struct iov_iter *iter)
> >>  	return 0;
> >>  }
> >>  
> >> +static void bio_put_pages(struct page **pages, size_t size, size_t off)
> >> +{
> >> +	size_t i, nr = DIV_ROUND_UP(size + (off & ~PAGE_MASK), PAGE_SIZE);
> >> +
> >> +	for (i = 0; i < nr; i++)
> >> +		put_page(pages[i]);
> >> +}
> >> +
> >>  #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
> >>  
> >>  /**
> >> @@ -1023,8 +1031,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> >>  			if (same_page)
> >>  				put_page(page);
> >>  		} else {
> >> -			if (WARN_ON_ONCE(bio_full(bio, len)))
> >> -                                return -EINVAL;
> >> +			if (WARN_ON_ONCE(bio_full(bio, len))) {
> >> +				bio_put_pages(pages + i, left, offset);
> >> +				return -EINVAL;
> >> +			}
> > 
> > It is unlikely to happen:
> > 
> >         unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
> >         struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
> >         struct page **pages = (struct page **)bv;
> > 
> > 		pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
> > 		size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> 
> Agree, mentioned in the commit, however ...
> 
> >>  			__bio_add_page(bio, page, len, offset);
> >>  		}
> >>  		offset = 0;
> >> @@ -1069,6 +1079,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
> >>  		len = min_t(size_t, PAGE_SIZE - offset, left);
> >>  		if (bio_add_hw_page(q, bio, page, len, offset,
> >>  				max_append_sectors, &same_page) != len) {
> >> +			bio_put_pages(pages + i, left, offset);
> > 
> > Same with above.
> 
> ... bio_add_hw_page() is more complex and additionally does checks
> against queue_max_zone_append_sectors(), queue_max_segments(), and
> queue_virt_boundary() in of bvec_gap_to_prev().
> 
> It may be unlikely, but are you sure that those are just safety
> checks? It's not so obvious to me, so would be great if you could
> point out the other place where the verification is done.

OK, bio_add_hw_page() is special, and it needs the handling, but 
__bio_iov_iter_get_pages() needn't that since it is so obvious.


Thanks,
Ming

