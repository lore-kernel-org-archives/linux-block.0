Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752139AbdATPwZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2017 10:52:25 -0500
Date: Fri, 20 Jan 2017 10:41:52 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Hou Tao <houtao1@huawei.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, agk@redhat.com, ejt@redhat.com,
        vgoyal@redhat.com
Subject: Re: [PATCH RFC 0/4] dm thin: support blk-throttle on data and
 metadata device
Message-ID: <20170120154152.GA2933@redhat.com>
References: <1484910952-29820-1-git-send-email-houtao1@huawei.com>
 <x49bmv192th.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <x49bmv192th.fsf@segfault.boston.devel.redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 20 2017 at 10:19am -0500,
Jeff Moyer <jmoyer@redhat.com> wrote:

> Hou Tao <houtao1@huawei.com> writes:
> 
> > Hi all,
> >
> > We need to throttle the O_DIRECT IO on data and metadata device
> > of a dm-thin pool and encounter some problems. If we set the
> > limitation on the root blkcg, the throttle works. If we set the
> > limitation on a child blkcg, the throttle doesn't work well.
> >
> > The reason why the throttle doesn't work is that dm-thin defers
> > the process of bio when the physical block of bio has not been
> > allocated. The bio will be submitted by the pool worker, and the
> > blkcg of the bio will be the blkcg of the pool worker, namely,
> > the root blkcg instead of the blkcg of the original IO thread.
> > We only set a limitation on the blkcg of the original IO thread,
> > so the blk-throttle doesn't work well.
> >
> > In order to handle the situation, we add a "keep_bio_blkcg" feature
> > to dm-thin. If the feature is enabled, the original blkcg of bio
> > will be saved at thin_map() and will be used during blk-throttle.
> 
> Why is this even an option?  I would think that you would always want
> this behavior.

Right, shouldn't be an optional feature.

Also, this implementation is very dm-thin specific.  I still have this
line of work on my TODO because there should be a more generic way to
wire up these associations in either block core or DM core.

Now that there is both dm-crypt and dm-thin specific RFC patches to fix
this I'll see about finding a solution that works for both but that is
more generic.

Not sure how quickly I'll get to this but I'll do my best.
