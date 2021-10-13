Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD30C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC7C61139
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhJMR6F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhJMR6D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 13:58:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CDAC061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4gGRUK2cnVZRdPoe/AvrUSrx+ZW0LlKzv0D6ny9yo/Y=; b=fRot7vCBC3k2XbiSuF4uBU5XOk
        I06cj+Vs3jDeTSlkzglFTBL8TlegfiOv32lJaURXiByqQHCUylOP+OqCvCO1ZZfN/VqHgn8EplfQ4
        MpjIlxuh8hAICWhak3YZlK++N+rkhZCruQJjJGrGf4X1jsYM/xkDZxDw4Bm83n/PnROepQLVNBuXp
        yqm6x7WDP/JOD9EKJKkAp0S5yKmsgGRbpEodvYR98j9rm+uMoJbhIJGYy+SgA8vVzEBzmQEq43qHx
        c40TcHlOwwq16npKnx4If/PNmYCiE06R2iLCXHcE3YiQWOSr+KKEY2BrkzjVdlFzuGke57ccJZktR
        wppkZgrA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maiSc-007g9c-89; Wed, 13 Oct 2021 17:54:51 +0000
Date:   Wed, 13 Oct 2021 18:54:38 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] block: move update request helpers into blk-mq.c
Message-ID: <YWcdXjZPpYvuaJ5O@infradead.org>
References: <20211013164937.985367-1-axboe@kernel.dk>
 <20211013164937.985367-5-axboe@kernel.dk>
 <YWcYFywO7J0R4oMb@infradead.org>
 <f55d823f-79ca-67f0-1868-c013d7711fe5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f55d823f-79ca-67f0-1868-c013d7711fe5@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 11:46:40AM -0600, Jens Axboe wrote:
> On 10/13/21 11:32 AM, Christoph Hellwig wrote:
> > On Wed, Oct 13, 2021 at 10:49:37AM -0600, Jens Axboe wrote:
> >> For some reason we still have them in blk-core, with the rest of the
> >> request completion being in blk-mq. That causes and out-of-line call
> >> for each completion.
> >>
> >> Move them into blk-mq.c instead.
> > 
> > The status/errno helpers really are core code.  And if we change
> > the block_rq_complete tracepoint to just take the status and do the
> > conversion inside the trace event to avoid the fast path out of line
> > call.
> 
> It's all core code at this point imho, there's on request based without
> mq.

But the errno mapping is just as relevant for bio based drivers.
