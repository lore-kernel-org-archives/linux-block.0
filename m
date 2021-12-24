Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D9CC433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Dec 2021 12:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352635AbhLXMGR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Dec 2021 07:06:17 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61976 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352634AbhLXMGR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Dec 2021 07:06:17 -0500
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BOC626X005352;
        Fri, 24 Dec 2021 21:06:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Fri, 24 Dec 2021 21:06:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BOC5uea005336
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 24 Dec 2021 21:06:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <f839a895-bb91-02f8-33fb-5994dd725d24@i-love.sakura.ne.jp>
Date:   Fri, 24 Dec 2021 21:05:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/2] loop: use a global workqueue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
References: <20211223112509.1116461-1-hch@lst.de>
 <20211223112509.1116461-2-hch@lst.de>
 <bb151d84-8a56-f6da-a5dd-b2d8d1fb6cdb@i-love.sakura.ne.jp>
 <20211224060311.GC12234@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <20211224060311.GC12234@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/12/24 15:03, Christoph Hellwig wrote:
> On Thu, Dec 23, 2021 at 11:37:21PM +0900, Tetsuo Handa wrote:
>>> @@ -1115,7 +1107,6 @@ static void __loop_clr_fd(struct loop_device *lo)
>>>  	/* freeze request queue during the transition */
>>>  	blk_mq_freeze_queue(lo->lo_queue);
>>>  
>>> -	destroy_workqueue(lo->workqueue);
>>
>> is it safe to remove destroy_workqueue() call here?
>>
>>>  	spin_lock_irq(&lo->lo_work_lock);
>>>  	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
>>>  				idle_list) {
>>
>> destroy_workqueue() implies flush_workqueue() which is creating the lock
>> ordering problem. And I think that flush_workqueue() is required for making
>> sure that there is no more work to process (i.e. loop_process_work() is
>> no longer running) before start deleting idle workers.
>>
>> My understanding is that the problem is not the use of a per-device workqueue
>> but the need to call flush_workqueue() in order to make sure that all pending
>> works are completed.
> 
> All the work items are for requests, and the blk_mq_freeze_queue should
> take care of flushing them all out.

Hmm, OK.

(1) loop_queue_rq() calls blk_mq_start_request() and then calls loop_queue_work().

(2) loop_queue_work() allocates "struct work_struct" and calls queue_work().

(3) loop_handle_cmd() from loop_process_work() from loop_workfn() is called by a WQ thread.

(4) do_req_filebacked() from loop_handle_cmd() performs read/write on lo->lo_backing_file.

(5) Either completion function or loop_handle_cmd() calls blk_mq_complete_request().

Therefore, as long as blk_mq_freeze_queue(lo->lo_queue) waits for completion of (5) and
blocks new events for (2), there should be no work to process by loop_process_work().

Then, we can defer

	destroy_workqueue(lo->workqueue);
	spin_lock_irq(&lo->lo_work_lock);
	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
				idle_list) {
		list_del(&worker->idle_list);
		rb_erase(&worker->rb_node, &lo->worker_tree);
		css_put(worker->blkcg_css);
		kfree(worker);
	}
	spin_unlock_irq(&lo->lo_work_lock);
	del_timer_sync(&lo->timer);

block in __loop_clr_fd() till loop_remove() if we want. Assuming that
loop devices are likely created only when there is no free one, a loop
device is likely reused once created. Then, we don't need to care idle
workers on every loop_configure()/__loop_clr_fd() pairs?

By the way, is it safe to use single global WQ if (4) is a synchronous I/O request?
Since there can be up to 1048576 loop devices, and one loop device can use another
loop device as lo->lo_backing_file (unless loop_validate_file() finds a circular
usage), one synchronous I/O request in (4) might recursively involve up to 1048576
works (which would be too many concurrency to be handled by a WQ) ?

Also, is

	blk_mq_start_request(rq);

	if (lo->lo_state != Lo_bound)
		return BLK_STS_IOERR;

in loop_queue_rq() correct? (Not only lo->lo_state test is racy, but wants
blk_mq_end_request() like lo_complete_rq() does?
