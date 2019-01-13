Return-Path: <SRS0=EL0S=PV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F46CC43387
	for <linux-block@archiver.kernel.org>; Sun, 13 Jan 2019 22:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5640A20850
	for <linux-block@archiver.kernel.org>; Sun, 13 Jan 2019 22:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfAMWms (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Jan 2019 17:42:48 -0500
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:15530 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbfAMWms (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Jan 2019 17:42:48 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 14 Jan 2019 09:12:45 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gioSq-0007Dr-Cs; Mon, 14 Jan 2019 09:42:44 +1100
Date:   Mon, 14 Jan 2019 09:42:44 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Kurt Miller <kurt@intricatesoftware.com>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: Block device flush ordering
Message-ID: <20190113224244.GC4205@dastard>
References: <1547130601.20294.152.camel@intricatesoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547130601.20294.152.camel@intricatesoftware.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[ cc'd linux-block@vger.kernel.org, where questions about block
device behaviour are better directed. ]

On Thu, Jan 10, 2019 at 09:30:01AM -0500, Kurt Miller wrote:
> For a well behaved block device that has a writeback cache,
> what is the proper behavior of flush when there are more
> then one outstanding flush operations? Is it;
> 
> Flush all writes seen since the last flush.
> or
> Flush all writes received prior to the flush including
> those before any prior flush.
> 
> For example take the following order of requests presented
> to the block device:
> 
> 	writes 1-5
> 	flush 1
> 	write 6
> 	flush 2
> 
> Can flush 2 finish with success as soon as write 6 is flushed
> (which may be before flush 1 success)? Or must it wait for
> all prior write operations to flush (writes 1-6)?

Don't take what I say as gospel, but according to block/blk-flush.c:

.....
 * Currently, the following conditions are used to determine when to issue
 * flush.
 *
 * C1. At any given time, only one flush shall be in progress.  This makes
 *     double buffering sufficient.
.....

However, flushes can be deferred and re-ordered vs other non-flush
write IO dispatch. As such, the rules we work to with filesystems is
that a flush only guarantees IO that is already completed will be
written to stable storage.  i.e. the filesystem has to wait for IO
completion of a write IO it needs to be stable before it can issue
(and wait for) a flush that will guarantee that it is on stable
storage.

IOWs, if your above scenario is:

	submit writes 1-5
	flush 1
	submit write 6
	writes 1,3,5 complete
	flush 2
	writes 2,4,6 complete

Then flush 1 does not guarantee any of the writes are on stable
storage. They *may* be on stable storage if the timing is right, but
it is not guaranteed by the OS code. Likewise, flush 2 only
guarantees writes 1, 3 and 5 are on stable storage becase they are
the only writes that have been signalled as complete when flush 2
was submitted.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
