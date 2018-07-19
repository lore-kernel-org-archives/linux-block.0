Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727584AbeGSPuT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jul 2018 11:50:19 -0400
Date: Thu, 19 Jul 2018 17:06:42 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Ming Lei <ming.lei@redhat.com>, Martin Wilck <mwilck@suse.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] blkdev: __blkdev_direct_IO_simple: make sure to fill
 up the bio
Message-ID: <20180719150642.ppvxbapasfl2kqai@quack2.suse.cz>
References: <20180718075440.GA15254@ming.t460p>
 <20180719093918.28876-1-mwilck@suse.com>
 <20180719093918.28876-3-mwilck@suse.com>
 <20180719102122.GA20700@ming.t460p>
 <20180719103713.tfuqzagme7zze6md@quack2.suse.cz>
 <20180719110840.GZ30522@ZenIV.linux.org.uk>
 <20180719145351.GD21000@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180719145351.GD21000@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu 19-07-18 16:53:51, Christoph Hellwig wrote:
> On Thu, Jul 19, 2018 at 12:08:41PM +0100, Al Viro wrote:
> > > Well, there has never been a promise that it will grab *all* pages in the
> > > iter AFAIK. Practically, I think that it was just too hairy to implement in
> > > the macro magic that iter processing is... Al might know more (added to
> > > CC).
> > 
> > Not really - it's more that VM has every right to refuse letting you pin
> > an arbitrary amount of pages anyway.
> 
> In which case the code after this patch isn't going to help either, because
> it still tries to pin it all, just in multiple calls to get_user_pages().

Yeah. Actually previous version of the fix (not posted publicly) submitted
partial bio and then reused the bio to submit more. This is also the way
__blkdev_direct_IO operates. Martin optimized this to fill the bio
completely (as we know we have enough bvecs) before submitting which has
chances to perform better. I'm fine with either approach, just we have to
decide which way to go.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
