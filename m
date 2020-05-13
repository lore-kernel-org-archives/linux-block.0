Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0031BC2D0FC
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 13:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A36F20643
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 13:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WTizA4/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbgEMN0Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 09:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387477AbgEMN0Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 09:26:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01ECC061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 06:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0PxzeM4WAhATUFJQeYzTUKgkHt1NEcFH/ziu0Tl+yvs=; b=WTizA4/+R69imQ+rYvssDaL53F
        xsR2mi1QZsaL2Vi/0Zgo1s6CX5i/pAKDhIitgL/trGdHzR0T6tQfsoZV0oPu8tzeXf4XSY+sWMBNx
        u8vUznPtDF11KDYYcvA7hkVlMvfCtPeYT7znnrjSxh/cbv415MMeqz4ekALUIqaRz3AeB971r4k63
        38WRi5LQTaE6e0ZVJ7V+IixSqlO0NQYobPAAo2Szb7tiQVVpkHq74JvlCLt+NwEa5FfnKNyBMSW+3
        1+CDrOSkRUAbzdZsEEUDTQn/osy83sa32u7Yy0qWSdq8XrJe07e7YXJ7+LSSJ0yBkjw/b6DZdSfBL
        xzFHrptw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYrOt-0004zX-Kf; Wed, 13 May 2020 13:26:19 +0000
Date:   Wed, 13 May 2020 06:26:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 8/9] blk-mq: pass obtained budget count to
 blk_mq_dispatch_rq_list
Message-ID: <20200513132619.GA8048@infradead.org>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-9-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095443.2038859-9-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 05:54:42PM +0800, Ming Lei wrote:
> Pass obtained budget count to blk_mq_dispatch_rq_list(), and prepare
> for supporting fully batching submission.
> 
> With the obtained budget count, it is easier to put extra budgets
> in case of .queue_rq failure.

I think you can remove the got_budget parameter, as it will be false
exactly when 0 is passed in the new arguent.  Also I think nr_budgets
might be a better name.
