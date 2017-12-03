Return-Path: <ebiggers3@gmail.com>
Return-Path: <ebiggers3@gmail.com>
Date: Sun, 3 Dec 2017 12:24:34 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot <bot+583353673e394aa41e5fb68ddc8b8d9d5c8d576f@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com, rostedt@goodmis.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in blk_trace_remove
Message-ID: <20171203202434.GD844@zzz.localdomain>
References: <001a1141f8dc4440a9055e53896e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001a1141f8dc4440a9055e53896e@google.com>
List-ID: <linux-block@vger.kernel.org>

On Sun, Nov 19, 2017 at 02:36:01AM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> d9e0e63d9a6f88440eb201e1491fcf730272c706
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> 
> Unfortunately, I don't have any reproducer for this bug yet.
> 
> 
> Use struct sctp_sack_info instead
> 
> ============================================
> WARNING: possible recursive locking detected
> 4.14.0-rc8-next-20171110+ #40 Not tainted
> --------------------------------------------
> syz-executor6/21462 is trying to acquire lock:
>  (&q->blk_trace_mutex){+.+.}, at: [<ffffffff81760261>]
> blk_trace_remove+0x21/0x40 kernel/trace/blktrace.c:373
> 
> but task is already holding lock:
>  (&q->blk_trace_mutex){+.+.}, at: [<ffffffff81763b38>]
> blk_trace_setup+0x38/0x70 kernel/trace/blktrace.c:606
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:

#syz fix: blktrace: fix trace mutex deadlock
