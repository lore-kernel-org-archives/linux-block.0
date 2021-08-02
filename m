Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A824C432BE
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 15:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10856112F
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 15:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhHBP6i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:58:38 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:39781 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbhHBP6h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 11:58:37 -0400
Received: by mail-pl1-f181.google.com with SMTP id e5so20129270pld.6
        for <linux-block@vger.kernel.org>; Mon, 02 Aug 2021 08:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6dwgOmSmOwCvv44jPBeik5HIlKtq6cW0WB3ArXQiP4A=;
        b=b91HPj+CigyYQoT356Uc/dEmOjA9W9UFIOVYisBh8SD+4xwSzzRsFn6ml/qfNGWGO7
         4hDiyDo8/IhhEisuPgMOj7ShlJeNZJHvBouKSoaK8hhQ5flvXazCjJAs0+tLXfeCmGza
         FDBf6UTDRgLBujk6MFP+ri/XLofXnOZG/JLLShA6aLLvlcR5pAyqR55tATTagSBCVpAP
         eaREZIFqt4D4XgkwO+kMmJRV6YFsc8sm7zvKO0hHu++sVito+GLM6xbRqLmMYE6zapfF
         N0tKVbDCpwZ5onWUW5Bjfe/FMiYfG/N/pGivcJ2xkWGZlV6daD0sNxulkRkynotAfVQI
         PqJA==
X-Gm-Message-State: AOAM530fvTBa0QY1EUizqC4pDguYUXIaKDZSIBqL5R88yZwvDHly1niL
        p+llBUbsDAyQhraOhPHxf6s=
X-Google-Smtp-Source: ABdhPJyV010Zq+tLdoNyCfk9Z80lRKNJ2k5Jo5okFL0WgbiOgwBq47ccpaUpUlHzEYube4ObKlFV8A==
X-Received: by 2002:a17:90a:d3ca:: with SMTP id d10mr18028756pjw.35.1627919907738;
        Mon, 02 Aug 2021 08:58:27 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:1687:85fe:8bf4:9fb9])
        by smtp.gmail.com with ESMTPSA id 37sm13751000pgt.28.2021.08.02.08.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 08:58:27 -0700 (PDT)
Subject: Re: [PATCH 2/3] block: fix ioprio interface
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
References: <20210802092157.1260445-1-damien.lemoal@wdc.com>
 <20210802092157.1260445-3-damien.lemoal@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <68044a9e-c268-79a0-f880-766cfc6e1f7f@acm.org>
Date:   Mon, 2 Aug 2021 08:58:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210802092157.1260445-3-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/2/21 2:21 AM, Damien Le Moal wrote:
> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
> index 77b17e08b0da..27dc7fb0ba12 100644
> --- a/include/uapi/linux/ioprio.h
> +++ b/include/uapi/linux/ioprio.h
> @@ -6,10 +6,12 @@
>    * Gives us 8 prio classes with 13-bits of data for each class
>    */
>   #define IOPRIO_CLASS_SHIFT	(13)
> +#define IOPRIO_CLASS_MASK	(0x07)
>   #define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
>   
> -#define IOPRIO_PRIO_CLASS(mask)	((mask) >> IOPRIO_CLASS_SHIFT)
> -#define IOPRIO_PRIO_DATA(mask)	((mask) & IOPRIO_PRIO_MASK)
> +#define IOPRIO_PRIO_CLASS(val)	\
> +	(((val) >> IOPRIO_CLASS_SHIFT) & IOPRIO_CLASS_MASK)
> +#define IOPRIO_PRIO_DATA(val)	((val) & IOPRIO_PRIO_MASK)
>   #define IOPRIO_PRIO_VALUE(class, data)	(((class) << IOPRIO_CLASS_SHIFT) | data)
>   
>   /*
> @@ -23,9 +25,16 @@ enum {
>   	IOPRIO_CLASS_RT,
>   	IOPRIO_CLASS_BE,
>   	IOPRIO_CLASS_IDLE,
> +
> +	IOPRIO_CLASS_MAX,
>   };
>   
> -#define ioprio_valid(mask)	(IOPRIO_PRIO_CLASS((mask)) != IOPRIO_CLASS_NONE)
> +static inline bool ioprio_valid(unsigned short ioprio)
> +{
> +	unsigned short class = IOPRIO_PRIO_CLASS(ioprio);
> +
> +	return class > IOPRIO_CLASS_NONE && class < IOPRIO_CLASS_MAX;
> +}
>   
>   /*
>    * 8 best effort priority levels are supported

Are there any plans to use ioprio_valid() in user space applications? If 
not, should this function perhaps be defined in a kernel-only header?

Thanks,

Bart.


