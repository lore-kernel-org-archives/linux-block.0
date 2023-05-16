Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C94C77B75
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 23:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjEPXVt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 19:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEPXVt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 19:21:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0D6137
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 16:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1F92639CB
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 23:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0910C433EF;
        Tue, 16 May 2023 23:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684279307;
        bh=RB09KM+3KpN4oj7sv9zsnMBe6pZ1mk1LFxqnJ5AHMCQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GqautldgBZOQdaSWdDmLEHey7TGpHmlnWgbiztbw5QHBIwSE8zsaUVZsFsH7i35gu
         oNcmTbpWuui+IMOFIqlBUoj1IeOQE3wZKx9+EuL1JD8ltJug5q0ghfnUtgoEaTcqJ8
         GKNrxRjKrFl519toOx5sHaEUdKmAXaYVUm+xFw6PiCrZ5U/E5ISSj2kYeL1DuPDOk+
         Q/Et0zI8QCiPj78TLUpaUIHKth5QA3X3DQBXrKSZ1O/jWtREjwU82+I9Ttw37V4U00
         Hg4nN63FEjawbI0Na/KAt45FnURfypC3UwO2dxgJ0vX29uXoDoF2w6GJa6ybXIoQ1E
         URoKg/DLJBS8w==
Message-ID: <97f5788d-c1ec-c9d5-9668-64ccac1b3d35@kernel.org>
Date:   Wed, 17 May 2023 08:21:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] block: Decode all flag names in the debugfs output
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230516173426.798414-1-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230516173426.798414-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 02:34, Bart Van Assche wrote:
> See also:
> * Commit 4d337cebcb1c ("blk-mq: avoid to touch q->elevator without any protection").
> * Commit 414dd48e882c ("blk-mq: add tagset quiesce interface").
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq-debugfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index d23a8554ec4a..a0fd20b64a46 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -103,6 +103,8 @@ static const char *const blk_queue_flag_name[] = {
>  	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
>  	QUEUE_FLAG_NAME(HCTX_ACTIVE),
>  	QUEUE_FLAG_NAME(NOWAIT),
> +	QUEUE_FLAG_NAME(SQ_SCHED),
> +	QUEUE_FLAG_NAME(SKIP_TAGSET_QUIESCE),
>  };
>  #undef QUEUE_FLAG_NAME
>  

Looks like QUEUE_FLAG_SYNCHRONOUS is also missing.

-- 
Damien Le Moal
Western Digital Research

