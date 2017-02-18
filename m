Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38229 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752765AbdBRDJN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 22:09:13 -0500
Subject: Re: [PATCH 1/2] blk-mq: use sbq wait queues instead of restart for
 driver tags
To: Omar Sandoval <osandov@osandov.com>, <linux-block@vger.kernel.org>
References: <d91d1df06ad9292459400637118bca8d09c88dcf.1487379857.git.osandov@fb.com>
CC: <kernel-team@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <d430e385-258a-9372-4c79-e0c098f84b90@fb.com>
Date: Fri, 17 Feb 2017 20:08:43 -0700
MIME-Version: 1.0
In-Reply-To: <d91d1df06ad9292459400637118bca8d09c88dcf.1487379857.git.osandov@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/17/2017 06:05 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Commit 50e1dab86aa2 ("blk-mq-sched: fix starvation for multiple hardware
> queues and shared tags") fixed one starvation issue for shared tags.
> However, we can still get into a situation where we fail to allocate a
> tag because all tags are allocated but we don't have any pending
> requests on any hardware queue.
> 
> One solution for this would be to restart all queues that share a tag
> map, but that really sucks. Ideally, we could just block and wait for a
> tag, but that isn't always possible from blk_mq_dispatch_rq_list().
> 
> However, we can still use the struct sbitmap_queue wait queues with a
> custom callback instead of blocking. This has a few benefits:
> 
> 1. It avoids iterating over all hardware queues when completing an I/O,
>    which the current restart code has to do.
> 2. It benefits from the existing rolling wakeup code.
> 3. It avoids punting to another thread just to have it block.

This is a great and innovative solution to this problem, it's much
better than stacked restart bits. Thanks Omar, I'll queue this up
for testing.

-- 
Jens Axboe
