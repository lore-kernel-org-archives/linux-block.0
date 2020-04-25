Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA165C55186
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 08:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC871206B6
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 08:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgDYILb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 04:11:31 -0400
Received: from verein.lst.de ([213.95.11.211]:39010 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgDYILb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 04:11:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5728B68C4E; Sat, 25 Apr 2020 10:11:26 +0200 (CEST)
Date:   Sat, 25 Apr 2020 10:11:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V8 08/11] block: add blk_end_flush_machinery
Message-ID: <20200425081125.GA5427@lst.de>
References: <20200424102351.475641-1-ming.lei@redhat.com> <20200424102351.475641-9-ming.lei@redhat.com> <20200424104136.GE28156@lst.de> <20200425034405.GG477579@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425034405.GG477579@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 25, 2020 at 11:44:05AM +0800, Ming Lei wrote:
> > FYI, we don't really need the bdev to send a bio anymore, this could just
> > do:
> > 
> > 	bio = bio_alloc(GFP_KERNEL, 0); // XXX: shouldn't this be GFP_NOIO??
> 
> Error handling.

bio_alloc does not fail for allocations that can sleep.

> 
> > 	bio->bi_disk = rq->rq_disk;
> > 	bio->bi_partno = 0;
> > 	bio_associate_blkg(bio); // XXX: actually, shouldn't this come from rq?
> > 	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
> > 	error = submit_bio_wait(bio);
> > 	bio_put(bio);
> 
> Yeah, that is another way, however I prefer to blkdev_issue_flush
> because it takes less code and we do have the API of blkdev_issue_flush.

It is about the same amount of code, and as commented above I think the
current code uses the wrong blkg assignment.
