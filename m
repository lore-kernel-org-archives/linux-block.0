Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0369C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 05:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF1A46101A
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 05:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhJNFtU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 01:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhJNFtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 01:49:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDDFC061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 22:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wSNU2NawI+4PK8VyzJtsC9apAJ0f4s27SV+8wa7+c5I=; b=Inq26Rd/kf7dXBlHfq/p35tVy8
        plqLyA0UVszy/2Sm1VVu0uU7dpQltFfqxnJ/3A8VMjIFVZRYpAhjU+t+NFWSn1OXdzurmheEook1q
        PgxJaUeBeBQh5dcWTqFJbv0FaTufqK/qjqlcRZqUGz5gKrZ0TBEuUsE+ZCUhahdMB0oU6q8zHUfke
        VzrnyEnl7hhIqFDBPz4RqDuHHkYHvNs/0OYPNmJEFBDS5eBd8jkG3M6B8OmouAYbYv/ciXmvFXppB
        rCWq8B8r5On+xJSMnihLDpavrD3xc4Fu+r2ybX4goHs/mK5MQWPwQCyjWHYn/1VizFhVLrGImucME
        uC3ANqeQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1matYe-0083yT-Qf; Thu, 14 Oct 2021 05:46:07 +0000
Date:   Thu, 14 Oct 2021 06:45:36 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 1/9] block: define io_batch structure
Message-ID: <YWfEALs4P+bGQtY9@infradead.org>
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013165416.985696-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 10:54:08AM -0600, Jens Axboe wrote:
> This adds the io_batch structure, and a helper for defining one on the
> stack. It's meant to be used for collecting requests for completion,
> with a completion handler defined to be called at the end.

Isn't the name a little misleading given that it is all about
completions?

Also I wonder if this should be merged with the next patch as that's
sortof a logical unit.
