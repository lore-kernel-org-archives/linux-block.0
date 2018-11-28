Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B056C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 06:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B894D20832
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 06:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B894D20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbeK1Rg1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:36:27 -0500
Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:45996 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727082AbeK1Rg1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 12:36:27 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Nov 2018 12:36:25 EST
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl6.internode.on.net with ESMTP; 28 Nov 2018 17:00:49 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gRtN0-0004DR-Iy; Wed, 28 Nov 2018 17:30:46 +1100
Date:   Wed, 28 Nov 2018 17:30:46 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Allison Henderson <allison.henderson@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com
Subject: Re: [RFC PATCH v1 0/7] Block/XFS: Support alternative mirror device
 retry
Message-ID: <20181128063046.GO6311@dastard>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
 <20181128053303.GL6311@dastard>
 <20181128054923.GF8125@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128054923.GF8125@magnolia>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27, 2018 at 09:49:23PM -0800, Darrick J. Wong wrote:
> On Wed, Nov 28, 2018 at 04:33:03PM +1100, Dave Chinner wrote:
> > On Tue, Nov 27, 2018 at 08:49:44PM -0700, Allison Henderson wrote:
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
> > > * Expanding bi_write_hint to bi_rw_hint, now @bi_rw_hint has three meanings.
> > >  1.Original write_hint.
> > >  2.end_io() will update @bi_rw_hint to reflect which mirror this i/o really happened.
> > >  3.Fs set @bi_rw_hint to force driver e.g raid1 read from a specific mirror.
> > > 
> > > * Modify md/raid1 to support this retry feature.
> > > 
> > > * Add b_rw_hint to xfs_buf
> > >   This patch adds a new field b_rw_hint to xfs_buf.  We will use this to set the
> > >   new bio->bi_rw_hint when submitting the read request, and also to store the
> > >   returned mirror when the read compleates
> > 
> > One thing that is going to make this more complex at the XFS layer
> > is discontiguous buffers. They require multiple IOs (and therefore
> > bios) and so we are going to need to ensure that all the bios use
> > the same bi_rw_hint.
> 
> Hmm, we hadn't thought about that.  What happens if we have a
> discontiguous buffer mapped to multiple blocks, and there's only one
> good copy of each block on separate disks in the whole array?
> 
> e.g. we have 8k directory blocks on a 4k block filesystem, only disk 0
> has a good copy of block 0 and only disk 1 has a good copy of block 1?

Then the user has a disaster on their hands because they have
multiple failing disks. 

> I think we're just stuck with failing the whole thing because we can't
> check the halves of the 8k block independently and there's too much of a
> combinatoric explosion potential to try to mix and match.

Yup, user needs to fix their storage before the filesystem can
attempt recovery.

> > > We're not planning to take over all 16 bits of the read hint field; just looking for
> > > feedback about the sanity of the overall approach.
> > 
> > It seems conceptually simple enough - the biggest questions I have
> > are:
> > 
> > 	- how does propagation through stacked layers work?
> 
> Right now it doesn't, though once we work out how to make stacking work
> through device mapper (my guess is that simple dm targets like linear
> and crypt can set the mirror count to min(all underlying devices).
> 
> > 	- is it generic/abstract enough to be able to work with
> > 	  RAID5/6 to trigger verification/recovery from the parity
> > 	  information in the stripe?
> 
> In theory we could supply a raid5 implementation, wherein rw_hint == 0
> lets the raid do as it pleases; rw_hint == 1 reads from the stripe; and
> rw_hint == 2 forces stripe recovery for the given block.

So more magic numbers to define complex behaviours? :P

> A trickier scenario that I have no idea how to solve is the question of
> how to handle dynamic redundancy levels.  We don't have a standard bio
> error value that means "this mirror is temporarily offline", so if you

We can get ETIMEDOUT, ENOLINK, EBUSY and EAGAIN from the block layer
which all indicate temporary errors (see blk_errors[]). Whether the
specific storage layers are actually using them is another matter...

> have a raid1 of two disks and disk 0 goes offline, the retry loop in xfs
> will hit the EIO and abort without even asking disk 1.  It's also
> unclear if we need to designate a second bio error value to mean "this
> mirror is permanently gone".

If we have a mirror based retries, we should probably consider EIO
as "try next mirror", not as a hard failure.

> [Also insert handwaving about whether or not online fsck will want to
> control retries and automatic rewrite; I suspect the answer is that it
> doesn't care.]

Don't care - have the storage fix itself, then check what comes
back and fix it from there.

> [[Also insert severe handwaving about do we expose this to userspace so
> that xfs_repair can use it?]]

I suspect the answer there is through the AIO interfaces....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
