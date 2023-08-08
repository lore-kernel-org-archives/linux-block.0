Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9460EC001DB
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 21:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjHHV7A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjHHV7A (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 17:59:00 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D2412D
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 14:58:59 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1bc6624623cso27421305ad.3
        for <linux-block@vger.kernel.org>; Tue, 08 Aug 2023 14:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691531939; x=1692136739;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H8ytia4aZLWYggaC6l6X44c5UKfKCy4XnmgCOW0vBl0=;
        b=FJDtDZHCVjA/wU5Ft83Be5nKHfqsvLq30fsaXU1F2akBtYmsmbsl/F5bb7poCAecfS
         ZJ3H/oTYyE6iyidIZ7EgMIg8+ZLqgcUvRRsUugxkr26VU9Zeql7oqUqp42ClJ3nbMXYz
         3iSLsHDZIW4n90EdjKjyb838+b3fsKs/7FbIc4vvO+Y2RdRhe8/UactgLhPv+kM8XJVL
         FbDZfzW2c1lB4c0EDKWwS8ExarNXyi+cJrELQ+zqzr5e9Nm5C9iKgUn9D+MpGcRJnwDi
         gmFN0QV+m2aqbR79DuskqesJatFgLMTE5i0pFbofCay2NRXswvglQvAZ9ubOEJFmUVrK
         eGTw==
X-Gm-Message-State: AOJu0YyyRv7Gi3A63RLOB/4Udej3q9Kyhqjsj9IxQa6Dornq15l/5/8P
        dxQABnEzK9qHIdz8sIBjkr9Nsl7o2gQ=
X-Google-Smtp-Source: AGHT+IFMQiPWjVifwxYASw0ufxb3LY8sL4WgT+P8wmSsLS9aYPfsKPTY/QoNhtq4QTGeUacl0MXE5A==
X-Received: by 2002:a17:903:22cc:b0:1b6:797d:33fb with SMTP id y12-20020a17090322cc00b001b6797d33fbmr1119445plg.64.1691531939175;
        Tue, 08 Aug 2023 14:58:59 -0700 (PDT)
Received: from ?IPV6:2600:1010:b047:2ab0:fd93:3f7d:e947:afd4? ([2600:1010:b047:2ab0:fd93:3f7d:e947:afd4])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b001b03f208323sm9522147plb.64.2023.08.08.14.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 14:58:58 -0700 (PDT)
Message-ID: <6184fb8b-288d-e21d-2a01-dd2a3fef3104@acm.org>
Date:   Tue, 8 Aug 2023 14:58:56 -0700
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
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index c4f5b5228105..11984ed29cb8 100644
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

The implementation of bio_set_polled() is short and that function has
only one caller. Has it been considered to inline that function into
its caller?

Thanks,

Bart.


