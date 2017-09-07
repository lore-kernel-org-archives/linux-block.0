Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:59857 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754953AbdIGLIE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Sep 2017 07:08:04 -0400
Date: Thu, 7 Sep 2017 04:08:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: Christoph Hellwig <hch@infradead.org>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias@cnexlabs.com>
Subject: Re: [PATCH 10/18] lightnvm: pblk: use bio_copy_kern when possible
Message-ID: <20170907110801.GA17144@infradead.org>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
 <1504695071-25928-11-git-send-email-javier@cnexlabs.com>
 <20170906134731.GD3960@infradead.org>
 <EE4FE7F3-88CF-42DD-B18F-B0AC2CB5EB2C@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <EE4FE7F3-88CF-42DD-B18F-B0AC2CB5EB2C@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 06, 2017 at 04:00:56PM +0200, Javier Gonz�lez wrote:
> > Nope.  You want to loop over vmalloc_to_page and call bio_add_page
> > for each page,
> 
> Yes. This is basically what I did before.
> 
> > after taking care of virtually tagged caches instead
> > of this bounce buffering.
> 
> And thus I considered bio_copy_kern to be a better solution, since it
> will through time take care of doing the vmalloc_to_page correctly for
> all cases.

bio_copy_kern copies all the data, so it is generally not a good
idea.  The cache flushing isn't too hard - take a look at the XFS
buffer cache for an existing version.

It would be good to just to do the right thing inside bio_map_kern
for that so that callers don't need to care if it is vmalloced or
not.

> Ok. So this would mean that targets (e.g., pblk) deal with struct
> request instead of only dealing with bios and then letting the LightNVM
> core transforming bios to requests. This way we can directly map to the
> request. Is this what you mean?

Yes.

> Just out of curiosity, why is forming the bio trough bio_copy_kern (or
> manually doing the same) and then transforming to a request incorrect /
> worse?

Because you expose yourself to the details of mapping a bio to request.
We had to export blk_init_request_from_bio just for lightnvm to do this,
and it also has to do weird other bits about requests.  If you go
through blk_rq_map_* the block layer takes care of all that for you.
