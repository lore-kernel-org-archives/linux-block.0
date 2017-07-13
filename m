Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:60854 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751197AbdGMHp0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2017 03:45:26 -0400
Date: Thu, 13 Jul 2017 09:45:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shaohua Li <shli@kernel.org>
Cc: linux-block@vger.kernel.org, axboe@fb.com,
        Shaohua Li <shli@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] block: delete bio_uninit
Message-ID: <20170713074519.GA13404@lst.de>
References: <cover.1499881589.git.shli@fb.com> <094050f349fdf7eed4a20335e9a7573d7c8c9b35.1499881589.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <094050f349fdf7eed4a20335e9a7573d7c8c9b35.1499881589.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>  static void bio_free(struct bio *bio)
>  {
>  	struct bio_set *bs = bio->bi_pool;
>  	void *p;
>  
> -	bio_uninit(bio);
> +	bio_disassociate_task(bio);

As said in the last mail I think there is no point in having this call..

> @@ -294,7 +289,7 @@ void bio_reset(struct bio *bio)
>  {
>  	unsigned long flags = bio->bi_flags & (~0UL << BIO_RESET_BITS);
>  
> -	bio_uninit(bio);
> +	bio_disassociate_task(bio);

.. and this one.  And I suspect it would make sense to have all these
changes in a single patch.
