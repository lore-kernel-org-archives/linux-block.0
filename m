Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C99DC433FE
	for <linux-block@archiver.kernel.org>; Wed,  8 Sep 2021 14:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F09D6113A
	for <linux-block@archiver.kernel.org>; Wed,  8 Sep 2021 14:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhIHOBi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Sep 2021 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbhIHOBh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Sep 2021 10:01:37 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87265C061575
        for <linux-block@vger.kernel.org>; Wed,  8 Sep 2021 07:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6AxC6oCsSfAyqhwx3Kpc0CB2wC62kyU10XqVk+1JOcQ=; b=gFTXTJQya1IqAb3KQdfoHsaxAo
        K05vUN3P5XYh2X+LRkQEUhh8kXy3Dd/evq4rb+LipfBFn70hNWSfh6uGMyU+ubAyIyIp866SyJD68
        q61Ne89P97Y9nB94G47cq2Pb4hoh2MFqkIYiq0bpUsjpP0YVndQzJ3otuEqGuPtefunlEt9DDktIG
        FB6CkwjE7vvVYCTqBtp2GKUdbGIi6fKOVdLJ6hT6mfEJu1yXgQiO4v2jLEMScUES1Yai8jcDMveG1
        Sc/wyIfKObQQ/K7YN0TC7+jOgfEE5C8PzCg5x49dwjLVOx7ZSEIjzFEIpnKkBtSCLRAq3LYqxVcEP
        DV4T4pqw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNy7l-006s74-Np; Wed, 08 Sep 2021 14:00:25 +0000
Date:   Wed, 8 Sep 2021 07:00:25 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: make __register_blkdev() return an error
Message-ID: <YTjB+ad2chvRNsS7@bombadil.infradead.org>
References: <20210904013932.3182778-1-mcgrof@kernel.org>
 <20210904013932.3182778-2-mcgrof@kernel.org>
 <9b9e8bfd-a2a6-4b78-413b-7c6c7eb83e05@I-love.SAKURA.ne.jp>
 <YTUIV0mSJHfgtMov@bombadil.infradead.org>
 <d5c7f0e6-8ded-581c-cb10-00e785a7f7b3@i-love.sakura.ne.jp>
 <YTd98oss0WgCwVzY@bombadil.infradead.org>
 <1c795252-3bc8-1b6c-8a2b-3ef01fd73247@i-love.sakura.ne.jp>
 <YTeFButum63FZUTo@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTeFButum63FZUTo@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 07, 2021 at 08:28:06AM -0700, Luis Chamberlain wrote:
> On Wed, Sep 08, 2021 at 12:23:02AM +0900, Tetsuo Handa wrote:
> > On 2021/09/07 23:57, Luis Chamberlain wrote:
> > >> Actually, blk_request_module() failures should be ignored, for
> > >> subsequent ilookup() will fail if blk_request_module() failed to
> > >> create the requested block device.
> > > 
> > > Then how about this:
> > > 
> > > Since we would like to use __must_check for add_disk() we proceed with
> > > the change to capture the errors and propagate them and we just document on
> > > fs/block_dev.c's use of blk_request_module() about the above issue and
> > > how we prefer the errror that ilookup() would return.
> > 
> > Marking add_disk() as __must_check makes it possible to enforce "don't leave
> > partially initialized devices". That's already an enough improvement.
> > 
> > Probe functions can remain "void", and hence blk_request_module() can remain "void".
> > That is, I would drop "[PATCH 1/2] block: make __register_blkdev() return an error".
> 
> Probe calls can be left voide, but because of the new __must_check we'd
> still have to modify all probe calls as they use add_disk() and it would
> seem odd to just capture the error to ignore it without documenting
> any of this.

So indeed, all probe() routines would need to be modified anyway because
of the added final __must_check. Because of this I still think that if
we want to *ignore* the error, we should just document and ignore it on
the caller side. That is, still modify __register_blkdev() to propagate
the error, and the caller can decide to ignore or not. In this case
we can document on fs/block_dev.c *why* we are ignoring the error.

Thoughts?

  Luis
