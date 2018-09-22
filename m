Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH v3 (resend)] block/loop: Serialize ioctl operations.
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        syzbot
 <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
        syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
References: <1537009136-4839-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <1af79300-cb04-36e3-a650-168a5942161f@i-love.sakura.ne.jp>
Date: Sat, 22 Sep 2018 21:39:02 +0900
MIME-Version: 1.0
In-Reply-To: <1537009136-4839-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hello, Ming Lei.

I'd like to hear your comment on this patch regarding the ordering of
stopping kernel thread.

  > In order to enforce this strategy, this patch inversed
  > loop_reread_partitions() and loop_unprepare_queue() in loop_clr_fd().
  > I don't know whether it breaks something, but I don't have testcases.

Until 3.19, kthread_stop(lo->lo_thread) was called before
ioctl_by_bdev(bdev, BLKRRPART, 0) is called.
During 4.0 to 4.3, the loop module was using "kloopd" workqueue.
But since 4.4, loop_reread_partitions(lo, bdev) is called before
loop_unprepare_queue(lo) is called. And this patch is trying to change to
call loop_unprepare_queue() before loop_reread_partitions() is called.
Is there some reason we need to preserve current ordering?

Relevant commits:

  commit b5dd2f6047ca108001328aac0e8588edd15f1778
  block: loop: improve performance via blk-mq

  commit e03a3d7a94e2485b6e2fa3fb630b9b3a30b65718
  block: loop: use kthread_work
