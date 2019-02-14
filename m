Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4878C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 10:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA79222B6
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 10:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406809AbfBNKzJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:55:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:32942 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406807AbfBNKzJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 05:55:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2760ADF0;
        Thu, 14 Feb 2019 10:55:07 +0000 (UTC)
Date:   Thu, 14 Feb 2019 11:55:07 +0100
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] improving storage testing
Message-ID: <20190214105507.GA9739@linux-x5ow.site>
References: <20190213180754.GX23000@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190213180754.GX23000@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 13, 2019 at 01:07:54PM -0500, Theodore Y. Ts'o wrote:
> 2) Documenting what are known failures should be for various tests on
> different file systems and kernel versions.  I think we all have our
> own way of excluding tests which are known to fail.  One extreme case
> is where the test case was added to xfstests (generic/484), but the
> patch to fix it got hung up because it was somewhat controversial, so
> it was failing on all file systems.

How about having a wiki page, either in the respective filesystems wiki or a
common wiki, that show's the list of test that are expected to fail for kernel
version X?

This is something I'm desperately looking for for brtfs for example.

[...]

> 3) Making blktests more stable/useful.  For someone who is not a block
> layer specialist, it can be hard to determine whether the problem is a
> kernel bug, a kernel misconfiguration, some userspace component (such
> as nvme-cli) being out of date, or just a test bug.  (For example, all
> srp/* tests are currently failing in blktests upstream; I had to pull
> some not-yet-merged commits from Bart's tree in order to fix bugs that
> caused all of srp to fail.)
> 
> Some of the things that we could do include documenting what kernel
> CONFIG options are needed to successfully run blktests, perhaps using
> a defconfig list.

Or checking for specific CONFIG_* settings in a test's requires() via
/proc/config.gz. This obviously won't work with kernels that don't have it.
 
> Also, there are expectations about minimum versions of bash that can
> be supported; but there aren't necessarily for other components such
> as nvme-cli, and I suspect that it is due to the use of a overly new
> version of nvme-cli from its git tree.  Is that supposed to work, or
> should I constrain myself to whatever version is being shipped in
> Fedora or some other reference distribution?  More generally, what is
> the overall expectations that should be expected?  xfstests has some
> extremely expansive set of sed scripts to normalize shell script
> output to make xfstests extremely portable; will patches along similar
> lines something that we should be doing for blktests?

I think this is the root cause of the problems you've sent out mails for this
week. A lot of blktests test need filtering. See [1] as an example.

[1] https://github.com/osandov/blktests/pull/34

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
