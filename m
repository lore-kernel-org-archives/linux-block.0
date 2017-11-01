Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbdKARXK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Nov 2017 13:23:10 -0400
Date: Thu, 2 Nov 2017 01:22:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>, "axboe@fb.com" <axboe@fb.com>,
        "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Message-ID: <20171101172253.GC7152@ming.t460p>
References: <20171027044330.11921-1-ming.lei@redhat.com>
 <1509079996.3244.3.camel@wdc.com>
 <20171027053834.GA12858@ming.t460p>
 <1509395096.27259.15.camel@wdc.com>
 <20171031014728.GA12070@ming.t460p>
 <1509508448.2604.4.camel@wdc.com>
 <20171101040755.GB9527@ming.t460p>
 <1509554825.2530.32.camel@wdc.com>
 <20171101165902.GB7152@ming.t460p>
 <1509556180.2530.41.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509556180.2530.41.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Nov 01, 2017 at 05:09:41PM +0000, Bart Van Assche wrote:
> On Thu, 2017-11-02 at 00:59 +0800, Ming Lei wrote:
> > The commit has described clearly that we don't need to iterate over all hw
> > queue when completing an I/O.
> 
> You quoted a small part of the description of commit da55f2cc7841 and left out
> the part that shows that what you wrote above is not correct.

If you mean the 1st part:

    Commit 50e1dab86aa2 ("blk-mq-sched: fix starvation for multiple hardware
    queues and shared tags") fixed one starvation issue for shared tags.
    However, we can still get into a situation where we fail to allocate a
    tag because all tags are allocated but we don't have any pending
    requests on any hardware queue.

That is just what this commit wants to address, then we don't need to
depend on restart from all hctx for fixing this starvation.

If you don't believe me, you can ask Omar and Jens to clarify.

-- 
Ming
