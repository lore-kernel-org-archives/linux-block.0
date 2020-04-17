Return-Path: <SRS0=bgcA=6B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74450C352BE
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 09:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550942137B
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 09:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgDQJSL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:18:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:52736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730181AbgDQJSL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 05:18:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2A5B5AFAE;
        Fri, 17 Apr 2020 09:18:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E72AE1E0E58; Fri, 17 Apr 2020 11:18:08 +0200 (CEST)
Date:   Fri, 17 Apr 2020 11:18:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.com>
Subject: Re: [PATCH 0/2 RFC] bfq: Waker logic tweaks for dbench performance
Message-ID: <20200417091808.GB12234@quack2.suse.cz>
References: <20200409170915.30570-1-jack@suse.cz>
 <2C0E3547-FD20-45A4-B1B0-AAD7B0024999@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2C0E3547-FD20-45A4-B1B0-AAD7B0024999@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Paolo!

On Fri 17-04-20 09:47:07, Paolo Valente wrote:
> I'm glad you're addressing these BFQ issues.  Sorry for the delay, but
> I happen to be working on similar issues, for other sort of
> corner-case workloads.  So I wanted to consolidate my changes before
> replying.
> 
> Probably, the best first step for me, to check your proposal, is to
> merge it with my current changes, and test the outcome.  In this
> respect, my problem is that, after our last improvements for dbench,
> we cannot reproduce regressions any longer.  So, we would need your
> support to test both issues, i.e., to test throughput with dbench (on
> your side/machines), and possible other regressions of your and my
> changes (on our side/machines).
> 
> Would it be ok for you to participate in this little collaboration?
> If it is, then I'll contact you privately to kick this off.

Sure, I can test whatever patches you send me on our machines.

								Honza

> 
> Thanks,
> Paolo
> 
> > Il giorno 9 apr 2020, alle ore 19:09, Jan Kara <jack@suse.cz> ha scritto:
> > 
> > Hello,
> > 
> > I was investigating why dbench performance (even for single dbench client) with
> > BFQ is significantly worse than it used to be CFQ. The culprit is the idling
> > logic in BFQ. The dbench workload is very fsync(2) heavy. In practice the time
> > to complete fsync(2) calls is what determines the overall performance. For
> > filesystems with a journal such as xfs or ext4 it is common that fsync(2)
> > involves writing data from the process runningg fsync(2) - dbench in this case
> > - and then waiting for the journalling machinery to flush out metadata from a
> > separate process (jbd2 process in ext4 case, worker thread in xfs case).
> > CFQ's heuristic was able to determine that it isn't worth to idle waiting for
> > either dbench or jbd2 IO. BFQ's heuristic is not able to determine this and
> > thus jbd2 process is often blocked waiting for idle timer of dbench queue to
> > trigger.
> > 
> > The first patch in the series is an obvious bugfix but is not enough to improve
> > performance. The second patch does improve dbench performance from ~80 MB/s
> > to ~200 MB/s on my test machine but I'm aware that it is probably way too
> > aggressive and probably a different solution is needed. So I just wrote that
> > patch to see the results and spark some discussion :). Any idea how to
> > improve the waker logic so that dbench performance doesn't drop so
> > dramatically?
> > 
> > 								Honza
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
