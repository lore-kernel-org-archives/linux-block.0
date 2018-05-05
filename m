Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: INFO: rcu detected stall in blkdev_ioctl
To: syzbot
 <syzbot+369c35474963daf8f8eea897ecf33cb6ad6c7ea2@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Jan Kara <jack@suse.cz>
Cc: akpm@linux-foundation.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, npiggin@gmail.com, pombredanne@nexb.com,
        tglx@linutronix.de, x86@kernel.org
References: <94eb2c05a38090aaeb0560706bb5@google.com>
 <0000000000001554a7056add26c6@google.com>
 <18608105-31d3-3d77-ccbb-a25bbe7e55e6@I-love.SAKURA.ne.jp>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <00724984-6edd-d0df-4c51-53be8c330234@I-love.SAKURA.ne.jp>
Date: Sat, 5 May 2018 20:57:16 +0900
MIME-Version: 1.0
In-Reply-To: <18608105-31d3-3d77-ccbb-a25bbe7e55e6@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

If various stall reports regarding loop_set_fd() are hitting below sequence, a patch
was proposed at https://groups.google.com/d/msg/syzkaller-bugs/5pzXJ8yQFR0/vWeRytaQBAAJ .

----------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/loop.h>

int main(int argc, char *argv[])
{
        const int fd = open("/tmp/file", O_RDWR | O_CREAT | O_TRUNC, 0600);
        const int fd0 = open("/dev/loop0", O_RDONLY);
        const int fd1 = open("/dev/loop1", O_RDONLY);
        ioctl(fd0, LOOP_SET_FD, fd);
        ioctl(fd0, LOOP_CHANGE_FD, fd0);
        ioctl(fd1, LOOP_SET_FD, fd0);
        return 0;
}
----------
