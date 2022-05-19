Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311EBC433FE
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 16:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238244AbiESQGW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 12:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiESQGR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 12:06:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD961146A;
        Thu, 19 May 2022 09:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=arC+VmOdKBG0BguUDCJJWFhQ30/9XxDqLrgXrPrRX3o=; b=Wp20ZnLDKitpFW0p/cyWyRx3D4
        YnkcjmJSSp5lHSfJ1pDUFqe2tfqWftiISBqIjEdWaIXQE1r48ZWSrl6lZmjD4toO4xKQZSuw+DaMr
        +RMrG6tMBtFzEsYU/Ll9g9+oA/ZfAx9TKMUCUo6uB/EGoKA3rBG1k0t4NneSQsJaKFIkqI2+t2ddZ
        ktx9IGMj3+1Q5ghvB+3oXuRJ02PHL2XKfGCW4vGKn2Jq+CJBMF4OD/z8XjGiW7sTvuHun1IlSaeoG
        WJNWtoewXuC7TT0K9QN194s8l5bO/jMDBPDol58+ew3QhGbFY9TVK8P20zE0nwxPRxKHteIuZM2gZ
        Uo/vIqdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrif9-00CraC-Q0; Thu, 19 May 2022 16:06:07 +0000
Date:   Thu, 19 May 2022 17:06:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, pankydev8@gmail.com,
        Theodore Tso <tytso@mit.edu>,
        Josef Bacik <josef@toxicpanda.com>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <YoZq7/lr8hvcs9T3@casper.infradead.org>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <CAOQ4uxhKHMjGq0QKKMPFAV6iJFwe1H5hBomCVVeT1EWJzo0eXg@mail.gmail.com>
 <20220519112450.zbje64mrh65pifnz@zlang-mailbox>
 <YoZbF90qS+LlSDfS@casper.infradead.org>
 <20220519154419.ziy4esm4tgikejvj@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519154419.ziy4esm4tgikejvj@zlang-mailbox>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 19, 2022 at 11:44:19PM +0800, Zorro Lang wrote:
> On Thu, May 19, 2022 at 03:58:31PM +0100, Matthew Wilcox wrote:
> > On Thu, May 19, 2022 at 07:24:50PM +0800, Zorro Lang wrote:
> > > Yes, we talked about this, but if I don't rememeber wrong, I recommended each
> > > downstream testers maintain their own "testing data/config", likes exclude
> > > list, failed ratio, known failures etc. I think they're not suitable to be
> > > fixed in the mainline fstests.
> > 
> > This assumes a certain level of expertise, which is a barrier to entry.
> > 
> > For someone who wants to check "Did my patch to filesystem Y that I have
> > never touched before break anything?", having non-deterministic tests
> > run by default is bad.
> > 
> > As an example, run xfstests against jfs.  Hundreds of failures, including
> > some very scary-looking assertion failures from the page allocator.
> > They're (mostly) harmless in fact, just being a memory leak, but it
> > makes xfstests useless for this scenario.
> > 
> > Even for well-maintained filesystems like xfs which is regularly tested,
> > I expect generic/270 and a few others to fail.  They just do, and they're
> > not an indication that *I* broke anything.
> > 
> > By all means, we want to keep tests around which have failures, but
> > they need to be restricted to people who have a level of expertise and
> > interest in fixing long-standing problems, not people who are looking
> > for regressions.
> 
> It's hard to make sure if a failure is a regression, if someone only run
> the test once. The testers need some experience, at least need some
> history test data.
> 
> If a tester find a case has 10% chance fail on his system, to make sure
> it's a regression or not, if he doesn't have history test data, at least
> he need to do the same test more times on old kernel version with his
> system. If it never fail on old kernel version, but can fail on new kernel.
> Then we suspect it's a regression.
> 
> Even if the tester isn't an expert of the fs he's testing, he can report
> this issue to that fs experts, to get more checking. For downstream kernel,
> he has to report to the maintainers of downstream, or check by himself.
> If a case pass on upstream, but fail on downstream, it might mean there's
> a patchset on upstream can be backported.
> 
> So, anyway, the testers need their own "experience" (include testing history
> data, known issue, etc) to judge if a failure is a suspected regression, or
> a known issue of downstream which hasn't been fixed (by backport).
> 
> That's my personal perspective :)

Right, but that's the personal perspective of an expert tester.  I don't
particularly want to build that expertise myself; I want to write patches
which touch dozens of filesystems, and I want to be able to smoke-test
those patches.  Maybe xfstests or kdevops doesn't want to solve that
problem, but that would seem like a waste of other peoples time.
