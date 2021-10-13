Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5855C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C616115B
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhJMPel (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhJMPel (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 11:34:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA3BC061570;
        Wed, 13 Oct 2021 08:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+yfyEGem+HIxX7wO22gQfWzAOaAv2ZtPBrOstpcn55A=; b=qYWdUGEAYrNKdnbZ/WnTtFJJQt
        vjAzCcGsvHtgKLqb9Ej0elHxUr01TX9gIfejER91GLvbUN0Rd2+uWgXP59TV/MrpH/fJ+/2kyPn1A
        OfITO2xAz9vUO8G572jYaw8Rkc7eMfMwl2J32JdTCG0nMz+d4gaYBQkdcmxTscgmHUAzEfbpQbN7e
        SEfaA1+hSdRclkEHqHkBjaSREA7Mu1jivpl/NjvSnhqiWl1U6khDQNYPxtd+q9+eL5k9/6T38htId
        CetSvZk1xWO+Dc9jbIh2oYb4h2bx86jNtMSd23Lm4cxtPQgDZpiXcMegK7z12WwywIBc/iWJ4q778
        XaK66dTw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1magCw-007Yky-C1; Wed, 13 Oct 2021 15:30:38 +0000
Date:   Wed, 13 Oct 2021 16:30:18 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 3/3] blk-mq: optimise *end_request non-stat path
Message-ID: <YWb7ikSx6vz03u6B@infradead.org>
References: <cover.1634115360.git.asml.silence@gmail.com>
 <e0f2ea812e93a8adcd07101212e7d7e70ca304e7.1634115360.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0f2ea812e93a8adcd07101212e7d7e70ca304e7.1634115360.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 09:57:13AM +0100, Pavel Begunkov wrote:
> We already have a blk_mq_need_time_stamp() check in
> __blk_mq_end_request() to get a timestamp, hide all the statistics
> accounting under it. It cuts some cycles for requests that don't need
> stats, and is free otherwise.

The transformation is a little non-obvious due to the checks hidden
inblk_mq_need_time_stamp, but after following all the spaghetti it does
looks like a correct transformation:

Reviewed-by: Christoph Hellwig <hch@lst.de>
