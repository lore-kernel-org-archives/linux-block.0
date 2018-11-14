Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196FBC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D611422360
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LXaKGaGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D611422360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733149AbeKOB0d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:26:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733008AbeKOB0d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 20:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/jj3D/AVFu32XAH+IiQPO12f5wBkMQtK9VaUEg9Dj/A=; b=LXaKGaGp1zViOckY5rEybILNu
        m8GGJuTfxrzMFok1dgz/CKU6e/01oiBrO8kjP31kzrcAQNqk3uGDvYLqkAEEjOltoH6BZxh20SPzn
        H5+LHqlcqngJpxTBqKvAZtUDxVCzGbM9ds6IwZ8Cs2okaAU/Jnp2liivpkMLhBvROQhp/ab+5w/2n
        Ra48rqEWv6Lik1AoZ3/Fj31qEFa051WBWxHazPrCNRB58YqJ6UHJz0xUj+l/rAR9wu0m5z1JmXwIU
        yth+uyCjy67YSmeFw9li1egrB7Z7DZ4mC/m/brYUG9X+Xy7MuvrrBAK3sdszJzhoOERM0cqVX0eVl
        lVxSscyvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMx0G-00078G-95; Wed, 14 Nov 2018 15:22:52 +0000
Date:   Wed, 14 Nov 2018 07:22:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 00/19] block: support multi-page bvec
Message-ID: <20181114152252.GC22186@infradead.org>
References: <20181113151505.15498-1-ming.lei@redhat.com>
 <20181114024455.GE6311@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114024455.GE6311@dastard>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 01:44:55PM +1100, Dave Chinner wrote:
> Can you please cc this entire patchset to linux-fsdevel? I've only
> received 3-4 of the patches in this series and I can't make head or
> tail of them because I haven't received the rest of the patches.

And to anyone else for that matter.  Adding a person or list to just
a few patches is fundamentally stupid, don't ever do that.
