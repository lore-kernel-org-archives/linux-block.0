Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE129C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 10:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F4160FF2
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 10:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhJSKkz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 06:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhJSKkz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 06:40:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82292C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 03:38:42 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d3so11231549edp.3
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 03:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XOFwsAVSd7Jcjp063R3y3JI8WT0cSTyCscGlirJWxkg=;
        b=YlwsJp25FR0JTwrtxy/MM9BTn0fUowuE1ZSewJNNnVR5gn83n30Zyn0IBYJrVYUL75
         MxLB+NP/Nv0tWIOsKA1elbhlealMC6yYJaNb4tRHc8Y7H7lE5p8AJ2N3Fw7C86CSKyP+
         f0sY3HzmKTg3w7migLI4v6tJQFap8o9C9AyUDXPw/wIepFay6tr5dbc7/CJmQSHYDjL5
         JeI9/uafs0ha5gmJSYK8El6m3qMcvQvv9fimszLpZeZd8/5BrV+dcUIt17wEtFq2/eD5
         v5a7HK78PmbMe+623WNhBu1Y6XBlCr0Mdaatc73CFzccePyqwm130Ny+bZ1CmuGlHYD+
         FfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XOFwsAVSd7Jcjp063R3y3JI8WT0cSTyCscGlirJWxkg=;
        b=b/v5+T1UwXRgq0yr1enlh193svxeDqVdTLJvH1+PVUkN1RQATUbWAJ4cKJK2StvW51
         VEr5NrO6YXtP2J8eSLBfGoqGHQgM7G3n65p+1r5yPcGIXeT7QZBeAPxo9YS6oMvkWrh6
         +FSGvc9TkDK25hfto4c+LN5G4SvTHU1JsrzoJhLiRujNfJBx5XaVKd82PL/0v1jsiI9g
         baJ/X7T0KDJZgvPAwGz9Lup+MFumDRe1rLvSGWczj2dOkCPEEBhNFE4HY7ljNTEMII0f
         Sd1A1Cp+BZ2tBwcaVXLqQXWPGyXbmWRrApIP3IQRQNVDrt2UEqLSvQvfWEK+QZqxxm62
         zbGg==
X-Gm-Message-State: AOAM532b4tXkZ5Vm65N7JlBezj5RxiFKT0U2qXTwyL15rLKrxz/3+5M3
        i1RCgHeaPRJrdORUGnudodw=
X-Google-Smtp-Source: ABdhPJzNU5E4iZBAu8L+hmO32/uNxZz35Flg8Rz7czxKkswA819Y2el8fIF7Xgh97llKiKwOBjwj9g==
X-Received: by 2002:a05:6402:642:: with SMTP id u2mr32672176edx.324.1634639921120;
        Tue, 19 Oct 2021 03:38:41 -0700 (PDT)
Received: from [192.168.8.198] ([185.69.145.213])
        by smtp.gmail.com with ESMTPSA id j11sm9968665ejt.114.2021.10.19.03.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 03:38:40 -0700 (PDT)
Message-ID: <6e21b434-832f-a2c4-505e-6a9f511f578e@gmail.com>
Date:   Tue, 19 Oct 2021 11:38:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/3] block: blk_mq_rq_ctx_init cache ctx/q/hctx
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <cover.1634589262.git.asml.silence@gmail.com>
 <06a05d0b16a6504461502140c3d1e9c8cd91b862.1634589262.git.asml.silence@gmail.com>
 <YW5fEpG+4G9XNuzy@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YW5fEpG+4G9XNuzy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/21 07:00, Christoph Hellwig wrote:
> On Mon, Oct 18, 2021 at 09:37:28PM +0100, Pavel Begunkov wrote:
>> We should have enough of registers in blk_mq_rq_ctx_init(), store them
>> in local vars, so we don't keep reloading them.
>>
>> note: keeping q->elevator may look unnecessary, but it's also used
>> inside inlined blk_mq_tags_from_data().
> 
> Is this really making a difference?  I'd expect todays hyper-optimizing
> compilers to not be tricked into specific register allocations just by
> adding a local variable.

Looking again, there are only reads before the use site, so indeed
shouldn't matter. Was left from first versions of the patch where
it wasn't the case.

-- 
Pavel Begunkov
