Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: general protection fault in wb_workfn (2)
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <95865cab-e12f-d45b-b6e3-465b624862ba@i-love.sakura.ne.jp>
 <CACT4Y+byRRtCA9B9bPG9mjrf3UY3OsGeBsoh8dZ0T+V6tKpTHg@mail.gmail.com>
 <201806080231.w582VIRn021009@www262.sakura.ne.jp>
 <CACT4Y+Y7Mj1JngLst1aRHDhURXQMn-eTjyPFjDdGAT0ZV-dHrw@mail.gmail.com>
 <CACT4Y+bBfwpcP2h0URpqwiNMQ5SFJdPDHThUu2xetmrxgC+3BQ@mail.gmail.com>
 <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
Date: Sat, 9 Jun 2018 14:30:41 +0900
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Dmitry Vyukov wrote:
> Here we go:

Great. Thank you.

> 
> [ 2853.033175] WARNING: wb_workfn: device is NULL
> [ 2853.034709] wb->state=2
> 

It is surprising that wb->state == WB_shutting_down .

WB_shutting_down is set by only wb_shutdown() and is always cleared
before leaving wb_shutdown(). This means that someone was calling
wb_shutdown() on this wb object. And bdi->dev == NULL means that
bdi_unregister() already did bdi->dev = NULL while someone was still
inside wb_shutdown().

Since we call wb_shutdown() from bdi_unregister() for each wb object
on this bdi object, this should not happen. But since "INFO: task hung
in wb_shutdown (2)" found that it is possible that wb_shutdown() is
concurrently called on the same wb object, there might be something
complicated concurrency.

Well, is it really true that "we call wb_shutdown() from bdi_unregister()
for each wb object on this bdi object"? It seems it is not always true...

While cgwb_bdi_unregister() from bdi_unregister() calls wb_shutdown() on
each wb object reachable from bdi->wb_list, wb_shutdown() firstly calls
list_del_rcu(&wb->bdi_node) (which was added by
list_add_tail_rcu(&wb->bdi_node, &bdi->wb_list) from cgwb_create()) and
then starts waiting for that wb object by calling
mod_delayed_work()/flush_delayed_work() and then clears WB_shutting_down.

Then, it is possible that cgwb_bdi_unregister() from calls wb_shutdown()
fails to find a wb object which already passed list_del_rcu() from
wb_shutdown(), and cgwb_bdi_unregister() can return without waiting for
somebody who is waiting inside wb_shutdown(). Hence, allows doing
bdi->dev = NULL before a wb object which somebody is waiting inside
wb_shutdown() completes wb_workfn(), and NULL pointer dereference...
