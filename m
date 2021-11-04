Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C86EC433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 14:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D764F611C4
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 14:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhKDOoj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 10:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhKDOof (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 10:44:35 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C01C06127A
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 07:41:57 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id c26-20020a9d615a000000b0055bf6efab46so304037otk.6
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 07:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=e8fd8CcgzD0vvHj18hWmkSikSlqHt0R6Y/TRO3BBSC8=;
        b=k/WuS4cH0MsvfDcF5t1LEqPGWZQCjC3718j9F9vDE10t9hNCsRhPAxp2KdyQAH4cfV
         kFTYNLPsZUbP+DImZcZF77JxL1BjUkNLyJGwXBMIigMbiLW705HSDm8ndcLQHlG4hIZx
         UU2GCLc1QSmqyA01yBujwMeZdWqk+kFi7/vfiX9rv/1mpxye63/LTonLCbDeZ0cD7zcr
         tP81EyxK0TEqho8Gg3B71fyMf/g9T8xEmL1kSlWqsDs9+ZWJzhJ8O1Zl0GABDii7C3GQ
         0Yb07Y08fFpseFVIi2BM5bVqsUTCnhCf1uGx68WhnlcJ6chzlCkCxBNhl5SfZI4DzIkh
         QNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e8fd8CcgzD0vvHj18hWmkSikSlqHt0R6Y/TRO3BBSC8=;
        b=x9m47NOpnBv/bi0Kv3T41s7ZZdli1ggetyu1qHxoYv5JV9hjo9H/X+DzXlstQOGK1D
         tlWV7z6a5vYW18w6VQPPLsKfENFqH88r3EoaOJybN0o8RzQDazgR85GBtwmI8o8IPjF+
         3HKE+jvizgcpzPsbFLmsvHLOzgzOHubFoAKGu6yOkKNPCi1V39KmOW61pqXgwf+Q9Wun
         KqITb1rRs5R/qesxQzpxxHpJXaFSpZ0SNro7jGuAwhO4Qz+XLCJEVkAzPFO6OfR1361s
         mkL8sTVKM/w5wS+W7roc3G3U7s1czHuUnCm49eExzNpHhtmb/SBkeO5umGHwYDxrqFWj
         hSeg==
X-Gm-Message-State: AOAM530y4st5W1I7tMTujf2Uu8UNDD0uGB9mqKqoP4UQiYOksX4bjepp
        a0L4ucDzIrWi190lGyuDMvY0FMG8BQiMvA==
X-Google-Smtp-Source: ABdhPJy87q6Rdz/f7ZmpA5XvkDkrS4tYBsgC3Msse8Sj6l//vf1mGRFinGvyoRHXEUrTZ6gOzMXK9Q==
X-Received: by 2002:a9d:6a4d:: with SMTP id h13mr23565568otn.293.1636036916445;
        Thu, 04 Nov 2021 07:41:56 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a8sm1401184otr.3.2021.11.04.07.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 07:41:56 -0700 (PDT)
Subject: Re: block: please restore 2d52c58b9c9b ("block, bfq: honor
 already-setup queue merges")
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        linux-block <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
References: <65495934-09fe-55b0-62a9-c649dc9940ba@applied-asynchrony.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a66f5127-8b0b-d21a-eda5-73968255b52c@kernel.dk>
Date:   Thu, 4 Nov 2021 08:41:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <65495934-09fe-55b0-62a9-c649dc9940ba@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/21 8:04 AM, Holger Hoffstätte wrote:
> 
> Hi Jens,
> 
> a simple no-code request:
> 
> Commit d29bd41428cf ("block, bfq: reset last_bfqq_created on group change")
> fixed a UAF in bfq, which was previously worked-around by ebc69e897e17
> ("Revert "block, bfq: honor already-setup queue merges"").
> 
> However since then the original commit 2d52c58b9c9b was never restored.
> 
> Reinstating 2d52c58b9c9b has so far not resulted in any problems for me,
> and I think it would be nice to bring it back in early just to get
> feedback as early as possible in this cycle.

Adding Paolo.

-- 
Jens Axboe

