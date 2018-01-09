Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34284 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756009AbeAIO5F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jan 2018 09:57:05 -0500
Date: Tue, 9 Jan 2018 06:56:59 -0800
From: Tejun Heo <tj@kernel.org>
To: xuejiufei <xuejiufei@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Shaohua Li <shli@kernel.org>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        jinli.zjl@alibaba-inc.com, qijiang.qj@alibaba-inc.com
Subject: Re: [RFC PATCH] blk-throttle: dispatch more sync writes in block
 throttle layer
Message-ID: <20180109145659.GG3668920@devbig577.frc2.facebook.com>
References: <f6f59e3c-456a-8275-8af0-32e4f2e5cdd6@gmail.com>
 <20180108120742.GJ3668920@devbig577.frc2.facebook.com>
 <5ff01c31-5277-909f-4c35-9b9be513d8e1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5ff01c31-5277-909f-4c35-9b9be513d8e1@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Tue, Jan 09, 2018 at 12:45:13PM +0800, xuejiufei wrote:
> 1. A bio is charged according to the direction, if we put the reads
> and sync writes together, we need to search the queue to pick a
> certain number of read and write IOs when the limit is not reached.

Ah, you're right.

> 2. I found that the multi-queue scheduler kyber also has three queues:
> one for read, one for sync write and one for others. This patch
> introduces another queue for async writes and others just like kyber.

Yeah, it'd make sense to make that a separate queue then.

Thanks.

-- 
tejun
