Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28320 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752980AbcJCVtw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Oct 2016 17:49:52 -0400
Date: Mon, 3 Oct 2016 18:00:41 -0400
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: Return invalid cookie if bio was split
Message-ID: <20161003220040.GA1259@localhost.localdomain>
References: <20160926230030.GB24200@localhost.localdomain>
 <20160927172536.53a1315f@tom-ThinkPad-T450>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160927172536.53a1315f@tom-ThinkPad-T450>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 27, 2016 at 05:25:36PM +0800, Ming Lei wrote:
> On Mon, 26 Sep 2016 19:00:30 -0400
> Keith Busch <keith.busch@intel.com> wrote:
> 
> > The only user of polling requires its original request be completed in
> > its entirety before continuing execution. If the bio needs to be split
> > and chained for any reason, the direct IO path would have waited for just
> > that split portion to complete, leading to potential data corruption if
> > the remaining transfer has not yet completed.
> 
> The issue looks a bit tricky because there is no per-bio place for holding
> the cookie, and generic_make_request() only returns the cookie for the
> last bio in the current bio list, so maybe we need the following patch too.

I'm looking more into this, and I can't see why we're returning a cookie
to poll on in the first place. blk_poll is only invoked when we could have
called io_schedule, so we expect the task state gets set to TASK_RUNNING
when all the work completes. So why do we need to poll for a specific
tag instead of polling until task state is set back to running?

I've tried this out and it seems to work fine, and should fix any issues
from split IO requests. It also helps direct IO polling, since it can
have a list of bios, but can only save one cookie.
