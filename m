Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C2BC6FA8B
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 05:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiIVFjX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 01:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiIVFjW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 01:39:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23CAB2DA8
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 22:39:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 34AAC68BEB; Thu, 22 Sep 2022 07:39:18 +0200 (CEST)
Date:   Thu, 22 Sep 2022 07:39:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Supporting segment sizes smaller than the page size
Message-ID: <20220922053917.GA27293@lst.de>
References: <3a32f6fd-af4a-3a81-67ad-7dc542bb6a3c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a32f6fd-af4a-3a81-67ad-7dc542bb6a3c@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 04:28:32PM -0700, Bart Van Assche wrote:
> I have been asked to add support for DMA segment sizes that are smaller 
> than the page size to support a UFS controller with a maximum DMA segment 
> size of 4 KiB and a page size > 4 KiB (my understanding of the JEDEC UFS 
> host controller specification is that UFS host controllers should support a 
> maximum DMA segment size of 256 KiB). Does anyone want to comment on this 
> before I start working on a patch series?

Don't do it.  This gets us into all kinds of corner cases, and even
worse now requires to do the expensive segment walk for every I/O while
right now we have a nice little fast path.
