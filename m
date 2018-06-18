Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: general protection fault in loop_validate_file
To: syzbot <syzbot+2f228435b0b9ec0ba068@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000006a6282056eeb71da@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <e9bd0998-b9ea-0028-b429-58baac69b877@I-love.SAKURA.ne.jp>
Date: Mon, 18 Jun 2018 23:51:30 +0900
MIME-Version: 1.0
In-Reply-To: <0000000000006a6282056eeb71da@google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2018/06/18 23:33, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    ce397d215ccd Linux 4.18-rc1
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=129dfccf800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f390986c4f7cd566
> dashboard link: https://syzkaller.appspot.com/bug?extid=2f228435b0b9ec0ba068
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.

This is a known bug. We are waiting for response from Jens Axboe at
http://lkml.kernel.org/r/748bce03-afda-4ed2-13b3-1fcd01d57770@kernel.dk .

#syz dup: general protection fault in lo_ioctl (2)
