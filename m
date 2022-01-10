Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B91C433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 16:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbiAJQk7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jan 2022 11:40:59 -0500
Received: from verein.lst.de ([213.95.11.211]:39316 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237627AbiAJQk5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 11:40:57 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6BE8368BFE; Mon, 10 Jan 2022 17:40:54 +0100 (CET)
Date:   Mon, 10 Jan 2022 17:40:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Message-ID: <20220110164054.GA7047@lst.de>
References: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp> <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp> <20220110103057.h775jv2br2xr2l5k@quack3.lan> <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp> <20220110134234.qebxn5gghqupsc7t@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110134234.qebxn5gghqupsc7t@quack3.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 10, 2022 at 02:42:34PM +0100, Jan Kara wrote:
> I see. But:
> a) We didn't fully establish a real deadlock scenario from the lockdep
> report, did we? The lockdep report involved suspend locks, some locks on
> accessing files in /proc etc. and it was not clear whether it all reflects
> a real deadlock possibility or just a fact that lockdep tracking is rather
> coarse-grained at times. Now lockdep report is unpleasant and loop device
> locking was ugly anyway so your async change made sense but once lockdep is
> silenced we should really establish whether there is real deadlock and more
> work is needed or not.
> 
> b) Unless we have a realistic plan of moving *all* blk_mq_freeze_queue()
> calls from under open_mutex in loop driver, moving stuff "where possible"
> from under open_mutex is IMO just muddying water.

Agreed.  I also have to say I'm not a fan of proliferating the use of
task_work_add.
