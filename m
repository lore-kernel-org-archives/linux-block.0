Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD2CC433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6604D61107
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 14:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbhIVOr0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 10:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbhIVOr0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 10:47:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F34C061574
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QwM7EI7bDcezKEbWhujqXVA48yz70ndbEO1gyuLcNn0=; b=MAbRtr4Fwbogva7HlyexTk3Fyv
        5qXPC2H2RPvyxMyR3siqZVdxsu7Fc9kI2R7y1pD79wP7/YZbEOfoO6vgQ6pkz9IQMcca1kgHykfyY
        XrgYQ3GJRVsopDBtTzRedXFkCBQSnZDQBYQ0ZCozCc/hQByvIsst/f3rCvM2SqOZwnrIDDp9kIJyX
        l+QKBF8XzVG9prutKGHjmLGv4j26OD+Ma2TBoh9LUWon8fVJCiMHe3S9xHef0ZVhSJla3oaLIkodj
        BFWlXv/kgJhdOpSsOpLn19/TmUGb2YHWYFfYK8WfkJgT7XyHm7rlLy5007Ccq8tNmpXraUKcXa+g1
        8DP3ZoAg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT3TZ-004sKG-S4; Wed, 22 Sep 2021 14:44:05 +0000
Date:   Wed, 22 Sep 2021 15:43:57 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Subject: Re: [PATCH v2 3/4] loop: Remove the unnecessary bdev checks and
 unused bdev variable
Message-ID: <YUtBLVk29bY/XDk3@infradead.org>
References: <20210922123711.187-1-xieyongji@bytedance.com>
 <20210922123711.187-4-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922123711.187-4-xieyongji@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 22, 2021 at 08:37:10PM +0800, Xie Yongji wrote:
> The lo->lo_device can't be null if the lo->lo_backing_file is set.
> So let's remove the unnecessary bdev checks and the entire bdev
> variable in __loop_clr_fd() since the lo->lo_backing_file is already
> checked before.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
