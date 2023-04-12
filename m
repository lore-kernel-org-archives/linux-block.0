Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EA0C7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjDLHTV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDLHTP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:19:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C92461BD
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:18:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 146FD60DFE
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64A6C433EF;
        Wed, 12 Apr 2023 07:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681283930;
        bh=vskc0sRxcq/tIk9+yX3IcAzPepbRk8ru6bnhFKZTOHo=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=o1ogDXH4dkeOhEPd178hwaV24yTbIfN8wWDxT5bZA1FPuIjBU4lqz6GVVyAslrU8K
         ZxXvah7UUXPCGBDWNmXyXJNxo+wLnmJoaz/x7iuWinkIi2Yx9eMGI6Eq7lFKFlLlAR
         teQ6Y5UgcNCBu3aQO/4/+mw5f+tGuxpTRFsLIHhFFet0jK5kIX2PNCtuhAafUSO8uF
         K5JV7W/ebRWeEaqWc3rd1X9H8g/bfGLRNV1tYXw0T0l6JQdo7q+pKuh5+n3JP95JZ3
         Vqkjjch0sshExco1/QIAR9m9Tu4ITyTBLrcO2scrcluBaCsSIBeC8BM5FDZ/WqYVjg
         9XYYnqHO8mI0w==
Message-ID: <3cb04b65-6e73-15f3-6920-76bd9c62a690@kernel.org>
Date:   Wed, 12 Apr 2023 16:18:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 06/18] blk-mq: move blk_mq_sched_insert_request to
 blk-mq.c
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-7-hch@lst.de>
 <b7dd075a-da91-556f-f713-2abac724e107@kernel.org>
Organization: Western Digital Research
In-Reply-To: <b7dd075a-da91-556f-f713-2abac724e107@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 16:14, Damien Le Moal wrote:
> On 4/12/23 14:32, Christoph Hellwig wrote:
>> blk_mq_sched_insert_request is the main request insert helper and not
>> directly I/O scheduler related.  Move blk_mq_sched_insert_request to
>> blk-mq.c, rename it to blk_mq_insert_request and mark it static.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> 
> [...]
> 
>> -void blk_mq_sched_insert_request(struct request *rq, bool at_head,
>> -				 bool run_queue, bool async)
>> -{
>> -	struct request_queue *q = rq->q;
>> -	struct elevator_queue *e = q->elevator;
>> -	struct blk_mq_ctx *ctx = rq->mq_ctx;
>> -	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>> -
>> -	WARN_ON(e && (rq->tag != BLK_MQ_NO_TAG));
>> -
>> -	if (blk_mq_sched_bypass_insert(hctx, rq)) {
> 
> Nit: given the super confusing name that blk_mq_sched_bypass_insert() has,
> replacing the above if with:
> 
> 	if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq))
> 
> with the comment above it would make things even more readable I think.

Ignore. Just saw you reworked this in patch 10.

> 
> Otherwise looks good.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> 

