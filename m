Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6673C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 05:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CACA360F9E
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 05:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbhJNFEd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 01:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhJNFEd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 01:04:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED09C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 22:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z2on1RmQfsHUDMXP/ulBq685C5GFk7YDOia/inf8fy8=; b=A5oqwcEGhbNOF+3Ae8I+5h+S6+
        GVjGggfcVABDnPhmj3esdL9D3n2Vqkg8uYh36TcOq6Vg496wdFBAj9mPKsLftUJwyLq+EJmyPAj2+
        g4nIac9IxT1NxMdmSuVO0AX2uAGj/QWt2gBT5gwJCLoMrXSMEfMqzDc3gk+mJMYtZstluK0+7tbJv
        foVY6aSTNObxuNtuHOGIR6HUaV87L0QPjXHMHYr1sCsjMclcZeEuDUBEDux4VMUWJBE3Aj7uV5Tjd
        Q7TIfd/JRgo3JwsBlKbEZkJLq8zg4a9zGbot4YMjcoET5GzUdom36K6eh4OsGDTrg8rd3NpFHHEc7
        NARC9kwA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1masrP-0082jn-Sf; Thu, 14 Oct 2021 05:01:23 +0000
Date:   Thu, 14 Oct 2021 06:00:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] block: move update request helpers into blk-mq.c
Message-ID: <YWe5h25TVmF3V05w@infradead.org>
References: <20211013164937.985367-1-axboe@kernel.dk>
 <20211013164937.985367-5-axboe@kernel.dk>
 <YWcYFywO7J0R4oMb@infradead.org>
 <f55d823f-79ca-67f0-1868-c013d7711fe5@kernel.dk>
 <YWcdXjZPpYvuaJ5O@infradead.org>
 <2418e448-6df4-ce6e-da2d-99fb7ac41fcb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2418e448-6df4-ce6e-da2d-99fb7ac41fcb@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 11:57:51AM -0600, Jens Axboe wrote:
> It's not like they are conditionally enabled, if you get one you get
> the other. But I can shuffle it around if it means a lot to you...

As I've been trying to reshuffle the files and data structures to
keep the bio and requests bits clearly separated I'd appreciate if we
can keep the status codes in core.c and just do the long overdue move
the request completion helers.

And as said before:  I think we should fix the trace point to not
unconditionally call the status to errno conversion first as not doing
it at all for the fast path will be even faster than inlining it :)
