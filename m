Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDD5C7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjDLHOI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjDLHOF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:14:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DECD5BA2
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:14:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3AD162EAC
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A421C433D2;
        Wed, 12 Apr 2023 07:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681283643;
        bh=pTuZvWL7g0svNosU+1PU6XiC4fXEGKhEzUkSk3C+x58=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WP/Ss/rSDKJ/H47RPQ6EpqTeD6QfhrbvvpsLRNlKhtuD9RhPvbTsHHprA7E+W6Tnz
         +WMWIrtK+XF8BRDdgLcb8gaS/gieDr4L+hBN9VeH92piQaPyaFyfFSZFeSMLfJAhj7
         OqrwvPIM6N1rydd83fsQjGLwXLHnJjUy+vEZ1whQlpauSeH3l0Y8d/QkK3oBLtpBnC
         TIqYDUjY04HBWTdhR4316QF2oFTFNkczUKbuDCkSwwwXLUKvYHRlSjLFszBQwLIcUH
         pEAG0eZ0mu6p+a+Ys/JoJIspEdKj9IfuUYfmh7C6UgMS7XCYQabb00Ki2Wc0bycPOh
         yImRw10aKiS/w==
Message-ID: <b7dd075a-da91-556f-f713-2abac724e107@kernel.org>
Date:   Wed, 12 Apr 2023 16:14:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 06/18] blk-mq: move blk_mq_sched_insert_request to
 blk-mq.c
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-7-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412053248.601961-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 14:32, Christoph Hellwig wrote:
> blk_mq_sched_insert_request is the main request insert helper and not
> directly I/O scheduler related.  Move blk_mq_sched_insert_request to
> blk-mq.c, rename it to blk_mq_insert_request and mark it static.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

[...]

> -void blk_mq_sched_insert_request(struct request *rq, bool at_head,
> -				 bool run_queue, bool async)
> -{
> -	struct request_queue *q = rq->q;
> -	struct elevator_queue *e = q->elevator;
> -	struct blk_mq_ctx *ctx = rq->mq_ctx;
> -	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> -
> -	WARN_ON(e && (rq->tag != BLK_MQ_NO_TAG));
> -
> -	if (blk_mq_sched_bypass_insert(hctx, rq)) {

Nit: given the super confusing name that blk_mq_sched_bypass_insert() has,
replacing the above if with:

	if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq))

with the comment above it would make things even more readable I think.

Otherwise looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


