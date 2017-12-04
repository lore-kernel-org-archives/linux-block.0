Return-Path: <efault@gmx.de>
Message-ID: <1512359270.8335.7.camel@gmx.de>
Subject: Re: possible deadlock in blk_trace_remove
From: Mike Galbraith <efault@gmx.de>
To: Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers3@gmail.com>
Cc: syzbot
 <bot+583353673e394aa41e5fb68ddc8b8d9d5c8d576f@syzkaller.appspotmail.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com,  rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Date: Mon, 04 Dec 2017 04:47:50 +0100
In-Reply-To: <33f25849-1aff-8464-6467-47ce55d1c0b1@kernel.dk>
References: <001a1141f8dc4440a9055e53896e@google.com>
	 <20171203202434.GD844@zzz.localdomain>
	 <9f7ab661-7d57-3e84-769c-6d103557f342@kernel.dk>
	 <20171204004427.GA13374@zzz.localdomain>
	 <33f25849-1aff-8464-6467-47ce55d1c0b1@kernel.dk>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Sun, 2017-12-03 at 17:47 -0700, Jens Axboe wrote:
> On 12/03/2017 05:44 PM, Eric Biggers wrote:
> > 
> >>> #syz fix: blktrace: fix trace mutex deadlock
> >>
> >> This is fixed in current -git.
> >>
> > 
> > I know, but syzbot needed to be told what commit fixes the bug.
> > See https://github.com/google/syzkaller/blob/master/docs/syzbot.md
> 
> Ah gotcha.

"@syzbot fix: bla" syntax would have been intuitive.

	-Mike
