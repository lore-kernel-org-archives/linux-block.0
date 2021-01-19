Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0FDC433E9
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 15:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B61B216FD
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 15:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391668AbhASPyb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jan 2021 10:54:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391626AbhASPyN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jan 2021 10:54:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B90E20780;
        Tue, 19 Jan 2021 15:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611071612;
        bh=Iur7PMN12GFuotDbIDuqkaf5UvK7lDumrhI+4zfetYU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=AHpmAeWH1iRfEAre195nrrwKW2FWRvOUYavb2LdUrJeOVydXT2dlzWLitC8B9OTtr
         Hq1/usVFKSxPStEojtv1ZZ2TeWp1HlwZCMSOu7us9yjnprUH87/DdY7TMH8urRy7hv
         ns8gAKX9oRpRYLHt/xurKoxLbLmbxaf1AYx7BpUQSLqVkMIWe8nPLGI4A6kVNEvcDr
         hAmbcBI/WtffU1qZ8FCqEKEos8ahWvYDQjsgeo6oYqlaB57gxdwD7Kna/2zkszJFvQ
         ZWJKoDle1JMvJbU4WwD2YkxlB8tr0/PH8jIOZPpSJQ/DQNMPF16Q9Vtf5+RlB4Vgx2
         DHGT/L5AmKisg==
Date:   Tue, 19 Jan 2021 16:53:29 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Wim Osterholt <wim@djo.tudelft.nl>,
        Denis Efremov <efremov@linux.com>
Subject: Re: [PATCH RESEND] floppy: fix open(O_ACCMODE) for ioctl-only open
In-Reply-To: <9c713fa8-9da1-47b5-0d5d-92f4cd13493a@kernel.dk>
Message-ID: <nycvar.YFH.7.76.2101191649190.5622@cbobk.fhfr.pm>
References: <20160610230255.GA27770@djo.tudelft.nl> <alpine.LNX.2.00.1606131414420.6874@cbobk.fhfr.pm> <20160614184308.GA6188@djo.tudelft.nl> <alpine.LNX.2.00.1606150906320.6874@cbobk.fhfr.pm> <20160615132040.GZ14480@ZenIV.linux.org.uk>
 <alpine.LNX.2.00.1606151610420.6874@cbobk.fhfr.pm> <20160615224722.GA9545@djo.tudelft.nl> <alpine.LNX.2.00.1606160946000.6874@cbobk.fhfr.pm> <alpine.LNX.2.00.1606301317290.6874@cbobk.fhfr.pm> <9c713fa8-9da1-47b5-0d5d-92f4cd13493a@kernel.dk>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 25 Jul 2016, Jens Axboe wrote:

> > From: Jiri Kosina <jkosina@suse.cz>
> >
> > Commit 09954bad4 ("floppy: refactor open() flags handling"), as a
> > side-effect, causes open(/dev/fdX, O_ACCMODE) to fail. It turns out that
> > this is being used setfdprm userspace for ioctl-only open().
> >
> > Reintroduce back the original behavior wrt !(FMODE_READ|FMODE_WRITE)
> > modes, while still keeping the original O_NDELAY bug fixed.
> >
> > Cc: stable@vger.kernel.org # v4.5+
> > Reported-by: Wim Osterholt <wim@djo.tudelft.nl>
> > Tested-by: Wim Osterholt <wim@djo.tudelft.nl>
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> Added for this series, thanks.

[ CCing Denis too ]

Let me revive this 4 years old thread.

I've just now noticed that instead of my patch above being merged, what 
happened instead was

	commit f2791e7eadf437633f30faa51b30878cf15650be
	Author: Jens Axboe <axboe@fb.com>
	Date:   Thu Aug 25 08:56:51 2016 -0600

	    Revert "floppy: refactor open() flags handling"
    
	    This reverts commit 09954bad448791ef01202351d437abdd9497a804.


which was plain revert of 09954bad4 (without any further explanation), 
which in turn reintroduced the O_NDELAY issue, and I've just been hit by 
it again.

I am not able to find any e-mail thread that'd indicate why ultimately 
revert happened, instead of mergin my fix.
Jens, do you have any idea?

Thanks,

-- 
Jiri Kosina
SUSE Labs

