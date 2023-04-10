Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E2BC77B61
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 08:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDJIGl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 04:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJIGk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 04:06:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AFB30C4
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 01:06:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75A2060E86
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 08:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE921C433D2;
        Mon, 10 Apr 2023 08:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681113998;
        bh=Uq/TTueFthJoVlbuWU49iBFEwh015q7FdhMVdIHgRGw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XN5zdNfed7s34zx9FFUKWS1tpBc9XwT/BvPKJw6YtVR4VqInzmz45LdS8YPIeNaFU
         VOdF1EvLKycAr6Wnrx7NIj20ZFQ8wsCcD/PqkbjbnEV+tS1E91q9sudocqIbWQ1vya
         y1yQ+EMmvG9TALR+CT3ck5Qb0vSnUotB7KKHYm2DL7CcDrv1yO3q091vWX7UmjYT93
         l3GIVoXR63+MIRQfL6j/aBYwFKoW3zWuuoYklQ95gM5/tn87kgE1H1ho43y/nq3aOn
         Oi5dIwooirD1rCKsOStyNylJCigFNKwm9Hvp11LQMpwZg82+8Y/yUHHJwU34ZxrTpQ
         CzdT5Nf+qBarg==
Message-ID: <54c82f3e-51ca-cdde-6a60-8d13af5aad99@kernel.org>
Date:   Mon, 10 Apr 2023 17:06:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 07/12] block: Make it easier to debug zoned write
 reordering
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-8-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230407235822.1672286-8-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/23 08:58, Bart Van Assche wrote:
> Issue a kernel warning if reordering could happen.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 562868dff43f..d89a0e6cf37d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2478,6 +2478,8 @@ void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
>  {
>  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>  
> +	WARN_ON_ONCE(rq->q->elevator && blk_rq_is_seq_zoned_write(rq));
> +
>  	spin_lock(&hctx->lock);
>  	if (at_head)
>  		list_add(&rq->queuelist, &hctx->dispatch);
> @@ -2570,6 +2572,8 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	bool run_queue = true;
>  	int budget_token;
>  
> +	WARN_ON_ONCE(q->elevator && blk_rq_is_seq_zoned_write(rq));
> +
>  	/*
>  	 * RCU or SRCU read lock is needed before checking quiesced flag.
>  	 *

Looks OK, but I think it would be preferable to optimize
blk_rq_is_seq_zoned_write() to compile to be always false for kernels where
CONFIG_BLK_DEV_ZONED is not set. E.g.:

static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
{
	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
		switch (req_op(rq)) {
		case REQ_OP_WRITE:
		case REQ_OP_WRITE_ZEROES:
			return disk_zone_is_seq(rq->q->disk, blk_rq_pos(rq));
		case REQ_OP_ZONE_APPEND:
		default:
			return false;
		}
	}

	return false;
}

