Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CCBC77B61
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 21:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjDPVBh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 17:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPVBg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 17:01:36 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130CA213D
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 14:01:33 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2468495aad8so765509a91.3
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 14:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681678892; x=1684270892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSP5MVe3VNdHIMCcgHVO4AZxWApzjuhLVczGzPcTOSY=;
        b=VXGetOSAgYFJoGdifPFe9a/MwIzyS/Ea6Fffr/aV0r4LPNP2Nm2iVl3yQbyk1Zqphb
         KQD+J/uxvZ7xEbLgdmZbbciJ/386uSyeW2l2PTdfW4VMRS3yu0y+Y2mutkc1M9wU8dMz
         YDp50pu9uqLhw6vTqOsMVELldv35GE1lneOl9DYvwfdK85VfyJcS7TB4dD4Qhzbv+A/+
         krBaqnu8R8L+xq2jX1p0YjGR7DXTEAS7Q74dUaGP1PdVuhEV0lLwzctPbZu0MTuD/A4h
         b3+5amPLS9m7/JDCGowa3Y1i32uavCar4p/HiEreqEnuSbcsjy0zFD6FLclxCw0GIzvV
         xqAA==
X-Gm-Message-State: AAQBX9fHRh25kedBSosijG+Q3b59oWf5dkbnU7h0RTAlNYfNMkbtCTKS
        H6aWQ8x+9CUTdQJHvks4X+x+RaX0SSs=
X-Google-Smtp-Source: AKy350ZvEaNKfYa9D5l+SrZV5UC84uqnumcKNugdAjyS8gFz/ai4+uJ/93HVFtAl/RJKy4ah4q3kMg==
X-Received: by 2002:a05:6a00:1306:b0:63b:435f:134a with SMTP id j6-20020a056a00130600b0063b435f134amr16819659pfu.28.1681678892243;
        Sun, 16 Apr 2023 14:01:32 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id h17-20020aa786d1000000b0063d238c2e95sm237414pfo.91.2023.04.16.14.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 14:01:31 -0700 (PDT)
Message-ID: <ac7547c1-214a-7919-a95c-7bf8bc186e48@acm.org>
Date:   Sun, 16 Apr 2023 14:01:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 7/7] blk-mq: don't use the requeue list to queue flush
 commands
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20230416200930.29542-1-hch@lst.de>
 <20230416200930.29542-8-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230416200930.29542-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/23 13:09, Christoph Hellwig wrote:
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 69e9806f575455..231d3780e74ad1 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -188,7 +188,9 @@ static void blk_flush_complete_seq(struct request *rq,
>   
>   	case REQ_FSEQ_DATA:
>   		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
> -		blk_mq_add_to_requeue_list(rq, 0);
> +		spin_lock(&q->requeue_lock);
> +		list_add_tail(&rq->queuelist, &q->flush_list);
> +		spin_unlock(&q->requeue_lock);
>   		blk_mq_kick_requeue_list(q);
>   		break;

At least the SCSI core can call blk_flush_complete_seq() from interrupt 
context so I don't think the above code is correct. The call chain is as 
follows:

LLD interrupt handler
   scsi_done()
     scsi_done_internal()
       blk_mq_complete_request()
         scsi_complete()
           scsi_finish_command()
             scsi_io_completion()
               scsi_end_request()
                 __blk_mq_end_request()
                   flush_end_io()
                     blk_flush_complete_seq()

Bart.
