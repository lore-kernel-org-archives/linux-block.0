Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
References: <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz> <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz> <20180611172053.GR1351649@devbig577.frc2.facebook.com>
 <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz> <b210e55c-b06a-41ff-8592-0dbe21875779@i-love.sakura.ne.jp>
 <20180613144606.nvbcyg2rdjpxhf7s@quack2.suse.cz> <7f4ae045-dfe4-6677-7418-f6f60b6c26f1@i-love.sakura.ne.jp>
In-Reply-To: <7f4ae045-dfe4-6677-7418-f6f60b6c26f1@i-love.sakura.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Jun 2018 09:25:03 -0700
Message-ID: <CA+55aFx=CwNCg08HUeyYWc-WWuPkQBXVJDvHfrBjraTy-3MRWQ@mail.gmail.com>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
	Jens Axboe <axboe@kernel.dk>, syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Dave Chinner <david@fromorbit.com>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 13, 2018 at 9:21 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since multiple addresses share bit_wait_table[256], isn't it possible that
> cgwb_start_shutdown() prematurely returns false due to wake_up_bit() by
> hash-conflicting addresses (i.e. not limited to clear_and_wake_up_bit() from
> wb_shutdown())? I think that we cannot be sure without confirming that
> test_bit(WB_shutting_down, &wb->state) == false after returning from schedule().

Right.

That's _always_ true, btw. Something else entirely could have woken
you up. TASK_UNINTERRUPTIBLE does not mean "nothing else wakes me", it
just means "_signals_ don't wake me".

So every single sleep always needs to be in a loop. Always.

              Linus
