Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3F0C001DE
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 22:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjHIWBh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Aug 2023 18:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjHIWBg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 18:01:36 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B2C1FF5
        for <linux-block@vger.kernel.org>; Wed,  9 Aug 2023 15:01:35 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1bc7b25c699so2766915ad.1
        for <linux-block@vger.kernel.org>; Wed, 09 Aug 2023 15:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691618495; x=1692223295;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0uZnAzv6qxs6cKnmvMTRXOsnDxrV/l9vzhxqhvZOEg=;
        b=KDQRU5y2Ys6XN6+9NmEkdF9PDN4AaalxEHWa+qIHTqjxmm9GYySxorFqVq06dA2Eet
         O3NtqRiYuK6sLx3S4FRVduOuZtuFDMMJ8uUSgWaqtE96leTbCkNqz4KZikFJwkse7PFB
         aoEKZXG5g4pJL0cG6VU52xEYAtz1AyclQdJ91s5iecYega2oQ6+ldJ7XVhEWuF23jsXE
         HdZq0U0gIabe/CBzvWIgAhsiFTBOmQQlqXKQ5Z0ogdQlqGOEGOWsb0aR82Cug9HTb805
         ++Cz+OA+XKP0c7egWRt0oY2+xduAHLecb+Ec+pd+4nFT3BbP2xby25bDWGFaoYF84k8j
         ymhQ==
X-Gm-Message-State: AOJu0YwdtPDg0JCmFf954GM4kQHZEr4S39KxxF+o/Tp6GlIU6fK+ZyPe
        um5FOao1yQQNfETrriBJTIZlz+4J4zg=
X-Google-Smtp-Source: AGHT+IH9v6i3w1D+KYuiSaOsMfCzaokpZY4AY/Wg/duOaEeijE1NJ50hYw5rRBRWbN77JgaVNUq/UA==
X-Received: by 2002:a17:902:8306:b0:1bb:cd10:823a with SMTP id bd6-20020a170902830600b001bbcd10823amr359602plb.39.1691618495144;
        Wed, 09 Aug 2023 15:01:35 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id jg6-20020a17090326c600b001bb54abfc07sm15774plb.252.2023.08.09.15.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 15:01:34 -0700 (PDT)
Message-ID: <f574c33b-a572-6cc8-693a-e47dda5db813@acm.org>
Date:   Wed, 9 Aug 2023 15:01:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] block: don't make REQ_POLLED imply REQ_NOWAIT
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20230808171310.112878-1-axboe@kernel.dk>
 <20230808171310.112878-3-axboe@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230808171310.112878-3-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/8/23 10:13, Jens Axboe wrote:
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -791,7 +791,7 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
>   static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
>   {
>   	bio->bi_opf |= REQ_POLLED;
> -	if (!is_sync_kiocb(kiocb))
> +	if (kiocb->ki_flags & IOCB_NOWAIT)
>   		bio->bi_opf |= REQ_NOWAIT;
>   }

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
