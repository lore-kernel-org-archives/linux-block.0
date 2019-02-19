Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA1BC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 13:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FB421736
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 13:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfBSNU3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:20:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:52726 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbfBSNU2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 08:20:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C408AC8A;
        Tue, 19 Feb 2019 13:20:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3583A1E1570; Tue, 19 Feb 2019 14:20:26 +0100 (CET)
Date:   Tue, 19 Feb 2019 14:20:26 +0100
From:   Jan Kara <jack@suse.cz>
To:     Meelis Roos <mroos@linux.ee>
Cc:     Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-alpha@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: ext4 corruption on alpha with 4.20.0-09062-gd8372ba8ce28
Message-ID: <20190219132026.GA28293@quack2.suse.cz>
References: <fb63a4d0-d124-21c8-7395-90b34b57c85a@linux.ee>
 <1c26eab4-3277-9066-5dce-6734ca9abb96@linux.ee>
 <076b8b72-fab0-ea98-f32f-f48949585f9d@linux.ee>
 <20190216174536.GC23000@mit.edu>
 <e175b885-082a-97c1-a0be-999040a06443@linux.ee>
 <20190218120209.GC20919@quack2.suse.cz>
 <4e015688-8633-d1a0-308b-ba2a78600544@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e015688-8633-d1a0-308b-ba2a78600544@linux.ee>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 19-02-19 14:17:09, Meelis Roos wrote:
> > > > > The result of the bisection is
> > > > > [88dbcbb3a4847f5e6dfeae952d3105497700c128] blkdev: avoid migration stalls for blkdev pages
> > > > > 
> > > > > Is that result relevant for the problem or should I continue bisecting between 4.20.0 and the so far first bad commit?
> > > > 
> > > > Can you try reverting the commit and see if it makes the problem go away?
> > > 
> > > Tried reverting it on top of 5.0.0-rc6-00153-g5ded5871030e and it seems
> > > to make the kernel work - emerge --sync succeeded.
> There is more to it.
> 
> After running 5.0.0-rc6-00153-g5ded5871030e-dirty (with the revert of
> that patch) successfully for Gentoo update, I upgraded the kernel to
> 5.0.0-rc7-00011-gb5372fe5dc84-dirty (todays git + revert of this patch)
> and it broke on rsync again:
> 
> RepoStorageException: command exited with status -6: rsync -a --link-dest /usr/portage --exclude=/distfiles --exclude=/local --exclude=/lost+found --exclude=/packages --exclude /.tmp-unverified-download-quarantine /usr/portage/ /usr/portage/.tmp-unverified-download-quarantine/
> 
> Nothing in dmesg.
> 
> This means the real root reason is somewhere deeper and reverting this
> commit just made it less likely to happen.

Thanks for information. Yeah, that makes somewhat more sense. Can you ever
see the failure if you disable CONFIG_TRANSPARENT_HUGEPAGE? Because your
findings still seem to indicate that there' some problem with page
migration and Alpha (added MM list to CC).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
