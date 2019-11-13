Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB4CC33C8C
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 16:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1476622D2A
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 15:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfKMP5e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:57:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39040 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbfKMP5e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 10:57:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id x28so1937188pfo.6;
        Wed, 13 Nov 2019 07:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6pyZ1939MoivKuyRR7oEn6mya6iiO1vxsXSZDomB2Uc=;
        b=ieA+Vg3QbXR9cGeOpyTZYExJIPKz8fO6QP4NyYhk0ulqlxyJw1Hl1DK5VDe+Ne0phj
         By8PGXxGYhQpncR6zN7aaYONJgcRHgILmHu78B5rFTCsuOXq35b461gV9IRjvbu/XE0z
         oi1FGzJD1HUjopFTqo00r+x8KrweDhw15DlOyCGWze443nTe43DdR7smrh3gZvZmEXnS
         iFuKmmJ6s7YG1rv4z87R48aMTbVEMOZp5OSmZMiTNboPfUt+RxuqJ5cP/2vC+HtPgIvA
         yyJIVTSX1wPSQOm8ftkQ3A/g5Z/kImMq9nmPqu9Q99eYCNiHdYWUZrIEmeJ4AbtAaxyJ
         mXjA==
X-Gm-Message-State: APjAAAVGJb/1qFJ6NjuobprweEILWEPHKsfSr09KCCkzEeN697O9wFwD
        J/z8jAN0ObmSN8lRgJuwlLsNE8Ra
X-Google-Smtp-Source: APXvYqyZ19Er5vajaooa3G10t17WIDxwieqazKrX2GvWj784lAzORY6FmwqMGtH1LL4li4XUhuwcog==
X-Received: by 2002:aa7:8210:: with SMTP id k16mr5229524pfi.84.1573660653156;
        Wed, 13 Nov 2019 07:57:33 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b26sm2838452pfo.158.2019.11.13.07.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 07:57:32 -0800 (PST)
Subject: Re: [PATCH] block: Fix the typo in comment of function
 deadline_latter_request
To:     Xianting Tian <xianting_tian@126.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1573658479-13094-1-git-send-email-xianting_tian@126.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d2218346-5005-09f7-4777-dd59a1674778@acm.org>
Date:   Wed, 13 Nov 2019 07:57:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573658479-13094-1-git-send-email-xianting_tian@126.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/13/19 7:21 AM, Xianting Tian wrote:
> Fix the typo "`" to "'"
> 
> Signed-off-by: Xianting Tian <xianting_tian@126.com>
> ---
>   block/mq-deadline.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index b490f47..6047192 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -71,7 +71,7 @@ struct deadline_data {
>   }
>   
>   /*
> - * get the request after `rq' in sector-sorted order
> + * get the request after 'rq' in sector-sorted order
>    */
>   static inline struct request *
>   deadline_latter_request(struct request *rq)
> 

I'm not sure that's a typo. I think that's a common style for quoting text.

Bart.
