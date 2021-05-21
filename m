Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97623C433B4
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 12:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A8F3613D6
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 12:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbhEUMHU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 08:07:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:56502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235092AbhEUMHP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 08:07:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E22F2AC11;
        Fri, 21 May 2021 12:05:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AAC951F2C73; Fri, 21 May 2021 14:05:51 +0200 (CEST)
Date:   Fri, 21 May 2021 14:05:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Khazhy Kumykov <khazhy@google.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH 2/2] blk: Fix lock inversion between ioc lock and bfqd
 lock
Message-ID: <20210521120551.GK18952@quack2.suse.cz>
References: <20210520223353.11561-1-jack@suse.cz>
 <20210520223353.11561-3-jack@suse.cz>
 <YKcFZMJiFnsktsBu@T590>
 <CACGdZYKk01Ef7aVjdU9bmL+6Qo99Dc_HqKKiEECGJSsRmADtHQ@mail.gmail.com>
 <YKdZEanY3WtXGjAc@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKdZEanY3WtXGjAc@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 21-05-21 14:54:09, Ming Lei wrote:
> On Thu, May 20, 2021 at 08:29:49PM -0700, Khazhy Kumykov wrote:
> > On Thu, May 20, 2021 at 5:57 PM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > On Fri, May 21, 2021 at 12:33:53AM +0200, Jan Kara wrote:
> > > > Lockdep complains about lock inversion between ioc->lock and bfqd->lock:
> > > >
> > > > bfqd -> ioc:
> > > >  put_io_context+0x33/0x90 -> ioc->lock grabbed
> > > >  blk_mq_free_request+0x51/0x140
> > > >  blk_put_request+0xe/0x10
> > > >  blk_attempt_req_merge+0x1d/0x30
> > > >  elv_attempt_insert_merge+0x56/0xa0
> > > >  blk_mq_sched_try_insert_merge+0x4b/0x60
> > > >  bfq_insert_requests+0x9e/0x18c0 -> bfqd->lock grabbed
> > >
> > > We could move blk_put_request() into scheduler code, then the lock
> > > inversion is avoided. So far only mq-deadline and bfq calls into
> > > blk_mq_sched_try_insert_merge(), and this change should be small.
> > 
> > We'd potentially be putting multiple requests if we keep the recursive merge.
> 
> Oh, we still can pass a list to hold all requests to be freed, then free
> them all outside in scheduler code.

If we cannot really get rid of the recursive merge (not yet convinced),
this is also an option I've considered. I was afraid what can we use in
struct request to attach request to a list but it seems .merged_requests
handlers remove the request from the queuelist already so we should be fine
using that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
