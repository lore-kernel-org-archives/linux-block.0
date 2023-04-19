Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC24C6FD18
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 04:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjDSEuG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 00:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjDSEuF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 00:50:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91EE3C0A
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 21:50:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E2D2C6732D; Wed, 19 Apr 2023 06:50:00 +0200 (CEST)
Date:   Wed, 19 Apr 2023 06:50:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 03/11] block: Introduce blk_rq_is_seq_zoned_write()
Message-ID: <20230419045000.GA25898@lst.de>
References: <20230418224002.1195163-1-bvanassche@acm.org> <20230418224002.1195163-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418224002.1195163-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 18, 2023 at 03:39:54PM -0700, Bart Van Assche wrote:
> +/**
> + * blk_rq_is_seq_zoned_write() - Whether @rq is a zoned write for which the order matters.

Maybe:

 * blk_rq_is_seq_zoned_write() - check if @rq needs zoned write serialization

> +bool blk_rq_is_seq_zoned_write(struct request *rq)
> +{
> +	switch (req_op(rq)) {
> +	case REQ_OP_WRITE:
> +	case REQ_OP_WRITE_ZEROES:
> +		return blk_rq_zone_is_seq(rq);
> +	case REQ_OP_ZONE_APPEND:
> +	default:

The REQ_OP_ZONE_APPEND case here is superflous.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
