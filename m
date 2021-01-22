Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005FBC433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 03:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D4F23899
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 03:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbhAVDrk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 22:47:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726160AbhAVDrg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 22:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611287168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EJZXLJK0hCUS1Rd2sy1TEx3934IszRbfzHGeQ+DiU4w=;
        b=SLE3m7hsHXkPNGX0Iv7pynUh2ToXoi6ySed1zqu5LnvDf+3vV6s1acuQ8c+cWEpP9oZlaf
        q59aGO9gcO4Q6HXyIRzy15QJ4bjhKH3AJUhlz+UQ48TeFzst6gXbCuZaC8XSAaSZmIiaRH
        hSV6R9ezfW4H4TyX2LvRa0baj4J3nsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-NxeNyzXzPHm8VbG_FgrgnQ-1; Thu, 21 Jan 2021 22:46:06 -0500
X-MC-Unique: NxeNyzXzPHm8VbG_FgrgnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96B15180A092;
        Fri, 22 Jan 2021 03:46:04 +0000 (UTC)
Received: from T590 (ovpn-13-11.pek2.redhat.com [10.72.13.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E57BB6267F;
        Fri, 22 Jan 2021 03:45:52 +0000 (UTC)
Date:   Fri, 22 Jan 2021 11:45:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     Johannes.Thumshirn@wdc.com, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com, patchwork-bot@kernel.org, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, tom.leiming@gmail.com, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, mj0123.lee@samsung.com,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [PATCH v2] bio: limit bio max size.
Message-ID: <20210122034547.GC509982@T590>
References: <CGME20210121011324epcas1p3a213069e873fd324a7ce3188558f0782@epcas1p3.samsung.com>
 <20210121005803.26052-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121005803.26052-1-nanich.lee@samsung.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 21, 2021 at 09:58:03AM +0900, Changheun Lee wrote:
> bio size can grow up to 4GB when muli-page bvec is enabled.
> but sometimes it would lead to inefficient behaviors.
> in case of large chunk direct I/O, - 32MB chunk read in user space -
> all pages for 32MB would be merged to a bio structure if memory address is
> continued phsycally. it makes some delay to submit until merge complete.
> bio max size should be limited as a proper size.
> 
> When 32MB chunk read with direct I/O option is coming from userspace,
> kernel behavior is below now. it's timeline.

IMO, the issue should only exist on sync direct IO and writeback.
Not sure if writeback cares this small delay because user data
has been written to page cache already.

Wrt. your big direct IO case, as I suggested, you may reduce the
submission delay a lot by applying THP.

Or you can just hardcode the limit in case of sync dio.

> 
>  | bio merge for 32MB. total 8,192 pages are merged.
>  | total elapsed time is over 2ms.
>  |------------------ ... ----------------------->|
>                                                  | 8,192 pages merged a bio.
>                                                  | at this time, first bio submit is done.
>                                                  | 1 bio is split to 32 read request and issue.
>                                                  |--------------->
>                                                   |--------------->
>                                                    |--------------->
>                                                               ......
>                                                                    |--------------->
>                                                                     |--------------->|
>                           total 19ms elapsed to complete 32MB read done from device. |
> 
> If bio max size is limited with 1MB, behavior is changed below.
> 
>  | bio merge for 1MB. 256 pages are merged for each bio.
>  | total 32 bio will be made.
>  | total elapsed time is over 2ms. it's same.
>  | but, first bio submit timing is fast. about 100us.
>  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
>       | 256 pages merged a bio.
>       | at this time, first bio submit is done.
>       | and 1 read request is issued for 1 bio.
>       |--------------->
>            |--------------->
>                 |--------------->
>                                       ......
>                                                  |--------------->
>                                                   |--------------->|
>         total 17ms elapsed to complete 32MB read done from device. |
> 
> As a result, read request issue timing is faster if bio max size is limited.
> Current kernel behavior with multipage bvec, super large bio can be created.
> And it lead to delay first I/O request issue.
> 
> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> 
> ---
>  block/bio.c               | 17 ++++++++++++++++-
>  include/linux/bio.h       | 13 +++----------
>  include/linux/blk_types.h |  1 +
>  3 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 1f2cc1fbe283..027503c2e2e7 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -284,9 +284,24 @@ void bio_init(struct bio *bio, struct bio_vec *table,
>  
>  	bio->bi_io_vec = table;
>  	bio->bi_max_vecs = max_vecs;
> +	bio->bi_max_size = UINT_MAX;
>  }
>  EXPORT_SYMBOL(bio_init);
>  
> +void bio_set_dev(struct bio *bio, struct block_device *bdev)
> +{
> +	if (bio->bi_disk != bdev->bd_disk)
> +		bio_clear_flag(bio, BIO_THROTTLED);
> +
> +	bio->bi_disk = bdev->bd_disk;
> +	bio->bi_partno = bdev->bd_partno;
> +	bio->bi_max_size = blk_queue_get_max_sectors(bio->bi_disk->queue,
> +			bio_op(bio)) << SECTOR_SHIFT;
> +
> +	bio_associate_blkg(bio);
> +}
> +EXPORT_SYMBOL(bio_set_dev);
> +
>  /**
>   * bio_reset - reinitialize a bio
>   * @bio:	bio to reset
> @@ -877,7 +892,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
>  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
>  
>  		if (page_is_mergeable(bv, page, len, off, same_page)) {
> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> +			if (bio->bi_iter.bi_size > bio->bi_max_size - len)
>  				*same_page = false;
>  				return false;
>  			}
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 1edda614f7ce..b9803e80c259 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -113,7 +113,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
>  	if (bio->bi_vcnt >= bio->bi_max_vecs)
>  		return true;
>  
> -	if (bio->bi_iter.bi_size > UINT_MAX - len)
> +	if (bio->bi_iter.bi_size > bio->bi_max_size - len)
>  		return true;
>  
>  	return false;
> @@ -482,20 +482,13 @@ extern struct bio_vec *bvec_alloc(gfp_t, int, unsigned long *, mempool_t *);
>  extern void bvec_free(mempool_t *, struct bio_vec *, unsigned int);
>  extern unsigned int bvec_nr_vecs(unsigned short idx);
>  extern const char *bio_devname(struct bio *bio, char *buffer);
> -
> -#define bio_set_dev(bio, bdev) 			\
> -do {						\
> -	if ((bio)->bi_disk != (bdev)->bd_disk)	\
> -		bio_clear_flag(bio, BIO_THROTTLED);\
> -	(bio)->bi_disk = (bdev)->bd_disk;	\
> -	(bio)->bi_partno = (bdev)->bd_partno;	\
> -	bio_associate_blkg(bio);		\
> -} while (0)
> +extern void bio_set_dev(struct bio *bio, struct block_device *bdev);
>  
>  #define bio_copy_dev(dst, src)			\
>  do {						\
>  	(dst)->bi_disk = (src)->bi_disk;	\
>  	(dst)->bi_partno = (src)->bi_partno;	\
> +	(dst)->bi_max_size = (src)->bi_max_size;\
>  	bio_clone_blkg_association(dst, src);	\
>  } while (0)
>  
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 866f74261b3b..e5dd5b7d8fc1 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -270,6 +270,7 @@ struct bio {
>  	 */
>  
>  	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
> +	unsigned int		bi_max_size;	/* max data size we can hold */

People don't like to extend bio which can be fit in two cachelines
exactly, and adding one 'int' will make it cross 3 cache lines.


Thanks,
Ming

