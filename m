Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: INFO: rcu detected stall in blkdev_ioctl
To: syzbot
 <syzbot+369c35474963daf8f8eea897ecf33cb6ad6c7ea2@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <94eb2c05a38090aaeb0560706bb5@google.com>
 <0000000000001554a7056add26c6@google.com>
Cc: akpm@linux-foundation.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, npiggin@gmail.com, pombredanne@nexb.com,
        tglx@linutronix.de, x86@kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <18608105-31d3-3d77-ccbb-a25bbe7e55e6@I-love.SAKURA.ne.jp>
Date: Sat, 28 Apr 2018 17:57:35 +0900
MIME-Version: 1.0
In-Reply-To: <0000000000001554a7056add26c6@google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Like I noted in a patch at

https://groups.google.com/d/msg/syzkaller-bugs/2Rw8-OM6IbM/PzdobV8kAgAJ

loop module is not thread safe. Can we use more global lock?
