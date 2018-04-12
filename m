Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:42520 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751755AbeDLH1X (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Apr 2018 03:27:23 -0400
From: tang.junhui@zte.com.cn
To: colyli@suse.de
Cc: kent.overstreet@gmail.com, mlyle@lyle.org,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: Re: [PATCH 0/4] bcache: incremental GC and dirty data init
Date: Thu, 12 Apr 2018 15:27:28 +0800
Message-Id: <1523518048-16115-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Coly,

> On 2018/4/12 2:38 PM, tang.junhui@zte.com.cn wrote:
> > Hi maintainers and folks,
> > 
> > Some patches of this patch set have been sent before, they are not merged
> > yet, and I add two new patches to solve some issues I found while testing.
> > since They are interdependent, so I make a patch set and resend them.
> > 
> > [PATCH 1/4] bcache: finish incremental GC
> > [PATCH 2/4] bcache: calculate the number of incremental GC nodes according to
> >             the total of btree nodes
> > [PATCH 3/4] bcache: notify allocator to prepare for GC
> > [PATCH 4/4] bcache: fix I/O significant decline while backend devices registering
> > 
> > These patches are useful to prevent I/O fluctuations or even jump 0 while GC or
> > cached devices registering. I have test them for some times, I hope somebody could
> > have a review for these patch, any comment would be welcome.
> > 
> 
> Hi Junhui,
> 
> Copied, these patches are in my to-review list :-)

Thanks for your quick response, you are always so warm to me.
I am looking forward to your comments.

Thanks.

Tang Junhui
