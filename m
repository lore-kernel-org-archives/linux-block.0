Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A2CC433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 15:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8159664E50
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 15:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbhBDP2O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 10:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237289AbhBDP1s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 10:27:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD7CC061786
        for <linux-block@vger.kernel.org>; Thu,  4 Feb 2021 07:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dQIvt99fwhCBvXUQTuD6MxHn1FJmYyV8DY+psBZxvaU=; b=DfyTJgJfNDc/+uSFJDdVycdNGM
        DE9Wvah8fyzmCsLtlQLqWaEUUcUNmrAqI1rxZqZfv6+SBT0WO9ibF/u5U9sZtBxuwrtxUnlnWnRxh
        t4VhuHo8oKquMHWe96s33Rl8X9o5jxc1SQuJgA95wnl/jKjBNB8ARHcLCLSqT0SrRCgwHsjEMqO1u
        X9fMkCf5A8n9T9fHOLxTUpU0xTOF70GbtU1Ez0ZVcgGPihAY+CGDB680YBGTMQ/nk7p5abxJ46PU2
        U6xXZc8xQ55HT83ME+zdg6GY6cgCPJoX33JHoHl5p1LbvsF8/2s67GYa1zugrTy+qpO08UkOZdW5H
        KGREr+AA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l7gXA-0012t1-N1; Thu, 04 Feb 2021 15:27:04 +0000
Date:   Thu, 4 Feb 2021 15:27:04 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme fixes for 5.11
Message-ID: <20210204152704.GA249252@infradead.org>
References: <YBwNukLwQfsXQL9U@infradead.org>
 <e407087c-3760-b725-4b02-692eee28041b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e407087c-3760-b725-4b02-692eee28041b@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 04, 2021 at 08:25:05AM -0700, Jens Axboe wrote:
> On 2/4/21 8:07 AM, Christoph Hellwig wrote:
> > git://git.infradead.org/nvme.git nvme-5.11
> 
> You forgot the signed tag, but I pulled it.

Sorry.  The signed tag would also have been available as
"nvme-5.11-2021-02-04", but I fat-fingered the actual pull request.
