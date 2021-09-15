Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D561FC433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 11:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA746108F
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 11:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhIOL3B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 07:29:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232526AbhIOL3B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 07:29:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E18D86115B;
        Wed, 15 Sep 2021 11:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631705262;
        bh=gy5T/VzIXKukGdoxNyoPAP9Fz2XZJrRpr1KAFEhLHvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HdbaviAJoMmbdfAa4DViXAR29rOy87nTMcOIor4Lleq6WdkxWcXBdrD2TjD+w8fC5
         1dXRQJpxMJuMygH5UVdyJj+YGlG/pVeA38kgkuOwBDsDHS2IUmoFt4ujJX3YsaEpOa
         LnVcBGch4E+Rd9Zl8PEcwmPMdkxRwcmJM4XCNFbk=
Date:   Wed, 15 Sep 2021 13:27:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     linux-block@vger.kernel.org, stable@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, yi.zhang@huawei.com
Subject: Re: [PATCH linux-4.19.y] blk-mq: fix divide by zero crash in
 tg_may_dispatch()
Message-ID: <YUHYqwVeeXtfD0qf@kroah.com>
References: <20210914125402.4068844-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914125402.4068844-1-yukuai3@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 14, 2021 at 08:54:02PM +0800, Yu Kuai wrote:
> If blk-throttle is enabled and io is issued before
> blk_throtl_register_queue() is done. Divide by zero crash will be
> triggered in tg_may_dispatch() because 'throtl_slice' is uninitialized.
> 
> The problem is fixed in commit 75f4dca59694 ("block: call
> blk_register_queue earlier in device_add_disk") from mainline, however
> it's too hard to backport this patch due to lots of refactoring.
> 
> Thus introduce a new flag QUEUE_FLAG_THROTL_INIT_DONE. It will be set
> after blk_throtl_register_queue() is done, and will be checked before
> applying any config.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-sysfs.c      |  2 ++
>  block/blk-throttle.c   | 41 +++++++++++++++++++++++++++++++++++++++--
>  include/linux/blkdev.h |  1 +
>  3 files changed, 42 insertions(+), 2 deletions(-)


The commit you reference above is in 5.15-rc1.  What about all of the
other stable kernel releases newer than 4.19.y?  You do not want to move
to a newer release and have a regression.

And I would _REALLY_ like to take the identical commits that are
upstream if at all possible.  What is needed to backport instead of
doing this one-off patch instead?

When we take changes that are not upstream, almost always they are
broken so we almost never want to do that.

thanks,

greg k-h
