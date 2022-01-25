Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC1FC5AC75
	for <linux-block@archiver.kernel.org>; Tue, 25 Jan 2022 23:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbiAYXrf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jan 2022 18:47:35 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61539 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiAYXrf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jan 2022 18:47:35 -0500
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20PNlMAe016774;
        Wed, 26 Jan 2022 08:47:22 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Wed, 26 Jan 2022 08:47:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20PNlLit016768
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Jan 2022 08:47:22 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ec15d9ef-a659-e4f0-fc3f-c75acaa0be2a@I-love.SAKURA.ne.jp>
Date:   Wed, 26 Jan 2022 08:47:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/5] task_work: export task_work_add()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
References: <20220121114006.3633-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20220125154730.GA4611@lst.de>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220125154730.GA4611@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/26 0:47, Christoph Hellwig wrote:
> I'm sometimes a little slow, but I still fail to understand why we need
> all this.  Your cut down patch that moves the destroy_workqueue call
> and the work_struct fixed all the know lockdep issues, right?

Right. Moving destroy_workqueue() (and blk_mq_freeze_queue() together)
in __loop_clr_fd() to WQ context fixed a known lockdep issue.

> 
> And the only other problem we're thinking off is that blk_mq_freeze_queue
> could have the same effect,

Right. blk_mq_freeze_queue() is still called with disk->open_mutex held, for
there is

	} else if (lo->lo_state == Lo_bound) {
		/*
		 * Otherwise keep thread (if running) and config,
		 * but flush possible ongoing bios in thread.
		 */
		blk_mq_freeze_queue(lo->lo_queue);
		blk_mq_unfreeze_queue(lo->lo_queue);
	}

path in lo_release().

>                             except that lockdep doesn't track it and
> we've not seen it in the wild.

It is difficult to test. Fuzzers cannot test fsfreeze paths, for failing to
issue an unfreeze request leads to unresponding virtual machines.

> 
> As far as I can tell we do not need the freeze at all for given that
> by the time release is called I/O is quiesced.

Why? lo_release() is called when close() is called. But (periodically-scheduled
or triggered-on-demand) writeback of previously executed buffered write() calls
can start while lo_release() or __loop_clr_fd() is running. Then, why not to
wait for I/O requests to complete? Isn't that the reason of

	} else if (lo->lo_state == Lo_bound) {
		/*
		 * Otherwise keep thread (if running) and config,
		 * but flush possible ongoing bios in thread.
		 */
		blk_mq_freeze_queue(lo->lo_queue);
		blk_mq_unfreeze_queue(lo->lo_queue);
	}

path in lo_release() being there?

