Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: INFO: task hung in lo_release
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+a4e4a2663a21c3c3c2b1@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jan Kara <jack@suse.cz>
References: <000000000000f961390571457196@google.com>
 <4871d3cc-769e-b65a-8c05-bfaf6e6fdc69@I-love.SAKURA.ne.jp>
 <CACT4Y+Y0OjxACZNKpKpaJRjAAdwjozkR9PEti6Y+KhO4pRev+A@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c3f63c2f-f163-d626-f96e-9e274b037124@i-love.sakura.ne.jp>
Date: Sat, 3 Nov 2018 10:06:05 +0900
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Y0OjxACZNKpKpaJRjAAdwjozkR9PEti6Y+KhO4pRev+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2018/11/03 4:24, Dmitry Vyukov wrote:
>> Dmitry, it is impossible to check what these lock holders are doing without dump of these threads
>> (they are not always TASK_UNINTERRUPTIBLE waiters; e.g. PID=18508 is TASK_RUNNING with a lock held).
> 
> I know. One day I will hopefully get to implementing dump collection...
> 
>> Jens, when can we start testing "[PATCH v3] block/loop: Serialize ioctl operations." ?
> 
> Was that merged? If we have a potential fix, merging it may be the
> simplest way to address it without debugging.
> I see that this "[v4] block/loop: Serialize ioctl operations." still
> has "State: New":
> https://patchwork.kernel.org/patch/10612217/
> 

Jan Kara is going to resend https://marc.info/?i=20181010100415.26525-1-jack@suse.cz
after the merge window closes.
