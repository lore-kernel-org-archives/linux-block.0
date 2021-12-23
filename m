Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF009C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 07:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346703AbhLWHCF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:02:05 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:59314 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242432AbhLWHCE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 02:02:04 -0500
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BN71pBq084781;
        Thu, 23 Dec 2021 16:01:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Thu, 23 Dec 2021 16:01:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BN71pKt084778
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Dec 2021 16:01:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <ae5848e6-aaeb-4f5a-ade7-f09d0f5d4d0b@i-love.sakura.ne.jp>
Date:   Thu, 23 Dec 2021 16:01:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] loop: use task_work for autoclear operation
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
References: <e9f59c70-5dc9-45ce-be93-9f149028f922@i-love.sakura.ne.jp>
 <9eff2034-2f32-54a3-e476-d0f609ab49c0@i-love.sakura.ne.jp>
 <da951c17-8a2f-4731-c34d-e08921824414@kernel.dk>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <da951c17-8a2f-4731-c34d-e08921824414@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/12/23 0:56, Jens Axboe wrote:
> On 12/22/21 8:27 AM, Tetsuo Handa wrote:
>> The kernel test robot is reporting that xfstest can fail at
>>
>>   umount ext2 on xfs
>>   umount xfs
>>
>> sequence, for commit 322c4293ecc58110 ("loop: make autoclear operation
>> asynchronous") broke what commit ("loop: Make explicit loop device
>> destruction lazy") wanted to achieve.
>>
>> Although we cannot guarantee that nobody is holding a reference when
>> "umount xfs" is called, we should try to close a race window opened
>> by asynchronous autoclear operation.
>>
>> Try to make the autoclear operation upon close() synchronous, by calling
>> __loop_clr_fd() from current thread's task work rather than a WQ thread.
> 
> Doesn't this potentially race with fput?
> 

What race?

loop_schedule_rundown() is called from lo_release() from blkdev_put() from
blkdev_close() from __fput() from task_work_run(). And loop_schedule_rundown()
calls kobject_get(&bdev->bd_device.kobj) before put_device() from
blkdev_put_no_open() from blkdev_put() from blkdev_close() from __fput() from
task_work_run() calls kobject_put(&bdev->bd_device.kobj).
