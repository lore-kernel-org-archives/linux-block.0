Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E61C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 06:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 145346134F
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 06:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhFVGza (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 02:55:30 -0400
Received: from verein.lst.de ([213.95.11.211]:45314 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhFVGz1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 02:55:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2DD6167357; Tue, 22 Jun 2021 08:53:10 +0200 (CEST)
Date:   Tue, 22 Jun 2021 08:53:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Wang Shanker <shankerwangmiao@gmail.com>
Subject: Re: [PATCH 1/2] block: fix discard request merge
Message-ID: <20210622065309.GA29691@lst.de>
References: <20210609004556.46928-1-ming.lei@redhat.com> <20210609004556.46928-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609004556.46928-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 09, 2021 at 08:45:55AM +0800, Ming Lei wrote:
> index 4d97fb6dd226..bcdff1879c34 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -559,10 +559,14 @@ static inline unsigned int blk_rq_get_max_segments(struct request *rq)
>  static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
>  		unsigned int nr_phys_segs)
>  {
> -	if (req->nr_phys_segments + nr_phys_segs > blk_rq_get_max_segments(req))
> +	if (blk_integrity_merge_bio(req->q, req, bio) == false)
>  		goto no_merge;
>  
> -	if (blk_integrity_merge_bio(req->q, req, bio) == false)
> +	/* discard request merge won't add new segment */
> +	if (req_op(req) == REQ_OP_DISCARD)
> +		return 1;
> +
> +	if (req->nr_phys_segments + nr_phys_segs > blk_rq_get_max_segments(req))

I'd rather handle this by returning UINT_MAX for discard requests from
blk_rq_get_max_segments given that bio_attempt_discard_merge is only used
for the !DISCARD_MERGE case anyway.
