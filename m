Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56701 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752454AbdF2UWx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2017 16:22:53 -0400
Date: Thu, 29 Jun 2017 22:22:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shaohua Li <shli@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, tj@kernel.org,
        gregkh@linuxfoundation.org, axboe@fb.com, rostedt@goodmis.org,
        lizefan@huawei.com, Kernel-team@fb.com, Shaohua Li <shli@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH V4 10/12] block: call __bio_free in bio_endio
Message-ID: <20170629202251.GA416@lst.de>
References: <cover.1498666964.git.shli@fb.com> <f1e84225656d403485ac5f1bd8b9f5db42bc74ca.1498666964.git.shli@fb.com> <20170628212908.GA19350@lst.de> <20170628214249.z42lypwtgzgdzh62@kernel.org> <20170629171552.GA28502@lst.de> <20170629183544.sgza7orhftb4zkg4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629183544.sgza7orhftb4zkg4@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 29, 2017 at 11:35:44AM -0700, Shaohua Li wrote:
> > -
> >  	/* Auto-generate integrity metadata if this is a write */
> >  	if (bio_data_dir(bio) == WRITE)
> >  		bio_integrity_process(bio, bi->profile->generate_fn);
> > @@ -370,14 +364,12 @@ static void bio_integrity_verify_fn(struct work_struct *work)
> >  	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
> >  
> >  	bio->bi_status = bio_integrity_process(bio, bi->profile->verify_fn);
> > -
> > -	/* Restore original bio completion handler */
> > -	bio->bi_end_io = bip->bip_end_io;
> > +	bio_integrity_free(bio);
> >  	bio_endio(bio);
> 
> should we directly call bi_end_io here? Otherwise, looks reasonable to me.

We should call bio_endio to get the proper chaining behavior.
