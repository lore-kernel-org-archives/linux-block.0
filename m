Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DFAC433F5
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 06:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiC2GlK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 02:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiC2GlJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 02:41:09 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F98A1FCD28
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 23:39:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3797168AFE; Tue, 29 Mar 2022 08:39:22 +0200 (CEST)
Date:   Tue, 29 Mar 2022 08:39:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH 12/13] loop: remove lo_refcount and avoid lo_mutex in
 ->open / ->release
Message-ID: <20220329063921.GA19778@lst.de>
References: <20220324075119.1556334-1-hch@lst.de> <20220324075119.1556334-13-hch@lst.de> <20220324141321.pqesnshaswwk3svk@quack3.lan> <96a4e2e7-e16e-7e89-255d-8aa29ffca68b@I-love.SAKURA.ne.jp> <20220324172335.GA28299@lst.de> <0b47dbee-ce17-7502-6bf3-fad939f89bb7@I-love.SAKURA.ne.jp> <20220325162331.GA16355@lst.de> <20220328083045.ryoh7rbhauxgezgn@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328083045.ryoh7rbhauxgezgn@quack3.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 28, 2022 at 10:30:45AM +0200, Jan Kara wrote:
> On Fri 25-03-22 17:23:31, Christoph Hellwig wrote:
> > On Fri, Mar 25, 2022 at 07:54:15PM +0900, Tetsuo Handa wrote:
> > > > But for now I'd really prefer to stop moving the goalpost further and
> > > > further.
> > > 
> > > Then, why not kill this code?
> > 
> > I think we should eventually do that, and I've indeed tested a patch
> > that is only cosmetically different.  I wasn't really convinced we
> > should do it in this series, but if there is consensus that we should
> > do it now I can respin the series with a patch like this included.
> 
> I'd defer it to a separate patchset. Because as much as the change to
> disallow LOOP_CLR_FD ioctl for used loop device makes sense, I'm not sure
> there isn't some framework using loop devices somewhere which relies on
> this just getting magically translated to setting LO_AUTOCLEAR flag. So IMO
> this has a big potential of userspace visible regression and as such I'd
> prefer doing it separately from the bugfixes.

At least my idea would not be to disallow LOOP_CLR_FD on a used block
devices as that would go back to the udev problems before Dave turned
it into a magic LO_AUTOCLEAR.  But to remove the lo_refcnt check
entirely, as loop_clr_fd now is safe against concurrent users - it
has to anyway as there can be other users even without an open.

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
---end quoted text---
