Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952D1C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 20:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EC67613CD
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 20:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbhDFVAF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 17:00:05 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:52883 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbhDFVAF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 17:00:05 -0400
Received: by mail-pj1-f42.google.com with SMTP id ha17so8609584pjb.2;
        Tue, 06 Apr 2021 13:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7wKjwrhzmSjHeWrVpnAkOBQbEzRdyrR2aeIGgS+FkyI=;
        b=eV408VgBZnTVhpPUIyxQm+oFz8d6ctyuqz7K/bKPPw0dTq0CAdogIhSmghNB4z7/HS
         yVy4nnc1Sqk1vuG4eAhp4mFlLQQZmPppNF4aAIOCl2gsQk5PZY+rx4HzTP/jWMueDYkf
         JI1KlVJug60xK2IRQqNRvOQm4UOnHYAzUZTtzZXdlG2cFAhrZtk1EMUG8jRl6c35er1V
         dXVkv72UggKqfvwaZTnvv/c+ozG+77W3dilTAKFB0WFo2sDuK53P61NQVA5Np3D5a7TM
         bbR2J2R4rTZ1rTPcodC5clC5/Gr1dTQt5tcJN4iG4oALmtzN8CRNFoisW7iglzQuwDQA
         XZgQ==
X-Gm-Message-State: AOAM532AW83X4ycJi2+UmFsulH1A6xsvkjyPNnbYdYStVtrgY/WbVzIA
        8DwrdsvEzlrywVdJPw6grlChr9ZCfYM=
X-Google-Smtp-Source: ABdhPJzX+L5MUlwlM2fcWX43GSWtqhKISbMGLSnKxG3ZwnzwSNtpytB/x2YU8GRglpyIQ6Cyb5FvQg==
X-Received: by 2002:a17:902:9886:b029:e6:2bc6:b74 with SMTP id s6-20020a1709029886b02900e62bc60b74mr121136plp.13.1617742796452;
        Tue, 06 Apr 2021 13:59:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:277d:764e:de23:a2e8? ([2601:647:4000:d7:277d:764e:de23:a2e8])
        by smtp.gmail.com with ESMTPSA id r10sm3375183pjf.5.2021.04.06.13.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 13:59:55 -0700 (PDT)
Subject: Re: [PATCH 01/11] block: rsxx: core: Remove superfluous const
 qualifier
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20210312105530.2219008-1-lee.jones@linaro.org>
 <20210312105530.2219008-2-lee.jones@linaro.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8245074f-18ea-5cf6-6976-5246aea361ca@acm.org>
Date:   Tue, 6 Apr 2021 13:59:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210312105530.2219008-2-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/12/21 2:55 AM, Lee Jones wrote:
> This function returns a const string.
> 
> The second const qualifier is not required.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/block/rsxx/core.c:395:8: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
> 
> Cc: Joshua Morris <josh.h.morris@us.ibm.com>
> Cc: Philip Kelleher <pjk1939@linux.ibm.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/block/rsxx/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
> index 5ac1881396afb..813b0a554d4a8 100644
> --- a/drivers/block/rsxx/core.c
> +++ b/drivers/block/rsxx/core.c
> @@ -392,7 +392,7 @@ static irqreturn_t rsxx_isr(int irq, void *pdata)
>  }
>  
>  /*----------------- Card Event Handler -------------------*/
> -static const char * const rsxx_card_state_to_str(unsigned int state)
> +static const char *rsxx_card_state_to_str(unsigned int state)
>  {
>  	static const char * const state_strings[] = {
>  		"Unknown", "Shutdown", "Starting", "Formatting",

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
