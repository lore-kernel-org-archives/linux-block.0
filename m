Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686DDC433B4
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 12:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413EC61261
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 12:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbhDLMvS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 08:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbhDLMvS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 08:51:18 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E15C06174A
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 05:51:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso8760359pji.3
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 05:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WkGmlX5ftli+EWO0CazbhQyRHDGa3y5/GM0CgYRRd1M=;
        b=Lqtt/R+PG7FyygYH8QWNBcksgjCfvw3n0LsPgd2jafIpF+AOIesjGp4KpltidruzhF
         e7C3PfEzwzsyVIJOCtvB1k5IyFGbYrKYqD+DP6rn90TIIi9AM82N5QKr37++D2NSo4nD
         EzOSkI6e8jm+pwGSx93mnS2ZAukznrIrSWAECXS/icMcRUFBKrjOJ+2LbDVvSvYM3QJK
         PRtWyzZhjwmcxuVi0XrWna1T3MlUi8FuUskVPGpGEt7+56w/pj2YhbjEpFgt6HNFeLA2
         hKE0cWDKWjoWpBU8Ml7UdRRM32wo2s+6T8MTkzOp83dcoQTBhIeIS9gJ/hPGu3TiSQYT
         E95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WkGmlX5ftli+EWO0CazbhQyRHDGa3y5/GM0CgYRRd1M=;
        b=Q2ML5B/nGB2HKtjpkXVuqg/a8MNoaQEAgl51nAsLpjV5IJFIgdOzomvv5R3bfLsJ2w
         sks2q60zknUlxgxpWD3ICAUo2hhZccOJ3IaoL/zq9/p3Qb4SUl2PuOYjfNasjfrXfIP1
         9iu6gAXCcG+pPsRQmmfeRJ0K8PIMJIWf800aOluCL4U8jmx3p4GDbbTOwJFPdO5hCOUH
         XIHlcXAZzu1vsyuFqqdUXgoxSkuER22vR0smqGLuuv6bB8+Fi1fY8zp+kjyfbkwyaYIZ
         S0X91PpqdXfT7r9Wn4GSYN1xXVQu7tvnOybRdOmIWfCwdQO7t6Fh/8lkoU3BCNOWSZXK
         kRNQ==
X-Gm-Message-State: AOAM530ACNn37vMvKsnNifcWYMZDXPxjzFZ2KST7jjURHz+oWOF7vcPG
        Rzm9HBOYoavCfIsl9lve90/tYhV5Pk41Pg==
X-Google-Smtp-Source: ABdhPJyy1UDIsMLd9649fHgbN//VtPaMUUZoKH4yE05p/csBlFuaRkmxgj2LbJ+5WJw0hXX56TEAiA==
X-Received: by 2002:a17:90a:8914:: with SMTP id u20mr27931995pjn.90.1618231859779;
        Mon, 12 Apr 2021 05:50:59 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a25sm5454429pfo.27.2021.04.12.05.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 05:50:59 -0700 (PDT)
Subject: Re: [PATCH 7/7] bcache: fix a regression of code compiling failure in
 debug.c
To:     Coly Li <colyli@suse.de>, Christoph Hellwig <hch@lst.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20210411134316.80274-1-colyli@suse.de>
 <20210411134316.80274-8-colyli@suse.de> <20210412090600.GA8026@lst.de>
 <902e1ba6-cd73-b0e8-6c17-75fccbaeb9b4@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <caf688de-19f6-925e-3059-966fe0d8ce42@kernel.dk>
Date:   Mon, 12 Apr 2021 06:50:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <902e1ba6-cd73-b0e8-6c17-75fccbaeb9b4@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/21 3:53 AM, Coly Li wrote:
> On 4/12/21 5:06 PM, Christoph Hellwig wrote:
>> On Sun, Apr 11, 2021 at 09:43:16PM +0800, Coly Li wrote:
>>> The patch "bcache: remove PTR_CACHE" introduces a compiling failure in
>>> debug.c with following error message,
>>>   In file included from drivers/md/bcache/bcache.h:182:0,
>>>                    from drivers/md/bcache/debug.c:9:
>>>   drivers/md/bcache/debug.c: In function 'bch_btree_verify':
>>>   drivers/md/bcache/debug.c:53:19: error: 'c' undeclared (first use in
>>>   this function)
>>>     bio_set_dev(bio, c->cache->bdev);
>>>                      ^
>>> This patch fixes the regression by replacing c->cache->bdev by b->c->
>>> cache->bdev.
>>
>> Why not fold this into the offending patch?
>>
> 
> I don't know whether I can do it without authorization or agreement from
> original author. And I see other maintainers handling similar situation
> by either re-write whole patch or appending an extra fix.
> 
> If you have a suggested process, I can try it out next time for similar
> situation.

What I generally do is just add a line between the SOB's for cases
like this, ala:

commit 70aacfe66136809d7f080f89c492c278298719f4
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Mon Mar 1 13:02:15 2021 +0000

    io_uring: kill sqo_dead and sqo submission halting
    
    As SQPOLL task doesn't poke into ->sqo_task anymore, there is no need to
    kill the sqo when the master task exits. Before it was necessary to
    avoid races accessing sqo_task->files with removing them.
    
    Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
    [axboe: don't forget to enable SQPOLL before exit, if started disabled]
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

