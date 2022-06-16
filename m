Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801F9C433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 20:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiFPUlr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378350AbiFPUlr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 16:41:47 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACEF5E76B
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 13:41:46 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y12so2651754ior.7
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 13:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1gFzSolO1z+U4ztQI3/Yj4TytkxM+Hdk4t0mHz3B1jg=;
        b=63RZzWYfwQhEmpDBGI/EsWMXsapNlGlwVq5bkgIUilYF2kfk7psyERdtDPtjONGzeV
         7W0Y5ct+kR1FZCaLTTTSebAzdRqjVPVNEI32mHwj2OBXK/mnzLthke1SeRlxtg9ERRze
         i0soEKZiPhq3t9OS1v772HwsSsFQ5x3NgXOVj+iUlKAjQrbb9tDfye43QG5dhiTjbn1y
         WZgD9kXUkJ3l3rZRQ4ENoKnDZvvWpsPVpSr9q2oop+eblmq8KggpcekyrG54Lrqv69Q9
         q/yQsZwyuV3c1VdjPd/OhvobWLoK8ZZbgk86IY2tnMqe+b5hiBxk/3+qY2lJI63PUNbL
         zcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1gFzSolO1z+U4ztQI3/Yj4TytkxM+Hdk4t0mHz3B1jg=;
        b=a6JSFgB3+1ZN3xpAT2zp2mVdEXFJxYyN6cV9sWUKr0BI9gwJKLsF23c5OD4tyC2tJB
         1X2nZNd3gtlRaL5xJoZtxdu1Ux0y8HWlBeivTCM47uwLS3CwUunDRvQ4C6qWrQpssA7M
         N2dp4p/tDjEb/hwa/gqk23D3qTAup0FDT1meOveQapnP9x2G2wcjEcPcAnpsbZtf8UHs
         arn8OrDbQWJmWQlTwOcsprn3Vn+zGcn0apRKs8fVAcovCMTRC8nWxKbvHCYNKCM1tc5B
         Tp6XyISYwC/KD7vdqc19x7zi04i7yU+jXnMtFAY1iULkR2bPJWQHO3wuFIBFa2LNn7Vf
         iotg==
X-Gm-Message-State: AJIora9HCMxfT/Jw8kHqjm+9TyXWKNVQL41wCDAKEmvoKo4xJlP1/cMR
        hhEpm6W7Xn4av0UH8Yrf4bE30w==
X-Google-Smtp-Source: AGRyM1sQkG9D3RTv3whmiMj71xvE4b1KY/brXamlkYJr/l/D+aUEBs6uMRurOmvZK/zQgUltSIt8NA==
X-Received: by 2002:a6b:3115:0:b0:660:d5f1:e3b6 with SMTP id j21-20020a6b3115000000b00660d5f1e3b6mr3416950ioa.99.1655412105833;
        Thu, 16 Jun 2022 13:41:45 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e41-20020a02862c000000b0032e21876ea8sm1307920jai.72.2022.06.16.13.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 13:41:45 -0700 (PDT)
Message-ID: <96fa5291-a945-c745-2ee9-e453d85c1bee@kernel.dk>
Date:   Thu, 16 Jun 2022 14:41:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/5] block: Introduce the blk_rq_is_seq_write() function
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220614174943.611369-1-bvanassche@acm.org>
 <20220614174943.611369-2-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220614174943.611369-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/22 11:49 AM, Bart Van Assche wrote:
> Introduce a function that makes it easy to verify whether a write
> request is for a sequential write required or sequential write preferred
> zone.
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/blk-mq.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index e2d9daf7e8dd..3e7feb48105f 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -1129,6 +1129,15 @@ static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
>  	return blk_queue_zone_is_seq(rq->q, blk_rq_pos(rq));
>  }
>  
> +/**
> + * blk_rq_is_seq_write() - Whether @rq is a write request for a sequential zone.
> + * @rq: Request to examine.
> + */
> +static inline bool blk_rq_is_seq_write(struct request *rq)
> +{
> +	return req_op(rq) == REQ_OP_WRITE && blk_rq_zone_is_seq(rq);
> +}

This should include something telling us it's a zone thing, because it
sounds generic. blk_rq_is_zoned_seq_write()?


-- 
Jens Axboe

