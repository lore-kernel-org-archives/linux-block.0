Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:58359 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934141AbdDFLnu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2017 07:43:50 -0400
Date: Thu, 6 Apr 2017 04:43:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 5/9] bio-integrity: fold bio_integrity_enabled to
 bio_integrity_prep
Message-ID: <20170406114349.GC9312@infradead.org>
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
 <1491332201-26926-6-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491332201-26926-6-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> --- a/Documentation/block/data-integrity.txt
> +++ b/Documentation/block/data-integrity.txt
> @@ -202,9 +202,6 @@ will require extra work due to the application tag.
>        added.  It is up to the caller to ensure that the bio does not
>        change while I/O is in progress.
>  
> -      bio_integrity_prep() should only be called if
> -      bio_integrity_enabled() returned 1.
> -

This should grow a blurb that bio_integrity_prep will complete the bio
if an error occurs.

>  /**
> - * bio_integrity_prep - Prepare bio for integrity I/O
> + * bio_integrity_setup - Prepare bio for integrity I/O
>   * @bio:	bio to prepare
>   *
>   * Description: Allocates a buffer for integrity metadata, maps the
> @@ -269,7 +231,7 @@ static int bio_integrity_process(struct bio *bio,
>   * block device's integrity function.  In the READ case, the buffer
>   * will be prepared for DMA and a suitable end_io handler set up.
>   */
> -int bio_integrity_prep(struct bio *bio)
> +static int bio_integrity_setup(struct bio *bio)

Instead of renaming the function I'd suggest simply merging the two,
the end result will be smaller and more readable.

> +	if (bio_data_dir(bio) == READ && bi->profile->verify_fn != NULL &&
> +	    (bi->flags & BLK_INTEGRITY_VERIFY))
> +		goto need_prep;
> +
> +	if (bio_data_dir(bio) == WRITE && bi->profile->generate_fn != NULL &&
> +	    (bi->flags & BLK_INTEGRITY_GENERATE))
> +		goto need_prep;

I'd invert the conditions to avoid the goto:

	if (bio_data_dir(bio) == READ) {
		if (!bi->profile->verify_fn ||
		    !(bi->flags & BLK_INTEGRITY_VERIFY))
			return 0;
	} else {
		if (!bi->profile->generate_fn ||
		    !(bi->flags & BLK_INTEGRITY_GENERATE))
			return 0;
	}
