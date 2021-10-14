Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DC5C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 08:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A4516109F
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 08:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhJNIHQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 04:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhJNIHP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 04:07:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D18BC061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 01:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=25XY4YrpwBExwBP6s8IxaKKZ2GSD+wtTsYdTtN84f4s=; b=ukxxY1+NLmualQn0AJbJYDgjvB
        XS0zPwb5YKTFJ2T10B3oLP8q5cBFMVawPMlAeIa+56cMUz6lv4FX2UxC8+CQLDOKrWSYeQxo/EYBU
        cQdjl2PwfKyIy132jp+AdRLxX4ecIPi+yOuoOEwCq+htVtpwNWNMb8CCD7V2DfXdawwwdtT0h5Ltn
        kPlPEeaZGM2HRY+Kk0a4pW7BlkubWd+5Uj5bCdICZQWQY3WIWXGaJYkG2y0ah7b0F1dnr0I7Ip154
        Zl+CE/kBSxjxBb7aCIGuY0hI9APrb0EMHmCmcR88Pwc5lpUEzW3I56Ozvpi8/7KLKcpVbAXtinTkX
        k8r0IJgw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maviA-008AWu-9n; Thu, 14 Oct 2021 08:04:10 +0000
Date:   Thu, 14 Oct 2021 09:03:34 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 8/9] io_uring: utilize the io_batch infrastructure for
 more efficient polled IO
Message-ID: <YWfkVtB+pMpaG2T3@infradead.org>
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-9-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013165416.985696-9-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 10:54:15AM -0600, Jens Axboe wrote:
> @@ -2404,6 +2406,11 @@ static int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
>  		struct kiocb *kiocb = &req->rw.kiocb;
>  		int ret;
>  
> +		if (!file)
> +			file = kiocb->ki_filp;
> +		else if (file != kiocb->ki_filp)
> +			break;
> +

Can you explain why we now can only poll for a single file (independent
of the fact that batching is used)?

> +	if (!pos && !iob.req_list)
>  		return 0;
> +	if (iob.req_list)
> +		iob.complete(&iob);

Why not:

	if (iob.req_list)
		iob.complete(&iob);
	else if (!pos)
		return 0;

?
