Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF67C10F00
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 10:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B2F21841
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 10:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfCUKlM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:41:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:60738 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727829AbfCUKlM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 06:41:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9AC76AF94;
        Thu, 21 Mar 2019 10:41:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 286261E0CE4; Thu, 21 Mar 2019 11:41:10 +0100 (CET)
Date:   Thu, 21 Mar 2019 11:41:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jan Kara <jack@suse.cz>, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: Revert commit 310ca162d77
Message-ID: <20190321104110.GF29086@quack2.suse.cz>
References: <20190320125806.GD9485@quack2.suse.cz>
 <20190320151231.GA31247@kroah.com>
 <20190320151601.GA31992@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320151601.GA31992@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 20-03-19 16:16:01, Greg KH wrote:
> On Wed, Mar 20, 2019 at 04:12:31PM +0100, Greg KH wrote:
> > On Wed, Mar 20, 2019 at 01:58:06PM +0100, Jan Kara wrote:
> > > Hello,
> > > 
> > > commit 310ca162d77 "block/loop: Use global lock for ioctl() operation." has
> > > been pushed to multiple stable trees. This patch is a part of larger series
> > > that overhauls the locking inside loopback device upstream and for 4.4,
> > > 4.9, and 4.14 stable trees only this patch from the series is applied. Our
> > > testing now has shown [1] that the patch alone makes present deadlocks
> > > inside loopback driver more likely (the openqa test in our infrastructure
> > > didn't hit the deadlock before whereas with the new kernel it hits it
> > > reliably every time). So I would suggest we revert 310ca162d77 from 4.4,
> > > 4.9, and 4.14 kernels.
> > 
> > Ugh, ok.
> > 
> > > Another option would be to backport other locking fixes for the loop
> > > device but honestly I don't think that's a stable material - never heard
> > > of real users hitting problems, only syzkaller could, and we are still
> > > fixing up some small glitches resulting from that rework...
> > 
> > I tried to backport a number of the loop fixes, and odds are I am the
> > one that grabbed this.  There are other loop locking fixes in the stable
> > releases, I don't know if I can just revert this one, let me check...
> 
> Nope, does not revert cleanly due to the other loop fixes I added after
> this one.
> 
> So either I back out _all_ of the loop patches, or we leave what we have
> now, or we add the proper fixes to get things working.  I'd like to have
> this all work properly, so why not just have me backport the needed
> fixes that are upstream?

Sure, that is another option. Be sure to include recent fixups:

40853d6fc619 "loop: do not print warn message if partition scan is
successful"
758a58d0bc67 "loop: set GENHD_FL_NO_PART_SCAN after blkdev_reread_part()"

otherwise you need commits:

b1ab5fa309e6 "block/loop: Don't grab "struct file" for vfs_getattr()
operation."
...
628bd8594709 "loop: Fix double mutex_unlock(&loop_ctl_mutex) in
loop_control_ioctl()"

to drivers/block/loop.c. It's just that my experience tells me that when
there were 15 original patches in the series and then 3 followup fixups,
the series is not usually worth the risk for something nobody hit besides
fuzzers...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
