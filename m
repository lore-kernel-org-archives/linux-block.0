Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08D6C77B7F
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 01:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjEQBCJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 21:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjEQBCI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 21:02:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB31F468E
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 18:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47FD463F26
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 01:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D019CC433D2;
        Wed, 17 May 2023 01:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684285325;
        bh=uNiUG5vP/abjOPjcLwuLPZPCLk6KK034wz1288VEAaE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D0CD/EwdBa9WluPye++LmtN68hvEAcg6+h+ofES3y2b9dsptqUI8SQJC2KRavn648
         hVdgSvC8fYo5UrDbOA4+9i/0zJBzdrL0Mf0/ZjnRowOjHGzIVC6oMLA2jYcSuo7FDX
         12U76Qq4ky0xNxxaPHhYM4/ObZo8bXrqkXE68swRX2algL1tUGa/6PjEk5RWbuRqgI
         Go4oGrnpb2nXPeCKFRMdiAkq9M1fwa3M7217ixEj2E8jAiJOQj0tx0UgXudn0Et/Tm
         l6cmneV0boRa2mwMWeu3BjQ55cpFeCuOD9A4ptXPZXnKhSSBOE0xXN5dE6nDit3Ynu
         8tg8Kbju4+GUg==
Message-ID: <c46b14b0-56e3-ace9-91f7-15434ae93c2e@kernel.org>
Date:   Wed, 17 May 2023 10:02:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 05/11] block: mq-deadline: Clean up
 deadline_check_fifo()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-6-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230516223323.1383342-6-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 07:33, Bart Van Assche wrote:
> Change the return type of deadline_check_fifo() from 'int' into 'bool'.
> Use time_is_before_eq_jiffies() instead of time_after_eq(). No
> functionality has been changed.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 5839a027e0f0..a016cafa54b3 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -272,21 +272,15 @@ static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
>  }
>  
>  /*
> - * deadline_check_fifo returns 0 if there are no expired requests on the fifo,
> - * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
> + * deadline_check_fifo returns true if and only if there are expired requests
> + * in the FIFO list. Requires !list_empty(&dd->fifo_list[data_dir]).
>   */
> -static inline int deadline_check_fifo(struct dd_per_prio *per_prio,
> -				      enum dd_data_dir data_dir)
> +static inline bool deadline_check_fifo(struct dd_per_prio *per_prio,
> +				       enum dd_data_dir data_dir)
>  {
>  	struct request *rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
>  
> -	/*
> -	 * rq is expired!
> -	 */
> -	if (time_after_eq(jiffies, (unsigned long)rq->fifo_time))
> -		return 1;
> -
> -	return 0;
> +	return time_is_before_eq_jiffies((unsigned long)rq->fifo_time);

This looks wrong: isn't this reversing the return value ?
Shouldn't this be:

	return time_after_eq(jiffies, (unsigned long)rq->fifo_time));

To return true if the first request in fifo list *expired* as indicated by the
function kdoc comment.

>  }
>  
>  /*

-- 
Damien Le Moal
Western Digital Research

