Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969451AbdDTIa5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2017 04:30:57 -0400
Date: Thu, 20 Apr 2017 16:30:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>
Subject: Re: [PATCH 0/4] blk-mq-sched: allow to use hw tag for sched
Message-ID: <20170420083041.GA1637@ming.t460p>
References: <20170415123825.32716-1-ming.lei@redhat.com>
 <cafbd7d9-1027-5282-6f1a-48f7ccec3d45@fb.com>
 <20170420004410.GA16917@ming.t460p>
 <90e249d6-996c-a8d9-f54d-e8142082bfa5@fb.com>
 <20170420010346.GC16917@ming.t460p>
 <20170420045408.GB2235@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170420045408.GB2235@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Christoph,

On Wed, Apr 19, 2017 at 09:54:08PM -0700, Christoph Hellwig wrote:
> On Thu, Apr 20, 2017 at 09:03:47AM +0800, Ming Lei wrote:
> > If we don't need to reserve tag for internal command, I am happy
> > to fix it in the interim. However, the mtip32xx driver has to
> > ask blk-mq to reserve the tag zero for internal command. Then
> > if we can't allow the driver to use that reserved tag, it looks
> > quite awkward, doesn't it?
> 
> It doesn't.  Just offset the hardware tags by 1 from the blk-mq tags.
> 
> But I'm pretty sure the hardware wouldn't require a specific tag
> for the internal ops.

>From mtip32xx code, the tag 0 is used to send internal command only, and
not used for submitting normal request.

>From code of mtip_issue_non_ncq_command() and mtip_issue_ncq_command(),
even same hardware address is writen to when issuing non-ncq and ncq
commands. So I think the internal ops and normal requests share one same
tag space on mtip32xx.

Could you explain it a bit why you think the hw doesn't need the tag
for internal ops in this case?

Thanks,
Ming
