Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Sat, 26 May 2018 19:36:02 -0700
From: Tejun Heo <tj@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, axboe@kernel.dk, david@fromorbit.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
Message-ID: <20180527023602.GE1351649@devbig577.frc2.facebook.com>
References: <000000000000cbd959056d1851ca@google.com>
 <0c7c5dea-7312-8a59-9d1b-5467f69719bf@I-love.SAKURA.ne.jp>
 <314ae2e0-c873-04ce-9cd5-fe2acadaee26@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <314ae2e0-c873-04ce-9cd5-fe2acadaee26@I-love.SAKURA.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Sun, May 27, 2018 at 11:21:25AM +0900, Tetsuo Handa wrote:
> From 8a8222698163d1fe180258566e9a3ff43f54fcd9 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sun, 27 May 2018 11:08:20 +0900
> Subject: [PATCH] bdi: Fix another oops in wb_workfn()
> 
> syzbot is still hitting NULL pointer dereference at wb_workfn() [1].
> This might be because we overlooked that delayed_work_timer_fn() does not
> check WB_registered before calling __queue_work() while mod_delayed_work()
> does not wait for already started delayed_work_timer_fn() because it uses
> del_timer() rather than del_timer_sync().

It shouldn't be that as dwork timer is an irq safe timer.  Even if
that's the case, the right thing to do would be fixing workqueue
rather than reaching into workqueue internals from backing-dev code.

Thanks.

-- 
tejun
