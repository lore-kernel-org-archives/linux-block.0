Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:44600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbdBMNsX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2017 08:48:23 -0500
Date: Mon, 13 Feb 2017 05:48:22 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v1 2/5] md/raid1: use bio_clone_bioset_partial() in case
 of write behind
Message-ID: <20170213134822.GC22818@infradead.org>
References: <1486724177-14817-1-git-send-email-tom.leiming@gmail.com>
 <1486724177-14817-3-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486724177-14817-3-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> +		struct bio *mbio = NULL;
> +		int offset;
>  		if (!r1_bio->bios[i])
>  			continue;
>  
> -		mbio = bio_clone_mddev(bio, GFP_NOIO, mddev);
> -		bio_trim(mbio, r1_bio->sector - bio->bi_iter.bi_sector,
> -			 max_sectors);
> +		offset = r1_bio->sector - bio->bi_iter.bi_sector;

I think offset should be a sector_t.

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
