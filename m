Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5A7C433F5
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 12:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiEWMgd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 08:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbiEWMgP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 08:36:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EBC14D07
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 05:36:06 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b135so1824980pfb.12
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=INkfgsb8DgkgWmtKMANQ1Vo1QXhIfhnDd/K2kDPrH3Q=;
        b=1fhqz3+apWfJ+ZsEhTE6mAVaEw1c/7DNg5ozDW0PFTFoPjcNQOq1PewkdDlvrMsykq
         zYigUM7hOavb8VqDpEuzNufWasevbXmlT6JhI1F/KHvLNxI23r+ANzri4beDnNmNEL13
         ODquPR328ZY4b40JXwFPQTOnTnwYkbGYWED9ZOV5MeVDmCJrfQPqUoJFL7W7Y48MHVtx
         BnpWrbGRb4TRH9+dWCJo8TrBOSVnWQ+NMpzcn0l3qKbGeVKPKOffJedFeiBSm8MDr5s6
         IuVdKGNPEhNpBRS154C67LLzdc0nq4Z/9VZCWPjPwJ9aAKXm0EQahgtm9sGMSkF1DvIm
         VMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=INkfgsb8DgkgWmtKMANQ1Vo1QXhIfhnDd/K2kDPrH3Q=;
        b=FYHhfYgSAf3sdjQQjK2Q0/zpEmVVtIFoAui/kYh6TgQK+MeWATc0yiXzMyQxUJeL38
         tqlguU0+Uq9wo35DG5cBZ8rL3DX1JwX5NTfu/eP0DAW9Qgy1g+RO/VebQNy2kkVCKNOJ
         5FnkDeNc6YAyn9xWn7LwOkrZYmRVPYDmZ0kNInTTq9YeRvSDwh99z64ShuZREWY3XxUx
         lmUYt6FOmPThbYM8reaivGFQ6/3Hw/L71G5b3AVNShJ1ig+AZVCB9CUbR2fsGSfJ/XsN
         oMKLrNA9O2nyb8dWJ4oATth3XcNkalJpvHwSwPAN+G2zjjrGTYC17zVAA1scK4oKxZ/5
         E0Kw==
X-Gm-Message-State: AOAM530XC2IHUPk9Gpw4tPWQcSLDhLx6yOTKPUfT2kzIrepI8DTbX+Vn
        CeFK/TPqLgU2o1XZDOruJBKisg==
X-Google-Smtp-Source: ABdhPJxgbS504JkLNi1GG1RBkkzpmYhy4T9e/1i/En0Pu2KHyWvPQjZQaaYP37Mzz2R5Jcq9YxVMNg==
X-Received: by 2002:a63:cd0b:0:b0:3c6:afc0:32a6 with SMTP id i11-20020a63cd0b000000b003c6afc032a6mr19958954pgg.436.1653309365142;
        Mon, 23 May 2022 05:36:05 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b24-20020a056a0002d800b0050dc76281besm7012750pft.152.2022.05.23.05.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 05:36:04 -0700 (PDT)
Message-ID: <dfd2ac0b-74da-85f4-ff66-2eb307578d93@kernel.dk>
Date:   Mon, 23 May 2022 06:36:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH -next v5 0/3] support concurrent sync io for bfq on a
 specail occasion
Content-Language: en-US
To:     Yu Kuai <yukuai3@huawei.com>, paolo.valente@linaro.org
Cc:     jack@suse.cz, tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220428120837.3737765-1-yukuai3@huawei.com>
 <d50df657-d859-79cf-c292-412eaa383d2c@huawei.com>
 <61b67d5e-829c-8130-7bda-81615d654829@huawei.com>
 <81411289-e13c-20f5-df63-c059babca57a@huawei.com>
 <d5a90a08-1ac6-587a-e900-0436bd45543a@kernel.dk>
 <55919e29-1f22-e8aa-f3d2-08c57d9e1c22@huawei.com>
 <b32ed748-a141-862c-ed35-debb474962ed@kernel.dk>
 <1172d00f-0843-1d7c-721f-fdb60a0945cb@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1172d00f-0843-1d7c-721f-fdb60a0945cb@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/22 2:18 AM, Yu Kuai wrote:
> ? 2022/05/23 9:24, Jens Axboe ??:
>> On 5/22/22 7:10 PM, yukuai (C) wrote:
>>> ? 2022/05/21 20:21, Jens Axboe ??:
>>>> On 5/21/22 1:22 AM, yukuai (C) wrote:
>>>>> ? 2022/05/14 17:29, yukuai (C) ??:
>>>>>> ? 2022/05/05 9:00, yukuai (C) ??:
>>>>>>> Hi, Paolo
>>>>>>>
>>>>>>> Can you take a look at this patchset? It has been quite a long time
>>>>>>> since we spotted this problem...
>>>>>>>
>>>>>>
>>>>>> friendly ping ...
>>>>> friendly ping ...
>>>>
>>>> I can't speak for Paolo, but I've mentioned before that the majority
>>>> of your messages end up in my spam. That's still the case, in fact
>>>> I just marked maybe 10 of them as not spam.
>>>>
>>>> You really need to get this issued sorted out, or you will continue
>>>> to have patches ignore because folks may simply not see them.
>>>>
>>> Hi,
>>>
>>> Thanks for your notice.
>>>
>>> Is it just me or do you see someone else's messages from *huawei.com
>>> end up in spam? I tried to seek help from our IT support, however, they
>>> didn't find anything unusual...
>>
>> Not sure, I think it's just you. It may be the name as well "yukuai (C)"
> Hi, Jens
> 
> I just change this default name "yukuai (C)" to "Yu Kuai", can you
> please have a check if following emails still go to spam?
> 
> https://lore.kernel.org/all/20220523082633.2324980-1-yukuai3@huawei.com/

These did not go into spam, were delivered just fine.

-- 
Jens Axboe

