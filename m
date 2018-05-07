Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: general protection fault in lo_ioctl (2)
To: Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>
References: <000000000000cbaaf6056b341859@google.com>
 <CACT4Y+bTo34q4=7X8zGL_XVOGoYd7fqhfAbCAWUxsr-N96Kyxw@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <2030b2cf-29f9-7bfd-8266-b39abc19bdfe@I-love.SAKURA.ne.jp>
Date: Tue, 8 May 2018 05:56:15 +0900
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bTo34q4=7X8zGL_XVOGoYd7fqhfAbCAWUxsr-N96Kyxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2018/05/02 20:23, Dmitry Vyukov wrote:
> #syz dup: INFO: rcu detected stall in blkdev_ioctl

The cause of stall turned out to be ioctl(loop_fd, LOOP_CHANGE_FD, loop_fd).

But we haven't explained the cause of NULL pointer dereference which can
occur when raced with ioctl(LOOP_CLR_FD). Therefore,

#syz undup
