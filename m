Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5327FC47256
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 14:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BEB020746
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 14:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgEFOMK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 May 2020 10:12:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:43712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728555AbgEFOMK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 May 2020 10:12:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9C16CAC11;
        Wed,  6 May 2020 14:12:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5DFA11E12FB; Wed,  6 May 2020 16:12:08 +0200 (CEST)
Date:   Wed, 6 May 2020 16:12:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH 0/3] Fix blkparse and iowatcher for kernels >= 4.14
Message-ID: <20200506141208.GB5224@quack2.suse.cz>
References: <20200506133933.4773-1-jack@suse.cz>
 <E027D84B-27AE-4426-80A7-269E9357A03A@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E027D84B-27AE-4426-80A7-269E9357A03A@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 06-05-20 15:50:30, Paolo Valente wrote:
> Does this fix make process names (with PIDS) be shown too in bfq log messages?

No, I didn't change how that's handled. Also AFAICS the kernel does not add
PID information to BLK_TN_MESSAGE events (which is how bfq log messages are
passed) so blkparse has nothing to display even if it wanted.

So poor man's solution is to derive pid from the BFQ queue name and then
lookup process name from some other event. Nicer solution would be to
modify blktrace handling in the kernel to add PID information to such
events as well so we get similar info as when using tracing infrastructure
directly.

								Honza

> > Il giorno 6 mag 2020, alle ore 15:39, Jan Kara <jack@suse.cz> ha scritto:
> > 
> > I was investigating a performance issue with BFQ IO scheduler and I was
> > pondering why I'm not seeing informational messages from BFQ. After quite
> > some debugging I have found out that commit 35fe6d763229 "block: use
> > standard blktrace API to output cgroup info for debug notes" broke standard
> > blktrace API - namely the informational messages logged by bfq_log_bfqq()
> > are no longer displayed by blkparse(8) tool. This is because these messages
> > have now __BLK_TA_CGROUP bit set and that breaks flags checking in
> > blkparse(1) and iowatcher(1). This series fixes both tools to be able to
> > cope with events with __BLK_TA_CGROUP flag set.
> > 
> > 								Honza
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
