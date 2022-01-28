Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C152C433F5
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 07:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346720AbiA1H0V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 02:26:21 -0500
Received: from verein.lst.de ([213.95.11.211]:47155 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346717AbiA1H0T (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 02:26:19 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 04D1668AA6; Fri, 28 Jan 2022 08:26:15 +0100 (CET)
Date:   Fri, 28 Jan 2022 08:26:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 3/8] block: remove the racy
 bd_inode->i_mapping->nrpages asserts
Message-ID: <20220128072614.GA2691@lst.de>
References: <20220126155040.1190842-1-hch@lst.de> <20220126155040.1190842-4-hch@lst.de> <20220127094737.dosrg7xbnwuw3ttx@quack3.lan> <20220127094942.GA14727@lst.de> <20220127122327.ivzofycd6g7umox6@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127122327.ivzofycd6g7umox6@quack3.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 27, 2022 at 01:23:27PM +0100, Jan Kara wrote:
> On Thu 27-01-22 10:49:42, Christoph Hellwig wrote:
> > On Thu, Jan 27, 2022 at 10:47:37AM +0100, Jan Kara wrote:
> > > On Wed 26-01-22 16:50:35, Christoph Hellwig wrote:
> > > > Nothing prevents a file system or userspace opener of the block device
> > > > from redirtying the page right afte sync_blockdev returned.  Fortunately
> > > > data in the page cache during a block device change is mostly harmless
> > > > anyway.
> > > > 
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > 
> > > My understanding was these warnings are there to tell userspace it is doing
> > > something wrong. Something like the warning we issue when DIO races with
> > > buffered IO... I'm not sure how useful they are but I don't see strong
> > > reason to remove them either...
> > 
> > Well, it is not just a warning, but also fails the command.  With some of
> > the reduced synchronization blktests loop/002 can hit them pretty reliably.
> 
> I see. I guess another place where using mapping->invalidate_lock would be
> good to avoid these races... So maybe something like attached patch?

So this looks sensible, but it does nest the inode lock and and the
invalidate lockinside lo_mutex.  I wonder if that is going to create
more problems down the road.
