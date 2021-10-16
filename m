Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E0DC433F5
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 04:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8736F61211
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 04:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbhJPEc6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 00:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbhJPEcz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 00:32:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D23C061570
        for <linux-block@vger.kernel.org>; Fri, 15 Oct 2021 21:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DX6M7v7X0ayC67qW3nJ+TavjmqSDOsODdrT3D53fE7Q=; b=ye2Mcv5gpCUVW7eFwOjdQalIXI
        2yTDQ6JqUI0SngGtQsLjIXaHykV01nrz8APLkOqVXkV3MMt5GTZTHtN2xyU5K1BXIKMdbe/R8Zfm1
        D64qgAMS4cId3ZrgjHBrCcfbSOYqDjcS7pvt3J0MZG8+NZhTgTXe8wPCJNTY8rRM4oOxKqzqdcorC
        S+bvbAyo6NzcLBc/Yckl/q6rtfCYCOv+Nx248sGqjgZHSs9rhp7tV/KjoOCwxxurYcm2MdTn0eUwy
        DgI/N9XM5Y7HlfRxuNrZT5RE+79ICO/utV4ZHBRseUCDPpU78OLdZ5dzvy5jvJkHoi6TOy2eCwlWv
        2/roYVMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbbLM-009jCD-9j; Sat, 16 Oct 2021 04:30:48 +0000
Date:   Fri, 15 Oct 2021 21:30:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: use flags instead of bit fields for blkdev_dio
Message-ID: <YWpVeBfUt3zoafD4@infradead.org>
References: <4b427811-106d-53b2-bdfc-afd022282067@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b427811-106d-53b2-bdfc-afd022282067@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 14, 2021 at 12:34:55PM -0600, Jens Axboe wrote:
> This generates a lot better code for me, and bumps performance from
> 7650K IOPS to 7750K IOPS. Looking at profiles for the run and running
> perf diff, it confirms that we're now sending a lot less time there:
> 
>      6.38%     -2.80%  [kernel.vmlinux]  [k] blkdev_direct_IO
> 
> Taking it from the 2nd most cycle consumer to only the 9th most at
> 3.35% of the CPU time.

Kinda weird that the overhead is so big.  That being said for more
than a single flag I prefer the bit ops anyway, this code just
"evolved".

Reviewed-by: Christoph Hellwig <hch@lst.de>
