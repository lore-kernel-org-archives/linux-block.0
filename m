Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E65C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 12:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350512AbiCPMVh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 08:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348295AbiCPMVg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 08:21:36 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3651963BC6
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 05:20:22 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id rm8-20020a17090b3ec800b001c55791fdb1so2241069pjb.1
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 05:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0WrTBFJC/dMUKRSv7OKWrVPgV64mCLt3BuJALhPnr6k=;
        b=DdtXZK75HlwNOl7rpcVVME3PZRoccpu0/nNUZQF6j+Fi3V1BSvZyVKbiyDYjCCG4Dr
         iIY4mbs9K28iJLpopXHxMX/Np8ilu/BXHKTDhFrxzrpM6ClOWNNRtBS8lJGTEbZWfaqT
         GM9fPNrfaO5owv05vewsrsusHtAI549ycNY/Ku8cnIB4mUrDRSQ9TyXYTOdPmwAZEQ6B
         /UDXpO/eX3EroetHdAlBq1IwE7QbUIFF148KfYBIL+fTTsL3TZ4PgFLNkVptAcvC9jWo
         Jhk5MIzUU6pSqmOPD4sTeR9P0YtkkBXoYne8SqaLbM8WAGyYpSjQ+TCm9PtePNUn944/
         oVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0WrTBFJC/dMUKRSv7OKWrVPgV64mCLt3BuJALhPnr6k=;
        b=P1RZEMrcvGvpGq44gPCcImjrvnzlecATlB7pVUK8RDcta2Sssz85LEGHpOCTpImjqA
         KZaBwj/f1JI7x0l92dRjRngOx8OuLBP6XpyGxwxdImM2QYoQbPuZfkwMYwbeetDnCjbN
         38DO0UNDQu3vxEg9HHwSsgsetZ6AQc6nw/dO2TJFMWMcXNIFahWDnvmflytZBUC5SSmz
         3d8SJvKfsWk90ys1d97TGosrlKNK2OHKFKuLT4u3+Qtt2iRt/Rc+hbInOCwnoLmbqzA0
         S8NMybsK8C0D/54VM+c4E7OaMvc1drEc2vElSwSYfrIGdtV2I8XOzK4vw4bwZ0J7uwIY
         6BoQ==
X-Gm-Message-State: AOAM53265B0bjg3UF5SKX1SRWyoYsfn9fGVFQtzQ85kFDvsdwakFXHqq
        9xiNFFjuwDwpiPpQaQW3jrr1FQ==
X-Google-Smtp-Source: ABdhPJxc88+Xrl6yZHYorenH/CMNT1ECySsgwwh+c/CtPEGNW5+VYgoYSHGgLMAbwClK29YKbqM46w==
X-Received: by 2002:a17:903:230f:b0:151:e465:1877 with SMTP id d15-20020a170903230f00b00151e4651877mr33373264plh.19.1647433221557;
        Wed, 16 Mar 2022 05:20:21 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f756b6c315sm3061018pfo.66.2022.03.16.05.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 05:20:21 -0700 (PDT)
Message-ID: <59f724e7-1b42-b2fd-7d32-264cec939810@kernel.dk>
Date:   Wed, 16 Mar 2022 06:20:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] block: limit request dispatch loop duration
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220316061134.3812309-1-shinichiro.kawasaki@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220316061134.3812309-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/16/22 12:11 AM, Shin'ichiro Kawasaki wrote:
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 55488ba97823..64941615befc 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -181,9 +181,15 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  {
>  	int ret;
> +	unsigned long end = jiffies + HZ;
>  
>  	do {
>  		ret = __blk_mq_do_dispatch_sched(hctx);
> +		if (ret == 1 &&
> +		    (need_resched() || time_is_after_jiffies(end))) {
> +			blk_mq_delay_run_hw_queue(hctx, 0);
> +			break;
> +		}
>  	} while (ret == 1);
>  
>  	return ret;

I think it'd look cleaner as:

static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
{
	unsigned long end = jiffies + HZ;
	int ret;

	do {
		ret = __blk_mq_do_dispatch_sched(hctx);
		if (ret != 1)
			break;
		if (need_resched() || time_is_after_jiffies(end)) {
			blk_mq_delay_run_hw_queue(hctx, 0);
			break;
		}
	} while (1);

	return ret;
}

-- 
Jens Axboe

