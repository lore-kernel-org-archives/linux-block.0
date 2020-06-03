Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67812C433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 08:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43648206C3
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 08:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgFCIfa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:35:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:46926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgFCIfa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Jun 2020 04:35:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C231AAC37;
        Wed,  3 Jun 2020 08:35:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 040DB1E1281; Wed,  3 Jun 2020 10:35:28 +0200 (CEST)
Date:   Wed, 3 Jun 2020 10:35:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        bvanassche@acm.org, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] blktrace: Avoid sparse warnings when assigning
 q->blk_trace
Message-ID: <20200603083527.GF19165@quack2.suse.cz>
References: <20200602071205.22057-1-jack@suse.cz>
 <20200602141734.GL11244@42.do-not-panic.com>
 <20200602151033.GG13911@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602151033.GG13911@42.do-not-panic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 02-06-20 15:10:33, Luis Chamberlain wrote:
> On Tue, Jun 02, 2020 at 02:17:34PM +0000, Luis Chamberlain wrote:
> > On Tue, Jun 02, 2020 at 09:12:05AM +0200, Jan Kara wrote:
> > > Here is version of my patch rebased on top of Luis' blktrace fixes. Luis, if
> > > the patch looks fine, can you perhaps include it in your series since it seems
> > > you'll do another revision of your series due to discussion over patch 5/7?
> > > Thanks!
> > 
> > Sure thing, will throw in the pile.
> 
> I've updated the commit log as follows as well, as I think its important
> to annotate that the check for processing of the blktrace only makes
> sense if it was not set. Let me know if this is fine. The commit log
> is below.

Thanks! The changelog looks good to me.

								Honza

> 
> From: Jan Kara <jack@suse.cz>
> Date: Tue, 2 Jun 2020 09:12:05 +0200
> Subject: [PATCH 1/8] blktrace: Avoid sparse warnings when assigning
>  q->blk_trace
> 
> Mostly for historical reasons, q->blk_trace is assigned through xchg()
> and cmpxchg() atomic operations. Although this is correct, sparse
> complains about this because it violates rcu annotations since commit
> c780e86dd48e ("blktrace: Protect q->blk_trace with RCU") which started
> to use rcu for accessing q->blk_trace. Furthermore there's no real need
> for atomic operations anymore since all changes to q->blk_trace happen
> under q->blk_trace_mutex *and* since it also makes more sense to check
> if q->blk_trace is set with the mutex held *earlier* and this is now
> done through the patch titled "blktrace: break out on concurrent calls"
> and was already before on blk_trace_setup_queue().
> 
> So let's just replace xchg() with rcu_replace_pointer() and cmpxchg()
> with explicit check and rcu_assign_pointer(). This makes the code more
> efficient and sparse happy.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
