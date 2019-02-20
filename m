Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC602C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 22:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56E020859
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 22:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfBTW7K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:59:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfBTW7J (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 17:59:09 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47F7985376;
        Wed, 20 Feb 2019 22:59:09 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A98C5C277;
        Wed, 20 Feb 2019 22:59:01 +0000 (UTC)
Date:   Thu, 21 Feb 2019 06:58:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, hch@lst.de, jmoyer@redhat.com,
        avi@scylladb.com, jannh@google.com, viro@ZenIV.linux.org.uk
Subject: Re: [PATCH 11/19] block: implement bio helper to add iter bvec pages
 to bio
Message-ID: <20190220225856.GB28313@ming.t460p>
References: <20190211190049.7888-1-axboe@kernel.dk>
 <20190211190049.7888-13-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211190049.7888-13-axboe@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 20 Feb 2019 22:59:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 11, 2019 at 12:00:41PM -0700, Jens Axboe wrote:
> For an ITER_BVEC, we can just iterate the iov and add the pages
> to the bio directly. This requires that the caller doesn't releases
> the pages on IO completion, we add a BIO_NO_PAGE_REF flag for that.
> 
> The current two callers of bio_iov_iter_get_pages() are updated to
> check if they need to release pages on completion. This makes them
> work with bvecs that contain kernel mapped pages already.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/bio.c               | 59 ++++++++++++++++++++++++++++++++-------
>  fs/block_dev.c            |  5 ++--
>  fs/iomap.c                |  5 ++--
>  include/linux/blk_types.h |  1 +
>  4 files changed, 56 insertions(+), 14 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 4db1008309ed..330df572cfb8 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -828,6 +828,23 @@ int bio_add_page(struct bio *bio, struct page *page,
>  }
>  EXPORT_SYMBOL(bio_add_page);
>  
> +static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
> +{
> +	const struct bio_vec *bv = iter->bvec;
> +	unsigned int len;
> +	size_t size;
> +
> +	len = min_t(size_t, bv->bv_len, iter->count);
> +	size = bio_add_page(bio, bv->bv_page, len,
> +				bv->bv_offset + iter->iov_offset);

iter->iov_offset needs to be subtracted from 'len', looks
the following delta change[1] is required, otherwise memory corruption
can be observed when running xfstests over loop/dio.

Another interesting thing is that bio_add_page() is capable of
adding multi contiguous pages actually, especially loop uses
ITER_BVEC to pass multi-page bvecs. Even though pages in loop's
ITER_BVEC may belong to user-space, looks it is still safe to not
grab the page ref given it has been done by fs. 

[1]
diff --git a/block/bio.c b/block/bio.c
index 3b49963676fc..df99bb3816a1 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -842,7 +842,10 @@ static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
 	unsigned int len;
 	size_t size;
 
-	len = min_t(size_t, bv->bv_len, iter->count);
+	if (WARN_ON_ONCE(iter->iov_offset > bv->bv_len))
+		return -EINVAL;
+
+	len = min_t(size_t, bv->bv_len - iter->iov_offset, iter->count);
 	size = bio_add_page(bio, bv->bv_page, len,
 				bv->bv_offset + iter->iov_offset);
 	if (size == len) {

Thanks,
Ming
