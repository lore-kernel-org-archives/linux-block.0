Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF30AC433FF
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 18:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CC321743
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 18:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfHHSKU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:10:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35833 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfHHSKU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 14:10:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id n4so2734728pgv.2
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2019 11:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GMszoUHvE3RfgvRojrspRnIflchBJiyANieVIVfNDJY=;
        b=ngt9oRKbgOd46hhGQXwdlvyLvjVndydQgmTSDGfbB10tR/X8TtcAoh+Y+fUBKDe+74
         P05qK7cdF6W8KYR/h+1D867U2xSmoSFE5Pb5bhymcYdmLkfEXgjbmHemixKKcd3lkY5q
         5ChV56VJjAVqJlNxldZ2IavljxLI957/Rd447L9H89Ct0Eyvvl84JQS77egP4BQSd3i1
         c7R8WqMMY2jACsXU8Dc/1W+KFTA69CLdJ1z4k+PRO1flqA8oVA0jYazuQrz7sYlSSS5Z
         7uSy3H93QD94GkAcZxEjJvPHe68YnI96mWkbq7sit3E8dRzrklJGf2XnDF+y7z/h25q4
         YdVw==
X-Gm-Message-State: APjAAAUxrtltyvPnLogyMEGBYJtjRikxEf2aH8UEDyBxizBnhvX5LZkN
        yPJUpespkDsm+5AA0fdDqWQ=
X-Google-Smtp-Source: APXvYqzrLEWrAaNirN8y5v9Kyxdq1Am9igRidd43ZKZinBy9kaf9VQ5lORYyb+6zkUbEkDpXz+YqoA==
X-Received: by 2002:a63:f941:: with SMTP id q1mr13917719pgk.350.1565287819783;
        Thu, 08 Aug 2019 11:10:19 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:fb9c:664d:d2ad:c9b5? ([2620:15c:2c1:200:fb9c:664d:d2ad:c9b5])
        by smtp.gmail.com with ESMTPSA id 131sm25303518pge.37.2019.08.08.11.10.18
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 11:10:18 -0700 (PDT)
Subject: Re: [PATCH] block: only set DYING flag once in blk_cleanup_queue()
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>
References: <20190808020610.23121-1-dmitry.fomichev@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <31f9a707-1c60-6166-d001-21a413c66842@acm.org>
Date:   Thu, 8 Aug 2019 11:10:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808020610.23121-1-dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/7/19 7:06 PM, Dmitry Fomichev wrote:
> This commit removes the statement in blk_cleanup_queue() function that
> marks the queue as dying. QUEUE_FLAG_DYING is already set inside
> blk_set_queue_dying() a few lines above, no need to do it again.
> 
> No functional change.
> 
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  block/blk-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d0cc6e14d2f0..0822acc423a3 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -339,7 +339,6 @@ void blk_cleanup_queue(struct request_queue *q)
>  
>  	blk_queue_flag_set(QUEUE_FLAG_NOMERGES, q);
>  	blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
> -	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
>  	mutex_unlock(&q->sysfs_lock);

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

