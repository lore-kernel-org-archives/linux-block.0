Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE9DC433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 12:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B640611AB
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 12:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbhDPM3e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 08:29:34 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]:45592 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbhDPM3c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 08:29:32 -0400
Received: by mail-qv1-f46.google.com with SMTP id bs7so12798320qvb.12;
        Fri, 16 Apr 2021 05:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jk36eYtLMeyJSNx9XAqpGadjjqtLtgy4AzBa+/tMpFM=;
        b=Zpe5v4E7EYU6air29l/BM29JKksJFfh9vfHwspuoGq6W00a+jorMUNp+g3IYImlBGO
         UN+76APSHYkP/ZnHU8HgpC1J1ERCixQIRheqfRivSj0R1u1R8/IGOdZTQ/nc5qYfvKKg
         Gfg4y7Xq/KSE/CYvrPDjbYP4h2J99MkjBpdjSwbu4gNAPSRvRJVW06LDQbcI58yyEiAt
         PnMhwOihj3V68SseXC3iQVzCBOnHCMd7u98UKa9ikwWmmJLNoeEYiWRG62tVnOHjJcu/
         cZJnDJhqEDB1Fv1exuhvKnsg067dStoHothZ3pEdRH7vS6n0mKy63hKIV2sPEmfzZQ9M
         aowA==
X-Gm-Message-State: AOAM531T1+hZHodiegzNxthdNFiCTCp06YjlnSxx7Bm1agu7+pH2GjOC
        FmkwT3SFGDqMSw89FuShegx5JmXoTwAF/Q==
X-Google-Smtp-Source: ABdhPJxNGyjLKZ/oS+9/Xqx9fNqI3kp0gsMjlfVpsCvcZyjzS5RvBT0qdtCEk2bYWJMjJfdNy8JpFg==
X-Received: by 2002:a0c:fbac:: with SMTP id m12mr8087022qvp.52.1618576146247;
        Fri, 16 Apr 2021 05:29:06 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id b15sm3986102qtg.82.2021.04.16.05.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 05:29:05 -0700 (PDT)
Subject: Re: [PATCH] floppy: remove redundant assignment to variable st
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin King <colin.king@canonical.com>,
        Willy Tarreau <w@1wt.eu>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210415130020.1959951-1-colin.king@canonical.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <d6c29628-be82-c812-e021-fd0f0ab02172@linux.com>
Date:   Fri, 16 Apr 2021 15:29:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210415130020.1959951-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens, could you please take this one? I thought to send it to you with other
cleanup patches in a merge request, but you already applied rest of the
patches. If you prefer to take it as merge request, it's ok I'll send it
based on your branch for-5.13/drivers.

On 4/15/21 4:00 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable st is being assigned a value that is never read and
> it is being updated later with a new value. The initialization is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Denis Efremov <efremov@linux.com>

Thanks,
Denis

> ---
>  arch/x86/include/asm/floppy.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/floppy.h b/arch/x86/include/asm/floppy.h
> index d43717b423cb..6ec3fc969ad5 100644
> --- a/arch/x86/include/asm/floppy.h
> +++ b/arch/x86/include/asm/floppy.h
> @@ -74,7 +74,6 @@ static irqreturn_t floppy_hardint(int irq, void *dev_id)
>  		int lcount;
>  		char *lptr;
>  
> -		st = 1;
>  		for (lcount = virtual_dma_count, lptr = virtual_dma_addr;
>  		     lcount; lcount--, lptr++) {
>  			st = inb(virtual_dma_port + FD_STATUS);
> 
