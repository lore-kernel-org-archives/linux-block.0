Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7BBC5B578
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 06:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10032214AF
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 06:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfGAG3R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 02:29:17 -0400
Received: from verein.lst.de ([213.95.11.211]:58501 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfGAG3R (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Jul 2019 02:29:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9665168CEE; Mon,  1 Jul 2019 08:29:15 +0200 (CEST)
Date:   Mon, 1 Jul 2019 08:29:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, hch@lst.de, bvanassche@acm.org,
        axboe@kernel.dk
Subject: Re: [PATCH 2/5] null_blk: create a helper for badblocks
Message-ID: <20190701062915.GG20073@lst.de>
References: <20190629050442.8459-1-chaitanya.kulkarni@wdc.com> <20190629050442.8459-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629050442.8459-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	if (dev->queue_mode == NULL_Q_BIO &&
> +			bio_op(cmd->bio) != REQ_OP_FLUSH) {
> +		is_flush = false;
> +		sector = cmd->bio->bi_iter.bi_sector;
> +		size = bio_sectors(cmd->bio);
> +	}
> +	if (dev->queue_mode != NULL_Q_BIO &&
> +			req_op(cmd->rq) != REQ_OP_FLUSH) {
> +		is_flush = false;
> +		sector = blk_rq_pos(cmd->rq);
> +		size = blk_rq_sectors(cmd->rq);
> +	}
> +	if (is_flush)
> +		goto out;

This isn't really new in your patch, but looks very odd.  Why not:

	if (dev->queue_mode == NULL_Q_BIO) {
		if (bio_op(cmd->bio) == REQ_OP_FLUSH)
			return BLK_STS_OK;
		sector = cmd->bio->bi_iter.bi_sector;
		size = bio_sectors(cmd->bio);
	} else {
		if (req_op(cmd->rq) == REQ_OP_FLUSH)
			return BLK_STS_OK;
		sector = blk_rq_pos(cmd->rq);
		size = blk_rq_sectors(cmd->rq);
	}

> +	if (badblocks_check(bb, sector, size, &first_bad, &bad_sectors)) {
> +		cmd->error = BLK_STS_IOERR;
> +		sts = BLK_STS_IOERR;
> +	}
> +out:
> +	return sts;

Also I find the idea of a goto label that just does a return rather odd.
Please just return directly to make it obvious what is going on.

But in general for the whole series:  I'd much prefer moving the
bio vs request handling out of null_handle_cmd and into the callers
rather than hiding them one layer deeper in helpers.  Patch 1 is
a good help for that, and anything else factoring out common code,
but code for request vs bio should much rather move to the callers.
