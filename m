Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD288C433EF
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 11:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348167AbiA1Lpb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 06:45:31 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35560 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244361AbiA1Lpa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 06:45:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C2FAD1F384;
        Fri, 28 Jan 2022 11:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643370328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q4u7CjlyKS0CLwlC75fQFslulthY3mFAxb4p5gsfVqc=;
        b=psjGPHqllIs0BIoLFx4VHHZNLzoAUdRdwDlzJ7OqH7Z46HJFJu5PiyaLJamE1GVO580u5t
        dOS7aBT9cLH/IBJqGOkwxMWfC0QghGInDJlxR21HeJdAH6F6E/L1FTV1imE4t03oGlRbMe
        s6SwZ3x82Wmj04fSTk/NVcJPVEd2u6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643370328;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q4u7CjlyKS0CLwlC75fQFslulthY3mFAxb4p5gsfVqc=;
        b=bXosiF2hGFmgGS5Ubq5cKY29NmlcVXIuk6IX8/KISNJianSCqkjXmWTdumC7mBRCTClnfM
        JbI64GkjQ6nOYtBQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5636CA3B84;
        Fri, 28 Jan 2022 11:45:27 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 45D77A05E6; Fri, 28 Jan 2022 12:45:27 +0100 (CET)
Date:   Fri, 28 Jan 2022 12:45:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 3/8] block: remove the racy bd_inode->i_mapping->nrpages
 asserts
Message-ID: <20220128114527.nwlo4prgqz7lg75w@quack3.lan>
References: <20220126155040.1190842-1-hch@lst.de>
 <20220126155040.1190842-4-hch@lst.de>
 <20220127094737.dosrg7xbnwuw3ttx@quack3.lan>
 <20220127094942.GA14727@lst.de>
 <20220127122327.ivzofycd6g7umox6@quack3.lan>
 <20220128072614.GA2691@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128072614.GA2691@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 28-01-22 08:26:14, Christoph Hellwig wrote:
> On Thu, Jan 27, 2022 at 01:23:27PM +0100, Jan Kara wrote:
> > On Thu 27-01-22 10:49:42, Christoph Hellwig wrote:
> > > On Thu, Jan 27, 2022 at 10:47:37AM +0100, Jan Kara wrote:
> > > > On Wed 26-01-22 16:50:35, Christoph Hellwig wrote:
> > > > > Nothing prevents a file system or userspace opener of the block device
> > > > > from redirtying the page right afte sync_blockdev returned.  Fortunately
> > > > > data in the page cache during a block device change is mostly harmless
> > > > > anyway.
> > > > > 
> > > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > 
> > > > My understanding was these warnings are there to tell userspace it is doing
> > > > something wrong. Something like the warning we issue when DIO races with
> > > > buffered IO... I'm not sure how useful they are but I don't see strong
> > > > reason to remove them either...
> > > 
> > > Well, it is not just a warning, but also fails the command.  With some of
> > > the reduced synchronization blktests loop/002 can hit them pretty reliably.
> > 
> > I see. I guess another place where using mapping->invalidate_lock would be
> > good to avoid these races... So maybe something like attached patch?
> 
> So this looks sensible, but it does nest the inode lock and and the
> invalidate lockinside lo_mutex.  I wonder if that is going to create
> more problems down the road.

Yeah, I was wondering about that a bit as well. Quick blktests run didn't
trigger any lockdep warning so I thought it's worth a try. But for now I
guess let's not complicate things, it's difficult enough already.

I have checked the code now and it does not seem to cause any obvious harm
if we have block device page cache while changing loop device parameters.
Just some IO may fail, trigger some warning (e.g. IO beyond end of device)
but nothing worse.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
