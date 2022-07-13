Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E168C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Jul 2022 23:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiGMXuB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jul 2022 19:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiGMXuB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jul 2022 19:50:01 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73A552DCF
        for <linux-block@vger.kernel.org>; Wed, 13 Jul 2022 16:49:59 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id h132so4464pgc.10
        for <linux-block@vger.kernel.org>; Wed, 13 Jul 2022 16:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IvPV3oJ9vdJJfCHBYW47RH7lM0GyR4PdZoEoClAuzZ8=;
        b=LAvAyxp4I4+n8v9SORbIIJ5N22J+7DKCmHWwajz2niYjyMyy18EYjteQv2hGEppho2
         ahbtlwpKZHKVfj1e5lUs2l9qTmMVKeLHFs+w/6ftXYLX8HQ0nyMQjJjZbTeogQSh6mFT
         gauaZ5w50UKDEj2s3wX7Mn6kSKa5ceMTCK8TaCMFkUT5hGdbThQpmkZ5MVEi7o4RnPQ5
         acgtuUQJC5vWefRGMdgaHTe16Ji8CZPKGbDM7zv1HvXGjr+M0q5XWr79QFGBGbuIXFQl
         y+M042pZk2WNyp91dBKvKVXeGdsc6xumfZ36B6apXHDOp9GwwWZdeadC5hPkN8TSv+O/
         L2Pg==
X-Gm-Message-State: AJIora9XH5Gh/RKhQFNgDM1KrS/pGUjyTgDZGQc/i2oAZhpOSiS/E2q/
        1tcnrh32lRoSpq3qrgPMG44Ep8FTT1Y=
X-Google-Smtp-Source: AGRyM1vLzflS9+Q+Xr1E1B4DFWNgPKak2akIdeSxm76cXX+bkulQapC/tRtORsaUByOmq2HjUb2MuA==
X-Received: by 2002:a62:7bd7:0:b0:52b:1d57:e098 with SMTP id w206-20020a627bd7000000b0052b1d57e098mr706908pfc.19.1657756199133;
        Wed, 13 Jul 2022 16:49:59 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:cf8d:5409:1ca6:f804? ([2620:15c:211:201:cf8d:5409:1ca6:f804])
        by smtp.gmail.com with ESMTPSA id np12-20020a17090b4c4c00b001ecbd9aa1a7sm69347pjb.1.2022.07.13.16.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 16:49:58 -0700 (PDT)
Message-ID: <0496421c-5793-40c4-4662-865fc19bbbdc@acm.org>
Date:   Wed, 13 Jul 2022 16:49:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 00/63] Improve static type checking for request flags
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <d1a88d4f-9f03-a1d6-cf4a-fcdb8070399c@acm.org>
 <ee65aa8a-2e74-9a7a-f8e6-11266744a326@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ee65aa8a-2e74-9a7a-f8e6-11266744a326@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/13/22 16:46, Jens Axboe wrote:
> On 7/13/22 3:48 PM, Bart Van Assche wrote:
>> I think that everyone who is interested in reviewing this patch series
>> has had sufficient time to review the patches in this patch series. Do
>> you prefer to queue this patch series for kernel v5.20 or kernel
>> v5.21?
> 
> I've been pondering the same. I'm fine with going for 5.20 as this will
> be a pain to maintain, but the first patch doesn't even apply to my
> for-5.20/block branch...

Hi Jens,

This patch series was prepared against your for-next branch. I will 
rebase it on top of your for-5.20/block branch, retest and repost it.

Thanks,

Bart.


