Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840A5C433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 08:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 607F060F93
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 08:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhITIHQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 04:07:16 -0400
Received: from verein.lst.de ([213.95.11.211]:50448 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235257AbhITIHQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 04:07:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BABB567373; Mon, 20 Sep 2021 10:05:47 +0200 (CEST)
Date:   Mon, 20 Sep 2021 10:05:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: genhd: fix double kfree() in __alloc_disk_node()
Message-ID: <20210920080547.GA30362@lst.de>
References: <0000000000004a5adf05cc593ca9@google.com> <41766564-08cb-e7f2-4cb2-9ad102f21324@I-love.SAKURA.ne.jp> <3999c511-cd27-1554-d3a6-4288c3eca298@i-love.sakura.ne.jp> <20210920064028.GB26999@lst.de> <c5b78df8-1ab7-04fa-d6e8-c7270c3bc373@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5b78df8-1ab7-04fa-d6e8-c7270c3bc373@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 20, 2021 at 05:02:19PM +0900, Tetsuo Handa wrote:
> On 2021/09/20 15:40, Christoph Hellwig wrote:
> > I was going to suggest to just move the bd_disk initialization after
> > the bd_stats allocations,  but iseems like we currently don't even
> > the zero the bdev on allocation.  So I suspect we should do that first
> > to avoid nasty surprises.
> 
> Hmm? bdev_alloc_inode() zeros the bdev on allocation.
> Are you talking about some other function?

Ah yes, we do.  Sorry, not enough coffee yet.  So in that case I think
you can simply move the bd_disk asignment later to simplify the
first hunk.
