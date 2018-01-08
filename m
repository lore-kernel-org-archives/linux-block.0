Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:44256 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeAHMHr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jan 2018 07:07:47 -0500
Date: Mon, 8 Jan 2018 04:07:42 -0800
From: Tejun Heo <tj@kernel.org>
To: xuejiufei <xuejiufei@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Shaohua Li <shli@kernel.org>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        jinli.zjl@alibaba-inc.com, qijiang.qj@alibaba-inc.com
Subject: Re: [RFC PATCH] blk-throttle: dispatch more sync writes in block
 throttle layer
Message-ID: <20180108120742.GJ3668920@devbig577.frc2.facebook.com>
References: <f6f59e3c-456a-8275-8af0-32e4f2e5cdd6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f6f59e3c-456a-8275-8af0-32e4f2e5cdd6@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Fri, Jan 05, 2018 at 01:16:26PM +0800, xuejiufei wrote:
> From: Jiufei Xue <jiufei.xjf@alibaba-inc.com>
> 
> Cgroup writeback is supported since v4.2. But there exists a problem
> in the following case.
> 
> A cgroup may send both buffer and direct/sync IOs. The foreground
> thread will be stalled when periodic writeback IOs is flushed because
> the service queue in block throttle layer already has a plenty of
> writeback IOs, then foreground IOs should be enqueued with its FIFO
> policy. The current policy is dispatching 6 reads and 2 writes during
> each round, sync writes will be significantly delayed.
> 
> This patch adds another queue in block throttle. Now there are 3 queues
> in a service queue: read, sync write, async write, and we can dispatch
> more sync writes than aync writes.

We usually handle sync writes together with reads instead of
introducing a separate queue for sync writes.

Thanks.

-- 
tejun
