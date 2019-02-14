Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5740FC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 21:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2421821B18
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 21:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="hXBBjXgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404781AbfBNV4h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:56:37 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37106 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404106AbfBNV4g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 16:56:36 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so3853069plr.4
        for <linux-block@vger.kernel.org>; Thu, 14 Feb 2019 13:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zpCd471dJtiMwj91lh8iqLQAw3XYw9hGVUiQiK1RbeM=;
        b=hXBBjXgsjFhAi1K9dH8jQYoTbIV905a01qrYdlT5E1We4dAyXxwQKRykuyWsbi1rqt
         nhTRhZCYeULlLiQxom24QE30XbGXR0QHYC99zYXZZbEVfURzmNdLdAswSDAjQUL1tG+W
         0JnMWUkqjTtT5YtG0YtFy85YOYWIWfTh5xQFkXFoZITTQcuU3859xHhDbC+mK/Tp+yxa
         sCNM+2RTikB87LKhOEFvah9xlfY8m8N3jRhszh0r8Qm/uLGckpoR2OjqULg4OJ79SzES
         bYIC58XWwoIv56R4jrrwWwJjWwqF83rx/kBdZFBK+JZLHJAPBjJx3oGnDU+NdVtEnj/m
         BjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zpCd471dJtiMwj91lh8iqLQAw3XYw9hGVUiQiK1RbeM=;
        b=Tth8bAYsSD16cWmkdMNfoystCCgSbbfOTOYXodlxQsMGHFs4gCZ3bva/JTf/cmbdsU
         xMpLeNRCQCsDZm/UakJ9IIUvFVu4wZSL5kO61nHf0wiytOnStR71vmnBnU7g/A1ZadSq
         DqZGW5Vy68XWuwl8MlUFXfBL6J0ouloDieGrRTGHMWXOhuKNPIwuftEpaJYjx+5XUtaf
         invCm1raYiRasA/Hu3qxaJ3AMNWSyDLwL2rZjjmffqyFiqlajq0AquN7GgqxTWS4hnh1
         Y2KGFzPsk3XO3L+VU9iW984Gd8/hbxzM5qLaHNHDMKxxFH8mBv91ZxlzoCovLiHUZMqc
         7IUA==
X-Gm-Message-State: AHQUAuYFrRcb7bjlHM7DzpOEuQ2MIRne3cm0uS1n+GF4wTtgr1CFSSUr
        WE204kUgPU31zNYzBGN6JaUvKafhfAc=
X-Google-Smtp-Source: AHgI3IaedB7vsffNN7yMq/P7jiMhLgYzRfcEgdZbjAfKoWbS95gAJfzyasPF+pFSmiOwyeG9zvTY8A==
X-Received: by 2002:a17:902:a50e:: with SMTP id s14mr6572808plq.311.1550181395475;
        Thu, 14 Feb 2019 13:56:35 -0800 (PST)
Received: from vader ([2620:10d:c090:200::7:c363])
        by smtp.gmail.com with ESMTPSA id p12sm8210424pfj.81.2019.02.14.13.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 13:56:34 -0800 (PST)
Date:   Thu, 14 Feb 2019 13:56:34 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] improving storage testing
Message-ID: <20190214215634.GD9819@vader>
References: <20190213180754.GX23000@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213180754.GX23000@mit.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 13, 2019 at 01:07:54PM -0500, Theodore Y. Ts'o wrote:
> This should probably be folded into other testing proposals but I'd
> like to discuss ways that we can improve storage and file systems
> testing.  Specifically,
> 
> 1) Adding some kind of "smoke test" group.  The "quick" group in
> xfstests is no longer terribly quick.  Using gce-xfstests, the time to
> run the quick group on f2fs, ext4, btrfs, and xfs is 17 minutes, 18
> minutes, 25 minutes, and 31 minutes, respectively.  It probably won't
> be too contentious to come up with some kind of criteria --- stress
> tests plus maybe a few tests added to maximize code coverage, with the
> goal of the smoke test to run in 5-10 minutes for all major file
> systems.
> 
> Perhaps more controversial might be some way of ordering the tests so
> that the ones which are most likely to fail if a bug has been
> introduced are run first, so that we can have a "fail fast" sort of
> system.
> 
> 2) Documenting what are known failures should be for various tests on
> different file systems and kernel versions.  I think we all have our
> own way of excluding tests which are known to fail.  One extreme case
> is where the test case was added to xfstests (generic/484), but the
> patch to fix it got hung up because it was somewhat controversial, so
> it was failing on all file systems.
> 
> Other cases might be when fixing a particular test failure is too
> complex to backport to stable (maybe because it would drag in all
> sorts of other changes in other subsystems), so that test is Just
> Going To Fail for a particular stable kernel series.
> 
> It probably doesn't make sense to do this in xfstests, which is why we
> all have our own individual test runners that are layered on top of
> xfstests.  But if we want to automate running xfstests for stable
> kernel series, some way of annotating fixes for different kernel
> versions would be useful, perhaps some kind of centralized clearing
> house of this information would be useful.
> 
> 3) Making blktests more stable/useful.  For someone who is not a block
> layer specialist, it can be hard to determine whether the problem is a
> kernel bug,

From my experience with running xfstests at Facebook, the same thing
goes for xfstests :) The filesystem developers on the team are the only
ones that can make sense of any test failures.

> a kernel misconfiguration

In theory, every test should verify that the kernel is configured
correctly and skip the test if not, just like xfstests.

> some userspace component (such as nvme-cli) being out of date or just
> a test bug.  (For example, all srp/* tests are currently failing in
> blktests upstream; I had to pull some not-yet-merged commits from
> Bart's tree in order to fix bugs that caused all of srp to fail.)
> 
> Some of the things that we could do include documenting what kernel
> CONFIG options are needed to successfully run blktests, perhaps using
> a defconfig list.

Have you encountered issues where missing config options have caused
test failures? Or you want the config options for maximum coverage? If
you have examples of the former, I'll fix them up. For the latter, I
have a list somewhere that I can add to the blktests repository.

> Also, there are expectations about minimum versions of bash that can
> be supported; but there aren't necessarily for other components such
> as nvme-cli, and I suspect that it is due to the use of a overly new
> version of nvme-cli from its git tree.  Is that supposed to work, or
> should I constrain myself to whatever version is being shipped in
> Fedora or some other reference distribution?  More generally, what is
> the overall expectations that should be expected?

My (undocumented) rule of thumb has been that blktests shouldn't assume
anything newer than whatever ships on Debian oldstable. I can document
that requirement.

For specific tests that require a newer feature, the test _should_ check
that the feature is available. Please report any tests where that isn't
the case, although I'll likely defer to the contributors for
nvme/srp/zbd issues.

> xfstests has some
> extremely expansive set of sed scripts to normalize shell script
> output to make xfstests extremely portable; will patches along similar
> lines something that we should be doing for blktests?

Yup, we've added a couple of these. We should add more as needed.

blktests is new, so we have some rough edges, but I'd like to think that
we're trying to do the right things. Please report the cases where we're
not and we'll get them fixed up.
