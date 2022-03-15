Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837DBC433FE
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 10:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347703AbiCOK7M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 06:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348044AbiCOK64 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 06:58:56 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DE335267
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 03:57:43 -0700 (PDT)
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22FAvQgf040704;
        Tue, 15 Mar 2022 19:57:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Tue, 15 Mar 2022 19:57:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22FAvQSq040699
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Mar 2022 19:57:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <134d1b65-f7c0-b8b3-d6c9-4a5e1d807afd@I-love.SAKURA.ne.jp>
Date:   Tue, 15 Mar 2022 19:57:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] loop: don't hold lo->lo_mutex from lo_open() and
 lo_release()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+6479585dfd4dedd3f7e1@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org
References: <00000000000099c4ca05da07e42f@google.com>
 <bbdd20da-bccb-2dbb-7c46-be06dcfc26eb@I-love.SAKURA.ne.jp>
 <613b094e-2b76-11b7-458b-553aafaf0df7@I-love.SAKURA.ne.jp>
 <20220314152318.k4cvwe737q5r5juw@quack3.lan> <20220315084458.GA3911@lst.de>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220315084458.GA3911@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/03/15 17:44, Christoph Hellwig wrote:
> On Mon, Mar 14, 2022 at 04:23:18PM +0100, Jan Kara wrote:
>> Honestly, the anon inode trick makes the code pretty much unreadable. As
>> far as I remember Christoph was not pricipially against using task_work. He
>> just wanted the task_work API to be improved so that it is easier to use.
> 
> This whole patch is awful.  And no, I don't think task_work_add really has
> any business here.  We need to properly unwind the mess instead of piling
> things higher and higher.

How do you plan to unwind the mess?



On 2022/03/15 0:23, Jan Kara wrote:
> On Mon 14-03-22 00:15:22, Tetsuo Handa wrote:
>> syzbot is reporting circular locking problem at __loop_clr_fd() [1], for
>> commit 87579e9b7d8dc36e ("loop: use worker per cgroup instead of kworker")
>> is calling destroy_workqueue() with disk->open_mutex held.
>>
>> Commit 322c4293ecc58110 ("loop: make autoclear operation asynchronous")
>> tried to fix this problem by deferring __loop_clr_fd() from lo_release()
>> to a WQ context, but that commit was reverted because there are userspace
>> programs which depend on that __loop_clr_fd() completes by the moment
>> close() returns to user mode.
>>
>> This time, we try to fix this problem by deferring __loop_clr_fd() from
>> lo_release() to a task work context. Since task_work_add() is not exported
>> but Christoph does not want to export it, this patch uses anonymous inode
>> interface as a wrapper for calling task_work_add() via fput().
>>
>> Although Jan has found two bugs in /bin/mount where one of these was fixed
>> in util-linux package [2], I found that not holding lo->lo_mutex from
>> lo_open() causes occasional I/O error [3] (due to
>>
>> 	if (lo->lo_state != Lo_bound)
>> 		return BLK_STS_IOERR;
>>
>> check in loop_queue_rq()) when systemd-udevd opens a loop device and
>> reads from it before loop_configure() updates lo->lo_state to Lo_bound.
> 
> Thanks for detailed explanation here. Finally, I can see what is the
> problem with the open path. A few questions here:
> 
> 1) Can you please remind me why do we need to also remove the lo_mutex from
> lo_open()? The original lockdep problem was only for __loop_clr_fd(),
> wasn't it?

Right, but from locking dependency chain perspective, holding lo->lo_mutex from
lo_open()/lo_release() is treated as if lo_open()/lo_release() waits for flush
of I/O with lo->lo_mutex held, even if it is not lo_open()/lo_release() which
actually flushes I/O with lo->lo_mutex held.

We need to avoid holding lo->lo_mutex from lo_open()/lo_release() while
avoiding problems caused by not waiting for loop_configure()/__loop_clr_fd().

> 
> 2) Cannot we just move the generation of DISK_EVENT_MEDIA_CHANGE event
> after the moment the loop device is configured? That way systemd won't
> start probing the new loop device until it is fully configured.

Do you mean

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1024,7 +1024,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
                goto out_unlock;
        }

-       disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
        set_disk_ro(lo->lo_disk, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);

        INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
@@ -1066,6 +1065,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
        wmb();

        lo->lo_state = Lo_bound;
+       disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
        if (part_shift)
                lo->lo_flags |= LO_FLAGS_PARTSCAN;
        partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;

? Maybe possible, but looks strange. Such change will defer only
open()->read() sequence triggered via kobject_uevent(KOBJ_CHANGE).
My patch defers all open() from userspace, like we did until 5.11.

> 
> Because the less hacks with task_work we have the better.
> 
> Also I don't think the deadlock is really fixed when you wait for
> __loop_clr_fd() during open. It is maybe just hidden from lockdep.

Since lo_post_open() is called with no locks held, how can waiting
for __loop_clr_fd() after lo_open() can cause deadlock? The reason to
choose task_work context is to synchronize without any other locks held.

Until 5.11, lo_open() and loop_configure() were serialized using
loop_ctl_mutex. In 5.12, lo_open() and loop_configure() started using
lo->lo_mutex, and serialization among multiple loop devices was fixed
in 5.13 using loop_validate_mutex. Therefore, basically we had been
waiting for loop_configure() and __loop_clr_fd() during open. My patch
just moves waiting for loop_configure() and __loop_clr_fd() in open
to outside of system_transition_mutex/1 and disk->open_mutex.

>                                                                    But the
> fundamental problem of the cycle syzbot constructed is that flushing of IO
> to a loop device may end up depending on open of that loop device to
> finish.

How can my patch depend on open of that loop device? It is task_work context.

>         So if pending __loop_clr_fd() is a problem for somebody (is it?),
> we still need to let open finish and deal with waiting for __loop_clr_fd()
> in other places where that actually causes problem (and make sure
> Lo_rundown is either treated as Lo_unbound or wait for Lo_rundown to
> transition to Lo_unbound).

lo_post_open() lets open finish and deal with waiting for __loop_clr_fd().

