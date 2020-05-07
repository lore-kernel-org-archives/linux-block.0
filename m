Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58843C38A24
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 09:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33EA620CC7
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 09:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgEGJtq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 05:49:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:58568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgEGJtq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 05:49:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3954AAFF2;
        Thu,  7 May 2020 09:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C69821E12B0; Thu,  7 May 2020 11:49:44 +0200 (CEST)
Date:   Thu, 7 May 2020 11:49:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/3] Fix blkparse and iowatcher for kernels >= 4.14
Message-ID: <20200507094944.GA30922@quack2.suse.cz>
References: <20200506133933.4773-1-jack@suse.cz>
 <20200506144251.GA7564@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506144251.GA7564@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 06-05-20 07:42:51, Christoph Hellwig wrote:
> On Wed, May 06, 2020 at 03:39:30PM +0200, Jan Kara wrote:
> > I was investigating a performance issue with BFQ IO scheduler and I was
> > pondering why I'm not seeing informational messages from BFQ. After quite
> > some debugging I have found out that commit 35fe6d763229 "block: use
> > standard blktrace API to output cgroup info for debug notes" broke standard
> > blktrace API - namely the informational messages logged by bfq_log_bfqq()
> > are no longer displayed by blkparse(8) tool. This is because these messages
> > have now __BLK_TA_CGROUP bit set and that breaks flags checking in
> > blkparse(1) and iowatcher(1). This series fixes both tools to be able to
> > cope with events with __BLK_TA_CGROUP flag set.
> 
> I'd much rather revert a kernel change that breaks frequently used
> userspace.

We've discussed it [1]. The commit was merged in 4.14 which shows that the
breakage is not that severe as nobody noticed until now. Actually I did
some more digging in history now and until commit 743210386c "cgroup: use
cgrp->kn->id as the cgroup ID" from last November the breakage was only
visible if you had CONFIG_BLK_CGROUP enabled and had bio with bi_blkcg set
or trace note messages for non-trivial cgroups (effectively only BFQ
informational messages). After that commit trace note messages are broken
whenever you have CONFIG_BLK_CGROUP. So the reason why nobody noticed is
probably because until 5.5 the breakage was actually difficult to hit.

So I'm undecided whether at this point it's better to revert the original
commit (as likely there is other tooling that depends on this info), just
fix the fact that since commit 743210386c all trace note messages will have
non-empty cgroup info, or just fixup blkparse and move on...

								Honza

[1] https://lore.kernel.org/r/20200430114711.GA6576@quack2.suse.cz

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
