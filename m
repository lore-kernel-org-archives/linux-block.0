Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64084C433F5
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 09:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiC2Jnu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 05:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbiC2Jnt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 05:43:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839C64B422
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 02:42:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 372B621614;
        Tue, 29 Mar 2022 09:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648546925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bd2RgASabPUF53MD8kPW9HA/VZftYdPTsYUe1/q/32M=;
        b=zzqKCPqtz7T1GfQriG2fM3yXZMBd/gXxCNgK4ZIOWkMXlQZ7d7X7r8vB7uyy0zI+GCoMTg
        ZjKgSFeDGo6PAMdg1/1snQBCsTBEI0Cj6PcKTvy2753aV6KChevkwLmEx6r+HbucFtZgHo
        G5ymRKH7/CtQun3KJuA6ORFVYZh5PlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648546925;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bd2RgASabPUF53MD8kPW9HA/VZftYdPTsYUe1/q/32M=;
        b=p5kSxPjVdRzBVHnBFXsEuWz0LnccB8S37/6MRGOib1DjMduyr8bHReq6MAREBN1s4EiSLp
        jomTPmUMXGs2mhDg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 89300A3B82;
        Tue, 29 Mar 2022 09:42:04 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 98AB2A0610; Tue, 29 Mar 2022 11:42:03 +0200 (CEST)
Date:   Tue, 29 Mar 2022 11:42:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>,
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
Message-ID: <20220329094203.zkgkqtumix7nygs2@quack3.lan>
References: <20220324075119.1556334-1-hch@lst.de>
 <20220324075119.1556334-13-hch@lst.de>
 <20220324141321.pqesnshaswwk3svk@quack3.lan>
 <96a4e2e7-e16e-7e89-255d-8aa29ffca68b@I-love.SAKURA.ne.jp>
 <20220324172335.GA28299@lst.de>
 <0b47dbee-ce17-7502-6bf3-fad939f89bb7@I-love.SAKURA.ne.jp>
 <20220325162331.GA16355@lst.de>
 <20220328083045.ryoh7rbhauxgezgn@quack3.lan>
 <20220329063921.GA19778@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329063921.GA19778@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 29-03-22 08:39:21, Christoph Hellwig wrote:
> On Mon, Mar 28, 2022 at 10:30:45AM +0200, Jan Kara wrote:
> > On Fri 25-03-22 17:23:31, Christoph Hellwig wrote:
> > > On Fri, Mar 25, 2022 at 07:54:15PM +0900, Tetsuo Handa wrote:
> > > > > But for now I'd really prefer to stop moving the goalpost further and
> > > > > further.
> > > > 
> > > > Then, why not kill this code?
> > > 
> > > I think we should eventually do that, and I've indeed tested a patch
> > > that is only cosmetically different.  I wasn't really convinced we
> > > should do it in this series, but if there is consensus that we should
> > > do it now I can respin the series with a patch like this included.
> > 
> > I'd defer it to a separate patchset. Because as much as the change to
> > disallow LOOP_CLR_FD ioctl for used loop device makes sense, I'm not sure
> > there isn't some framework using loop devices somewhere which relies on
> > this just getting magically translated to setting LO_AUTOCLEAR flag. So IMO
> > this has a big potential of userspace visible regression and as such I'd
> > prefer doing it separately from the bugfixes.
> 
> At least my idea would not be to disallow LOOP_CLR_FD on a used block
> devices as that would go back to the udev problems before Dave turned
> it into a magic LO_AUTOCLEAR.  But to remove the lo_refcnt check
> entirely, as loop_clr_fd now is safe against concurrent users - it
> has to anyway as there can be other users even without an open.

Ah, OK, so you'd always set LO_AUTOCLEAR and leave cleanup to happen
from lo_release()? That makes sense to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
