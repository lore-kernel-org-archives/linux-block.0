Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3307AC2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 21:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167F561003
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 21:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFVVRK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 17:17:10 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:54873 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVVRK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 17:17:10 -0400
Received: by mail-pj1-f48.google.com with SMTP id g24so184156pji.4;
        Tue, 22 Jun 2021 14:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZmTMb4a6r17PhoR8r6prvCOE5k8QoYyUfyAk3r0gCEE=;
        b=B7G5KBe3cKV+D8Rcrc14rc5OcPg+0agB0VAMqD5u3zvJS5xt7ewk4H8x2fUXJbIvKK
         MoUgofGN5wjTqrHbACpmHsUfQmm/wkqagnuASCKC+cIlVmUc72CD1LbVzIzfKc7J0DdM
         l31u4q0APbPSCWiYESb0TZNR+ItUVALChhA/J2o6dVQzB0hlrZ9BYgPbmzP3W4JT/g9n
         2sv/rti7lLrBjO8ppfgcgZ2h+71P9q5GGwrJzy/hjwL+GslCANJ83UR7iWlBj9hknlpu
         HpkPXRF0ioN0quDk504InasxxLIKQERzTpsrplrkSUejLKgbSqfVnXnkSriK6kE5c7aJ
         Yqow==
X-Gm-Message-State: AOAM530QjwOWwoG69gRyjr9wQTmJwETxw5L3jDFeYaDqyTB9wxVD1tch
        S/m5jMeJTs1a93FLOqysfRHjC6/ncCA=
X-Google-Smtp-Source: ABdhPJx4KVRtbQ9jKWLbY+oECX55qoyQ7JBCjvI6UdkS6Y5tCUGS6qdlcbnMnIphEcieOo7IO440zg==
X-Received: by 2002:a17:902:d909:b029:11b:870f:ddad with SMTP id c9-20020a170902d909b029011b870fddadmr24418952plz.81.1624396487685;
        Tue, 22 Jun 2021 14:14:47 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id y2sm218190pfa.195.2021.06.22.14.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 14:14:46 -0700 (PDT)
Subject: Re: [PATCH][next] block/mq-deadline: remove redundant assignment of
 variable ret
To:     Colin King <colin.king@canonical.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210622161742.25194-1-colin.king@canonical.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <dce79425-05fb-26a3-2f01-f9893de41513@acm.org>
Date:   Tue, 22 Jun 2021 14:14:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210622161742.25194-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/22/21 9:17 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable ret is being assigned a value at the end of the function
> and the value is never read. The assignment is redundant and can
> be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  block/mq-deadline-main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/mq-deadline-main.c b/block/mq-deadline-main.c
> index 4815e536091f..e3091d922ba2 100644
> --- a/block/mq-deadline-main.c
> +++ b/block/mq-deadline-main.c
> @@ -639,7 +639,6 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
>  	if (ret)
>  		goto free_stats;
>  
> -	ret = 0;
>  	q->elevator = eq;
>  	return 0;

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
