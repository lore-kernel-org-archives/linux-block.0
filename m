Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3942BC4338F
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 15:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E30A610FC
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 15:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhHBP4Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:56:25 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:40485 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbhHBP4Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 11:56:25 -0400
Received: by mail-pl1-f177.google.com with SMTP id c16so20114875plh.7
        for <linux-block@vger.kernel.org>; Mon, 02 Aug 2021 08:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m6qmj4cBtihHb9sKfIwEYy6Zy6qZpeSk2ratIaygsTA=;
        b=CvCv9AHnWn0P198yiFI/WAQNcldDZlhz7Q6pFLvA62dtMqXdScx/1zq9VXNQBndjUP
         6vnBc0DXBFNJEmj2O0JJIGOssaJKWntggFUstR4xvoGFikINpq5XoliQReTIZzaQvuV+
         2oB0q8UjVEy89N+iI3l0o5IJeLyfvJA8h4YEVQKFqppi2RjHBqGmGHpe5JooOK0DPf4r
         WDxcZ6qQrjTw+z0oWxnGLUrqxNcPdLganhg3ohAn1f7Hm9I5Da7SxNvl1McyB67wLSfM
         pRfetLa2yW4rl4PxYAWTqoMs/GHJjMtHxN1UDSs3rwmrweKov0tMpGtQmgkX5HjIki7E
         K4+w==
X-Gm-Message-State: AOAM530YSdeWC6OF6vS+pZS5CuYnWsaxQt+EApWAb3YVc4xg8UPoGrCh
        KatVtfxB3ABsDfLYCuVCNQU=
X-Google-Smtp-Source: ABdhPJz2x7lytch1cpcGqsGngOumwfOolevEEtPFtnv2Nx/abFu+m/x0HUtnYSpXcmNF05RWclJM8w==
X-Received: by 2002:a17:90a:a108:: with SMTP id s8mr2829050pjp.166.1627919774758;
        Mon, 02 Aug 2021 08:56:14 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:1687:85fe:8bf4:9fb9])
        by smtp.gmail.com with ESMTPSA id s19sm11827288pfe.206.2021.08.02.08.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 08:56:14 -0700 (PDT)
Subject: Re: [PATCH 3/3] block: rename IOPRIO_BE_NR
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
References: <20210802092157.1260445-1-damien.lemoal@wdc.com>
 <20210802092157.1260445-4-damien.lemoal@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3a204840-d398-18da-7444-a7f0c2fb1ab2@acm.org>
Date:   Mon, 2 Aug 2021 08:56:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210802092157.1260445-4-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/2/21 2:21 AM, Damien Le Moal wrote:
>   /*
> - * 8 best effort priority levels are supported
> + * The RT an BE priority classes support up to 8 priority levels.
>    */
> -#define IOPRIO_BE_NR	(8)
> +#define IOPRIO_NR_LEVELS	(8)

Is this kind of change acceptable in a UAPI header? Can this change 
break the build of user space applications?

If this change is acceptable, how about the name IOPRIO_NR_BE_LEVELS? 
Additionally, please leave out the parentheses since these are not 
necessary.

Thanks,

Bart.
