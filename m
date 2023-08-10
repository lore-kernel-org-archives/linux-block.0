Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3237CC04A94
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 13:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjHJNSc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 09:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjHJNSb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 09:18:31 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AC9121
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 06:18:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6878db91494so182103b3a.0
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691673510; x=1692278310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YgYLgMrkq2R3jhoJuI2J8T6JkrX4yvrwXFTezbq+9Y4=;
        b=O0lNkK2Ayd5sZz5kcedM/g8UaeDHkq702jG3NqYfoD2OyLZeWOx7MU+PXTOvq7d/Vn
         XT22ZTRvFkYQZiCQW9s0FkuNmTm8RSTsPzIFx+bQ8aHKUuk2M8E04EeeFtDX54NRdPJB
         rNQ+lYc/8Pj3HVv49i/WsGWaE5WusWLjJ9Z+/LQ+czS6pX9zZ1Tm/xX5lcWN7Y1rdQoI
         qotCq3O2+1M+07RmraDKIpCETxGlRPBIWTdjJk3g5On7T6aeF5xYd1kBBioGo14MBFDl
         GdkwSWH0jpaJHSgLKuE1H8DGbfCLHD6pvGG//i1Dm2LzBLsSglps3r1HmnMqUDe7ut1H
         /u3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691673510; x=1692278310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgYLgMrkq2R3jhoJuI2J8T6JkrX4yvrwXFTezbq+9Y4=;
        b=ksJA3Nasbqwdeams02VTWY6KkT8FIR1ZEOI3XuKUXIGr7joGc8oXRWuY2NGEyVxmRA
         NK/P1pGXMiDO1jKM94y5XCPwdxYcLwJMAhyzwW5kOh4qqo+LTVdgdzEs/b+PVwm5h0m6
         1Rc9/Fn2Kv/AJHaknGadGWbPiDjFkUqyR/foJ7W1Z545mC21NHpUGiRQS+7nD5EmTP8m
         SSEf+fsQ7TrVjj8mAWR3+7SZ4UdSfl4x3TzUr2joaeL9U8e/BThdThMFgPFt4UiDW/j1
         Yx+uqipDZv2fDdvPxVatl9y8rZEIPBOA2ceLN86gmYkgMRp+C2tlsYerN0mPMn3D/oN+
         spdA==
X-Gm-Message-State: AOJu0Yy0XIx4JiPX7XY8nqKAt/luICFn7XP4mbS3eDwYEyW8bqyBbsJ5
        IlMikI0+o+FoNg/1aLDsWtHbrg==
X-Google-Smtp-Source: AGHT+IEPH0QiNs4MzGBUQvqmIJa5Qhsu7LUDs0vn2KRwH+tNxdI3WiT2nuPKyqV5PYqqUr5kLFBBww==
X-Received: by 2002:a05:6a20:8e28:b0:13d:d5bd:758f with SMTP id y40-20020a056a208e2800b0013dd5bd758fmr3316513pzj.6.1691673509783;
        Thu, 10 Aug 2023 06:18:29 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u7-20020aa78487000000b0066a2e8431a0sm1487825pfn.183.2023.08.10.06.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 06:18:29 -0700 (PDT)
Message-ID: <29a213de-d7c7-4e53-8b5c-eb742dcf23ea@kernel.dk>
Date:   Thu, 10 Aug 2023 07:18:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk-crypto: dynamically allocate fallback profile
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, kernel-team@meta.com,
        ebiggers@kernel.org, stable@vger.kernel.org
References: <20230809125628.529884-1-sweettea-kernel@dorminy.me>
 <94c661a6-442b-4ca2-b9e8-198069d8b635@kernel.dk>
 <2023081023-parsnip-limb-dcd4@gregkh>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023081023-parsnip-limb-dcd4@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/9/23 10:53 PM, Greg KH wrote:
> On Wed, Aug 09, 2023 at 04:08:52PM -0600, Jens Axboe wrote:
>> On 8/9/23 6:56 AM, Sweet Tea Dorminy wrote:
>>> blk_crypto_profile_init() calls lockdep_register_key(), which warns and
>>> does not register if the provided memory is a static object.
>>> blk-crypto-fallback currently has a static blk_crypto_profile and calls
>>> blk_crypto_profile_init() thereupon, resulting in the warning and
>>> failure to register.
>>>
>>> Fortunately it is simple enough to use a dynamically allocated profile
>>> and make lockdep function correctly.
>>>
>>> Fixes: 2fb48d88e77f ("blk-crypto: use dynamic lock class for blk_crypto_profile::lock")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
>>
>> The offending commit went into 6.5, so there should be no need for a
>> stable tag on this one. But I can edit that while applying, waiting on
>> Eric to ack it.
> 
> That commit has been backported to stable releases, so it would be nice
> to keep it there so our tools automatically pick it up properly.  Once
> the authorship name is fixed up of course.

But that stable tag should not be necessary? If stable has backported a
commit, surely it'll pick a commit that has that in Fixes? Otherwise
that seems broken and implies that people need to potentially check
every commit for a stable presence.

I can keep the tag, just a bit puzzled as to why that would be
necessary.

The authorship is fine, but looks like the patch needs changes anyway as
per Eric.

-- 
Jens Axboe

