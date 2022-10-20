Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F970C4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 12:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJTMxM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 08:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiJTMxL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 08:53:11 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C413E17F296
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 05:53:09 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 78so19111694pgb.13
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 05:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1tSUOR0CGd4Km4WU9EABqtl9X4dWfnj8PpCfOdNXBc=;
        b=3Fin5tR+DxTOnCymWvNQXvC4DP5A9CvW/OpgGKccrmRGVFcE1OuUJQGkrqlo+ckrFh
         U+MGbaf9A8ztgk82880CFy4vbbjNXjhtqi5eSxxDu3XyziyuvWI7H9MeAMWY9hrAejxi
         5j3rfjrvbU7Jl3E5wgG3nrBCZsTDZVxaUgfEZrWPMEwVm19q7lbCXQAV/HzVjWBqk9GO
         L885iNCloh3qLdmRxDaEq+Ev5GUBKwzDFWxEGiVCxKxZsoqeQIyFeiWyyAZSrDkSNbV9
         FtkzOyVRIr86K6bOzCntYKwU4AnrmZYaZKMBUbcAFaKDCq/xXZjENs8qIFYfy1MYehUi
         L4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1tSUOR0CGd4Km4WU9EABqtl9X4dWfnj8PpCfOdNXBc=;
        b=TuImG+jPQ6MOF55um3pHwPPM/Wl35sbMBSfgL/O3H4c4F1stfvx6l9VuMsmqPWmZqa
         Iu41trjPVv97wjEUPZTuf5go4xodzTqIIlW4oeD/pF8wS7vpjs0FwqJ28t4wA6Nkt45S
         nvUuwIavg+OGSonzs08rL6h36/kFQ5o4VC858+NDCLL2oKqBrIVBn+b1Jy/Tck9jR4Ho
         66BZPyCCNnDGzyyiYARlHLraCEChxCq5rBlao3ZDShx49u8eqT7T0wsq1CmyI9nYx+zS
         IAp8TPm+4Bohn2+D+VjJSHCAbDM3uaQAlVMXg9/Xrk+G6zuTOZ7xaDUEswtkjuAwgYo/
         W8eQ==
X-Gm-Message-State: ACrzQf3WJf6wYLg4x1NZrIvP8ADXFc+NFnWZUSbPq/OAQS8//CISWrVN
        VBZctOzIhUylOgeIn7LWOQ5DnQ==
X-Google-Smtp-Source: AMsMyM7f5pr+Q4da5tL5VdWH16B7hstNTIj3sdj6G8HPE6MKotRnhdQnl2hrqR7v/as4WRggLhM+mw==
X-Received: by 2002:a63:1612:0:b0:461:4180:d88b with SMTP id w18-20020a631612000000b004614180d88bmr11920615pgl.434.1666270389223;
        Thu, 20 Oct 2022 05:53:09 -0700 (PDT)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 186-20020a6215c3000000b005626ef1a48bsm13162954pfv.197.2022.10.20.05.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 05:53:08 -0700 (PDT)
Message-ID: <80702edc-3e81-441b-efe7-a746c36f1d01@kernel.dk>
Date:   Thu, 20 Oct 2022 05:53:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RFC for-next v2 0/4] enable pcpu bio caching for IRQ I/O
Content-Language: en-US
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1666122465.git.asml.silence@gmail.com>
 <Y1EHjbhS1wuw3qcr@infradead.org>
 <dd22bf6a-8620-49c1-ec27-195e39cb4c33@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <dd22bf6a-8620-49c1-ec27-195e39cb4c33@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/22 5:40 AM, Pavel Begunkov wrote:
> On 10/20/22 09:32, Christoph Hellwig wrote:
>> On Tue, Oct 18, 2022 at 08:50:54PM +0100, Pavel Begunkov wrote:
>>> This series implements bio pcpu caching for normal / IRQ-driven I/O
>>> extending REQ_ALLOC_CACHE currently limited to iopoll. The allocation side
>>> still only works from non-irq context, which is the reason it's not enabled
>>> by default, but turning it on for other users (e.g. filesystems) is
>>> as a matter of passing a flag.
>>>
>>> t/io_uring with an Optane SSD setup showed +7% for batches of 32 requests
>>> and +4.3% for batches of 8.
>>
>> This looks much nicer to me than the previous attempt exposing the bio
>> internals to io_uring, thanks.
> 
> Yeah, I saw the one Jens posted before but I wanted this one to be more
> generic, i.e. applicable not only to io_uring. Thanks for taking a look.

It is indeed better like that, also because we can get rid of the alloc
cache flag long term and just have it be the way that bio allocations
work.

-- 
Jens Axboe


