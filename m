Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CE6C433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 14:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D404760FC1
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 14:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhIVOvF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 10:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbhIVOvF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 10:51:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8585BC061574
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 07:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NFcz2hy9ApyAue6R/MxGoz0rnoxrobESWO5tYq8yA5c=; b=Wxh8PGMGd5lPYi9PRPK/Arg6pe
        1dEGBpf0xksMzh5Fo5bjJbjsEBs+7hGX+Hogey9xUYlneWH1+iO47IdV3E1M7GeInt86vA86y2L7x
        WZ4tlcmZMX/Nxlkw/Z1/2G87nE/nycoSNLFhWTzDJtSBJXHs/yi84ofOn3RC9Rb2vjFJA9HX6lP7I
        dvHze0K3bvE4NuSFVHguj3yxcfGnySosEpgpC7T0iHtiB1abH2M3EhU1z0SZUuPyfMIB7N/eo6Hk8
        QAfUNY7mwuo75Wqdd9EruYFOnSCps8FPwuGammBj4oDkPWBGPAaTw7DTtJdaZt00QHokOCUTBwUjV
        7cTmDqUw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT3Wu-004sWj-U6; Wed, 22 Sep 2021 14:47:44 +0000
Date:   Wed, 22 Sep 2021 15:47:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Subject: Re: [PATCH v2 4/4] nbd: Use invalidate_disk() helper on disconnect
Message-ID: <YUtB/NtF8BJ7afwj@infradead.org>
References: <20210922123711.187-1-xieyongji@bytedance.com>
 <20210922123711.187-5-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922123711.187-5-xieyongji@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 22, 2021 at 08:37:11PM +0800, Xie Yongji wrote:
> When a nbd device encounters a writeback error, that error will
> get propagated to the bd_inode's wb_err field. Then if this nbd
> device's backend is disconnected and another is attached, we will
> get back the previous writeback error on fsync, which is unexpected.
> 
> To fix it, let's use invalidate_disk() helper to invalidate the
> disk on disconnect instead of just setting disk's capacity to zero.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
