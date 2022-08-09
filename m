Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A930EC19F2D
	for <linux-block@archiver.kernel.org>; Tue,  9 Aug 2022 12:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiHIMlc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Aug 2022 08:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242425AbiHIMla (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Aug 2022 08:41:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FADBCA6
        for <linux-block@vger.kernel.org>; Tue,  9 Aug 2022 05:41:28 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id w14so11205334plp.9
        for <linux-block@vger.kernel.org>; Tue, 09 Aug 2022 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WNr40UtTfHF/fzuU8JQrB0PNXLcXxn2MQ4y4InLcGjc=;
        b=Xx6N+GU9iNYMwuT9/3lSx7jhoAsO+71/iNml5D96YGeHwBzYZ3j4ILPJ44KjqPbZe3
         YpGuTWn01YdM7o2ebvIdXXnxeasvcrqV5g6NPHfGpE3zxMzdH75dxLbuIGh1RZpw8R6K
         A33OK2AyhA1yEfQpBhmLaQvI4ASVr/4GmXQVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WNr40UtTfHF/fzuU8JQrB0PNXLcXxn2MQ4y4InLcGjc=;
        b=hBq8N6qL4xh3cJEmErWu280xpxrbrL4TGC2FEL3XX0l5RaiQfB4ckSCdNQEqRalobV
         i9YJIQHobrwpaLJ7aO1BMc2qGEdLlw45xl9xaDukSqG45hzbuS0D6hN807x7W8kznb8r
         haeocXrCoAJjJEcTAvVNhMiopwi3Fkjrng5dhsoLJBLPULM/CTfLyB9rcAD3OJ0l7YoT
         pyaloHSNBVGXVzEPAUPVNi5RBeCdH3P9r99EU1dcM+KOHL5sBxk9Ihz5Df0VvQ47etWs
         gOdJvK5g54xNixyb2blZVCkwJERnDPAHBILPTglFCbXTy+sqFvEvjumdnCW40UD1XvqS
         cO8g==
X-Gm-Message-State: ACgBeo2sgvyplKClET3hj305C+C3DtCiUyBvsiSAF2C12ZidIXXdxbFD
        kyd0aH0GPD8v3ahTKPz+nZXXsRyPSp1aCQ==
X-Google-Smtp-Source: AA6agR4KP3+3TPwBOflqXePsVYMZv0/sRTeKgbWH6qJxglrD40OZS+CxcNTbdAS84lMcYYtGG4KzUw==
X-Received: by 2002:a17:90b:4f49:b0:1f5:c7c:b565 with SMTP id pj9-20020a17090b4f4900b001f50c7cb565mr35356292pjb.32.1660048887790;
        Tue, 09 Aug 2022 05:41:27 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:8d43:c739:457a:5504])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b0016dbaf3ff2esm10719392plk.22.2022.08.09.05.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 05:41:27 -0700 (PDT)
Date:   Tue, 9 Aug 2022 21:41:22 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>,
        Minchan Kim <minchan@kernel.org>
Cc:     akpm@linux-foundation.org, ngupta@vflare.org,
        senozhatsky@chromium.org, linux-block@vger.kernel.org,
        axboe@chromium.org, kernel@sberdevices.ru,
        linux-kernel@vger.kernel.org, mnitenko@gmail.com,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: Re: [PATCH v5] zram: remove double compression logic
Message-ID: <YvJV8rU9bkqiy9iA@google.com>
References: <20220505094443.11728-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505094443.11728-1-avromanov@sberdevices.ru>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (22/05/05 12:44), Alexey Romanov wrote:
> @@ -1975,7 +1954,6 @@ static int zram_add(void)
>  	if (ZRAM_LOGICAL_BLOCK_SIZE == PAGE_SIZE)
>  		blk_queue_max_write_zeroes_sectors(zram->disk->queue, UINT_MAX);
>  
> -	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, zram->disk->queue);

By the way, why did it remove QUEUE_FLAG_STABLE_WRITES bit?
