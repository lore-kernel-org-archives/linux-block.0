Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930CEC4360F
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 03:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D67221773
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 03:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfBSDd1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:33:27 -0500
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:3703 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725863AbfBSDd1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Feb 2019 22:33:27 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 19 Feb 2019 14:03:25 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gvw9r-0004MS-5U; Tue, 19 Feb 2019 14:33:23 +1100
Date:   Tue, 19 Feb 2019 14:33:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, hch@infradead.org, adilger@dilger.ca
Subject: Re: [RFC PATCH v2 0/9] Block/XFS: Support alternative mirror device
 retry
Message-ID: <20190219033323.GG14116@dastard>
References: <20190213095044.29628-1-bob.liu@oracle.com>
 <20190218213150.GE14116@dastard>
 <20190219025520.GB32253@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219025520.GB32253@magnolia>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 18, 2019 at 06:55:20PM -0800, Darrick J. Wong wrote:
> On Tue, Feb 19, 2019 at 08:31:50AM +1100, Dave Chinner wrote:
> > On Wed, Feb 13, 2019 at 05:50:35PM +0800, Bob Liu wrote:
> > > Motivation:
> > > When fs data/metadata checksum mismatch, lower block devices may have other
> > > correct copies. e.g. If XFS successfully reads a metadata buffer off a raid1 but
> > > decides that the metadata is garbage, today it will shut down the entire
> > > filesystem without trying any of the other mirrors.  This is a severe
> > > loss of service, and we propose these patches to have XFS try harder to
> > > avoid failure.
> > > 
> > > This patch prototype this mirror retry idea by:
> > > * Adding @nr_mirrors to struct request_queue which is similar as
> > >   blk_queue_nonrot(), filesystem can grab device request queue and check max
> > >   mirrors this block device has.
> > >   Helper functions were also added to get/set the nr_mirrors.
> > > 
> > > * Introducing bi_rd_hint just like bi_write_hint, but bi_rd_hint is a long bitmap
> > > in order to support stacked layer case.
> > > 
> > > * Modify md/raid1 to support this retry feature.
> > > 
> > > * Adapter xfs to use this feature.
> > >   If the read verify fails, we loop over the available mirrors and retry the read.
> > 
> > Why does the filesystem have to iterate every single posible
> > combination of devices that are underneath it?
> > 
> > Wouldn't it be much simpler to be able to attach a verifier
> > function to the bio, and have each layer that gets called iterate
> > over all it's copies internally until the verfier function passes
> > or all copies are exhausted?
> > 
> > This works for stacked mirrors - it can pass the higher layer
> > verifier down as far as necessary. It can work for RAID5/6, too, by
> > having that layer supply it's own verifier for reads that verifies
> > parity and can reconstruct of failure, then when it's reconstructed
> > a valid stripe it can run the verifier that was supplied to it from
> > above, etc.
> > 
> > i.e. I dont see why only filesystems should drive retries or have to
> > be aware of the underlying storage stacking. ISTM that each
> > layer of the storage stack should be able to verify what has been
> > returned to it is valid independently of the higher layer
> > requirements. The only difference from a caller point of view should
> > be submit_bio(bio); vs submit_bio_verify(bio, verifier_cb_func);
> 
> What if instead of constructing a giant pile of verifier call chain, we
> simply had a return value from ->bi_end_io that would then be returned
> from bio_endio()?

Conceptually it acheives the same thing - getting the high level
verifier status down to the lower layer to say "this copy is bad,
try again", but I suspect all the bio chaining and cloning done in
the stack makes this much more difficult than it seems.

> Stacked things like dm-linear would have to know how to connect
> the upper endio to the lower endio though.  And that could have
> its downsides, too. 

Stacking always makes things hard :/

> How long do we tie up resources in the scsi
> layer while upper levels are busy running verification functions...?

I suspect there's a more important issue to worry about: we run the
XFS read verifiers in an async work queue context after collecting
the IO completion status from the bio, rather than running directly
in bio->bi_end_io() call chain.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
