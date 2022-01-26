Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD0FC63697
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 10:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbiAZK1s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 05:27:48 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56918 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiAZK1l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 05:27:41 -0500
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20QARLdB038284;
        Wed, 26 Jan 2022 19:27:21 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Wed, 26 Jan 2022 19:27:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20QARLQm038281
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Jan 2022 19:27:21 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <bdb74587-c688-c326-332a-be0b3f2db844@I-love.SAKURA.ne.jp>
Date:   Wed, 26 Jan 2022 19:27:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/5] task_work: export task_work_add()
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
References: <20220121114006.3633-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20220125154730.GA4611@lst.de>
 <ec15d9ef-a659-e4f0-fc3f-c75acaa0be2a@I-love.SAKURA.ne.jp>
 <20220126052159.GA20838@lst.de> <YfD1xo/bepV17ggx@T590>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YfD1xo/bepV17ggx@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/26 16:18, Ming Lei wrote:
>>> Isn't that the reason of
>>>
>>> 	} else if (lo->lo_state == Lo_bound) {
>>> 		/*
>>> 		 * Otherwise keep thread (if running) and config,
>>> 		 * but flush possible ongoing bios in thread.
>>> 		 */
>>> 		blk_mq_freeze_queue(lo->lo_queue);
>>> 		blk_mq_unfreeze_queue(lo->lo_queue);
>>> 	}
>>>
>>> path in lo_release() being there?
>>
>> This looks completely spurious to me.  Adding Ming who added it.
> 
> It was added when converting to blk-mq.

Well, commit b5dd2f6047ca1080 ("block: loop: improve performance via blk-mq") in v4.0-rc1.
That's where "thread" in the block comment above became outdated, and a global WQ_MEM_RECLAIM
workqueue was used. We need to update both.

> 
> I remember it was to replace original loop_flush() which uses
> wait_for_completion() for draining all inflight bios, but seems
> the flush isn't needed in lo_release().

Even if we can remove blk_mq_freeze_queue()/blk_mq_unfreeze_queue() from lo_release(), we
cannot remove blk_mq_freeze_queue()/blk_mq_unfreeze_queue() from e.g. loop_set_status(), right?

Then, lo_release() which is called with disk->open_mutex held can be still blocked at
mutex_lock(&lo->lo_mutex) waiting for e.g. loop_set_status() to call mutex_unlock(&lo->lo_mutex).
That is, lo_open() from e.g. /sys/power/resume can still wait for I/O completion with disk->open_mutex held.

How to kill this dependency? Don't we need to make sure that lo_open()/lo_release() are not
blocked on lo->lo_mutex (like [PATCH v3 3/5] and [PATCH v3 4/5] does) ?

