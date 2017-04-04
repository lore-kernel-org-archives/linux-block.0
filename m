Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36460 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753496AbdDDMPn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 08:15:43 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 2/7] bio-integrity: save original iterator for verify stage
In-Reply-To: <20170404070122.GC12008@infradead.org>
References: <1491204212-9952-1-git-send-email-dmonakhov@openvz.org> <1491204212-9952-3-git-send-email-dmonakhov@openvz.org> <20170404070122.GC12008@infradead.org>
Date: Tue, 04 Apr 2017 15:15:39 +0300
Message-ID: <878tngl66s.fsf@dmlp.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> This is a pretty big increase in the bio_integrity_payload size,
> but I guess we can't get around it..

Yes, everybody hate this solution, me too, but I've stated with
other approach and it is appeaded to be very ugly.

My idea was that we have two types of iterator incrementors: bio_advance()
and bio_xx_complete, First one is called during split, later is called
on completion ( req_bio_endio() ) . So we can add new field "bi_done" to
iterator which has similar meaning as bi_bvec_done, but at full iterator
scope.  It is incremented during completion, but before end_io.
Chain bios will propogate bi_done to parent bio to parent one.
On ->vefify_fn() iterator will be rewinded (counter part of bvec_advance) to
iter->bi_done bytes, so we will get oritinal iterator. 
I've even prepare a patch for this idea and it looks big and awful.
Even more it does not works if chained bios overlapts (raid1,raid10,
etc).

But... at the time I've wrote this email I've realized that I do not
care about what happen with chained bios. The only thing is important
is parent bio and how far it was advanced. If bi_done is incremented
inside bvec_iter_advance() I can be shure that at the moment
->bi_end_io()
original position can be restored by rewinding back to io_done bytes.

I'll try to implement this.

>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
