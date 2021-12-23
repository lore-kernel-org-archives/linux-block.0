Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F716C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 15:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348982AbhLWP2v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 10:28:51 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:58791 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbhLWP2v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 10:28:51 -0500
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BNFScbO010560;
        Fri, 24 Dec 2021 00:28:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Fri, 24 Dec 2021 00:28:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BNFScd0010556
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 24 Dec 2021 00:28:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <c205dcd2-db55-a35c-e2ef-20193b5ac0da@i-love.sakura.ne.jp>
Date:   Fri, 24 Dec 2021 00:28:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 2/2] loop: use task_work for autoclear operation
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
References: <e9f59c70-5dc9-45ce-be93-9f149028f922@i-love.sakura.ne.jp>
 <9eff2034-2f32-54a3-e476-d0f609ab49c0@i-love.sakura.ne.jp>
 <da951c17-8a2f-4731-c34d-e08921824414@kernel.dk>
 <ae5848e6-aaeb-4f5a-ade7-f09d0f5d4d0b@i-love.sakura.ne.jp>
 <2b6db3cb-a942-6fd6-fdbf-8f355103cb55@kernel.dk>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <2b6db3cb-a942-6fd6-fdbf-8f355103cb55@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/12/23 23:13, Jens Axboe wrote:
> Race is the wrong word, I mean ordering issues. If the fput happens
> before you queue your task_work, then it'll be run before that.

There are two fput() related to this patch.
fput(file_of_loop_device) or fput(file_of_backing_file), which one?

loop_schedule_rundown() is called from lo_release() from blkdev_put() from
blkdev_close() from __fput() from task_work_run(), after fput(file_of_loop_device)
called task_work_add(TWA_RESUME) for scheduling __fput().

__loop_clr_fd() is called from loop_rundown_callbackfn() from task_work_run(),
after loop_schedule_rundown() called task_work_add(TWA_RESUME) for scheduling
loop_rundown_callbackfn().

fput(file_of_backing_file) is called from __loop_clr_fd(), and
fput(file_of_backing_file) calls task_work_add(TWA_RESUME) for scheduling
__fput().

And __fput() from task_work_run() calls release callback for file_of_backing_file.

fput(file_of_loop_device) happens before loop_schedule_rundown() calls
task_work_add(TWA_RESUME).

fput(file_of_backing_file) happens after loop_schedule_rundown() called
task_work_add(TWA_RESUME).

The release callback for file_of_backing_file will be completed before
close() syscall which triggered fput(file_of_loop_device) returns to
userspace, for these are chain of add_task_work().

As a total sequence, I think there is no ordering issues.
Or, am I missing limitation of task work usage?
