Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
References: <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz> <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz> <20180611172053.GR1351649@devbig577.frc2.facebook.com>
 <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz> <b210e55c-b06a-41ff-8592-0dbe21875779@i-love.sakura.ne.jp>
 <20180613144606.nvbcyg2rdjpxhf7s@quack2.suse.cz>
In-Reply-To: <20180613144606.nvbcyg2rdjpxhf7s@quack2.suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Jun 2018 07:55:32 -0700
Message-ID: <CA+55aFzKrUdOV1RU+H4iOXkiCh+CoGmS1pvCP9Rybn8tTgWang@mail.gmail.com>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
To: Jan Kara <jack@suse.cz>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Tejun Heo <tj@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>, Jens Axboe <axboe@kernel.dk>,
	syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Dave Chinner <david@fromorbit.com>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 13, 2018 at 7:46 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 13-06-18 19:43:47, Tetsuo Handa wrote:
> > Can't we utilize RCU grace period (like shown below) ?
>
> Honestly, the variant 1 looks too ugly to me. However variant 2 looks
> mostly OK.

The versions that don't have that conditional locking look fine to me, yes.

> Also I'd avoid the addition argument to wb_writeback() and split the function instead. The
> patch resulting from your and mine ideas is attached. Thoughts?

Is there a reason for this model:

+               if (cgwb_start_shutdown(wb))
+                       __wb_shutdown(wb);

when there is just one call site of this? Why not just make the
function void, and make it do that __wb_shutdown() itself in the true
case?

IOW, just make it be

+               cgwb_shutdown(wb);

instead?

That's what "wb_shutdown()" does - it does the "wb_start_shutdown()"
test internally, and does __wb_shutdown() all inside itself, instead
of expecting the caller to do it.

I dunno.

              Linus

              Linus
