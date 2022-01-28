Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7114FC433F5
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 06:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242452AbiA1Gsx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 01:48:53 -0500
Received: from verein.lst.de ([213.95.11.211]:47034 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234071AbiA1Gsx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 01:48:53 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4C38768AA6; Fri, 28 Jan 2022 07:48:50 +0100 (CET)
Date:   Fri, 28 Jan 2022 07:48:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 7/8] loop: only freeze the queue in __loop_clr_fd when
 needed
Message-ID: <20220128064850.GB1777@lst.de>
References: <20220126155040.1190842-1-hch@lst.de> <20220126155040.1190842-8-hch@lst.de> <20220127110143.g3jsi3z5vpxhotep@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127110143.g3jsi3z5vpxhotep@quack3.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 27, 2022 at 12:01:43PM +0100, Jan Kara wrote:
> On Wed 26-01-22 16:50:39, Christoph Hellwig wrote:
> > ->release is only called after all outstanding I/O has completed, so only
> > freeze the queue when clearing the backing file of a live loop device.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Looks good. I was just wondering: Is there anything which prevents us from
> moving blk_mq_freeze_queue() & blk_mq_unfreeze_queue() calls to
> loop_clr_fd() around __loop_clr_fd() call?

That would move more code into the freeze protection.  Including lo_mutex
which elsewhere is taken outside blk_freeze_queue.  The lo_mutex
acquisition is only for an assert, so we could skip that, so maybe we
can get there.  But the next patch adds another check for the release
flag so it doesn't seem worth it at this moment.
