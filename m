Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E68C433DF
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 05:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921A3205CB
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 05:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sRv6d+A9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgENFuO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 01:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbgENFuN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 01:50:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71525C061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 22:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sxo9Ep81jO2/p+U64anML+U88P1RPdL1LAXVqOHa30w=; b=sRv6d+A9+zWaL6nicSwQd7q4wY
        NaY84/HfZWDJb+7x0Kt69dGXVqmwZRGftrCalFgNT3gqK0JSP8KtzTvXu8ly6YvRMtdvMh8RNACFM
        EtNRX9eQvXCjUVV8aB4Z06snTXPqls4CxEuCyrJav1jtWTyd+oJ0QnM/pCjnSKM6WyveKIa59My7G
        Jc9rwlw05XkH2UASJ7qHm2oW4LIPVr21O1wPXvxmIBticSe0UiIeA4oo2CvUL3rpQJsuUcD+zfUrN
        JwMhgjTh70j4DICEKu/mHDhTnT7c+jYHYV311gQbNm85VEC2NvxALYq4rX1CRXY4DYgqqiaVjAgTl
        6mVjN9qw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZ6ks-0001MA-FR; Thu, 14 May 2020 05:50:02 +0000
Date:   Wed, 13 May 2020 22:50:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH 3/9] blk-mq: don't predicate last flag in
 blk_mq_dispatch_rq_list
Message-ID: <20200514055002.GA22388@infradead.org>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-4-ming.lei@redhat.com>
 <20200513122753.GC23958@infradead.org>
 <20200514005043.GE2073570@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514005043.GE2073570@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 14, 2020 at 08:50:43AM +0800, Ming Lei wrote:
> On Wed, May 13, 2020 at 05:27:53AM -0700, Christoph Hellwig wrote:
> > On Wed, May 13, 2020 at 05:54:37PM +0800, Ming Lei wrote:
> > > .commit_rqs() is supposed to handle partial dispatch when driver may not
> > > see .last of flag passed to .queue_rq().
> > > 
> > > We have added .commit_rqs() in case of partial dispatch and all consumers
> > > of bd->last have implemented .commit_rqs() callback, so it is perfect to
> > > pass real .last flag of the request list to .queue_rq() instead of faking
> > > it by trying to allocate driver tag for next request in the batching list.
> > 
> > The current case still seems like a nice optimization to avoid an extra
> > indirect function call.  So if you want to get rid of it I think it at
> > least needs a better rationale.
> 
> You mean marking .last by trying to allocate for next request can
> replace .commit_rqs()? No, it can't because .commit_rqs() can be
> called no matter .last is set or not, both two are independent.
> 
> Removing it can avoid to pre-allocate one extra driver tag, and
> improve driver tag's utilization.

What I said is that the current scheme works, and the new one will
need an additional indirect function call in various scenarios.  The
commit log doesn't really "sell" that change very well.  Your new
explanation is much better, as would be saying it helps you with
the hanges in this series.
