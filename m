Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1C3C433F5
	for <linux-block@archiver.kernel.org>; Thu,  2 Dec 2021 14:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358659AbhLBOn1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Dec 2021 09:43:27 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:63363 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358654AbhLBOn0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Dec 2021 09:43:26 -0500
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1B2EdiSJ040116;
        Thu, 2 Dec 2021 23:39:44 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Thu, 02 Dec 2021 23:39:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1B2EdhN4040111
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Dec 2021 23:39:44 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <3f4d1916-8e70-8914-57ba-7291f40765ae@i-love.sakura.ne.jp>
Date:   Thu, 2 Dec 2021 23:39:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] loop: make autoclear operation asynchronous
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <0000000000007f2f5405d1bfe618@google.com>
 <e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp>
 <bb3c04cf-3955-74d5-1e75-ae37a44f2197@i-love.sakura.ne.jp>
 <20c6dcbd-1b71-eaee-5213-02ded93951fc@i-love.sakura.ne.jp>
 <YaSpkRHgEMXrcn5i@infradead.org>
 <baeeebb3-c04e-ce0a-cb1d-56eb4a7e1914@i-love.sakura.ne.jp>
 <YaYfu0H2k0PSQL6W@infradead.org>
 <de6ec247-4a2d-7c3e-3700-90604f88e901@i-love.sakura.ne.jp>
 <20211202121615.GC1815@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <20211202121615.GC1815@quack2.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/12/02 21:16, Jan Kara wrote:
> Why not scheduling this using task_work_add()? It solves the locking
> context problems, has generally lower overhead than normal work (no need to
> schedule), and avoids possible unexpected side-effects of releasing
> loopback device later. Also task work is specifically designed so that one
> task work can queue another task work so we should be fine using it.

Indeed. But that will make really no difference between synchronous approach
( https://lkml.kernel.org/r/fb6adcdc-fb56-3b90-355b-3f5a81220f2b@i-love.sakura.ne.jp )
and asynchronous approach
( https://lkml.kernel.org/r/d1f760f9-cdb2-f40d-33d8-bfa517c731be@i-love.sakura.ne.jp ), for
disk->open_mutex is the only lock held when lo_release() is called.

Both approaches allow __loop_clr_fd() to run with no lock held, and both approaches
need to be aware of what actions are taken by blkdev_put() before and after dropping
disk->open_mutex. And bdev->bd_disk->fops->release() is the last action taken before
dropping disk->open_mutex.

What is so happier with preventing what will be done after disk->open_mutex is dropped
by blkdev_put() (i.e. __module_get() + kobject_get() before blkdev_put() calls
kobject_put() + module_put(), and kobject_put() + module_put() upon task_work_run()),
compared to doing things that can be done without disk->open_mutex (i.e. calling
__loop_clr_fd() without disk->open_mutex) ?

