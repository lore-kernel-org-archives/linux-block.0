Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81F8C76196
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 08:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjDJIcG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 04:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDJIcF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 04:32:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0963590
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 01:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 582EB60C79
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 08:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC78C433EF;
        Mon, 10 Apr 2023 08:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681115523;
        bh=xBtT4/1xl+qKxf8uW/CUqlnGlEx4FJ7gvtU7C0AOYD0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NTzL09n3T6X4/7sZ01n9QXonuhOXlMBn1+3F0H5aZMVow837vV4Ll9i3mBK2szv/4
         9D1oFNENQUR9JGzHavyrzZ35ueQeDKcUc7/istFn3ANrmoc/kmLBHFZQkOzJ2Ap5ys
         qrMjIHq8gHHdmLjh1TCxNWjW/9U+uDixR0sAptDa2QfI6+eCpxV9+cOx6GCvxHTxn+
         T3LFVCRVkFvQRd3BByKazHuYwZ2T+I1IrTBO93HM2jxJmcQB9L9Gebpa5d2V/Zp8L2
         lueh/tNRoNFTD3YNajVJTaQPt0DbK3bMvAHibil6KRMfACgWIP3+JOmU2mzIAGx7XN
         0g98d3il1zY+Q==
Message-ID: <c9b29094-50f9-3dac-647e-b7b5b7cc729d@kernel.org>
Date:   Mon, 10 Apr 2023 17:32:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 12/12] block: mq-deadline: Handle requeued requests
 correctly
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-13-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230407235822.1672286-13-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/23 08:58, Bart Van Assche wrote:
> If a zoned write is requeued with an LBA that is lower than already
> inserted zoned writes, make sure that it is submitted first.
> 
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index d49e20d3011d..c536b499a60f 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -162,8 +162,19 @@ static void
>  deadline_add_rq_rb(struct dd_per_prio *per_prio, struct request *rq)
>  {
>  	struct rb_root *root = deadline_rb_root(per_prio, rq);
> +	struct request **next_rq = &per_prio->next_rq[rq_data_dir(rq)];
>  
>  	elv_rb_add(root, rq);
> +	if (*next_rq == NULL || !blk_queue_is_zoned(rq->q))
> +		return;

A blank line here would be nice.

> +	/*
> +	 * If a request got requeued or requests have been submitted out of
> +	 * order, make sure that per zone the request with the lowest LBA is

Requests being submitted out of order would be a bug in the issuer code. So I
would not even mention this here and focus on explaining that requeue may cause
seeing inserts outs of order.

> +	 * submitted first.
> +	 */
> +	if (blk_rq_pos(rq) < blk_rq_pos(*next_rq) &&
> +	    blk_rq_zone_no(rq) == blk_rq_zone_no(*next_rq))
> +		*next_rq = rq;
>  }
>  
>  static inline void
> @@ -822,6 +833,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  		list_add(&rq->queuelist, &per_prio->dispatch);
>  		rq->fifo_time = jiffies;
>  	} else {
> +		struct list_head *insert_before;
> +
>  		deadline_add_rq_rb(per_prio, rq);
>  
>  		if (rq_mergeable(rq)) {
> @@ -834,7 +847,18 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  		 * set expire time and add to fifo list
>  		 */
>  		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
> -		list_add_tail(&rq->queuelist, &per_prio->fifo_list[data_dir]);
> +		insert_before = &per_prio->fifo_list[data_dir];
> +		if (blk_rq_is_seq_zoned_write(rq)) {
> +			const unsigned int zno = blk_rq_zone_no(rq);
> +			struct request *rq2 = rq;
> +
> +			while ((rq2 = deadline_earlier_request(rq2)) &&
> +			       blk_rq_zone_no(rq2) == zno &&
> +			       blk_rq_pos(rq2) > blk_rq_pos(rq)) {
> +				insert_before = &rq2->queuelist;
> +			}
> +		}
> +		list_add_tail(&rq->queuelist, insert_before);

This seems incorrect: the fifo list is ordered in arrival time, so always
queuing at the tail is the right thing to do. What I think you want to do here
is when we choose the next request to be the oldest (to implement aging), you
want to get the first request for the target zone of that oldest request. But
why do that on insert ? This should be in the dispatch code, coded in
deadline_fifo_request(), no ?

