Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C61C433FE
	for <linux-block@archiver.kernel.org>; Thu, 20 Jan 2022 12:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiATMNY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jan 2022 07:13:24 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43468 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiATMNY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jan 2022 07:13:24 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EBD0721709;
        Thu, 20 Jan 2022 12:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642680802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XbTaUwDkXc2YpBVQ5zhYci9z5sdLls8fCr2xhba8dfU=;
        b=EbevpEwrW5eOA9Y9SJvV2hxHzKq0KDJow+vT+A+j7fwl6LG1uAXmWK7Mxdq//YAGdHBPas
        Ned7yhlx6PGRZFueBLkrpp4FGcl62sQrX6XvabNpmlB0WzcvIHH9DGyIWh1v8lhxgk7NPU
        6kVoTslpjM+fGrnVhBQrl/RfYiNIPOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642680802;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XbTaUwDkXc2YpBVQ5zhYci9z5sdLls8fCr2xhba8dfU=;
        b=L6jcJHwOA0W2upHKbukNTQ+fv79iSUqSqSyY2UPrU7GPyeKI9CKVbBQoluYvfjOfEyin1Q
        vaZI7TFgOJwAjxCg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DD128A3B87;
        Thu, 20 Jan 2022 12:13:22 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 93EF3A05D9; Thu, 20 Jan 2022 13:13:19 +0100 (CET)
Date:   Thu, 20 Jan 2022 13:13:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     Karel Zak <kzak@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, util-linux@vger.kernel.org,
        linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: Racy loop device reuse logic
Message-ID: <20220120121319.kernpjn45jqgween@quack3.lan>
References: <20220113154735.hdzi4cqsz5jt6asp@quack3.lan>
 <20220119085247.duhblxzp6joukarw@quack3.lan>
 <20220119113900.tm5j65wzxglggsig@ws.net.home>
 <20220119213449.jydoqbyzjudqmikk@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119213449.jydoqbyzjudqmikk@quack3.lan>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 19-01-22 22:34:49, Jan Kara wrote:
> On Wed 19-01-22 12:39:00, Karel Zak wrote:
> > On Wed, Jan 19, 2022 at 09:52:47AM +0100, Jan Kara wrote:
> > > Ping? Any opinion?
> > 
> >  Sorry for the delay.
> > 
> > > On Thu 13-01-22 16:47:35, Jan Kara wrote:
> > > > Hello,
> > > > 
> > > > Tetsuo has been doing some changes to the loop device shutdown in the
> > > > kernel and that broke LTP that is doing essentially the following loop:
> > > > 
> > > > while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done
> > > > 
> > > > And this loop is broken because of a subtle interaction with systemd-udev
> > > > that also opens the loop device. The race seems to be in mount(8) handling
> > > > itself and the altered kernel timing makes it happen. It look like:
> > > > 
> > > > bash					systemd-udev
> > > >   mount -o loop,ro isofs.iso isofs/
> > > >     /dev/loop0 is created and bound to isofs.iso, autoclear is set for
> > > >     loop0
> > > >   					opens /dev/loop0
> > > >   umount isofs/
> > > >   loop0 still lives because systemd-udev still has device open
> > > >   mount -o loop,ro isofs.iso isofs/
> > > >     gets to mnt_context_setup_loopdev()
> > > >       loopcxt_find_overlap()
> > > >       sees loop0 is still valid and with proper parameters
> > > >       reuse = true;
> > > > 					close /dev/loop0
> > > > 					  last fd closed => loop0 is
> > > > 					    cleaned up
> > > >       loopcxt_get_fd()
> > > >         opens loop0 but it is no longer the device we wanted!
> > > >     calls mount(2) which fails because we cannot read from the loop device
> > > > 
> > > > It seems to me that mnt_context_setup_loopdev() should actually recheck
> > > > that loop device parameters still match what we need after opening
> > > > /dev/loop0 (if LOOP_GET_STATUS ioctl succeeds on the fd, you are guaranteed
> > > > the loop device is in that state and will not be torn down under your
> > > > hands). What do you think?
> > 
> > Seems like elegant solution. Please, send a patch.
> 
> OK, will do.

Patch sent which fixes the problem for me. Related to this, I have found out
that loop device reuse detection code sometimes fails with EPERM (if I run
the mount loop long enough). I have tracked this down to e.g.
loopcxt_get_sizelimit() calling ul_path_read_u64() which fails (loop device
just got torn down) and ul_path_read_u64() always returns -1 on error which
gets somewhat confusingly translated to EPERM error. I think this should be
handled more gracefully so I'll send patches to fix this as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
