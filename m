Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36004C433F5
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 20:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165E060FC4
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 20:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhKAUET (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 16:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhKAUES (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 16:04:18 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F3EC061714
        for <linux-block@vger.kernel.org>; Mon,  1 Nov 2021 13:01:44 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v20so12387551plo.7
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 13:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=//qLyozC7UQaBdURgH8zYX1NEvcJQYYYqxcLEEiD/C0=;
        b=peBqNdpy1901jw2VuRMcFADsSNPGF2oy8Kr3JTH5yjMnOZlkZ7FUSw2c+AbfaWojkL
         u1kye+XZNhbFlI5FANhCGhNvqQHCaD9wlL60y6neZNgZ/aE7uJjVYizEhfyP6ZywkXtd
         VSlfE1AYfiWuUjtlNT8xjq+tksH6x+z3jhxKPvjYXr1KWwMFrJmFKVkxzcAS6n7gLy3E
         oI2RURVtjxWVv2m6FeAnrJhrHm9UQQMiNHUIMbsCd8Pngg7Kg9l3w5subPAqC9lA2D3C
         eIoQThPd3PQcZcDEC9f7/1QFI5rMb1H1J0rxWNXhl8LkFxqbRFuzEvySsq6t/MVzOznT
         usaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=//qLyozC7UQaBdURgH8zYX1NEvcJQYYYqxcLEEiD/C0=;
        b=wLeolZghY1d2XC27XggriUuM2tNlD2tcBEVNMJqCfGJvrOwodl/nGg4cfc3oVs0bKj
         FeyxG0Xr3V0VhTLahTwfP0mSFH170elFegkXZmlzbeJj+1M9EsQ4EmxQIcU2HG3XNViQ
         PLLH01GLx81JsnBnSM4OObzaVG8NYQpmfoD001cX6r7/OQZfTL2p4AX2v8q3PgatLsRl
         liQgGn6S3BEFa/SQsR39zJxpggg9rthG/ZEKH1Rf4yX93cmZg0nWn+i9KnywF+0eaX6d
         k2AuynKlD60Z0pT+rdL9yLNElcV/ZxCIRFjgwIqGkvljYMIV7nJsKcoTREOlqSnBMYRY
         r6WQ==
X-Gm-Message-State: AOAM530NLYC5yVHHadU20HcTuTXP/Q4WB8JEGLIP041VOQNkcjLMrKBk
        7vr34f1zYADAPKg5PXtOxRK5NA==
X-Google-Smtp-Source: ABdhPJzxz3cnVsLDaAL1jCkkJjFC5U9ToZGS8xlNZ6wLOTkNhl62tXI+5y13i4LrDg7zVvr5wX7rbA==
X-Received: by 2002:a17:902:c407:b0:13f:68f:6753 with SMTP id k7-20020a170902c40700b0013f068f6753mr26985851plk.39.1635796903499;
        Mon, 01 Nov 2021 13:01:43 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id mr2sm258610pjb.25.2021.11.01.13.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 13:01:43 -0700 (PDT)
Message-ID: <2bf04f26-4e82-a822-90ce-4c28e2c0e407@linaro.org>
Date:   Mon, 1 Nov 2021 13:01:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: general protection fault in del_gendisk
Content-Language: en-US
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7468db5d-55b4-07c9-628a-9a60419d9121@linaro.org>
In-Reply-To: <7468db5d-55b4-07c9-628a-9a60419d9121@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/29/21 12:13, Tadeusz Struk wrote:
> Hi,
> I'm looking at a bug found by the syzkaller robot [1], and I just wanted
> to confirm that my understanding is correct, and the issue can be closed.
> First, the kernel is configured with some fault injections enabled:
> 
> CONFIG_FAULT_INJECTION=y
> CONFIG_FAILSLAB=y
> CONFIG_FAIL_PAGE_ALLOC=y
> 
> The test adds loop devices, which causes some entries in sysfs to be created.
> It does some magic with ioctls, which calls:
> __device_add_disk() -> register_disk()
> which eventually triggers sysfs_create_files() and it crashes there,
> in line 627 [2], because the fault injector logic triggers it.
> That can be seen in the trace [3]:
> [   34.089707][ T1813] FAULT_INJECTION: forcing a failure.
> 
> Sysfs code returns a -ENOMEM error, but because the __device_add_disk()
> implementation mostly uses void function, and doesn't return on errors [4]
> it goes farther, hits some warnings, like:
> disk_add_events() -> sysfs_create_files() -> sysfs_create_file_ns() - > WARN()
> and eventually triggers general protection fault in sysfs code, and panics there.
> 
> I think for this to recover and return an error to the caller via ioctl()
> the __device_add_disk() code would need be reworked to handle errors,
> and return errors to the caller.
> My question is: is it implemented like this by design? Are there any plans
> to make it fail more gracefully?

Hi,
Any comments on this one?

-- 
Thanks,
Tadeusz
