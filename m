Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8652C38A02
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 07:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJ3Hug (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 03:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3Hug (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 03:50:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C680119
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 00:50:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1167068AA6; Sun, 30 Oct 2022 08:50:33 +0100 (CET)
Date:   Sun, 30 Oct 2022 08:50:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Subject: Re: [bug?] blk_queue_may_bounce() has the comparison max_low_pfn
 and max_pfn wrong way
Message-ID: <20221030075032.GC4214@lst.de>
References: <Y1wZTtENDq3fvs6n@ZenIV> <01ce222b-8ad6-b4b3-428a-bae9534795e7@kernel.dk> <Y1wr0g39GzHcAk9v@ZenIV> <Y11YuS3kiOWoOjuI@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y11YuS3kiOWoOjuI@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 29, 2022 at 05:45:45PM +0100, Al Viro wrote:
> completion (in NULL_Q_BIO case, at least).  What happens if request
> gets split and split-off part finishes first with an error?  AFAICS,
> its ->bi_status will be copied to parent (original bio, the one that
> covers the tail).  Now the IO on the original bio is over as well
> and we hit drivers/block/null_blk/main.c:end_cmd().  Suppose this
> part succeeds; won't we end up overwriting ->bi_status with zero
> and assuming that the entire thing had succeeded, despite the
> (now lost) error on the split-off part?

As a rule of thumb drives should never set bi_status to 0, so null_blk
here has a bug.  What is missing everywhere is proper memory barriers,
though.
