Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33E2C5B578
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 06:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861902146E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 06:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfGAGaZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 02:30:25 -0400
Received: from verein.lst.de ([213.95.11.211]:58527 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfGAGaZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Jul 2019 02:30:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0007868CFE; Mon,  1 Jul 2019 08:30:23 +0200 (CEST)
Date:   Mon, 1 Jul 2019 08:30:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, hch@lst.de, bvanassche@acm.org,
        axboe@kernel.dk
Subject: Re: [PATCH 4/5] null_blk: create a helper for zoned devices
Message-ID: <20190701063022.GH20073@lst.de>
References: <20190629050442.8459-1-chaitanya.kulkarni@wdc.com> <20190629050442.8459-5-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629050442.8459-5-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 28, 2019 at 10:04:41PM -0700, Chaitanya Kulkarni wrote:
> This patch creates a helper function for handling zoned block device
> operations.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/block/null_blk_main.c | 50 +++++++++++++++++++++--------------
>  1 file changed, 30 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
> index e75d187c7393..824392681a28 100644
> --- a/drivers/block/null_blk_main.c
> +++ b/drivers/block/null_blk_main.c
> @@ -1214,6 +1214,34 @@ static inline int nullb_handle_memory_backed(struct nullb_cmd *cmd)
>  	return null_handle_rq(cmd);
>  }
>  
> +static inline void nullb_handle_zoned(struct nullb_cmd *cmd)
> +{
> +	unsigned int nr_sectors;
> +	sector_t sector;
> +	req_opf op;
> +
> +	if (cmd->nq->dev->queue_mode == NULL_Q_BIO) {
> +		op = bio_op(cmd->bio);
> +		sector = cmd->bio->bi_iter.bi_sector;
> +		nr_sectors = cmd->bio->bi_iter.bi_size >> 9;
> +	} else {
> +		op = req_op(cmd->rq);
> +		sector = blk_rq_pos(cmd->rq);
> +		nr_sectors = blk_rq_sectors(cmd->rq);
> +	}

And this checks for the same info as the previous one.
You probably just want to pass sector and nr_sectors as an argument
to null_handle_cmd early in the series.

> +	switch ((op)) {

No need for the double braces.
