Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F29C77B61
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 08:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDJIKO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 04:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjDJIKN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 04:10:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E867F4219
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 01:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 847CA618BF
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 08:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5017C433D2;
        Mon, 10 Apr 2023 08:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681114211;
        bh=i6HaLfgTOgLjYDeBxqAEstsAFAPjbMZ+3SzZFofZ+Rw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z7CUaBw/m++1hDwjavZAYM4QXoZGowpVHDiZofyZVUBgJYRf+OvZJ8zpDFnCShf7Z
         hl1jaZXdVezNgZBQKEBsjiSgDwwW4Vk3NN7e0zbjkFiOQEbd2bva8RirntNDwKAkyy
         dZ/toX4yCZSE/MpF6N+IwC18mLmA+LVuqctbqEJrJ/x0tnySf6C/wqwDr5qL66lwzu
         ZHMjXWMjhEu4UWCVfs7/ck8CLU8ipEPbr+VcH2bMBpJNl77IqD6EySw7ZRjB+uHTZw
         i9JG8599T0gNVV3pOCRKlcaI22Lod20u5kF3drBHcMjHFLJt1PqUFifbShRNntGMnS
         0c3grBqhU8Ebw==
Message-ID: <81ccc853-63f6-5be4-7ab3-fc95c128b7f9@kernel.org>
Date:   Mon, 10 Apr 2023 17:10:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 09/12] block: mq-deadline: Disable head insertion for
 zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-10-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230407235822.1672286-10-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/23 08:58, Bart Van Assche wrote:
> Make sure that zoned writes are submitted in LBA order.
> 
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 50a9d3b0a291..891ee0da73ac 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -798,7 +798,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  
>  	trace_block_rq_insert(rq);
>  
> -	if (at_head) {
> +	if (at_head && !blk_rq_is_seq_zoned_write(rq)) {
>  		list_add(&rq->queuelist, &per_prio->dispatch);
>  		rq->fifo_time = jiffies;
>  	} else {

Looks OK, but I would prefer us addressing the caller site using at_head = true,
as that is almost always completely wrong for sequential zone writes.
That would reduce the number of places we check for blk_rq_is_seq_zoned_write().
