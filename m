Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0129C32771
	for <linux-block@archiver.kernel.org>; Mon, 26 Sep 2022 17:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiIZRS7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiIZRSj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2022 13:18:39 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486ABE1098
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 09:32:45 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id h194so5680656iof.4
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=BxnsyrNOfRRvN4ZxwiPkZaVoZKcCqMXtLHTaeCguwX4=;
        b=KBC9QeNVMBnQErEdrDFPIQawHLknQnGE6SAYOpJC3hxSMiGNYPpGNkAJ/FhdC/ClCg
         tc1kiMOrX5LKuH1dYd29r02uKM0gtzoAguu1QcX3qOhLEazXtNHoJ65yGmqENYoHuwtm
         6056Mt/ITJf9IEt5SohjtVrsCS2hIRg07g1QQRUU0BJEk1fSqr4U/6xXz8zIFQ8efmDR
         iHvywvdbZIM39V1jNyxhAw27EDk4eCe4mpFQio6WcwZCxMc3v3nWtsYgC5PMhxSwujy1
         zp8qsFkMt0ux5iYPgioDdgtXbBQXz2vnEjDAt+xazrVZQ1drrCo4XcLyBfO+GvlC3BhH
         xWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BxnsyrNOfRRvN4ZxwiPkZaVoZKcCqMXtLHTaeCguwX4=;
        b=7Md+5hnGn2fDkqkKqVF/zI6517Ci4yTVdQBpc1E0uFsmrzU5k8wkVd9ovcKMQuNRs+
         HvoKyBNBiCUV3qzvh2XSa925tr9FWMPHU3HGinPmRt+WJPzJ/QxDm+hicFKZeSxq0MfV
         3yB2QLrcE1Silj1S+o2VrgR8x6bfqocd/y5uaBPDY9hu8ZdUSSGJJQjSjCGFaS2PkQAG
         dglHo3RSYj3MV6LxVLkzBC8yq/okDCuixfXwNJV9xDffzLGPvHo3ZOvRWUIJjBdtmlFf
         jsocWtPW7i8cbw/XlFxbnvcekASD6SIsnCzq90xWyRdtnrN1AbCklEI46YxPuVwLv9we
         O7Lg==
X-Gm-Message-State: ACrzQf3w45+vQjw/x8BNmks/c7HhfQ6axWb7FZoT0Ai2csjXX0JrZVls
        KinDVK00FOCxsmasB+4zd5QGcw==
X-Google-Smtp-Source: AMsMyM7hRmBGrNShU4EhDsmsaeaEdPVCEoPbLI2JqvhBfa9c1h1+675I8JpTEILBHkfM48YVXbJjmQ==
X-Received: by 2002:a05:6638:19:b0:35a:52a2:dfbe with SMTP id z25-20020a056638001900b0035a52a2dfbemr11450888jao.213.1664209961137;
        Mon, 26 Sep 2022 09:32:41 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h44-20020a022b2c000000b00358422fcc7bsm7194378jaa.120.2022.09.26.09.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 09:32:40 -0700 (PDT)
Message-ID: <2ee6a897-87e7-0592-2482-9928a9a63ff6@kernel.dk>
Date:   Mon, 26 Sep 2022 10:32:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] block: modify blk_mq_plug() to allow only reads for
 zoned block devices
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, linux-block@vger.kernel.org,
        damien.lemoal@opensource.wdc.com, gost.dev@samsung.com
References: <20220925185348.120964-1-p.raghav@samsung.com>
 <CGME20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef@eucas1p1.samsung.com>
 <20220925185348.120964-2-p.raghav@samsung.com>
 <YzG5RgmWSsH6rX08@infradead.org>
 <d5975b62-f2e9-dcde-e332-a73cca1f7fbf@kernel.dk>
 <YzG6fZdz6XBDbrVB@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YzG6fZdz6XBDbrVB@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/26/22 8:43 AM, Christoph Hellwig wrote:
> On Mon, Sep 26, 2022 at 08:40:54AM -0600, Jens Axboe wrote:
>> On 9/26/22 8:37 AM, Christoph Hellwig wrote:
>>> On Sun, Sep 25, 2022 at 08:53:46PM +0200, Pankaj Raghav wrote:
>>>> Modify blk_mq_plug() to allow plugging only for read operations in zoned
>>>> block devices as there are alternative IO paths in the linux block
>>>> layer which can end up doing a write via driver private requests in
>>>> sequential write zones.
>>>
>>> We should be able to plug for all operations that are not
>>> REQ_OP_ZONE_APPEND just fine.
>>
>> Agree, I think we just want to make this about someone doing a series
>> of appends. If you mix-and-match with passthrough you will have a bad
>> time anyway.
> 
> Err, sorry - what I wrote about is compelte garbage.  I initially
> wanted to say you can plug for REQ_OP_ZONE_APPEND just fine, and then
> realized that we also want various other ones that have the write bit
> set batched.  So I suspect we really want to explicitly check for
> REQ_OP_WRITE here.

My memory was a bit hazy, since we have separate ops for the driver
in/out, I think just checking for REQ_OP_WRITE is indeed the right
choice. That's the single case we need to care about.

-- 
Jens Axboe


