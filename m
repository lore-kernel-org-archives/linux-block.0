Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF85DC10F04
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 12:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72E621917
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 12:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbfBNMKp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:10:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729933AbfBNMKo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 07:10:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4428AC0CD168;
        Thu, 14 Feb 2019 12:10:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-204-161.brq.redhat.com [10.40.204.161])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04A3D60C62;
        Thu, 14 Feb 2019 12:10:42 +0000 (UTC)
Date:   Thu, 14 Feb 2019 13:10:40 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] improving storage testing
Message-ID: <20190214121040.vckivyo5qcp6iyc4@localhost.localdomain>
References: <20190213180754.GX23000@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213180754.GX23000@mit.edu>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 14 Feb 2019 12:10:44 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 13, 2019 at 01:07:54PM -0500, Theodore Y. Ts'o wrote:
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

I think that the first step can be to require the new test to go in
"after" the respective kernel fix. And related to that, require the test
to include a well-defined tag (preferably both in the test itself and
commit description) saying which commit fixed this particular problem.

It does not solve all the problems, but would be a huge help. We could
also update old tests regularly with new tags as problems are introduced
and fixed, but that's a bit more involved. One thing that would help
with this would be to tag a kernel commit that fixes a problem for which
we already have a tast with the repeoctive test number.


Another think I was planning to do since forever was to create a
standard machine readble output, the ability to construct a database of
the results and present it in the easily browsable format like a set of
html with help of js. I never got around to it, but it would be nice to
be able to compare historical data, kernel versions, options, or even
file systems and identify tests that often fail, or never fail and even
how the run time differs. That might also help one to construct fast,
quick fail set of tests from ones own historical data. It would open some
interesting possibilities.

-Lukas
