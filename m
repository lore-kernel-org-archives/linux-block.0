Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B71CC001E0
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 14:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjHJOb1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 10:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbjHJObZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 10:31:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D97626A9
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 07:31:24 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc76cdf0cbso1365245ad.1
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691677883; x=1692282683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dfLCCDH2lJon3gk1O7dp3FF9gazCYdPkfMfgDUEDf8E=;
        b=EURAVQYADIX4U/Ql2uJtC/SU+5E2wBUfGEFDWz/1HAwDr/V4yhjOCF8yS5rsc+OfOE
         KshHTsDt0VhhqpXNJRnWJf/e9xJD1BoLo+31KPek7eTtx/8OX4aIr+hwmK+i5UrAB9wr
         KSNDXe20E6RXxyRayLXgbEWFHw7lRPC4q6F6bhwpFa8Jn/YHZI3R2jHTtPBNOELFEknI
         /JY55dBisMhXA8wMeM16EQ7wuI92SGwgltoQ+wM8CCU1DIjCuj4sB0057q6STpVXbqHF
         GoGtPHUR9F/CY1263HsJoX/9tvLa+OAd5jMfGtwpsAtgo+/Lthyp4vt5kd+e9GxqmAqB
         p7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691677883; x=1692282683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfLCCDH2lJon3gk1O7dp3FF9gazCYdPkfMfgDUEDf8E=;
        b=aV/29EQkS0Huujlfm6O07A9tQhiA3cYIONFwlAX2xUtmE5jcrWhefs567hSeEGHVoO
         UCMdIFHY0rOLYZCOo/stzjGJx5SW47Ib/TpfMwdSFY3TY8UlG3zkEdL50WEpR5fFU8rt
         PLIlivipwRaulRDeIlQtZb5jrR75+f+Dkrk3jnLPb3biLBgUCiwmqlsM36a+OXp1GGxr
         IXgA7UjYWYIkhvEWfB2x97e/YE+iohDNuvoKMIXo1ERziMx8fuGh/YJQ30QS5mW5L2JE
         SDzptRc6rivWZGPp3GzloAXuxE9En/eF7ozkTx6qtuVD13DR3JyFqNNU8BHUBSkV29cF
         o/qg==
X-Gm-Message-State: AOJu0Yw247cHnT5pMt0LXGTgFO+bvv6GX95M7R9hcB8uRGzePyEmVK74
        T/Sg9Iak0pZ/NJN74aIne6km1Q==
X-Google-Smtp-Source: AGHT+IEJKGKRmPFBh/HK/d/ybnf411GaUAWNPEHIf+c1xUoCsq390IUfmMTKN5FrekqzYNVsivOudA==
X-Received: by 2002:a17:902:e847:b0:1bb:d7d4:e2b with SMTP id t7-20020a170902e84700b001bbd7d40e2bmr3169371plg.0.1691677883527;
        Thu, 10 Aug 2023 07:31:23 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c18-20020a170903235200b001b8b07bc600sm1824836plh.186.2023.08.10.07.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 07:31:22 -0700 (PDT)
Message-ID: <59c108b9-ac20-400a-804d-92e0c6a982ad@kernel.dk>
Date:   Thu, 10 Aug 2023 08:31:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk-crypto: dynamically allocate fallback profile
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, kernel-team@meta.com,
        ebiggers@kernel.org, stable@vger.kernel.org
References: <20230809125628.529884-1-sweettea-kernel@dorminy.me>
 <94c661a6-442b-4ca2-b9e8-198069d8b635@kernel.dk>
 <2023081023-parsnip-limb-dcd4@gregkh>
 <29a213de-d7c7-4e53-8b5c-eb742dcf23ea@kernel.dk>
 <2023081007-poise-zeppelin-df6a@gregkh>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023081007-poise-zeppelin-df6a@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/10/23 7:41 AM, Greg KH wrote:
> On Thu, Aug 10, 2023 at 07:18:27AM -0600, Jens Axboe wrote:
>> On 8/9/23 10:53 PM, Greg KH wrote:
>>> On Wed, Aug 09, 2023 at 04:08:52PM -0600, Jens Axboe wrote:
>>>> On 8/9/23 6:56 AM, Sweet Tea Dorminy wrote:
>>>>> blk_crypto_profile_init() calls lockdep_register_key(), which warns and
>>>>> does not register if the provided memory is a static object.
>>>>> blk-crypto-fallback currently has a static blk_crypto_profile and calls
>>>>> blk_crypto_profile_init() thereupon, resulting in the warning and
>>>>> failure to register.
>>>>>
>>>>> Fortunately it is simple enough to use a dynamically allocated profile
>>>>> and make lockdep function correctly.
>>>>>
>>>>> Fixes: 2fb48d88e77f ("blk-crypto: use dynamic lock class for blk_crypto_profile::lock")
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
>>>>
>>>> The offending commit went into 6.5, so there should be no need for a
>>>> stable tag on this one. But I can edit that while applying, waiting on
>>>> Eric to ack it.
>>>
>>> That commit has been backported to stable releases, so it would be nice
>>> to keep it there so our tools automatically pick it up properly.  Once
>>> the authorship name is fixed up of course.
>>
>> But that stable tag should not be necessary? If stable has backported a
>> commit, surely it'll pick a commit that has that in Fixes? Otherwise
>> that seems broken and implies that people need to potentially check
>> every commit for a stable presence.
>>
>> I can keep the tag, just a bit puzzled as to why that would be
>> necessary.
> 
> It's not necessary, no, our scripts will pick it out and get it merged
> eventually.  But if you know it's needed to start with, it's always nice
> to add it if possible, saves me the extra work :)

OK, makes sense.

-- 
Jens Axboe

