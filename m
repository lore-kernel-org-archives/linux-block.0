Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH 0/15 v2] loop: Fix oops and possible deadlocks
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20181010100415.26525-1-jack@suse.cz>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a40fcf62-85a4-a6be-0803-d99dedf8cc61@i-love.sakura.ne.jp>
Date: Wed, 10 Oct 2018 19:19:00 +0900
MIME-Version: 1.0
In-Reply-To: <20181010100415.26525-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2018/10/10 19:04, Jan Kara wrote:
> Hi,
> 
> this patch series fixes oops and possible deadlocks as reported by syzbot [1]
> [2]. The second patch in the series (from Tetsuo) fixes the oops, the remaining
> patches are cleaning up the locking in the loop driver so that we can in the
> end reasonably easily switch to rereading partitions without holding mutex
> protecting the loop device.
> 
> I have lightly tested the patches by creating, deleting, and modifying loop
> devices but if there's some more comprehensive loopback device testsuite, I
> can try running it. Review is welcome!

Testing on linux-next by syzbot will be the most comprehensive. ;-)

> 
> Changes since v1:
> * Added patch moving fput() calls in loop_change_fd() from under loop_ctl_mutex
> * Fixed bug in loop_control_ioctl() where it failed to return error properly
> 
> 								Honza
> 
> [1] https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3
> [2] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889
> 
