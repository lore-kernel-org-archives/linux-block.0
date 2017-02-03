Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35009 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdBCQof (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Feb 2017 11:44:35 -0500
Received: by mail-pg0-f53.google.com with SMTP id 194so7964427pgd.2
        for <linux-block@vger.kernel.org>; Fri, 03 Feb 2017 08:44:35 -0800 (PST)
Date: Fri, 3 Feb 2017 08:44:04 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, paolo.valente@linaro.org
Subject: Re: [PATCH 2/2] block: free merged request in the caller
Message-ID: <20170203164404.GB26515@vader>
References: <1486051573-13445-1-git-send-email-axboe@fb.com>
 <1486051573-13445-3-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486051573-13445-3-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 02, 2017 at 09:06:13AM -0700, Jens Axboe wrote:
> If we end up doing a request-to-request merge when we have completed
> a bio-to-request merge, we free the request from deep down in that
> path. For blk-mq-sched, the merge path has to hold the appropriate
> lock, but we don't need it for freeing the request. And in fact
> holding the lock is problematic, since we are now calling the
> mq sched put_rq_private() hook with the lock held. Other call paths
> do not hold this lock.
> 
> Fix this inconsistency by ensuring that the caller frees a merged
> request. Then we can do it outside of the lock, making it both more
> efficient and fixing the blk-mq-sched problem of invoking parts of
> the scheduler with an unknown lock state.
> 
> Reported-by: Paolo Valente <paolo.valente@linaro.org>

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-core.c     | 12 +++++++++---
>  block/blk-merge.c    | 15 ++++++++++++---
>  block/blk-mq-sched.c |  9 ++++++---
>  block/blk-mq-sched.h |  3 ++-
>  block/mq-deadline.c  |  8 ++++++--
>  5 files changed, 35 insertions(+), 12 deletions(-)
