Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36126 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753038AbdBCXys (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Feb 2017 18:54:48 -0500
Received: by mail-pg0-f48.google.com with SMTP id v184so10430163pgv.3
        for <linux-block@vger.kernel.org>; Fri, 03 Feb 2017 15:54:47 -0800 (PST)
Date: Fri, 3 Feb 2017 15:54:15 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: Re: [PATCH] blk-mq-sched: separate mark hctx and queue restart
 operations
Message-ID: <20170203235415.GA2686@vader.DHCP.thefacebook.com>
References: <0e041bc5f968fd15d86f1a89789c30ea82dd96ab.1486150202.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0e041bc5f968fd15d86f1a89789c30ea82dd96ab.1486150202.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Feb 03, 2017 at 11:35:58AM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> In blk_mq_sched_dispatch_requests(), we call blk_mq_sched_mark_restart()
> after we dispatch requests left over on our hardware queue dispatch
> list. This is so we'll go back and dispatch requests from the scheduler.
> In this case, it's only necessary to restart the hardware queue that we
> are running; there's no reason to run other hardware queues just because
> we are using shared tags.
> 
> So, split out blk_mq_sched_mark_restart() into two operations: the "all"
> variant is for when we really need to mark the request queue as needing
> a restart, and we'll keep the original for just the hardware queue.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> Based on block/for-next. There might be a better name for this.
> 
>  block/blk-mq-sched.h | 15 +++++++++++++++
>  block/blk-mq.c       |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)

Actually, I think I want to do this slightly differently, ignore this
for now.
