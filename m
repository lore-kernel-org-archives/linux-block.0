Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7A4C433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Apr 2022 09:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239039AbiDEJfM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345268AbiDEJWY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Apr 2022 05:22:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF73840A2F
        for <linux-block@vger.kernel.org>; Tue,  5 Apr 2022 02:10:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D212F210F1;
        Tue,  5 Apr 2022 09:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649149803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qm9Fw/mp1MiVZAnqKrxlsmgbwUCwCkA3r+UnMXLYLWg=;
        b=Vl1Lcf2uahRzky6OrpFam+WV5gyh6UhK36AhnrxkhDplU6GKZThjF25KBL0a8Y0cqNm58C
        OO6RvKOBAK1ub2bohI7VALe3P6w7+mDzWwyWp12QMDGNGj2wFLOwh6PSrwr2sz/9noOlxq
        vdzyJwlUBkJSIb+Wl0CPjQ+8CIiAwzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649149803;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qm9Fw/mp1MiVZAnqKrxlsmgbwUCwCkA3r+UnMXLYLWg=;
        b=ldiVcerhgle2I+ScrQb+bng8wgkqa5Bvd80KZMKi792G8TAQbz4dSAOEsAnKwCC9l2xyhI
        hSixvqipPRdTo4Bw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B6018A3B89;
        Tue,  5 Apr 2022 09:10:03 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2C569A0615; Tue,  5 Apr 2022 11:10:03 +0200 (CEST)
Date:   Tue, 5 Apr 2022 11:10:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: Re: yet another approach to fix the loop lock order inversions v6
Message-ID: <20220405091003.gmeuhtrwj7nzebyx@quack3.lan>
References: <20220330052917.2566582-1-hch@lst.de>
 <20220404074235.GA1046@lst.de>
 <499de381-c81e-4bd0-b5f7-1ee6be45821d@I-love.SAKURA.ne.jp>
 <20220405062838.GA24373@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405062838.GA24373@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 05-04-22 08:28:38, Christoph Hellwig wrote:
> On Mon, Apr 04, 2022 at 06:39:31PM +0900, Tetsuo Handa wrote:
> > Two bugs which Jan has found in /bin/mount might not be yet fixed in
> > versions developers/users are using. Thus, let's wait for a while
> > before committing to linux.git.
> 
> Jan, which loop bugs might be relevant here?

So there was a bug in libmount code trying to reuse already setup loop
devices and changes in timing & removing the lo_mutex from lo_open() +
suitable racing with systemd-udev probing devices caused these bugs to
manifest. The visible effect was that a loop like:

while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done

often failed with:

mount: /mnt: can't read superblock on /dev/loop0.
umount: /mnt: not mounted.

Bugs are fixed now by commits 3e1fc3bbe ("mount: Fix race in loop device
reuse code"), fb4b6b115 ("loopdev: Properly translate errors from
ul_path_read_*()"), 562990b552 ("loopdev: Do not treat errors when
detecting overlap as fatal") in util-linux git.

The only real-world impact I've heard about was LTP failing due to these
problems and those guys should be capable enough to update their util-linux
when we tell them. So I think we should be OK with pushing the kernel fixes
upstream but it may generate some noise from automated testers before
util-linux is updated on all of them...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
