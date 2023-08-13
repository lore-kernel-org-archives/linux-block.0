Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D21DC001B0
	for <linux-block@archiver.kernel.org>; Sun, 13 Aug 2023 15:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjHMPfA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Aug 2023 11:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjHMPe7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Aug 2023 11:34:59 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B820BE0
        for <linux-block@vger.kernel.org>; Sun, 13 Aug 2023 08:35:01 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686f6231bdeso988553b3a.1
        for <linux-block@vger.kernel.org>; Sun, 13 Aug 2023 08:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691940901; x=1692545701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNqe/nmjkgw3d8zLXWfLEuR3zEJElR6Cvxa4EUhIgTM=;
        b=nNM0ekLabYjOL/L6X7z8Eiw3UfTV8EdzaD6mXLaD9DnCTQnYj6bOUIWKO9WoaXjsez
         +3CJSvvOCLr7khKerM3Dk2aVUIgA2ukGpmzJiIwW/0HzxnBpSSorieCC1IEGm0+wyiuB
         DW/G6hImrEbJLRKR8rMUOtZMTt0XfUImsh1SLriEHcWHaw3Mb7dx1+okBM3TUu3vqtkX
         GxSpA8hC/ZzdphwQUZWGqVG82i07r/Tr1jbydeb4HzOifGlQrphfuTiuj63NdMAVwakm
         rg9dWUhSVldDNS2zmrcYUAuALB8IMJFjYA2DaXgVbYoNdtp8r3RpFyP/t+t9PTK6Mey8
         iLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691940901; x=1692545701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNqe/nmjkgw3d8zLXWfLEuR3zEJElR6Cvxa4EUhIgTM=;
        b=kBZyl18rAzVkCe7ND7gnUNJe7R8ADahJNI7jvatFJ1TFOfEgfFP+NM7zTo16QAHh9+
         Pej0qcKVKBW00Xd6WJ8j4o6A6ESEGpvCZzT6fBgzs866S+mDTbYz5uv6y4Nhz0HTRGZS
         /0neS8Kf2Yh5Kb+5xerpqER1E5t61DHRnCKFX2yiFls5vzpKjqYyQ6Xgnoq/DqJz+RFs
         izsIV2ZPR5cTa0JN8NLJY4pl5qEt7+Kh824N6VXpclw/cFvTzcLRtE1hKi/7Exgugb4X
         oCDT507lH0NYvEJhm2MEH30fVXR3Xg1G6nELQexJl/eRVyRHdYtBejryzlgSadlZjBWc
         r/vQ==
X-Gm-Message-State: AOJu0YzA7iW4LJN5qi2vvd9Wprh77mb79eEb/kpP9J68gaCwr/sEysDx
        qseJdxF0lCj5+/J38xgX6CINQA==
X-Google-Smtp-Source: AGHT+IHQw3V12cavdbXwv/KBh/WEXfZGutgwq36KqFYBQvM/crx2fJQ86XNpB5Wuc5avQCENertDFw==
X-Received: by 2002:a05:6a00:2ea0:b0:677:3439:874a with SMTP id fd32-20020a056a002ea000b006773439874amr9008826pfb.3.1691940901140;
        Sun, 13 Aug 2023 08:35:01 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i15-20020a63a84f000000b005634343cd9esm6780093pgp.44.2023.08.13.08.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 08:35:00 -0700 (PDT)
Message-ID: <61b9abff-091e-4aae-a9bd-3f1be1593661@kernel.dk>
Date:   Sun, 13 Aug 2023 09:34:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk-mq: release scheduler resource when request
 complete
Content-Language: en-US
To:     chengming.zhou@linux.dev, hch@lst.de, chuck.lever@oracle.com
Cc:     bvanassche@acm.org, cel@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230813152325.3017343-1-chengming.zhou@linux.dev>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230813152325.3017343-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/13/23 9:23 AM, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Chuck reported [1] a IO hang problem on NFS exports that reside on SATA
> devices and bisected to commit 615939a2ae73 ("blk-mq: defer to the normal
> submission path for post-flush requests").
> 
> We analysed the IO hang problem, found there are two postflush requests
> are waiting for each other.
> 
> The first postflush request completed the REQ_FSEQ_DATA sequence, so go to
> the REQ_FSEQ_POSTFLUSH sequence and added in the flush pending list, but
> failed to blk_kick_flush() because of the second postflush request which
> is inflight waiting in scheduler queue.
> 
> The second postflush waiting in scheduler queue can't be dispatched because
> the first postflush hasn't released scheduler resource even though it has
> completed by itself.
> 
> Fix it by releasing scheduler resource when the first postflush request
> completed, so the second postflush can be dispatched and completed, then
> make blk_kick_flush() succeed.

Thanks, applied with a bit of commit message massaging and adding a
comment for the newly added WARN_ON_ONCE().

-- 
Jens Axboe

