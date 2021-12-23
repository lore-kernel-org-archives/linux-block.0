Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5622EC433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 14:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhLWOhm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 09:37:42 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:63638 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbhLWOhm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 09:37:42 -0500
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BNEbRh9077725;
        Thu, 23 Dec 2021 23:37:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Thu, 23 Dec 2021 23:37:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BNEbMcg077716
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Dec 2021 23:37:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <bb151d84-8a56-f6da-a5dd-b2d8d1fb6cdb@i-love.sakura.ne.jp>
Date:   Thu, 23 Dec 2021 23:37:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/2] loop: use a global workqueue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
References: <20211223112509.1116461-1-hch@lst.de>
 <20211223112509.1116461-2-hch@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <20211223112509.1116461-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/12/23 20:25, Christoph Hellwig wrote:
> Using a per-device unbound workqueue is a bit of an anti-pattern and
> in this case also creates lock ordering problems.  Just use a global
> concurrency managed workqueue instead.

Use of a global workqueue for the loop driver itself is fine. But

> @@ -1115,7 +1107,6 @@ static void __loop_clr_fd(struct loop_device *lo)
>  	/* freeze request queue during the transition */
>  	blk_mq_freeze_queue(lo->lo_queue);
>  
> -	destroy_workqueue(lo->workqueue);

is it safe to remove destroy_workqueue() call here?

>  	spin_lock_irq(&lo->lo_work_lock);
>  	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
>  				idle_list) {

destroy_workqueue() implies flush_workqueue() which is creating the lock
ordering problem. And I think that flush_workqueue() is required for making
sure that there is no more work to process (i.e. loop_process_work() is
no longer running) before start deleting idle workers.

My understanding is that the problem is not the use of a per-device workqueue
but the need to call flush_workqueue() in order to make sure that all pending
works are completed.

