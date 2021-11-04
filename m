Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CB0C433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72C636121F
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhKDSiE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhKDSiC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 14:38:02 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B714FC061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 11:35:23 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id v40-20020a056830092800b0055591caa9c6so9552028ott.4
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 11:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pxor2PanzfqqDnoADZyr2iE8QUIoLLSlfLXLUVuix+0=;
        b=ee4zuJmTncJejSZrCrX9YPMrsj+Ljy+NeixA07w9vXZLPQr2tnm56yw56STXhtA4RC
         Mvciscr0fnJwiei0rEcEuBAC8ysuFAFWDrKhRCYJLutpvuZXLhhp4t163fwlLCsrq9Mp
         so6nLbmDsy4VpLyCjeBM0LXzniQ7TrKf0z+1sZD0LuK+xiMXXboMpEqKFfQ3U1G4t+kw
         syGiJLwQNJUgGyKOOQPilbfXDH1cKrFQJcmN/9+DCyqsLmpZI0fH6LnPD/jCViTgh3pn
         yxpnEx9St4dXpuy5N42ichiheYpMO8DLThxYZVodU406/iXM2pzMXJvo+h/FPEAIiOx3
         Ls2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pxor2PanzfqqDnoADZyr2iE8QUIoLLSlfLXLUVuix+0=;
        b=W0jRzqyCJ/Eh30viDbRoeFzexhhgxrfolf/SEI1tlDW1ZdipXKVZFBGyZkQDTjSCJm
         txoQ/0BMB3sxqhjE3rXzIBpGuGc9lm2J0bYbk5l4vEeo+KoF5ISSo5XYTTR1sjdsAOQs
         thyhmEqcECrHFY78yk4k8e1oKGv9igJoeqZM8DcwcJnD3X6GaUqsB8k6T/L0t3V+8Tgd
         ttUZFcL3JawwdYbAV8yIA9CsueXOA/7QQA5gbr2ck2ln+pO7LxxoTLNK9wJADkBVfLAU
         /sszfBYZTDitse1x++qMups28m4zHLwpV8/hjKIqjpqPPYwWcsaS1DgkhSRRHU2Db7rT
         fXWA==
X-Gm-Message-State: AOAM532kmVG/ygMmzjZNH36YHosx/IZlTyTpaJbv3oQEvzfS9qZMzR3N
        hcHVBtPWFnzFo+k0RuULPWGwE5xo8jNvzg==
X-Google-Smtp-Source: ABdhPJz45tHPp1OicNpf88ODaZZblFCqt2DIXvRVsXpWLl+lPa7fLYWJXaVelZ4Mekc68EaQgAei/g==
X-Received: by 2002:a05:6830:6:: with SMTP id c6mr39049993otp.273.1636050922925;
        Thu, 04 Nov 2021 11:35:22 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z6sm1619578otp.22.2021.11.04.11.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 11:35:22 -0700 (PDT)
Subject: Re: [PATCH 1/5] block: have plug stored requests hold references to
 the queue
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211104182201.83906-1-axboe@kernel.dk>
 <20211104182201.83906-2-axboe@kernel.dk> <YYQnxC65eFMXj3op@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5c0535f0-253b-1a47-b76c-5d3dfeb2bc4f@kernel.dk>
Date:   Thu, 4 Nov 2021 12:35:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YYQnxC65eFMXj3op@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/21 12:34 PM, Christoph Hellwig wrote:
> On Thu, Nov 04, 2021 at 12:21:57PM -0600, Jens Axboe wrote:
>> Requests that were stored in the cache deliberately didn't hold an enter
>> reference to the queue, instead we grabbed one every time we pulled a
>> request out of there. That made for awkward logic on freeing the remainder
>> of the cached list, if needed, where we had to artificially raise the
>> queue usage count before each free.
>>
>> Grab references up front for cached plug requests. That's safer, and also
>> more efficient.
> 
> I think it would be useful to add zour explanation why the cached
> requests should be flushed at schedule time now here.
> 
> Otherwise this looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, I'll add a comment when amending with your reviewed-by.

-- 
Jens Axboe

