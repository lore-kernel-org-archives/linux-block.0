Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265A6C77B7A
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 01:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjEQBGQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 21:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjEQBGQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 21:06:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA33630D2
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 18:06:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 777CD6407F
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 01:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3128FC433D2;
        Wed, 17 May 2023 01:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684285571;
        bh=N7P2iWnxMu6tm5tQPHNYC+7rdxn6/6IqRsccWYqXPi4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=p9Icv4CTTkBavRabOmFrxIYol/vGTd+LQ9jJLMGGvQ6WIlk2fjzNHKGm8IVgnppQi
         5vKu9BwJ6HDXiIS5HblNObd2JkDoCVbKje/iX+j0CANz1tUCkNaZYh4LwSNrAh3OTM
         XI7UcF+axowgXtR+zfMG026wp1nKA2DwzVkwgTxG75JoslhmXAGW7S4fX4WzUqKXkn
         t+Wb6hVWiTjtIatm0twf8v9OwWfoQPqP8Tsm/4VUw+DBstUSfedSkJQ12lsj+T9dX/
         soZf3VWL/DU7dGUmQEwiAClOFybqXKPM6NgAngKuBwtHIsjIg9zNDb67E2uIHPHJK5
         QrJqCaFdsYWHQ==
Message-ID: <37120c5c-120f-3ff3-fcbf-1a52f389fe3e@kernel.org>
Date:   Wed, 17 May 2023 10:06:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 07/11] block: mq-deadline: Improve
 deadline_skip_seq_writes()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-8-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230516223323.1383342-8-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 07:33, Bart Van Assche wrote:
> Make deadline_skip_seq_writes() do what its name suggests, namely to
> skip sequential writes.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 6276afede9cd..dbc0feca963e 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -308,7 +308,7 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
>  	do {
>  		pos += blk_rq_sectors(rq);
>  		rq = deadline_latter_request(rq);
> -	} while (rq && blk_rq_pos(rq) == pos);
> +	} while (rq && blk_rq_pos(rq) == pos && blk_rq_is_seq_zoned_write(rq));

No ! The "seq write" skip here is to skip writes that are contiguous/sequential
to ensure that we keep issuing contiguous/sequential writes belonging to
different zones, regardless of the target zone type.

So drop this change please.

>  
>  	return rq;
>  }

-- 
Damien Le Moal
Western Digital Research

