Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43534 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbeACRIt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jan 2018 12:08:49 -0500
Received: by mail-pl0-f65.google.com with SMTP id z5so1594375plo.10
        for <linux-block@vger.kernel.org>; Wed, 03 Jan 2018 09:08:49 -0800 (PST)
Subject: Re: [PATCH v1 01/10] bcache: exit bch_writeback_thread() with proper
 task state
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, tang.junhui@zte.com.cn
References: <20180103140325.63175-1-colyli@suse.de>
 <20180103140325.63175-2-colyli@suse.de>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <5cd9f028-366a-ba94-3bdf-0aefd5028c21@lyle.org>
Date: Wed, 3 Jan 2018 09:08:47 -0800
MIME-Version: 1.0
In-Reply-To: <20180103140325.63175-2-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/03/2018 06:03 AM, Coly Li wrote:
> Kernel thread routine bch_writeback_thread() has the following code block,
> 
> 452                         set_current_state(TASK_INTERRUPTIBLE);
> 453
> 454                         if (kthread_should_stop())
> 455                                 return 0;
> 456
> 457                         schedule();
> 458                         continue;
> 
> At line 452, its status is set to TASK_INTERRUPTIBLE, and at line 454 if
> kthread_should_stop() is true, a "return 0" at line 455 will to function
> kernel/kthread.c:kthread() and call do_exit().
> 
> It is not good to enter do_exit() with task state TASK_INTERRUPTIBLE, in
> following code path might_sleep() is called and a warning message is
> reported by __might_sleep(): "WARNING: do not call blocking ops when
> !TASK_RUNNING; state=1 set at [xxxx]".
> 
> Indeed it does not hurt when kernel thread exits with TASK_INTERRUPTIBLE
> state, but this warning message scares users, makes them feel there might
> be something risky with bcache and hurt their data.
> 
> In this patch, TASK_INTERRUPTIBLE is set after kthread_should_stop(),
> so writeback kernel thread can exist and enter do_exit() with
> TASK_RUNNING state. Warning message from might_sleep() is removed.
> 
> Signed-off-by: Coly Li <colyli@suse.de>

Reviewed-by: Michael Lyle <mlyle@lyle.org>
