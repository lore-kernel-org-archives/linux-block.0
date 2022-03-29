Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16C4C433F5
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 06:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiC2GyW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 02:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiC2GyV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 02:54:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD64D2DD46
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 23:52:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5D8F668AFE; Tue, 29 Mar 2022 08:52:34 +0200 (CEST)
Date:   Tue, 29 Mar 2022 08:52:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: Re: [PATCH 13/14] loop: remove lo_refcount and avoid lo_mutex in
 ->open / ->release
Message-ID: <20220329065234.GA20006@lst.de>
References: <20220325063929.1773899-1-hch@lst.de> <20220325063929.1773899-14-hch@lst.de> <03628e13-ca56-4ed0-da5a-ee698c83f48d@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03628e13-ca56-4ed0-da5a-ee698c83f48d@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tetsuo,

I'm a bit confused. Partially due to the two patches in one mail, but
also because I can't actually find a try that they cleanly apply to.

But let me add my thoughts here:

 - I think the change 

On Sat, Mar 26, 2022 at 11:52:36AM +0900, Tetsuo Handa wrote:
> Since __loop_clr_fd() is currently holding loop_validate_mutex and lo->lo_mutex,
> "avoid lo_mutex in ->release" part is incomplete.
> 
> The intent of holding loop_validate_mutex (which causes disk->open_mutex =>
> loop_validate_mutex => lo->lo_mutex => blk_mq_freeze_queue()/blk_mq_unfreeze_queue()
> chain) is to make loop_validate_file() traversal safe.
> 
> Since ->release is called with disk->open_mutex held, and __loop_clr_fd() from
> lo_release() is called via ->release when disk_openers() == 0, we are guaranteed
> that "struct file" which will be passed to loop_validate_file() via fget() cannot
> be the loop device __loop_clr_fd(lo, true) will clear. Thus, there is no need to
> hold loop_validate_mutex and lo->lo_mutex from __loop_clr_fd() if release == true.

This part looks reasonable.  Can you give a signoff and proper commit
log and I'll slot it in before the lo_refcount removal.
