Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0836BC4724C
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 15:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E22A02082E
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 15:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgD3P7N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:59:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:43992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgD3P7N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 11:59:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6710BABC7;
        Thu, 30 Apr 2020 15:59:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B54AE1E1295; Thu, 30 Apr 2020 17:59:11 +0200 (CEST)
Date:   Thu, 30 Apr 2020 17:59:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: Commit 35fe6d7632 breaks blktrace API
Message-ID: <20200430155911.GA15637@quack2.suse.cz>
References: <20200430114711.GA6576@quack2.suse.cz>
 <7ae4a13a-2f03-a902-5bb5-3dcd20cf1fad@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ae4a13a-2f03-a902-5bb5-3dcd20cf1fad@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 30-04-20 07:10:47, Jens Axboe wrote:
> On 4/30/20 5:47 AM, Jan Kara wrote:
> > Hello,
> > 
> > I was investigating a performance issue with BFQ IO scheduler and I was
> > pondering why I'm not seeing informational messages from BFQ. After quite
> > some debugging I have found out that commit 35fe6d763229 "block: use
> > standard blktrace API to output cgroup info for debug notes" broke standard
> > blktrace API - namely the informational messages logged by bfq_log_bfqq()
> > are no longer displayed by blkparse(8) tool. This is because these messages
> > have now __BLK_TA_CGROUP bit set and that breaks flags checking in
> > blkparse(8). It isn't that hard to fix blkparse once you know what the
> > problem is but I've wasted couple hours on this...
> > 
> > Also apparently nobody tested the patch with blkparse(8) since 4.14
> > days? Admittedly this requires CONFIG_BFQ_GROUP_IOSCHED and having cgroups
> > set up for the cgroup info to get emitted which probably is not that common
> > with non-production machines.
> > 
> > Anyway, what to do now? Update blkparse(8) and hope nobody else is using
> > the blktrace API (likely I'd say)? Revert the change?
> 
> It's been this long and nobody has complained, I think we should just update
> blkparse.

Fine by me although I would note that e.g. most of our customer are running
on 4.4 or 4.12-based kernels so if any of them has their custom scripting
using blktrace API (I seriously doubt that though), they'll probably notice
the problem only in couple of years... But as I said I doubt there's
anybody doing this and blktrace is a debugging API so I'm fine with just
fixing blkparse and crossing my fingers ;) I'll send the patch after some
polishing (I just quickly hacked it up so that I can proceed with my
analysis).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
