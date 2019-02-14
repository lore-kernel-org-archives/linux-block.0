Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993C3C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 21:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660462147C
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 21:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="K4YVpkwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440160AbfBNV2m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:28:42 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39976 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440159AbfBNV2m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 16:28:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id bj4so3806552plb.7
        for <linux-block@vger.kernel.org>; Thu, 14 Feb 2019 13:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rw2+D7+us+wJqdcSNjpNfeFzsqQkBVrdgzooPvFEdxI=;
        b=K4YVpkwdteoladCHicIieFXiZ7fB+i90feP85dmyIF5dcABOwDVuSTpQ1b9kRGlJzo
         eaIG0S5wDpd/6wXcwnoF0Th1mcoDt8M4yxjtVNg/sEsPLiSSfQSdAUR6Ep9jtLXZStSz
         iqapTyleGfw+ouwzYdZnwj12qCCF/0jEZH2RxbP7k7AL+PUR0lQYVRnN9Bb+0jetMOl6
         XnH3/nLP13UiLIbByo/IuMKItcFQjLMk+GxNO4XCq2ebdsGtZBY2TVkgs2jyiZEOs31u
         hIgt4gpjppGYZrQBgz1HLn8sjY1FQ+0UKrqPSoTUlJQ0EZZRwje3yFSkE6o3sAnsNB+Z
         6Nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rw2+D7+us+wJqdcSNjpNfeFzsqQkBVrdgzooPvFEdxI=;
        b=OBwmmh0UTyW3P+cHdOe9k6O2jynk0myIx/j/nf26ZRPCtyZMil68+3+uz281PqBiXA
         tuKwWm1tONalf0/9z8JVBHUVEYduZXNntL+BsVsa2uHIj4UD597ypJ3g5V0UX5Yc/f1h
         /Ix3/XaM8TS6sXuSThfHRgSBltl21GzBXlh53kuWi64aVJgYtRIrkkTsAaiupfUz5Yfz
         2Cke1MyrKq805LvXzcvJfBLGjgeOe0UOIeiqeJFAi2Htu26KNz1uxb5Zw5V8OzWY25xV
         6V6WMxqfT4pa/OQkyob23npMsZzC4yMgi/d6sklylDyqApkJYkfyZweFOtuwY3/0yvBQ
         fJRg==
X-Gm-Message-State: AHQUAuaEqf5bvKPyWh9jalvNHzUsedMIfN5PGD4/NG1drblsyAfx2POH
        UZyasQBAbqWRlanF1PLD0YlzFPnRjqE=
X-Google-Smtp-Source: AHgI3IY6rX7RIIlCeCrNvJREsSaqZdL3ScFlFbtTs2q9LgS0Lj1DfIS44AkoSz5E/2wFsLKWPbKfuQ==
X-Received: by 2002:a17:902:583:: with SMTP id f3mr6565146plf.202.1550179720276;
        Thu, 14 Feb 2019 13:28:40 -0800 (PST)
Received: from vader ([2620:10d:c090:200::7:c363])
        by smtp.gmail.com with ESMTPSA id c17sm4103576pgg.0.2019.02.14.13.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 13:28:39 -0800 (PST)
Date:   Thu, 14 Feb 2019 13:28:38 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] improving storage testing
Message-ID: <20190214212838.GC9819@vader>
References: <20190213180754.GX23000@mit.edu>
 <20190214121040.vckivyo5qcp6iyc4@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214121040.vckivyo5qcp6iyc4@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 14, 2019 at 01:10:40PM +0100, Lukas Czerner wrote:
> On Wed, Feb 13, 2019 at 01:07:54PM -0500, Theodore Y. Ts'o wrote:
> > 
> > 2) Documenting what are known failures should be for various tests on
> > different file systems and kernel versions.  I think we all have our
> > own way of excluding tests which are known to fail.  One extreme case
> > is where the test case was added to xfstests (generic/484), but the
> > patch to fix it got hung up because it was somewhat controversial, so
> > it was failing on all file systems.
> > 
> > Other cases might be when fixing a particular test failure is too
> > complex to backport to stable (maybe because it would drag in all
> > sorts of other changes in other subsystems), so that test is Just
> > Going To Fail for a particular stable kernel series.
> > 
> > It probably doesn't make sense to do this in xfstests, which is why we
> > all have our own individual test runners that are layered on top of
> > xfstests.  But if we want to automate running xfstests for stable
> > kernel series, some way of annotating fixes for different kernel
> > versions would be useful, perhaps some kind of centralized clearing
> > house of this information would be useful.
> 
> I think that the first step can be to require the new test to go in
> "after" the respective kernel fix. And related to that, require the test
> to include a well-defined tag (preferably both in the test itself and
> commit description) saying which commit fixed this particular problem.

For blktests, I require that regression tests include what commit they
are testing in the test comment. For xfstests, sometimes the test
mentions it, sometimes the commit mentions it, but more often you have
to search for keywords in kernel commit messages... It'd be great if
xfstests also required that the test file mentioned the commit/patch it
tests.
