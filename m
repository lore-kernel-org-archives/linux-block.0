Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ACAC433EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 09:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1102460EB4
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 09:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhKDJUA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 05:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhKDJT6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 05:19:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59469C061205
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q05ZkulSRVjVoBNvOzNQoU1UUxoTZasZjPBAho5ldHI=; b=Ri/pWhFsF4y7xjWD4BqFyE2f7q
        EZzeFRJ84hZlYYXxpmhSEmFGwkFaBZUNDUvioEe/Qf54vfNeZQuJQZ5l7tBuA8K1/46moPhUZ4vxL
        +EzPXOXmpN9iBud2rqnZ2JWG2NNHqpCwzf2ChTG4BLaAAWDKN5yTHJG56hPFGkHZXkAoc+1omddoH
        pjSFcOHVCC40eO4467sVB2AZvTpgsFuy4q+2454uDYD/II9AkLBfRH8Pn22s0jH+HEycwuv3EBmHn
        quq+ktp0uzU9E9PDg5xd54jJsPrAmKnPT0e7LVNlj8FRYx7MEzVjlrjd7oj4WxLozUk5Ta2UmJMcU
        bZ6vQhbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miYs4-008RJz-Tr; Thu, 04 Nov 2021 09:17:20 +0000
Date:   Thu, 4 Nov 2021 02:17:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] block: move plug rq alloc into helper and ensure
 queue match
Message-ID: <YYOlIGsSHN0+YrjK@infradead.org>
References: <20211103183222.180268-1-axboe@kernel.dk>
 <20211103183222.180268-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103183222.180268-5-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 03, 2021 at 12:32:22PM -0600, Jens Axboe wrote:
> +	if (plug && !rq_list_empty(plug->cached_rq)) {
> +		rq = rq_list_peek(&plug->cached_rq);

No need for the empty check plus peek.  This could be simplified
down to:

	if (!plug)
		return NULL;
	rq = rq_list_peek(&plug->cached_rq);
	if (!rq || rq->q != q)
		return NULL;

	rq_qos_throttle(q, bio);
	plug->cached_rq = rq_list_next(rq);
	INIT_LIST_HEAD(&rq->queuelist);
	return rq;
