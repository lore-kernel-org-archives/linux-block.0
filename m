Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413CAC433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Feb 2021 10:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E034864EAF
	for <linux-block@archiver.kernel.org>; Fri, 19 Feb 2021 10:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBSK1y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Feb 2021 05:27:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:35382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhBSK1x (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Feb 2021 05:27:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8699ACBF;
        Fri, 19 Feb 2021 10:27:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EA2921E14BC; Fri, 19 Feb 2021 11:27:11 +0100 (CET)
Date:   Fri, 19 Feb 2021 11:27:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Jan Kara <jack@suse.cz>, Keith Busch <kbusch@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] Revert "block: Do not discard buffers under a mounted
 filesystem"
Message-ID: <20210219102711.GC6086@quack2.suse.cz>
References: <20210216133849.8244-1-jack@suse.cz>
 <20210216163606.GA4063489@infradead.org>
 <20210216174941.GA2708768@dhcp-10-100-145-180.wdc.com>
 <BL0PR04MB651447424E3A3EFD5BE7A987E7879@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20210218140703.GD16953@quack2.suse.cz>
 <BL0PR04MB651418C1C31967E5AF7743A2E7859@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR04MB651418C1C31967E5AF7743A2E7859@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 18-02-21 22:35:41, Damien Le Moal wrote:
> On 2021/02/18 23:07, Jan Kara wrote:
> > On Tue 16-02-21 23:05:57, Damien Le Moal wrote:
> >> On 2021/02/17 2:51, Keith Busch wrote:
> >>> On Tue, Feb 16, 2021 at 04:36:06PM +0000, Christoph Hellwig wrote:
> >>>> On Tue, Feb 16, 2021 at 02:38:49PM +0100, Jan Kara wrote:
> >>>>> Apparently there are several userspace programs that depend on being
> >>>>> able to call BLKDISCARD ioctl without the ability to grab bdev
> >>>>> exclusively - namely FUSE filesystems have the device open without
> >>>>> O_EXCL (the kernel has the bdev open with O_EXCL) so the commit breaks
> >>>>> fstrim(8) for such filesystems. Also LVM when shrinking LV opens PV and
> >>>>> discards ranges released from LV but that PV may be already open
> >>>>> exclusively by someone else (see bugzilla link below for more details).
> >>>>>
> >>>>> This reverts commit 384d87ef2c954fc58e6c5fd8253e4a1984f5fe02.
> >>>>
> >>>> I think that is a bad idea. We fixed the problem for a reason.
> >>>> I think the right fix is to just do nothing if the device hasn't been
> >>>> opened with O_EXCL and can't be reopened with it, just don't do anything
> >>>> but also don't return an error.  After all discard and thus
> >>>> BLKDISCARD is purely advisory.
> >>>
> >>> A discard is advisory, but BLKZEROOUT is not, so something different
> >>> should happen there. We were also planning to send a patch using this
> >>> same pattern for Zone Reset to fix stale page cache issues after the
> >>> reset, but we'll wait to see how this settles before sending that.
> >>
> >> There is also another problem: the truncate_bdev & operation following it
> >> (discard, zeroout or zone reset) are not atomic vs read/write operations to the
> >> bdev. Without mutual exclusion, that page invalidation is best effort only since
> >> reads can snick in between the truncate and discard (or zeroout or zone reset).
> >> With our zone reset stale page problem case, it is reads from udevd that we see
> >> snicking in between the truncate bdev and zone reset and so we still get stale
> >> pages after the zone reset is finished. No solution to propose for solving that,
> >> yet...
> > 
> > Well, at least blkdev_fallocate() does:
> > 
> > 	truncate_bdev_range();
> > 	blkdev_issue_zeroout();
> > 	invalidate_inode_pages2_range();
> > 
> > so racing reads should not result in stale page cache contents AFAICT.
> 
> Yes, but concurrent writes can then get in between the blkdev_issue_zeroout()
> and invalidate_inode_pages2_range() and data discarded before hitting the
> drive... Not very nice either. Granted, that would mean that userland has 2
> concurrent writers that are not synchronized. So weird results are to be
> expected. I guess it is probably safe to ignore that case ?

Yes. IMHO any result that doesn't crash the kernel (or burn the HW) is fine
in that case.

> I guess the same pattern as above for zeroout would work for reset zone too.
> Will try to see if that solves our test problem.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
