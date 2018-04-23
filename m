Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Subject: Re: general protection fault in wb_workfn
To: Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: syzbot <syzbot+9873874c735f2892e7e9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <000000000000e563d7056a35bbb3@google.com>
 <00db9c75-e498-5324-622b-685e6888601e@I-love.SAKURA.ne.jp>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <1a40d046-9994-ad02-8f29-c4952429e557@I-love.SAKURA.ne.jp>
Date: Tue, 24 Apr 2018 06:43:00 +0900
MIME-Version: 1.0
In-Reply-To: <00db9c75-e498-5324-622b-685e6888601e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 2018/04/23 19:09, Tetsuo Handa wrote:
> By the way, I got a newbie question regarding commit 5318ce7d46866e1d ("bdi:
> Shutdown writeback on all cgwbs in cgwb_bdi_destroy()"). It uses clear_bit()
> to clear WB_shutting_down bit so that threads waiting at wait_on_bit() will
> wake up. But clear_bit() itself does not wake up threads, does it? Who wakes
> them up (e.g. by calling wake_up_bit()) after clear_bit() was called?
> 

Below report might be waiting for wake_up_bit() ?

  INFO: task hung in wb_shutdown (2)
  https://syzkaller.appspot.com/bug?id=b297474817af98d5796bc544e1bb806fc3da0e5e
