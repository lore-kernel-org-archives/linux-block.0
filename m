Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34607 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755788AbcKWVLN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2016 16:11:13 -0500
Date: Wed, 23 Nov 2016 16:11:10 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V4 02/15] blk-throttle: add .high interface
Message-ID: <20161123211018.GA11306@mtj.duckdns.org>
References: <cover.1479161136.git.shli@fb.com>
 <239e20c62e028b570f48403faea1419c4d84f2bd.1479161136.git.shli@fb.com>
 <20161122200253.GA17534@htj.duckdns.org>
 <20161122230836.GA14628@shli-mbp.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161122230836.GA14628@shli-mbp.local>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Tue, Nov 22, 2016 at 03:08:36PM -0800, Shaohua Li wrote:
> Yep, the limit could be high or max. It's doable moving the restrictions on
> input, but will increase trouble using the limits. If high is bigger than max,
> can I set high to max? if not, I'd prefer to keep the restrictions.

You can do that internally but userland should keep seeing what it
configured.

> > I haven't read the whole thing yet but this looks a bit suspicious.  A
> > css going offline indicates that the destruction of the css started.
> > I don't get why that'd reset high limits.  There can be a lot of async
> > IOs after offline.
> 
> Ok. We do want to reset the limits. Because if no cgroup has high limit, we
> definitively should use max limit for all cgroups. The whole state machine
> (switching between high and max limit) is meaningless in that case.
> 
> Is pd_free_fn a good place to guarantee anyc IOs finish?

Yeap.

Thanks.

-- 
tejun
