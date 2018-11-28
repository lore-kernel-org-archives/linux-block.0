Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC4BC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 05:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84EF20832
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 05:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84EF20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeK1Qks (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:40:48 -0500
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:25172 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726894AbeK1Qkr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 11:40:47 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 28 Nov 2018 16:10:20 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gRsaB-0004AL-FW; Wed, 28 Nov 2018 16:40:19 +1100
Date:   Wed, 28 Nov 2018 16:40:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Allison Henderson <allison.henderson@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com
Subject: Re: [PATCH v1 6/7] xfs: Rewrite retried read
Message-ID: <20181128054019.GN6311@dastard>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
 <1543376991-5764-7-git-send-email-allison.henderson@oracle.com>
 <20181128051719.GK6311@dastard>
 <20181128052604.GE8125@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128052604.GE8125@magnolia>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27, 2018 at 09:26:04PM -0800, Darrick J. Wong wrote:
> On Wed, Nov 28, 2018 at 04:17:19PM +1100, Dave Chinner wrote:
> > On Tue, Nov 27, 2018 at 08:49:50PM -0700, Allison Henderson wrote:
> > > If we had to try more than one mirror to get a successful
> > > read, then write that buffer back to correct the bad mirro
> > > 
> > > Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
> > > ---
> > >  fs/xfs/xfs_buf.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> > > index f102d01..81f6491 100644
> > > --- a/fs/xfs/xfs_buf.c
> > > +++ b/fs/xfs/xfs_buf.c
> > > @@ -847,6 +847,14 @@ xfs_buf_read_map(
> > >  
> > >  		}
> > >  retry_done:
> > > +
> > > +		/*
> > > +		 * if we had to try more than one mirror to sucessfully read
> > > +		 * the buffer, write the buffer back
> > > +		 */
> > > +		if (!bp->b_error && i > 0)
> > > +			xfs_bwrite(bp);
> > > +
> > 
> > This can go in the case statement on retry and then you don't need
> > to check for i > 0 or, well, bp->b_error. i.e.
> > 
> > 		swtich (bp->b_error) {
> > 		case -EBADCRC:
> > 		case -EIO:
> > 		case -EFSCORRUPTED:
> > 			/* try again from different copy */
> > 			continue;
> > 		0:
> > 			/* good copy, rewrite it to repair bad copy */
> > 			xfs_bwrite(bp);
> 
> Some day we might want to provide some controls for how long we'll retry
> these reads and whether or not we automatically rewrite buffers, since
> some administrators might prefer fast fail to get failover started.

Sure, but if the recovery code is trewn all through the read code,
it becomes a mess to untangle. isolate the recovery code as much as
possible, that way we can factor it out as it becomes more complex.

> (Not now though)

Which is exactly my point about future recovery complexity.... :P

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
