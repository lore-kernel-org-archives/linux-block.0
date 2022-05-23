Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EF5C433EF
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 14:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbiEWOMz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 10:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236821AbiEWOMx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 10:12:53 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DE226541
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 07:12:47 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 14so6710749qkl.6
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 07:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D9PaxQgh0dgGWTqhmUPSOfrq/Hw+1kY6VaKwgcNAm/M=;
        b=fFXpBoD84sQ7AF2ZfHFijFUDydy/a0AwqnA2dCvm8Mj/8UQianCRe4XVRsoBfQuG2D
         ICxF4JAgz7ViGJ1oKYxAZkstk3z9csDWHCrN7zFaS2fe9Nyge/XTh6UJfs5XmHLA8Ix/
         VyqAeQnm7o5wH93bsuJtKiwbDYH+OfkHSdKBFtS18g3I2W7vHeUt3GKHMAh85K/+gY+t
         O/KB58s6E5wWXEiOCrjIEWgi5j8SBvckaZZmAOx+JsBvzs5EklxxaITJJBn2axzY2cON
         D5V/uKFrC1Cmug3j/8WqLbad+hB3tBNaOlCyKQ+DurNVcTrJLVGhktLtikOuIWgXXn1D
         0Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D9PaxQgh0dgGWTqhmUPSOfrq/Hw+1kY6VaKwgcNAm/M=;
        b=FtsJFLh/i7N7YdTbgcARjbMb37wJL4T25ZyhbNoLxn4nMtcv3+JZKwUOeVCxZOvW9O
         ag/rhCvQVIpuBxgS3gPODHn+X+JtWpt4+5slmenQ0BG/ImFvRZFDvK1RocB1ee301TMg
         2KpzccM9a28zJupxEjZtY86msujAZZO5kPyrDmrzLRqJ0ClyAh5+NHKWo2OuKfnTIoU1
         Soz9z15WFxJ9rjhX12PR59yz/0gDKTJRCGILcvjir9kjuNpPO53WG/NyACfbUAPMdLz6
         oFtzTNPzL7t5TrTr09iRWV344rdxb1wdGQBQVi67G8RQZqw9Ps4zQmQU2KDJdi4uPDUL
         Wd7A==
X-Gm-Message-State: AOAM533sX+h+zD7YfFJ+oUdtMyyjHkgpusDS61RFtQsEfEEwed+B6fK8
        OSGzSwx93y+OAN+I6LMboIxQUA==
X-Google-Smtp-Source: ABdhPJya52lpcsbBSkKIaQkTMnZzwxjA4yWpPSm4Nqk0vkxh0Nl49AOOILI0+gCK/4A+BtBJMJq0hQ==
X-Received: by 2002:a37:d245:0:b0:69b:f153:9c38 with SMTP id f66-20020a37d245000000b0069bf1539c38mr13876045qkj.692.1653315166256;
        Mon, 23 May 2022 07:12:46 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u2-20020a05620a120200b0069fc13ce206sm4289849qkj.55.2022.05.23.07.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:12:45 -0700 (PDT)
Date:   Mon, 23 May 2022 10:12:44 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v3 3/6] nbd: don't clear 'NBD_CMD_INFLIGHT' flag if
 request is not completed
Message-ID: <YouWXEcyoBNUXLb7@localhost.localdomain>
References: <20220521073749.3146892-1-yukuai3@huawei.com>
 <20220521073749.3146892-4-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521073749.3146892-4-yukuai3@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 21, 2022 at 03:37:46PM +0800, Yu Kuai wrote:
> Otherwise io will hung because request will only be completed if the
> cmd has the flag 'NBD_CMD_INFLIGHT'.
> 
> Fixes: 07175cb1baf4 ("nbd: make sure request completion won't concurrent")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/block/nbd.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 2ee1e376d5c4..a0d0910dae2a 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -403,13 +403,14 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>  	if (!mutex_trylock(&cmd->lock))
>  		return BLK_EH_RESET_TIMER;
>  
> -	if (!__test_and_clear_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
> +	if (!test_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
>  		mutex_unlock(&cmd->lock);
>  		return BLK_EH_DONE;
>  	}
>  
>  	if (!refcount_inc_not_zero(&nbd->config_refs)) {
>  		cmd->status = BLK_STS_TIMEOUT;
> +		__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
>  		mutex_unlock(&cmd->lock);
>  		goto done;
>  	}
> @@ -478,6 +479,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>  	dev_err_ratelimited(nbd_to_dev(nbd), "Connection timed out\n");
>  	set_bit(NBD_RT_TIMEDOUT, &config->runtime_flags);
>  	cmd->status = BLK_STS_IOERR;
> +	__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
>  	mutex_unlock(&cmd->lock);
>  	sock_shutdown(nbd);
>  	nbd_config_put(nbd);
> @@ -745,7 +747,7 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
>  	cmd = blk_mq_rq_to_pdu(req);
>  
>  	mutex_lock(&cmd->lock);
> -	if (!__test_and_clear_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
> +	if (!test_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
>  		dev_err(disk_to_dev(nbd->disk), "Suspicious reply %d (status %u flags %lu)",
>  			tag, cmd->status, cmd->flags);
>  		ret = -ENOENT;
> @@ -854,8 +856,16 @@ static void recv_work(struct work_struct *work)
>  		}
>  
>  		rq = blk_mq_rq_from_pdu(cmd);
> -		if (likely(!blk_should_fake_timeout(rq->q)))
> -			blk_mq_complete_request(rq);
> +		if (likely(!blk_should_fake_timeout(rq->q))) {
> +			bool complete;
> +
> +			mutex_lock(&cmd->lock);
> +			complete = __test_and_clear_bit(NBD_CMD_INFLIGHT,
> +							&cmd->flags);
> +			mutex_unlock(&cmd->lock);
> +			if (complete)
> +				blk_mq_complete_request(rq);
> +		}

I'd rather this be handled in nbd_handle_reply.  We should return with it
cleared if it's ready to be completed.  Thanks,

Josef
