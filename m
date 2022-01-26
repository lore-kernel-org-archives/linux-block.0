Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F20C28CF5
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 13:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbiAZNfi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:35:38 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61606 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiAZNfh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 08:35:37 -0500
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20QDZBfJ096607;
        Wed, 26 Jan 2022 22:35:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Wed, 26 Jan 2022 22:35:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20QDZAOj096599
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Jan 2022 22:35:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <65d206c6-3361-5cbc-d25d-07faec3dda96@I-love.SAKURA.ne.jp>
Date:   Wed, 26 Jan 2022 22:35:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/5] task_work: export task_work_add()
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20220121114006.3633-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20220125154730.GA4611@lst.de>
 <ec15d9ef-a659-e4f0-fc3f-c75acaa0be2a@I-love.SAKURA.ne.jp>
 <20220126052159.GA20838@lst.de> <YfD1xo/bepV17ggx@T590>
 <bdb74587-c688-c326-332a-be0b3f2db844@I-love.SAKURA.ne.jp>
 <20220126131148.k5byj6p7fmgsmebw@quack3.lan>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220126131148.k5byj6p7fmgsmebw@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/26 22:11, Jan Kara wrote:
> On Wed 26-01-22 19:27:17, Tetsuo Handa wrote:
>> Even if we can remove blk_mq_freeze_queue()/blk_mq_unfreeze_queue() from
>> lo_release(), we cannot remove
>> blk_mq_freeze_queue()/blk_mq_unfreeze_queue() from e.g.
>> loop_set_status(), right?
> 
> Correct AFAICT.

OK.

> 
>> Then, lo_release() which is called with disk->open_mutex held can be
>> still blocked at mutex_lock(&lo->lo_mutex) waiting for e.g.
>> loop_set_status() to call mutex_unlock(&lo->lo_mutex).  That is,
>> lo_open() from e.g. /sys/power/resume can still wait for I/O completion
>> with disk->open_mutex held.
> 
> I don't think this is a real problem. If someone is calling
> loop_set_status() it means the loop device is open and thus lo_release()
> cannot be running in parallel, can it?

lo_release() is called when a file descriptor is close()d.
That is, loop_set_status() and lo_release() can run in parallel, can't it?

  Process-A                               Process-B

  int fd1 = open("/dev/loop0", O_RDWR);   int fd2 = open("/dev/loop0", O_RDWR);
  ioctl(fd1, LOOP_SET_STATUS64, ...);     close(fd2);

If lo_release() (which is called with disk->open_mutex held) waits for ioctl()
(which waits for I/O completion with lo->lo_mutex held), there is
disk->open_mutex => lo->lo_mutex => I/O completion dependency.

And the possibility of deadlock problem (when mixed with sysfs and fsfreeze)
happens at lo_open(). If lo_open() (which is called with disk->open_mutex held)
waits for ioctl() (which waits for I/O completion with lo->lo_mutex held), there
as well is disk->open_mutex => lo->lo_mutex => I/O completion dependency.
