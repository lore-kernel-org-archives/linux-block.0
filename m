Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEAFC433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 15:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E69D62166E
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 15:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nnSCFoxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405332AbgFSPwB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393186AbgFSPXa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 11:23:30 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33811C0613EF
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 08:23:30 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x22so4571511pfn.3
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zzBeoYkChCcVAStYW7riry6t3ZsDx2Q3uCHI24rM2Uw=;
        b=nnSCFoxYQ6AUSpPl6es7No4L1LX1qK6aUh3FwEFvx+WeSsOtxLwXhsHLAvFM6kig2O
         SV245MBqVFTqZWl4g3U9QzuwU+oxj1v4jxKS4r1RDH+Qe5p83thMMXeebnx9oe8xnYCb
         JB2UmXJ3oVZgULEcF+krwdSlyupQk5jtNrhcK6Nc+joMLRC6xJKI75lYwqECAxKxnoXM
         f3tq2NmFzCnozoFNNfLnQJAFoM3fuj8Btgjq+HaI7KEw09q7MV5+F0nuwFqYDD6r1fbJ
         WE53xOFEsZNg8/DJUR3WUCPMVi4E5ZjdMjRveodE4idwaRFNR5TaFOFR+50U7OAgJ0Mo
         1E0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zzBeoYkChCcVAStYW7riry6t3ZsDx2Q3uCHI24rM2Uw=;
        b=NT+O2TYjavnPEh5t0Ca1Uwc2Xps5KV0JjtHUt+F13HkwKzXfJtDbKeAl9Sg/EAo+NO
         mPq34CKx4K9AvXKh91FVhre+zLYN1oWIBoH4VvcdR/MUixrPvy7qfP+a8r+NuJG3/Khq
         jU8/bGSzaN/i94+HI2+RAJMkGQ3GD+Hy685a2TGw60sgGMldOo54WpAx2UcRC2kn8WOW
         7xtFAdt6HO2K6uOvZHLUpGfSnpmULvgYE9f9hV/w73TBNtHluQpHDJRSm/eK45MVALMJ
         vEY0s3Gf2O0+WQHQ3jlPthdO158ZEARoFaY14ENaqkHFSN5m/32c6f76uCCjf+mneQ/5
         Yt7A==
X-Gm-Message-State: AOAM5337gd0JG5s59ZaA6qJJBQ9Mp9j8X6qUUyWOIQpuk1sAIqu3SVrh
        K72KRL1mK19UELFBx9Emb5935Q==
X-Google-Smtp-Source: ABdhPJwvjmildVQ458MWHvwKJ1J5ToeoGRI4YFBGf+vUIXbuLmaFSHrHXTi8H577NG+qCE8UU1yEIw==
X-Received: by 2002:a63:525a:: with SMTP id s26mr1423522pgl.155.1592580209702;
        Fri, 19 Jun 2020 08:23:29 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a8sm2864224pga.64.2020.06.19.08.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 08:23:29 -0700 (PDT)
Subject: Re: [PATCH 3/3] io_uring: add support for zone-append
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        javier.gonz@samsung.com, linux-aio@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200619152208.GA62406@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b5bb1ba8-4738-3f8b-a8b7-839792cbfbf6@kernel.dk>
Date:   Fri, 19 Jun 2020 09:23:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619152208.GA62406@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/20 9:22 AM, Alexey Dobriyan wrote:
>> 	uint64_t val = cqe->res; // assuming non-error here
>>
>> 	if (cqe->flags & IORING_CQE_F_ZONE_FOO)
>> 		val |= (cqe->flags >> 16) << 32ULL;
> 
> Jens, ULL in shift doesn't do anything for widening the result.
> You need
> 
> 	val |= (uint64_t)(cqe->flags >> 16) << 32;

You're right of course, guess I should check my in-mail code a bit
better :-)

-- 
Jens Axboe

