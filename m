Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A22CC433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 14:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346421AbiCPOak (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 10:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356745AbiCPOak (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 10:30:40 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E23B4198B
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 07:29:24 -0700 (PDT)
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22GET97R013067;
        Wed, 16 Mar 2022 23:29:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Wed, 16 Mar 2022 23:29:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22GET9Fc013063
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 16 Mar 2022 23:29:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <926d498b-476c-018a-ddc6-4b776e49a0de@I-love.SAKURA.ne.jp>
Date:   Wed, 16 Mar 2022 23:29:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] loop: don't hold lo->lo_mutex from lo_open() and
 lo_release()
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+6479585dfd4dedd3f7e1@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org
References: <00000000000099c4ca05da07e42f@google.com>
 <bbdd20da-bccb-2dbb-7c46-be06dcfc26eb@I-love.SAKURA.ne.jp>
 <613b094e-2b76-11b7-458b-553aafaf0df7@I-love.SAKURA.ne.jp>
 <20220314152318.k4cvwe737q5r5juw@quack3.lan> <20220315084458.GA3911@lst.de>
 <134d1b65-f7c0-b8b3-d6c9-4a5e1d807afd@I-love.SAKURA.ne.jp>
 <20220316122614.6fmgrx55n4st7tsp@quack3.lan>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220316122614.6fmgrx55n4st7tsp@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/03/16 21:26, Jan Kara wrote:
>>> 1) Can you please remind me why do we need to also remove the lo_mutex from
>>> lo_open()? The original lockdep problem was only for __loop_clr_fd(),
>>> wasn't it?
>>
>> Right, but from locking dependency chain perspective, holding
>> lo->lo_mutex from lo_open()/lo_release() is treated as if
>> lo_open()/lo_release() waits for flush of I/O with lo->lo_mutex held,
>> even if it is not lo_open()/lo_release() which actually flushes I/O with
>> lo->lo_mutex held.
>>
>> We need to avoid holding lo->lo_mutex from lo_open()/lo_release() while
>> avoiding problems caused by not waiting for loop_configure()/__loop_clr_fd().
> 
> I thought the whole point of these patches is to move waiting for IO from
> under lo->lo_mutex and disk->open_mutex?

Excuse me? I couldn't tell you say "remove ... from ..." or "move ... from ... to ...".

The point of my patch is to avoid

  disk->open_mutex => lo->lo_mutex

  disk->open_mutex => loop_validate_mutex => lo->lo_mutex

dependency chain, for there is

  system_transition_mutex/1 => disk->open_mutex

dependency chain and

  blk_mq_freeze_queue()/blk_mq_unfreeze_queue()

are called with lo->lo_mutex held.

Christoph's "[PATCH 4/8] loop: don't freeze the queue in lo_release" and
"[PATCH 5/8] loop: only freeze the queue in __loop_clr_fd when needed" stops
calling blk_mq_freeze_queue()/blk_mq_unfreeze_queue() with lo->lo_mutex held
only from lo_release(). There are locations (e.g. __loop_update_dio()) which
calls blk_mq_freeze_queue()/blk_mq_unfreeze_queue() with lo->lo_mutex held.

>                                          And if we do that, there's no
> problem with open needing either of these mutexes? What am I missing?
> 
> Anyway, I have no problem with removing lo->lo_mutex from lo_open() as e.g.
> Christoph done it. I just disliked the task work magic you did there...
> 

Hmm, "these patches" === "yet another approach to fix the loop lock order inversions v3"
than my "[PATCH v2] loop: don't hold lo->lo_mutex from lo_open() and lo_release()" ?



>>> 2) Cannot we just move the generation of DISK_EVENT_MEDIA_CHANGE event
>>> after the moment the loop device is configured? That way systemd won't
>>> start probing the new loop device until it is fully configured.
>>
> Yes, something like that. But disk_force_media_change() has some
> invalidation in it as well and that may need to stay in the original place
> - needs a bit more thought & validation.

Yes, please. I don't know about invalidation.
But can't we instead remove

	if (lo->lo_state != Lo_bound)
		return BLK_STS_IOERR;

 from loop_queue_rq() ? There is some mechanism which can guarantee that crash
does not happen even if lo_queue_work() is called (blk_mq_*freeze_queue() ?),
isn't there?

> 
>> Such change will defer only open()->read() sequence triggered via
>> kobject_uevent(KOBJ_CHANGE). My patch defers all open() from userspace,
>> like we did until 5.11.
> 
> Correct. But EIO error is the correct return if you access unbound loop
> device. It is only after we tell userspace the device exists (i.e., after
> we send the event), when we should better make sure the IO succeeds.

Userspace may open this loop device with arbitrary delay; this is asyncronous
notification. By the moment some userspace process opens this loop device and
issues a read request as a response to "this device is ready", loop_clr_fd()
can be called (because lo_open() no longer holds lo->lo_mutex) by some other
process and this loop device can become unbound. There must be some mechanism
which can guarantee that crash does not happen.



> Sorry, I was wrong here. It will not cause deadlock. But in-kernel openers
> of the block device like swsusp_check() in kernel/power/swap.c (using
> blkdev_get_by_dev()) will be now operating on a loop device without waiting
> for __loop_clr_fd(). Which is I guess fine but the inconsistency between
> in-kernel and userspace bdev openers would be a bit weird.

It looks weired, but I think it is unavoidable in order to keep kernel
locking dependency chain simple, for in-kernel openers might be holding
e.g. system_transition_mutex/1.

>                                                            Anyway,
> Christophs patches look like a cleaner way forward to me...

My patch behaves as if

  int fd = open("/dev/loopX", 3);
  ioctl(fd, LOOP_CLR_FD);
  close(fd);

is automatically called when close() by the last user of /dev/loopX returns,
in order to keep kernel locking dependency chain short and simple.
Nothing difficult.

