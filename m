Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F671C433E0
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 13:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3B80221F1
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 13:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbhAMNZo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 08:25:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:35150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbhAMNZo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 08:25:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C45C6AC24;
        Wed, 13 Jan 2021 13:25:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 78A651E0872; Wed, 13 Jan 2021 14:25:02 +0100 (CET)
Date:   Wed, 13 Jan 2021 14:25:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.com>
Subject: Re: [PATCH 2/2] bfq: Allow short_ttime queues to have waker
Message-ID: <20210113132502.GF6854@quack2.suse.cz>
References: <20200409170915.30570-1-jack@suse.cz>
 <20200409170915.30570-3-jack@suse.cz>
 <9F84671F-5B43-46A8-8D92-FE30F6023F94@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9F84671F-5B43-46A8-8D92-FE30F6023F94@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun 10-01-21 10:20:19, Paolo Valente wrote:
> 
> 
> > Il giorno 9 apr 2020, alle ore 19:09, Jan Kara <jack@suse.cz> ha scritto:
> > 
> > Currently queues that have average think time shorter than slice_idle
> > cannot have waker. However this requirement is too strict. E.g. dbench
> > process always submits a one or two IOs (which is enough to pull its
> > average think time below slice_idle) and then blocks waiting for jbd2
> > thread to commit a transaction. Due to idling logic jbd2 thread is
> > often forced to wait for dbench's idle timer to trigger to be able to
> > submit its IO and this severely delays the overall benchmark progress.
> > 
> > E.g. on my test machine current dbench single-thread throughput is ~80
> > MB/s, with this patch it is ~200 MB/s.
> > 
> 
> Hi Jan,
> I've modified this logic a little bit (in patches that I'm going to
> submit).  And I don't see your boost in my tests.  So it's difficult
> for me to validate this change.  If ok for you, you could test it on
> top of the patches that I'll submit.  If you see a boost, and (as I
> expect) I won't see any regression, this improvement is very welcome
> for me.

As I wrote in the cover letter, I'm not really convinced that patch
conceptually makes sence. What you later implemented should be definitely a
more sophisticated approach to the problem. So I'd just discard this patch.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
