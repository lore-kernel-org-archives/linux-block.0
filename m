Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A18DC433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 15:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4930F61106
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 15:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345338AbhIGP3W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 11:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345280AbhIGP3Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 11:29:16 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D356C061575
        for <linux-block@vger.kernel.org>; Tue,  7 Sep 2021 08:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v5mvkiJgnrQe57dTbbnXSFkFMUvB+Nq/iIJNpA+RbMU=; b=W3sYVrOPd06/2ezSjAF+qfjl/R
        FF9ostU2c1CQl1A/kkXjwG2NeFfJHyssK8p6tDpzYR9ArOw/PbgQf1i2eBF71H9nImg+Ij9qg69D8
        tY5acskkzcgy5NmDlBPBn5d7OD60G6Sb0Wt2gz7s8zbp2g11j19J1ep0elp7R3Tj0xYo282wI0tEM
        4OfWzs4DtNA5pFVjEwBx47q1ifugwtu9l20POyFhmaOv2Txl2FQVBGaTpRDAjrAajBM3LhjNNbh5H
        6smza4wjLJxo1bYmt6dbuI8QfB5qHW43LL6lniMQfBBmCmQuQtCOVYOTpzjaoskHGPlpqYg29fBPn
        /LSh6Aqw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNd14-0043hN-T3; Tue, 07 Sep 2021 15:28:06 +0000
Date:   Tue, 7 Sep 2021 08:28:06 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: make __register_blkdev() return an error
Message-ID: <YTeFButum63FZUTo@bombadil.infradead.org>
References: <20210904013932.3182778-1-mcgrof@kernel.org>
 <20210904013932.3182778-2-mcgrof@kernel.org>
 <9b9e8bfd-a2a6-4b78-413b-7c6c7eb83e05@I-love.SAKURA.ne.jp>
 <YTUIV0mSJHfgtMov@bombadil.infradead.org>
 <d5c7f0e6-8ded-581c-cb10-00e785a7f7b3@i-love.sakura.ne.jp>
 <YTd98oss0WgCwVzY@bombadil.infradead.org>
 <1c795252-3bc8-1b6c-8a2b-3ef01fd73247@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c795252-3bc8-1b6c-8a2b-3ef01fd73247@i-love.sakura.ne.jp>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 08, 2021 at 12:23:02AM +0900, Tetsuo Handa wrote:
> On 2021/09/07 23:57, Luis Chamberlain wrote:
> >> Actually, blk_request_module() failures should be ignored, for
> >> subsequent ilookup() will fail if blk_request_module() failed to
> >> create the requested block device.
> > 
> > Then how about this:
> > 
> > Since we would like to use __must_check for add_disk() we proceed with
> > the change to capture the errors and propagate them and we just document on
> > fs/block_dev.c's use of blk_request_module() about the above issue and
> > how we prefer the errror that ilookup() would return.
> 
> Marking add_disk() as __must_check makes it possible to enforce "don't leave
> partially initialized devices". That's already an enough improvement.
> 
> Probe functions can remain "void", and hence blk_request_module() can remain "void".
> That is, I would drop "[PATCH 1/2] block: make __register_blkdev() return an error".

Probe calls can be left voide, but because of the new __must_check we'd
still have to modify all probe calls as they use add_disk() and it would
seem odd to just capture the error to ignore it without documenting
any of this.

  Luis
