Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C43C433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 12:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A7960FDA
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 12:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbhIMMgm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 08:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbhIMMgm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 08:36:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99048C061574
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 05:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ouLFyNfLBm4Dk36viGOwYm8Tka9E+hmUQ7R27zeY3VU=; b=KF3m4F8zNaePid0owuuXCVVxn6
        edWyWHdhgR3bnWhwowRy8FD3i2LKbTQwA6qNGTJAerIjyuqZwOGWu607biklebLu3RMqlNy44y4Uf
        QQPY0lyC7Avm5VGPU4D4RQJVge5Z95SVT8wnwHAZHkUXS1Vqa4fIJrGfrKykeHNBPfc75/8JDyh8q
        09Oq/JH8FdLSFOv2KIGYeyl0+cCRYPnjuok8eYgvBisT3jmbu7UL9OjBIbgfAf89wjgm7DQbLo8kt
        FWKPhLIr8ovsfSvjV4MhpVKR4eJ0Zstjhc+FspWb9PyAK5pNGt0NccS4YMWL56PaPoDKwbaLdpKwg
        v0aybTNA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPlAM-00DT8L-Hd; Mon, 13 Sep 2021 12:34:38 +0000
Date:   Mon, 13 Sep 2021 13:34:30 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Subject: Re: [PATCH 2/3] loop: Use invalidate_gendisk() helper to invalidate
 gendisk
Message-ID: <YT9FVrXcaUdaXlu6@infradead.org>
References: <20210913112557.191-1-xieyongji@bytedance.com>
 <20210913112557.191-3-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913112557.191-3-xieyongji@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 13, 2021 at 07:25:56PM +0800, Xie Yongji wrote:
> Use invalidate_gendisk() helper to simplify the code for gendisk
> invalidation.

bdev can't be null here so this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can you also add a cleanup patch to remove the bdev checks and the
entire bdev variable in __loop_clr_fd?
