Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750992AbdIMQoc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Sep 2017 12:44:32 -0400
Date: Thu, 14 Sep 2017 00:44:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] blk-mq: don't allocate driver tag beforehand for flush rq
Message-ID: <20170913164419.GA10407@ming.t460p>
References: <20170913133230.13639-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170913133230.13639-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 13, 2017 at 09:32:30PM +0800, Ming Lei wrote:
> The behind idea is simple:
> 
> 1) for none scheduler, driver tag has to be borrowed for flush
> rq, otherwise we may run out of tag, and IO hang is caused.
> get/put driver tag is actually a nop, so reorder tags isn't
> necessary at all.
> 
> 2) for real I/O scheduler, we needn't to allocate driver tag
> beforehand for flush rq, and it works just fine to follow the
> way for normal requests: allocate driver tag for each rq just
> before calling .queue_rq().
> 
> Then flush rq isn't treated specially wrt. get/put driver tag,
> codes get cleanup much, such as, reorder_tags_to_front() is
> removed, needn't to worry about request order in dispatch list
> any more.
> 
> One visible change to driver is that flush rq's tag may not be
> same with the data rq in flush sequence, that won't be a
> problem, since we always do that in legacy path.

Please ignore this patch, since looks there is one issue.

-- 
Ming
