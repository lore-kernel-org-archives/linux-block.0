Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0D4C77B7A
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 13:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjEPNJD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 09:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjEPNI7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 09:08:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CC1BD
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 06:08:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-643990c5319so10214128b3a.2
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 06:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684242536; x=1686834536;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pOB1tODyfSELjR296/O7BhxSCcZcHN22thGmCOylqyw=;
        b=CKn/RwqvXmXiTJ2aSozwIQCkq5S7NeBKA9GxrGP5dOcxAbllj5hIku44I4QFJGb79p
         b1OTVkA7h7ave42AGgjh0r9v6pVGhv6D4mDoz3HFQDgRZ+xurofF2oXvJdnMR2o+m97O
         u+qBKrOUXO9mm2uHS23ntO1ndQ2aODJbaUS+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684242536; x=1686834536;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOB1tODyfSELjR296/O7BhxSCcZcHN22thGmCOylqyw=;
        b=bEsXAiJKjxmaOg5icUqFx5s0DpZrDbhdb4qI0f1sdA10XOJYzhUIk6jetXFgdFUhrN
         UuYjwjkbWJkDbYpcg1zF8F99dordvQY6RqZWE05+lbI093BCYiHBSgJQh0K6BI6vNE+z
         ZwIAEJxatBPMcU7zoMXs9GpBiwRm/GRWj6+77tRyAZn+tNfdZRpxRTNavMgj1NknZTHC
         33e9lc6CCKTWhsSe6hZK7J8IsN2fJl9UrN0AMmVuAbyM43wedE1J1/2InSINij//lmDt
         3Gm5I33/iAL1iCf/Ass0Z9OQiedt51o9nPaTgAWrkPSsqsopKiMqfCzSumKmitXDaNJQ
         lKRA==
X-Gm-Message-State: AC+VfDxFGz7ayc0VbKK8kdgV5ZMC1AyDFOaQ05SLMBgHM3RTzsKFWCeq
        TPhfqle/p/gMxoyfAbymevEyBA==
X-Google-Smtp-Source: ACHHUZ6q8eESve/9O5ZYihdbgP17V9SlZdmhFPrM+2jgwzsPp6oWoQZ4SG3g1w+4Lx4JtS0qAdZ/VQ==
X-Received: by 2002:a05:6a00:15ca:b0:63b:19e5:a9ec with SMTP id o10-20020a056a0015ca00b0063b19e5a9ecmr49715418pfu.33.1684242536623;
        Tue, 16 May 2023 06:08:56 -0700 (PDT)
Received: from google.com ([110.11.159.72])
        by smtp.gmail.com with ESMTPSA id b19-20020aa78713000000b00643355ff6a6sm13857526pfo.99.2023.05.16.06.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 06:08:56 -0700 (PDT)
Date:   Tue, 16 May 2023 22:08:50 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] zram: allow user to set QUEUE_FLAG_NOWAIT
Message-ID: <20230516130850.GA298930@google.com>
References: <20230512082958.6550-1-kch@nvidia.com>
 <20230512082958.6550-2-kch@nvidia.com>
 <ZF5NssjIVNUU9oIA@infradead.org>
 <8a661736-2c79-9330-1371-b6f539a9a695@kernel.dk>
 <b55b03ca-7967-faac-20c9-5c1ca6dc171b@nvidia.com>
 <2e6864ef-394d-f43e-9175-a4f3da65c755@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e6864ef-394d-f43e-9175-a4f3da65c755@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/05/16 05:51), Chaitanya Kulkarni wrote:
> Removed modparam v2 is ready to send, but I've few  concerns enabling
> nowait unconditionally for zram :-
> 
>  From brd data [1] and zram data [2] from my setup :-
> 
>          IOPs  (old->new)    | sys cpu% (old->new)
> --------------------------------------------------
> brd  | 1.5x (3919 -> 5874) | 3x (29 -> 87)
> zram | 1.09x ( 29 ->   87) | 9x (11 -> 97)
> 
> brd:-
> IOPs increased by               ~1.5  times (50% up)
> sys CPU percentage increased by ~3.0  times (200% up)
> 
> zram:-
> IOPs increased by               ~1.09 times (  9% up)
> sys CPU percentage increased by ~8.81 times (781% up)
> 
> This comparison clearly demonstrates that zram experiences a much more
> substantial CPU load relative to the increase in IOPs compared to brd.
> Such a significant difference might suggest a potential CPU regression
> in zram ?
> 
> Especially for zram, if applications are not expecting this high cpu
> usage then they we'll get regression reports with default nowait
> approach. How about we avoid something like this with one of the
> following options ?

Well, zram performs decompression/compression on the CPU (per-CPU
crypto streams) for each IO operation, so zram IO is CPU intensive.
