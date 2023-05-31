Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550D1C7EE2D
	for <linux-block@archiver.kernel.org>; Wed, 31 May 2023 15:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjEaPAu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 May 2023 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbjEaPAs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2023 11:00:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEF3121
        for <linux-block@vger.kernel.org>; Wed, 31 May 2023 08:00:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C728168B05; Wed, 31 May 2023 17:00:40 +0200 (CEST)
Date:   Wed, 31 May 2023 17:00:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 4/7] blk-mq: use the I/O scheduler for writes from the
 flush state machine
Message-ID: <20230531150040.GA5774@lst.de>
References: <20230519044050.107790-1-hch@lst.de> <20230519044050.107790-5-hch@lst.de> <20230524055327.GA19543@lst.de> <d2e12e08-3a5f-2f5b-e3d1-2c1ea39d716b@acm.org> <20230530145516.GA11237@lst.de> <7ad83f37-cf3d-952c-741c-a70fb0d363e2@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ad83f37-cf3d-952c-741c-a70fb0d363e2@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 31, 2023 at 06:34:49AM -0700, Bart Van Assche wrote:
> On 5/30/23 07:55, Christoph Hellwig wrote:
>> No, I mean block/001
>
> Test block/001 also passes on my test setup. That setup is as follows:
> * Kernel commit 0cac5b67c168 ("Merge branch 'for-6.5/block' into
>   for-next").
> * Multiple debugging options enabled in the kernel config (DEBUG_LIST,
>   PROVE_LOCKING, KASAN, UBSAN, ...).
>
> I ran this test twice: once with /dev/vdb as test device and once with 
> /dev/ram0 as test device.

Hi Bart,

I did a quick re-run on the latest for-6.5/block tree and can't reproduce
the hang.  Let me see if it is still there with my old branch or if
something else made it go away.
