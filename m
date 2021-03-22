Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A4EC433C1
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 15:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C1361931
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 15:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCVPaw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 11:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhCVPaV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 11:30:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0135161931;
        Mon, 22 Mar 2021 15:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616427020;
        bh=2dO3ApbwwimsIPO8Z+7xEFYSB59RRiJapAD647NFm9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7nYBh4GIXFvqrjoc4b0g9IswpzGsGE7BN01C1PxUwu/KMUa+tXhlRuRpUQcN69ho
         DHh3exXkwUBwVkxOUvMx/13IbO1FvrX1m1GyOXzBxmJrl+hDgsDwQdAQ45UxXn2GQV
         Mfnpd/v/rm46CRsKdudvzn6+0eZIqaOvGLkYKMUtJbqj+X35cceUA1PNUI4/Ar0BBB
         alqsrkBKxg6E1dyC61v1pQq56L+SK3di1EfeBjCEIWAjf0M4LPBAIm++u5hSaOm8wj
         HWBsu/95odYKCgqeb45AGOXjXWpR1EIy6VACtzqa32ErQ7NX6R4EKOGutcU5YPgAaX
         2lLO/VZw/VojA==
Date:   Tue, 23 Mar 2021 00:30:13 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] blk-mq: add a blk_mq_submit_bio_direct API
Message-ID: <20210322153013.GA17311@redsun51.ssa.fujisawa.hgst.com>
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322073726.788347-2-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good. Just a couple minor typo's in the commit message.

Reviewed-by: Keith Busch <kbusch@kernel.org>

On Mon, Mar 22, 2021 at 08:37:25AM +0100, Christoph Hellwig wrote:
> This adds (back) and API for simple stacking drivers to submit a bio to

                   an API

> blk-mq queue.  The prime aim is to avoid blocking on the queue freeze
> percpu ref, as a multipath driver really does not want to get blocked
> on that when an underlying device is undergoing error recovery.  It also
> happens to optimize away the small overhead of the curren->bio_list based

                                                     current->bio_list
