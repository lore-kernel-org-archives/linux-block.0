Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F7EC433B4
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 17:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D877161163
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 17:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhDBR1e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Apr 2021 13:27:34 -0400
Received: from verein.lst.de ([213.95.11.211]:44445 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBR1d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Apr 2021 13:27:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 71A1368BFE; Fri,  2 Apr 2021 19:27:30 +0200 (CEST)
Date:   Fri, 2 Apr 2021 19:27:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] block: shutdown blktrace in case of fatal signal
 pending
Message-ID: <20210402172730.GA22923@lst.de>
References: <20210323081440.81343-1-ming.lei@redhat.com> <20210323081440.81343-2-ming.lei@redhat.com> <20210330165330.GA13829@lst.de> <YGO/cpalyGevAJjn@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGO/cpalyGevAJjn@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 31, 2021 at 08:16:50AM +0800, Ming Lei wrote:
> On Tue, Mar 30, 2021 at 06:53:30PM +0200, Christoph Hellwig wrote:
> > On Tue, Mar 23, 2021 at 04:14:39PM +0800, Ming Lei wrote:
> > > blktrace may allocate lots of memory, if the process is terminated
> > > by user or OOM, we need to provide one chance to remove the trace
> > > buffer, otherwise memory leak may be caused.
> > > 
> > > Fix the issue by shutdown blktrace in case of task exiting in
> > > blkdev_close().
> > > 
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > 
> > This just seems weird.  blktrace has no relationship to open
> > block device instances.
> 
> blktrace still needs to open one blkdev, then send its own ioctl
> commands to block layer. In case of OOM, the allocated memory in
> these ioctl commands won't be released.
> 
> Or any other suggestion?

Not much we can do there I think.  If we want to autorelease memory
it needs to be an API that ties the memory allocation to an FD.
