Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5CEC433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 17:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhKWRIq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhKWRIq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 12:08:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802E9C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 09:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d3lSyVwVntDHYZZOwLoaVCwF51HhHLA2RgNEPDCKb+s=; b=37pPTwLLbfMGKxfL6fGb11u2by
        7ds/4MJZVRH85ywkkm3F4cZyDNaCstQc0BO9a6ryL5Wq8kkjC4FnP0/pXJwUIFc/f2RQEhbrxNM3x
        845hkGqorEWKPdohsLJCTHOw3bOdTw/I+AGpSPKX4t5SiAfTLVQV0DmT1uk8W/y6rRhmTocvHuXzM
        xfwa0yZpR+Ayl6S5OHmYwUZpWHTZ659ljlkkf1521wKO8QUVVPkSGJmtEOo1jiNQu0lbBL/t60aRh
        hPYPaoui1v8zv9AsHDxNE+LEEaXJFLWm3vIZbdWDQFldtgs4+TvuX1U58GRh1+GysHp9tEvixbOlR
        RctP34Pw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpZEg-0031He-4r; Tue, 23 Nov 2021 17:05:38 +0000
Date:   Tue, 23 Nov 2021 09:05:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block: only allocate poll_stats if there's a user of
 them
Message-ID: <YZ0fYq+7XSRWp+XG@infradead.org>
References: <20211123161813.326307-1-axboe@kernel.dk>
 <20211123161813.326307-4-axboe@kernel.dk>
 <YZ0ZvJMKlHOjMckv@infradead.org>
 <e1a46189-0b83-42ea-4488-4b6ccb3132e0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1a46189-0b83-42ea-4488-4b6ccb3132e0@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 23, 2021 at 09:44:18AM -0700, Jens Axboe wrote:
> I think so:

I think my eternal enemy in blk-mq-debugfs.c will need an update for
the flag removal, but otherwise this looks good.
