Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0A9C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F0DE610EA
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhJMRf6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhJMRf5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 13:35:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277BFC061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ba96B3BincnapozQebznkVJ5OEEf4XtTAXMAJtffBjw=; b=uv3SMh8B1VHUsvD1o6Hwja8tho
        46RA4iE0XtR6d3hXOvEUtn8lOoFR6yxSQLsYcVzZye/qwraveH70RVW3KxdL65cZ8SsVn5VvojAKx
        USlFe1uuasnOWuusd2zzvRynHXxi3nYds54JwEp/f3YlDpQAnK8cVQe2j4g8MH6HDhPnGy8bZrpnp
        IXHwk++BPvIxfL1niPcvIO8ykHVfxWK+dIPoz5uyjOo3xoRzNYbLeJIQB88jXLJufFWUzsgGwpBjj
        anOmnIcDlJI+ga2Jlr8fyYS0jxKSEdz1puhmZnuLXOqSa1/r0eSahUXwnhA88Jmkx68INy0gFH8uL
        G84Lszgg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mai6p-007fF9-FR; Wed, 13 Oct 2021 17:32:50 +0000
Date:   Wed, 13 Oct 2021 18:32:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] block: move update request helpers into blk-mq.c
Message-ID: <YWcYFywO7J0R4oMb@infradead.org>
References: <20211013164937.985367-1-axboe@kernel.dk>
 <20211013164937.985367-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013164937.985367-5-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 10:49:37AM -0600, Jens Axboe wrote:
> For some reason we still have them in blk-core, with the rest of the
> request completion being in blk-mq. That causes and out-of-line call
> for each completion.
> 
> Move them into blk-mq.c instead.

The status/errno helpers really are core code.  And if we change
the block_rq_complete tracepoint to just take the status and do the
conversion inside the trace event to avoid the fast path out of line
call.
