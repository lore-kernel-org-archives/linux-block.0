Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763031AbdDTBD6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2017 21:03:58 -0400
Date: Thu, 20 Apr 2017 09:03:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>
Subject: Re: [PATCH 0/4] blk-mq-sched: allow to use hw tag for sched
Message-ID: <20170420010346.GC16917@ming.t460p>
References: <20170415123825.32716-1-ming.lei@redhat.com>
 <cafbd7d9-1027-5282-6f1a-48f7ccec3d45@fb.com>
 <20170420004410.GA16917@ming.t460p>
 <90e249d6-996c-a8d9-f54d-e8142082bfa5@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <90e249d6-996c-a8d9-f54d-e8142082bfa5@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Apr 19, 2017 at 06:55:30PM -0600, Jens Axboe wrote:
> On 04/19/2017 06:44 PM, Ming Lei wrote:
> > On Wed, Apr 19, 2017 at 02:17:45PM -0600, Jens Axboe wrote:
> >> On 04/15/2017 06:38 AM, Ming Lei wrote:
> >>> The 1st patch enhances BLK_MQ_F_NO_SCHED so that we can't change/
> >>> show available io schedulers on devices which don't support io
> >>> scheduler.
> >>>
> >>> The 2nd patch passes BLK_MQ_F_NO_SCHED for avoiding one regression
> >>> on mtip32xx, which is introduced by blk-mq io scheduler.
> >>
> >> I've added 1-2 for 4.11 for now, and then let's plan on getting
> >> a real fix done for 4.12.
> > 
> > The real fix has been posted out already:
> > 
> > 	http://marc.info/?t=149256196700001&r=1&w=2
> > 
> > Could you consider that for 4.12?
> 
> I didn't particularly like that approach. And we are really late
> in the 4.11 cycle, and your first two patches fit the bill for
> how we should fix it in the interim.

If we don't need to reserve tag for internal command, I am happy
to fix it in the interim. However, the mtip32xx driver has to
ask blk-mq to reserve the tag zero for internal command. Then
if we can't allow the driver to use that reserved tag, it looks
quite awkward, doesn't it?

> I'll take a closer look for 4.12, I want to get this fixed
> for real, obviously.

OK, thanks, let's discuss on solutions.

Thanks,
Ming
