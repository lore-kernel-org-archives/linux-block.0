Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2691C433EF
	for <linux-block@archiver.kernel.org>; Fri, 31 Dec 2021 02:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbhLaCxF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Dec 2021 21:53:05 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56728 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbhLaCxE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Dec 2021 21:53:04 -0500
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BV2qjUm065072;
        Fri, 31 Dec 2021 11:52:45 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Fri, 31 Dec 2021 11:52:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BV2qfrD065062
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 31 Dec 2021 11:52:45 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1d72db41-ff3a-f45e-a479-a0db0989f987@I-love.SAKURA.ne.jp>
Date:   Fri, 31 Dec 2021 11:52:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [syzbot] possible deadlock in blkdev_get_by_dev
Content-Language: en-US
To:     syzbot <syzbot+a1db28a5dacdaf16ffde@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
References: <000000000000f8dd4e05d466d166@google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000f8dd4e05d466d166@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Same reproducer applies. Need to avoid destroy_workqueue() with &disk->open_mutex held.

----------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/loop.h>
#include <sys/sendfile.h>

int main(int argc, char *argv[])
{
        const int file_fd = open("testfile", O_RDWR | O_CREAT, 0600);
        ftruncate(file_fd, 1048576);
        char filename[128] = { };
        const int loop_num = ioctl(open("/dev/loop-control", 3),  LOOP_CTL_GET_FREE, 0);
        snprintf(filename, sizeof(filename) - 1, "/dev/loop%d", loop_num);
        const int loop_fd_1 = open(filename, O_RDWR);
        ioctl(loop_fd_1, LOOP_SET_FD, file_fd);
        const int loop_fd_2 = open(filename, O_RDWR);
        ioctl(loop_fd_1, LOOP_CLR_FD, 0);
        const int sysfs_fd = open("/sys/power/resume", O_RDWR);
        sendfile(file_fd, sysfs_fd, 0, 1048576);
        sendfile(loop_fd_2, file_fd, 0, 1048576);
        write(sysfs_fd, "700", 3);
        return 0;
}
----------------------------------------

#syz dup: possible deadlock in blkdev_put (2)

I think that not only we can remove destroy_workqueue() from __loop_clear_fd() but also
we can make whole __loop_clear_fd() be called without &disk->open_mutex held.
Jens, any questions remaining on https://lkml.kernel.org/r/c205dcd2-db55-a35c-e2ef-20193b5ac0da@i-love.sakura.ne.jp ?

