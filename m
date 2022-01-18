Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C169BC433EF
	for <linux-block@archiver.kernel.org>; Tue, 18 Jan 2022 08:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiARIZM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jan 2022 03:25:12 -0500
Received: from verein.lst.de ([213.95.11.211]:36031 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238557AbiARIZL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jan 2022 03:25:11 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 89C8368AFE; Tue, 18 Jan 2022 09:25:08 +0100 (CET)
Date:   Tue, 18 Jan 2022 09:25:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3] block: don't drain file system I/O on del_gendisk
Message-ID: <20220118082508.GB21847@lst.de>
References: <20220116041815.1218170-1-ming.lei@redhat.com> <20220117081321.GA22627@lst.de> <YeUyB/5YtA1AGyt8@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeUyB/5YtA1AGyt8@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 17, 2022 at 05:08:23PM +0800, Ming Lei wrote:
> > We need it to have proper life times in the block layer.  Everything only
> > needed for file system I/O and not blk-mq specific should slowly move
> > from the request_queue to the gendisk and I have patches going in
> > that direction.  In the end only the SCSI discovery code and the case
> > of /dev/sg without SCSI ULP will ever do passthrough I/O purely on the
> > gendisk.
> > 
> > So I think this series is moving in the wrong direction.  If you care
> > about no doing two freeze cycles the right thing to do is to record
> 
> I just think that the extra draining point in del_gendisk() isn't useful,
> can you share any use case with this change?

SCSI disk detach for example is a place where we need it.

> > if we ever did non-disk based passthrough I/O on a requeue_queue and
> > if not simplify the request_queue cleanup.  Doing this is on my TODO
> > list but I haven't look into the details yet.
> > 
> > > 1) queue freezing can't drain FS I/O for bio based driver
> > 
> > This is something I've started looking into it.
> 
> But that is one big problem, not sure you can solve it in short time,
> also not sure if it is useful, cause FS already guaranteed that every
> IO is drained before releasing disk, or IOs in the submission task are
> drained when exiting the task.

Think of a hot unplug.  The device gets a removal even, but the file
system still lives on.

> Firstly, FS layer has already guaranteed that every FS IO is done before
> releasing disk, so no need to take so much effort and make code more
> fragile to add one extra FS IO draining point in del_gendisk().

In the hot removal case the file system is still alive when del_gendisk
is called.

> Also the above two things aren't trivial enough to solve in short time, so
> can we delay the FS draining in del_gendisk() until the two are done?

We already have the draining.  What are you trying to fix by removing it?
