Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FC8C28CF5
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 05:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiAZFWD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 00:22:03 -0500
Received: from verein.lst.de ([213.95.11.211]:38433 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbiAZFWD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 00:22:03 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8D38B67373; Wed, 26 Jan 2022 06:21:59 +0100 (CET)
Date:   Wed, 26 Jan 2022 06:21:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 1/5] task_work: export task_work_add()
Message-ID: <20220126052159.GA20838@lst.de>
References: <20220121114006.3633-1-penguin-kernel@I-love.SAKURA.ne.jp> <20220125154730.GA4611@lst.de> <ec15d9ef-a659-e4f0-fc3f-c75acaa0be2a@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec15d9ef-a659-e4f0-fc3f-c75acaa0be2a@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 26, 2022 at 08:47:17AM +0900, Tetsuo Handa wrote:
> > As far as I can tell we do not need the freeze at all for given that
> > by the time release is called I/O is quiesced.
> 
> Why? lo_release() is called when close() is called. But (periodically-scheduled
> or triggered-on-demand) writeback of previously executed buffered write() calls
> can start while lo_release() or __loop_clr_fd() is running. Then, why not to
> wait for I/O requests to complete?

Let's refine my wording, the above should be "... by the time the final
lo_release is called".  blkdev_put_whole ensures all writeback has finished
and all buffers are gone by writing all data back and waiting for it and then
truncating the pages from blkdev_flush_mapping.

> Isn't that the reason of
> 
> 	} else if (lo->lo_state == Lo_bound) {
> 		/*
> 		 * Otherwise keep thread (if running) and config,
> 		 * but flush possible ongoing bios in thread.
> 		 */
> 		blk_mq_freeze_queue(lo->lo_queue);
> 		blk_mq_unfreeze_queue(lo->lo_queue);
> 	}
> 
> path in lo_release() being there?

This looks completely spurious to me.  Adding Ming who added it.
