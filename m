Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D841C433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 14:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB6720884
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 14:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qHJ0AeBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgFROLJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgFROLI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 10:11:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2947CC06174E
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2VCYy4C36bVSKPOdZsbjyuJ7FYfjvBrWrzEm+tns33A=; b=qHJ0AeBF5GoJcfpszFy4lBUZn6
        drIVbgYLyrVhfZYBTwaGUYv0XCxcOmCg9AVxpo36t4ibJe/mTfQ4LfV8Ug5KAj+jZzf5v9WSqi5AF
        N+qz9tgWzcDKpCwavvvfkiV5n6zHO+dm3crgJtjssou20KzNZ4LayoloGIW3EryKA4z1QSFTjDI8w
        pF1iRc8/PIHmXYvt812D2Qr+3VZqplAmJXDzDkWAwX7DkJxEpvYlqfz3S/IN7ovAxW1fKQRpwoo8t
        cf4hRiYh6BeNRRS8QDiineasDvjDhrmHY9ynbZzE0uCi1dIyqXto9Dh/kRwwScY5ZjN6FFRaQRp/4
        xUAUuP2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlvFw-0006ZL-0j; Thu, 18 Jun 2020 14:11:04 +0000
Date:   Thu, 18 Jun 2020 07:11:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: blk_mq_complete_request overhaul
Message-ID: <20200618141103.GA16866@infradead.org>
References: <20200611064452.12353-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611064452.12353-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Any comments?

(and yes, I misspelled the nvme list address, but the interested
parties should be on linux-block anyway)

On Thu, Jun 11, 2020 at 08:44:40AM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> Peters recent inquiry made me dust off various bits of unfinished work
> around blk_mq_complete_request and massage it into a coherent series.
> 
> This does three different things all touching the same area:
> 
>  - merge the softirq based single queue completion into the main
>    blk-mq completion mechanism, as there is a lot of duplicate logic
>    between the two
>  - move the error injection that just fails to complete requests out into
>    the drivers.  The fact that blk_mq_complete_request just wouldn't
>    complete when called from the error handle has been causing all kinds
>    of pain
>  - optimize the fast path by allowing drivers to avoid the indirect call
>    with a little more work for polled or per-CPU IRQ completions.  With
>    this a polled block device I/O only has two indirect calls let, one for
>    the file operation that ends up in the block device code, and another
>    one for disptching to the nvme driver
---end quoted text---
