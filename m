Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
To: osandov@osandov.com, axboe@fb.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        dvyukov@google.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] loop: fix LOOP_GET_STATUS lock imbalance
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <6bee3eddc24ef5525ca12efb023e66b2503cb178.1523033157.git.osandov@fb.com>
In-Reply-To: <6bee3eddc24ef5525ca12efb023e66b2503cb178.1523033157.git.osandov@fb.com>
Message-Id: <201804071627.IIG65113.FSHOFMtOVOFJLQ@I-love.SAKURA.ne.jp>
Date: Sat, 7 Apr 2018 16:27:01 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Commit 2d1d4c1e591f made loop_get_status() drop lo_ctx_mutex before
> returning, but the loop_get_status_old(), loop_get_status64(), and
> loop_get_status_compat() wrappers don't call loop_get_status() if the
> passed argument is NULL. The callers expect that the lock is dropped, so
> make sure we drop it in that case, too.
> 
> Reported-by: syzbot+31e8daa8b3fc129e75f2@syzkaller.appspotmail.com

Well, it is me who reported this bug before syzbot reports it. ;-)

> Fixes: 2d1d4c1e591f ("loop: don't call into filesystem while holding lo_ctl_mutex")

But I feel we should revert 2d1d4c1e591f rather than applying this patch.

> Signed-off-by: Omar Sandoval <osandov@fb.com>

If the reason of dropping the lock is to avoid deadlock caused by recursing
into the same lock from vfs_getattr(), it is correct thing to drop the lock.

But when the reason is that vfs_getattr() cannot return when NFS server is
dead, there is no point with dropping the lock. Anybody who tries to call
loop_get_status() will get stuck. It is commit 3148ffbdb9162baa ("loop:
use killable lock in ioctls") which actually helps minimizing number of
stuck processes when NFS server is dead if we didn't drop the lock.
If we drop the lock before calling vfs_getattr(), all threads who called
loop_get_status() will reach vfs_getattr() and get stuck, won't it?
