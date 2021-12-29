Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28784C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Dec 2021 17:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbhL2RVi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Dec 2021 12:21:38 -0500
Received: from verein.lst.de ([213.95.11.211]:38252 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237440AbhL2RVi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Dec 2021 12:21:38 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6A63768AFE; Wed, 29 Dec 2021 18:21:35 +0100 (CET)
Date:   Wed, 29 Dec 2021 18:21:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] loop: use a global workqueue
Message-ID: <20211229172135.GB27693@lst.de>
References: <20211223112509.1116461-1-hch@lst.de> <20211223112509.1116461-2-hch@lst.de> <bb151d84-8a56-f6da-a5dd-b2d8d1fb6cdb@i-love.sakura.ne.jp> <20211224060311.GC12234@lst.de> <f839a895-bb91-02f8-33fb-5994dd725d24@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f839a895-bb91-02f8-33fb-5994dd725d24@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 24, 2021 at 09:05:53PM +0900, Tetsuo Handa wrote:
> By the way, is it safe to use single global WQ if (4) is a synchronous I/O request?
> Since there can be up to 1048576 loop devices, and one loop device can use another
> loop device as lo->lo_backing_file (unless loop_validate_file() finds a circular
> usage), one synchronous I/O request in (4) might recursively involve up to 1048576
> works (which would be too many concurrency to be handled by a WQ) ?

Indeed, this will cause problems with stacked loop devices.

> Also, is
> 
> 	blk_mq_start_request(rq);
> 
> 	if (lo->lo_state != Lo_bound)
> 		return BLK_STS_IOERR;
> 
> in loop_queue_rq() correct? (Not only lo->lo_state test is racy, but wants
> blk_mq_end_request() like lo_complete_rq() does?

Besides the racyness this should be fine, the caller can cope with
errors both before and after blk_mq_start_request is called.
