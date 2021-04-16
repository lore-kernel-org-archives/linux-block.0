Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586C1C433ED
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 12:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33669611AB
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 12:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhDPMNU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 08:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhDPMNU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 08:13:20 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2D6C061574
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 05:12:54 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f29so19077826pgm.8
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 05:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+dfabf1WqpeXG/i1YwfvvMCPvn6LrTMInR7Y3IaKWck=;
        b=jWTLLy3FqDM5BAle45/l0VnSqG8MeacYGsNUxRacs4t6qyy4LIws4BuwJtQC60GSw3
         0XZTeTS8FvnyLjUcJi9hfDavi2ZV6IWtrUz7TxxIgHalWNB838UPVIQAzJrllh5T/6sN
         oVtyBWpCnIE8O6qIFXrh+Asd8beZgXTWCiWGekIRHQSB912Z44yIQbEJPWQbQvBKSOB/
         p47c3/3LTUABlumNR2tdaud4t7SDgeR0kRejODZOWvm6q0OiWiNUwqWFdYal4H8ITWRF
         PGoZsbONVfslv2xd7R3VRBe/wmOiniL4pYhtnzW5mj4bfLRgJfzwsOZHTzLWjv8jdLyH
         dFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+dfabf1WqpeXG/i1YwfvvMCPvn6LrTMInR7Y3IaKWck=;
        b=kUnPIEZmJ+S6RzmMnBjf4CnPFuX5tA6KIdm7kpOsSoYBoOxX8O1iOx7QMXP2P81C9R
         cK4hO5CM61ZPLkIkgVQqzy4+KWK/i/reMdqfEWOYeCQhpI7rXcdlMnDvf14eKPL+1UqN
         PJO7BALOXesWe332zgK3fUgjHL1+K1norUdQOX5r0HZlrK6jNythMVeb3a3HqLfUmvtl
         DGXOFWBdAo8H1qbQfpcLfm9blzXhldtkfi2W4I0vX1a90RHLNVQjt3l0+wsUEyu3z5sE
         vQ6nTpsTpMMEnNCf2TwUSFRXfr2vjXNdm+QcWRaAzVk0cCulHLmGeHn9HfSDCQk5IuxZ
         PMDg==
X-Gm-Message-State: AOAM532MwfPyN4PsAtT235y5nCLCuTMlx3HxCX/Wa+zDnMcBYxlQIWfW
        034/9+kCJQfLJnZQ0Kpf5ZTJO0p4hv1rJA==
X-Google-Smtp-Source: ABdhPJy8Pxx4pa04/f0R3HTLmZWDmMsd7pKVohMo55bCVcIS2ol12SEa94QUKyNJzC+2HN7juz1ZRg==
X-Received: by 2002:a65:4486:: with SMTP id l6mr7934892pgq.347.1618575173795;
        Fri, 16 Apr 2021 05:12:53 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id g6sm4505623pfj.139.2021.04.16.05.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 05:12:53 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: cleanup redundant nr_hw_queues assignement
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org
References: <20210416075318.19976-1-jefflexu@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <96bd4f9f-cea9-6a8d-fc65-fb9980d10b78@kernel.dk>
Date:   Fri, 16 Apr 2021 06:12:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210416075318.19976-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/21 1:53 AM, Jeffle Xu wrote:
> 'set->nr_hw_queues' has already been assigneid to nr_hw_queues in
> blk_mq_realloc_tag_set_tags().
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  block/blk-mq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 55ef6b975169..c7d1613e7514 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3672,7 +3672,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  	    0)
>  		goto reregister;
>  
> -	set->nr_hw_queues = nr_hw_queues;

This isn't an equivalent transformation if nr_hw_queues >
set->nr_hw_queues.

-- 
Jens Axboe

