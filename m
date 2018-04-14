Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: WARNING: lock held when returning to user space!
To: Jens Axboe <axboe@kernel.dk>, Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+31e8daa8b3fc129e75f2@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Omar Sandoval <osandov@osandov.com>
References: <00000000000082922905692da9e1@google.com>
 <0e998b77-14f0-aee0-8d32-bc1dd96fcc4c@kernel.dk>
 <CACT4Y+Y0TVJLDA5-0RGq-a-A6KKLKHZtA4pwUH2rtvR0hkiZQQ@mail.gmail.com>
 <63121c85-f417-cde8-510d-f275dbe81c4d@kernel.dk>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <7e5ab719-ad6b-015f-2e4c-8cba2ee157f8@I-love.SAKURA.ne.jp>
Date: Sun, 15 Apr 2018 00:33:03 +0900
MIME-Version: 1.0
In-Reply-To: <63121c85-f417-cde8-510d-f275dbe81c4d@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

The patch was sent to linux.git as commit bdac616db9bbadb9.

#syz fix: loop: fix LOOP_GET_STATUS lock imbalance
