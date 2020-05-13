Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EE7CA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 102B424927
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BQN/7MBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbgEMM0N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 08:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgEMM0N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 08:26:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185D4C061A0E
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XOs/kv+T6qbza6AdYsRpL4tPP2gObeAAOcTAr4IuhVk=; b=BQN/7MBpG4N7C69hJEowakAMSD
        leR4j/yo4raiBoM3vkoW6NTsOkWRf5urwffG7cu6Vit0KgtE0rP79N0yjZqhKIPgIqCjRRRr124+U
        xh1BmHLLS1FIlnUlyuJoHGHXmG5QzEcYh8Mj/F+BdT9cSHpQT/ltfwGvi+BaGUf/vSrx4SgNJANwj
        84SLPqozX3HxqB9AvdN4agp1ar3qpU2rAzEqt9M/WC5UWfEhqrP8cBQN5xZ9b25F2mNsfL5JN4zZz
        w62aNgD0/lI5P/NRkCkR3iRi+TNekXjWY39J7VH9rjjLz8CeNC7JqC+KY3UwqDT9YatqwFsNGowiR
        DFJV8xrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYqSi-0005zH-Bs; Wed, 13 May 2020 12:26:12 +0000
Date:   Wed, 13 May 2020 05:26:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/9] blk-mq: pass hctx to blk_mq_dispatch_rq_list
Message-ID: <20200513122612.GB23958@infradead.org>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095443.2038859-3-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 05:54:36PM +0800, Ming Lei wrote:
> All requests in the 'list' of blk_mq_dispatch_rq_list belong to same
> hctx, so it is better to pass hctx instead of request queue, because
> blk-mq's dispatch target is hctx instead of request queue.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
