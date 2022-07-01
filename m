Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522F0CCA479
	for <linux-block@archiver.kernel.org>; Fri,  1 Jul 2022 23:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiGAXgg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Jul 2022 19:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiGAXgf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jul 2022 19:36:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A81377FF;
        Fri,  1 Jul 2022 16:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=06eWdRDXpS34TZjyg7jwgtfLBHcIz1i2VzM1RtH1mfA=; b=SCQbaRTEAXMUXjU/N+uRsxDfdV
        KsgXGXae+K4l1GRAsBEg85GpPtSLXRuZ5PSQkLFYMelbfoL1K0WOr+vStjn0/jLSxFvEcQ87Hlnn/
        sHa0FhioCZJyVrW6a2vWLe0x6xt9ex06YtLhdKm6DYLJBwYGHl/7Yyau5kY9Zrz+kYe8rHKUjG/OR
        9i6ycC62S+piDMLGreThwqkbOzUDQtDoIef3PAnvjgevIW0rij94bJa35EMpZx6JbdkQzHqUGggIX
        Q6zzInAxyhMAhl3NfXbXhPJSYrG7e5boqFBNpLk6dQQrwoUskd9fr3OfweKDcjyHsJP+XzKCQHtKs
        r69VVWFw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7QBZ-007QcH-Go; Fri, 01 Jul 2022 23:36:29 +0000
Date:   Fri, 1 Jul 2022 16:36:29 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Zorro Lang <zlang@redhat.com>, Amir Goldstein <amir73il@gmail.com>,
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
Message-ID: <Yr+E/SvxeSGBbPq1@bombadil.infradead.org>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <CAOQ4uxhKHMjGq0QKKMPFAV6iJFwe1H5hBomCVVeT1EWJzo0eXg@mail.gmail.com>
 <20220519112450.zbje64mrh65pifnz@zlang-mailbox>
 <YoZbF90qS+LlSDfS@casper.infradead.org>
 <20220519154419.ziy4esm4tgikejvj@zlang-mailbox>
 <YoZq7/lr8hvcs9T3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZq7/lr8hvcs9T3@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 19, 2022 at 05:06:07PM +0100, Matthew Wilcox wrote:
> Right, but that's the personal perspective of an expert tester.  I don't
> particularly want to build that expertise myself; I want to write patches
> which touch dozens of filesystems, and I want to be able to smoke-test
> those patches.  Maybe xfstests or kdevops doesn't want to solve that
> problem,

kdevop's goals are aligned to enable that. However at this point
in time there is no agreement to share expunges and so we just
carry tons of them per kernel / distro for those that *did* have
time to run them for the environment used and share them.

Today there are baselines for stable and linus' kernel for some
filesystems, but these are on a best effort basis as this takes
system resources and someone's time. The results are tracked in:

workflows/fstests/expunges/

With time now that there is at least a rig to do this for stable
and upstream this should expand to be more up to date. There is
also a shared repo which enables folks to share results there.

  Luis
