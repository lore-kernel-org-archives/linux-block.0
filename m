Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29103C76196
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 08:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjDJIQe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 04:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDJIQd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 04:16:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7C6E6B
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 01:16:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A09F60C7F
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 08:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D048C433EF;
        Mon, 10 Apr 2023 08:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681114591;
        bh=cLaPwBkEWyqytsxJEtY+Ec1mgpfVOkJqH+EWX4gxpuU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NIoH1vrxP/Da85ghGsBSshNY9MGmiMhauM5v9R3twnGrD14TylTNVI+HpoxpIYgVt
         n6I3crJJnQfOJ+4rZVmbfX2MFEQarup3KyNOWFylTqlmiQc+D4wwT/zOWzBOxq07lc
         o0E8sRMTWD8jlRbZhadVBHTQsUi3OK87mA4tPRo+wHYeUePK75KRW48vk/5yjd/KK7
         4KyjKdE2H1HW8YpG8yvpN2+UDt/wpF9LXZ/GYIFswsq4JUSkpdrguyvj1ZD1j5MyEQ
         QCSE+2Pi/0OnaizPEPKPvYUeIN3rgi9zg4xR8bMawg0iQ4GVeT/OmhZFEmRRsC2lfD
         7eTKGDisIjCyg==
Message-ID: <daabaf7e-6672-689c-ecd1-efea0407b6a1@kernel.org>
Date:   Mon, 10 Apr 2023 17:16:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 11/12] block: mq-deadline: Fix a race condition related
 to zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-12-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230407235822.1672286-12-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/23 08:58, Bart Van Assche wrote:
> Let deadline_next_request() only consider the first zoned write per
> zone. This patch fixes a race condition between deadline_next_request()
> and completion of zoned writes.
> 
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c    | 24 +++++++++++++++++++++---
>  include/linux/blk-mq.h |  5 +++++
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 8c2bc9fdcf8c..d49e20d3011d 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -389,12 +389,30 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  	 */
>  	spin_lock_irqsave(&dd->zone_lock, flags);
>  	while (rq) {
> +		unsigned int zno = blk_rq_zone_no(rq);
> +
>  		if (blk_req_can_dispatch_to_zone(rq))
>  			break;
> -		if (blk_queue_nonrot(q))
> -			rq = deadline_latter_request(rq);
> -		else
> +
> +		WARN_ON_ONCE(!blk_queue_is_zoned(q));

I do not think this WARN is useful as blk_req_can_dispatch_to_zone() will always
return true for regular block devices.

> +
> +		if (!blk_queue_nonrot(q)) {
>  			rq = deadline_skip_seq_writes(dd, rq);
> +			if (!rq)
> +				break;
> +			rq = deadline_earlier_request(rq);
> +			if (WARN_ON_ONCE(!rq))
> +				break;

I do not understand why this is needed.

> +		}
> +
> +		/*
> +		 * Skip all other write requests for the zone with zone number
> +		 * 'zno'. This prevents that this function selects a zoned write
> +		 * that is not the first write for a given zone.
> +		 */
> +		while ((rq = deadline_latter_request(rq)) &&
> +		       blk_rq_zone_no(rq) == zno)
> +			;
>  	}
>  	spin_unlock_irqrestore(&dd->zone_lock, flags);
>  
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index e62feb17af96..515dfd04d736 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -1193,6 +1193,11 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
>  	return !blk_req_zone_is_write_locked(rq);
>  }
>  #else /* CONFIG_BLK_DEV_ZONED */
> +static inline unsigned int blk_rq_zone_no(struct request *rq)
> +{
> +	return 0;
> +}
> +
>  static inline bool blk_req_needs_zone_write_lock(struct request *rq)
>  {
>  	return false;

