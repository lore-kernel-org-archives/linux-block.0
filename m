Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15410C4332F
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 20:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A8560D07
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 20:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhKAUGo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 16:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhKAUGf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 16:06:35 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D9BC061764
        for <linux-block@vger.kernel.org>; Mon,  1 Nov 2021 13:03:59 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b203so7683648iof.1
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 13:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4AtCK1XuB5hE5TDzH4q2BKS4Nibuf/j8sQQv1NGRnaQ=;
        b=XB6PscRyDKDTZzcg4QMUbxg4lPOr6Xr5BOoS2wpTZybKd9DyiuEqJ8Zr9Zx1R6MfUA
         iHRlgCAv1EAdx8HAGdeuIud9RVEyvSrnjyg6BK9ADpWrBEqRBSce9PJIORFdl/08a4t1
         6DBuVnR8aM6CXxhaUvMxMpTjz2i/eUrjii7G3a6vmoHUceuA8yKg7LOxO714Z1rKGvMr
         peCKkg9R/G8yF3p173Dzvmll40T5z8uywooV5YR++IdRH876tWwD4Qhl/IaTO1qRrdeu
         Ho0C8LQlzgx391FOIT0DHV80WZdjniywYBfWFTjPKZ0A7tVP7xnEa1mmqZ02F7KeWXAH
         xBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4AtCK1XuB5hE5TDzH4q2BKS4Nibuf/j8sQQv1NGRnaQ=;
        b=uNzHZaXysoeQeiT2i/b5otY20hOPpDb+LVI2U8cnAXV/DNHr4//Dh7LUrbDQaILRcS
         k0NrZJ3mqYvTZiiO0V2OyWeYqg/u3ke6BO6lPtO2FVLSlgx2UGyfH59hhhWOfe2ltpFs
         ND0gc2sL12Z65wuxtkAeMpNLz/2qDKUDuQzsThkQUoD6CV4grADtsmJUo8OpNTWmGbgk
         HRffLLQV+9FuhgwJGj4OBYuaTue09yE1TEzXOWzWHakLANAPkaf9xx3gFHDHYgkJz3Nw
         2Rqxrq/YrBgNTqWOruwZTe5vtxpVF29GOWotoria/QVJAocpuAENybF8nnIgrV+Owpqa
         +ytw==
X-Gm-Message-State: AOAM5305PWz6Gz4KR6ciBtw/5oc47VqdLl/8HbzcYOgt2osqZrRLZ5H0
        gs2FfGl3IyVXWuCuG1HsItz8lLUXzlOlAQ==
X-Google-Smtp-Source: ABdhPJzUtbdwP48XmX6Yf2KQplfpteDUN+Np9mYvX3Vrc5UXL/Im4+Oc46ZIwPUmqkCgY2gneSHdKQ==
X-Received: by 2002:a05:6602:2b10:: with SMTP id p16mr22628078iov.207.1635797039099;
        Mon, 01 Nov 2021 13:03:59 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p13sm5889839iom.23.2021.11.01.13.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 13:03:58 -0700 (PDT)
Subject: Re: general protection fault in del_gendisk
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7468db5d-55b4-07c9-628a-9a60419d9121@linaro.org>
 <2bf04f26-4e82-a822-90ce-4c28e2c0e407@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <90d72173-edd8-79d9-b680-b1d47ab78150@kernel.dk>
Date:   Mon, 1 Nov 2021 14:03:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2bf04f26-4e82-a822-90ce-4c28e2c0e407@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/1/21 2:01 PM, Tadeusz Struk wrote:
> On 10/29/21 12:13, Tadeusz Struk wrote:
>> Hi,
>> I'm looking at a bug found by the syzkaller robot [1], and I just wanted
>> to confirm that my understanding is correct, and the issue can be closed.
>> First, the kernel is configured with some fault injections enabled:
>>
>> CONFIG_FAULT_INJECTION=y
>> CONFIG_FAILSLAB=y
>> CONFIG_FAIL_PAGE_ALLOC=y
>>
>> The test adds loop devices, which causes some entries in sysfs to be created.
>> It does some magic with ioctls, which calls:
>> __device_add_disk() -> register_disk()
>> which eventually triggers sysfs_create_files() and it crashes there,
>> in line 627 [2], because the fault injector logic triggers it.
>> That can be seen in the trace [3]:
>> [   34.089707][ T1813] FAULT_INJECTION: forcing a failure.
>>
>> Sysfs code returns a -ENOMEM error, but because the __device_add_disk()
>> implementation mostly uses void function, and doesn't return on errors [4]
>> it goes farther, hits some warnings, like:
>> disk_add_events() -> sysfs_create_files() -> sysfs_create_file_ns() - > WARN()
>> and eventually triggers general protection fault in sysfs code, and panics there.
>>
>> I think for this to recover and return an error to the caller via ioctl()
>> the __device_add_disk() code would need be reworked to handle errors,
>> and return errors to the caller.
>> My question is: is it implemented like this by design? Are there any plans
>> to make it fail more gracefully?
> 
> Hi,
> Any comments on this one?

People will take a look at it, but you sent it out on a Saturday right
before a merge window, doing a 'ping' kind of followup on a Monday is
way too soon.

-- 
Jens Axboe

