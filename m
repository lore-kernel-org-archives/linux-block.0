Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20491C4320E
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 17:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 028F360E75
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 17:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbhHZRvw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 13:51:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51878 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbhHZRvw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 13:51:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BAA4D22201;
        Thu, 26 Aug 2021 17:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630000263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hb/qm1jrnqY/KdKwTRoSgfMFLNJXuGtT8ndi41k1R1o=;
        b=IoLQyDf2AneEHC6W4tovxowAEqgAXFT4yVy0FJFziZeZz/wTlLan/tTgMz6srkTdZlfnZJ
        KnCe51d0d2pKjpQc20UCRfFf91FHxi2co14ANHLE6QUsbxXJW84+J2eaaw5rM834MsE4EN
        7mS2oTFkfyYjHXS3E/dUt1WWepv8Sfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630000263;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hb/qm1jrnqY/KdKwTRoSgfMFLNJXuGtT8ndi41k1R1o=;
        b=5YmrnN9wd0oZjE+VBqa7uH85c+YK6Of2l+Avn8sapS5sNwhQvkjHPHoDBT/7nK/RZRbHDr
        ttkeNa9w4Lk8VbCA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id A9E09A3B8B;
        Thu, 26 Aug 2021 17:51:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E8CE31E0BD5; Thu, 26 Aug 2021 19:51:03 +0200 (CEST)
Date:   Thu, 26 Aug 2021 19:51:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: False waker detection in BFQ
Message-ID: <20210826175103.GA919@quack2.suse.cz>
References: <20210505162050.GA9615@quack2.suse.cz>
 <FFFA8EE2-3635-4873-9F2C-EC3206CC002B@linaro.org>
 <20210813140111.GG11955@quack2.suse.cz>
 <A72B321A-3952-4C00-B7DB-67954B05B99A@linaro.org>
 <20210823160618.GI21467@quack2.suse.cz>
 <20210825164301.GB14270@quack2.suse.cz>
 <DF2D1482-0CF4-4CDF-B31C-FA3354AC831C@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DF2D1482-0CF4-4CDF-B31C-FA3354AC831C@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 26-08-21 11:45:17, Paolo Valente wrote:
> 
> 
> > Il giorno 25 ago 2021, alle ore 18:43, Jan Kara <jack@suse.cz> ha scritto:
> > 
> > On Mon 23-08-21 18:06:18, Jan Kara wrote:
> >> On Mon 23-08-21 15:58:25, Paolo Valente wrote:
> >>>> Currently I'm running wider set of benchmarks for the patches to see
> >>>> whether I didn't regress anything else. If not, I'll post the patches to
> >>>> the list.
> >>> 
> >>> Any news?
> >> 
> >> It took a while for all those benchmarks to run. Overall results look sane,
> >> I'm just verifying by hand now whether some of the localized regressions
> >> (usually specific to a particular fs+machine config) are due to a measurement
> >> noise or real regressions...
> > 
> > OK, so after some manual analysis I've found out that dbench indeed becomes
> > more noisy with my changes for high numbers of processes. I'm leaving for
> > vacation soon so I will not be probably able to debug it before I leave but
> > let me ask you one thing: The problematic change seems to be mostly a
> > revert of 7cc4ffc55564 ("block, bfq: put reqs of waker and woken in
> > dispatch list") and I'm currently puzzled why it has such an effect. What
> > I've found out is that 7cc4ffc55564 results in IO of higher priority
> > process being injected into the time slice of lower priority process and
> > thus there's always only single busy queue (of the lower priority process)
> > and thus higher priority process queue never gets scheduled. As a result
> > higher priority IO always competes with lower priority IO and there's no
> > service differentiation (we get 50/50 split of throughput between the
> > processes despite different IO priorities).
> 
> I need a little help here.  Since high-priority I/O is immediately
> injected, I wonder why it does not receive all the bandwidth it
> demands.  Maybe, from your analysis, you have an answer.  Perhaps it
> happens because:
> 1) high-priority I/O is FIFO-queued with lower-priority I/O in the
>    dispatch list?

Yes, this is the case.

> >  And this scenario shows that
> > always injecting IO of waker/wakee isn't desirable, especially in a way as
> > done in 7cc4ffc55564 where injected IO isn't accounted within BFQ at all
> > (which easily allows for service degradation unnoticed by BFQ).
> 
> Not sure that accounting would help high-priority I/O in your scenario.

It did help noticeably. Because then both high and low priority bfq queues
become busy so bfq_select_queue() sees both queues and schedules higher
priority queue.

> >  That's why
> > I've basically reverted that commit on the ground that on next dispatch we
> > call bfq_select_queue() which will see waker/wakee has IO to do and can
> > decide to inject the IO anyway. We do more CPU work but the IO pattern
> > should be similar. But apparently I was wrong :)
> 
> For the pattern to be similar, I guess that, when new high-priority
> I/O arrives, this I/O should preempt lower-priority I/O.
> Unfortunately, this is not always the case, depending on other
> parameters.  Waker/wakee I/O is guaranteed to be injected only when the
> in-service queue has no I/O.
> 
> At any rate, probably we can solve this puzzle by just analyzing a
> trace in which you detect a loss of throughput without 7cc4ffc55564.
> The best case would be one with the minimum possible number of
> threads, to get a simpler trace.

Yeah, OK, I'll gather the trace once I return from vacation and look into
it. Thanks for help!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
