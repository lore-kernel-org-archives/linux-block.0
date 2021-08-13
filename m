Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB00C4320A
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 14:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AEDE60F57
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 14:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhHMOBk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 10:01:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38676 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbhHMOBk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 10:01:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D234622318;
        Fri, 13 Aug 2021 14:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628863272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=12mJK5+VgPTj9FpwvGfQUq7oXr1AbSdN+55ov6uPHRs=;
        b=12UfXo+8GbpAxlOar9nuIIhSxsGWqMNB6/GhFLPfdsQx2yt3pMrpKKUFx4T/GUw+Voj8Eu
        UN5P+x9vdBAk1QA/9/9kOLLLMUf6ad19d098NkWme1y22hICBO+pU/fD1dZ2X37cTbkxrF
        5NEvO2POaqigDg1qQ5+WEBhtEnmwmj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628863272;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=12mJK5+VgPTj9FpwvGfQUq7oXr1AbSdN+55ov6uPHRs=;
        b=/JSEd2hhessckYf9nMR4mXd3LZcIKm1xD0zAJ2SbDcn4azErPsYld9L5A7Lf97jpo15ErR
        0UTE+NKIDuk9zzDQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id B65C3A3B88;
        Fri, 13 Aug 2021 14:01:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7FC3E1E423D; Fri, 13 Aug 2021 16:01:11 +0200 (CEST)
Date:   Fri, 13 Aug 2021 16:01:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: False waker detection in BFQ
Message-ID: <20210813140111.GG11955@quack2.suse.cz>
References: <20210505162050.GA9615@quack2.suse.cz>
 <FFFA8EE2-3635-4873-9F2C-EC3206CC002B@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FFFA8EE2-3635-4873-9F2C-EC3206CC002B@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Paolo!

On Thu 20-05-21 17:05:45, Paolo Valente wrote:
> > Il giorno 5 mag 2021, alle ore 18:20, Jan Kara <jack@suse.cz> ha scritto:
> > 
> > Hi Paolo!
> > 
> > I have two processes doing direct IO writes like:
> > 
> > dd if=/dev/zero of=/mnt/file$i bs=128k oflag=direct count=4000M
> > 
> > Now each of these processes belongs to a different cgroup and it has
> > different bfq.weight. I was looking into why these processes do not split
> > bandwidth according to BFQ weights. Or actually the bandwidth is split
> > accordingly initially but eventually degrades into 50/50 split. After some
> > debugging I've found out that due to luck, one of the processes is decided
> > to be a waker of the other process and at that point we loose isolation
> > between the two cgroups. This pretty reliably happens sometime during the
> > run of these two processes on my test VM. So can we tweak the waker logic
> > to reduce the chances for false positives? Essentially when there are only
> > two processes doing heavy IO against the device, the logic in
> > bfq_check_waker() is such that they are very likely to eventually become
> > wakers of one another. AFAICT the only condition that needs to get
> > fulfilled is that they need to submit IO within 4 ms of the completion of
> > IO of the other process 3 times.
> > 
> 
> Hi Jan!
> as I happened to tell you moths ago, I feared some likely cover case
> to show up eventually.  Actually, I was even more pessimistic than how
> reality proved to be :)
> 
> I'm sorry for my delay, but I've had to think about this issue for a
> while.  Being too strict would easily run out journald as a waker for
> processes belonging to a different group.
> 
> So, what do you think of this proposal: add the extra filter that a
> waker must belong to the same group of the woken, or, at most, to the
> root group?

Returning back to this :). I've been debugging other BFQ problems with IO
priorities not really leading to service differentiation (mostly because
scheduler tag exhaustion, false waker detection, and how we inject IO for a
waker) and as a result I have come up with a couple of patches that also
address this issue as a side effect - I've added an upper time limit
(128*slice_idle) for the "third cooperation" detection and that mostly got
rid of these false waker detections. We could fail to detect waker-wakee
processes if they do not cooperate frequently but then the value of the
detection is small and the lack of isolation may do more harm than good
anyway.

Currently I'm running wider set of benchmarks for the patches to see
whether I didn't regress anything else. If not, I'll post the patches to
the list.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
