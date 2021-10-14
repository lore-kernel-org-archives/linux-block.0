Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36977C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 07:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EBC2610F9
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 07:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJNHvY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 03:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhJNHvY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 03:51:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FE6C061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 00:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s6KIsu8rGE7ibe7sJkUwQ/w2r+h0bdlXn5SXzwT1Efc=; b=V5VosHFciKE50vMvWAUxS7SiaY
        3ZHY0DF96CBgwYS5fXYq1mVhU6qEXHqIqvKTAL0NjYXn+RtxViC+9V5wVHvqa9xbjcJJGATBubzoW
        jn2AUV7dERZjjHp3OwpVRNhW33zwWmWrDAEPzc6R2riXi4sm0spLn0JYa7yNwSEAITX7XRAqGD/ut
        B540qeb3C3q85yEW2KyI+H/uIC0nAH/dkZm9w3n3FUx1LhLVQH9ynVJVg6t8EZVIDg80nnyL/d/Bt
        xEdk2D3gmVSpX+AcnW7h+QJlQgLfeZttxpY8js5VSB5GLR5eeH8Guk2d1vHtpCWIlzicxwrb6kqcT
        SCk+fSdA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mavTZ-0089bW-8a; Thu, 14 Oct 2021 07:48:44 +0000
Date:   Thu, 14 Oct 2021 08:48:29 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 7/9] block: assign batch completion handler in blk_poll()
Message-ID: <YWfgzYEEjfPKupJL@infradead.org>
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-8-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013165416.985696-8-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 10:54:14AM -0600, Jens Axboe wrote:
> If an io_batch is passed in to blk_poll(), we need to assign the batch
> handler associated with this queue. This allows callers to complete
> an io_batch handler on by calling it.

blk_poll() is gone now :)

> +	if (iob) {
> +		iob->complete = q->mq_ops->complete_batch;
> +		if (!iob->complete) {
> +			WARN_ON_ONCE(iob->req_list);
> +			iob = NULL;
> +		}
> +	}

Assigning first and checking later looks a little strange, even if it
makes no actual difference.  Why not:

	if (iob && q->mq_ops->complete_batch)
	 	iob->complete = q->mq_ops->complete_batch;
	else
		iob = NULL;

Also I'd expect this patch in the series right after the other block
patches.
