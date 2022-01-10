Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A44CC433FE
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 01:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiAJB7C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jan 2022 20:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238054AbiAJB7B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jan 2022 20:59:01 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3EAC061748
        for <linux-block@vger.kernel.org>; Sun,  9 Jan 2022 17:59:01 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id o20so3611033ill.0
        for <linux-block@vger.kernel.org>; Sun, 09 Jan 2022 17:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XRSlWSOwl4Vpt5hVHwQzwHcS4ZVgPWX/VD2cJFBVCLA=;
        b=jHNJpwwLSWzzMj4sNlQWK3Xz/rGxRKUVu7eIRnVnCLMhDMaKe0UmGzqOLXl+qtrfT1
         lo+lWvm8MqNyBVIOHrolWJBsiH64TPV3y2uqR+pEMRtPvgAlY8aFLpY3dNB9zeJRqU5o
         8PZf7Al8pSjYiNuYjzDXsKWYOJKnwRqshTZ0ylTEVizQuHuL9LKRUbg9+6Q4MEyxhVsh
         Gf8zXX/2N17+8pZVAz9w9/vWjchEbRGwC+g0gwZqPZYYtnDEds46KKn2oFTfazCovWCd
         4g5jPifCPsMhOPZfrE1iBSmF9cvKb/9iUclMSllRdLNuofg/JI75XhWxnPqMdb6aY2KP
         FhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XRSlWSOwl4Vpt5hVHwQzwHcS4ZVgPWX/VD2cJFBVCLA=;
        b=XbNA3nF1/Ph/NT/NhoHT94di32Lg2UcMaa4G7LwfL8nsT2tKvnIKu6ubI2XEEWZtih
         /sTZf1sdKYs90iwe0I5n5wSDiyyNICGD1PMjF6+G76nVqg+bq6a4ZwUBVQ9a4SdA8nvW
         a6D2rIdo/ANz7BuvKj5qCwwrtM5aDrNajbXy8A9q0GYTer2q4vVJl8MiU1aIm77jxDAc
         eHP9dwcqB85RXH6rcJ0IuaIb71fK8CKT1rhc3rbj5Q82VicdMxIuINOThovI5/UoIj9o
         6QZVA97gag5ISRjC9617EnUUODc2PPZiHfEUTv2EA2kb8ETrWKyGkdTWj9yIersH4reT
         pztg==
X-Gm-Message-State: AOAM530y5XRlbqq33FK0GelJCeyMyU7xiWOg0lrq+B7edeAH7pNxB6HY
        RvRTa44EAA8rRoksuKDZKbVK7Q==
X-Google-Smtp-Source: ABdhPJxbva2uyCGNav/0mBTbzA1NRPx9JpqffAXn1gwCOuny6jQxJkr5MKyo/hJha2pgxvwFovaJNg==
X-Received: by 2002:a92:c685:: with SMTP id o5mr34948623ilg.152.1641779940894;
        Sun, 09 Jan 2022 17:59:00 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j2sm3352550ilr.71.2022.01.09.17.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 17:59:00 -0800 (PST)
Subject: Re: [PATCH v3 0/8] docs: consolidate sysfs-block into
 Documentation/ABI/
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20211209003833.6396-1-ebiggers@kernel.org>
 <YcH1uxfdTRHIwl7Y@quark> <YdMQ6rfSZWSOLptA@quark>
 <YddiJFr+ba7Veh82@sol.localdomain>
 <65376e36-579b-76c4-0642-4582d6679914@acm.org>
 <ef487b83-a1cc-d8a5-8a45-d0fec5eed94b@kernel.dk>
 <YdtS3x0M1qFcN3R1@sol.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fff11146-f759-2887-5c80-6449dbc16717@kernel.dk>
Date:   Sun, 9 Jan 2022 18:58:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YdtS3x0M1qFcN3R1@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/22 2:25 PM, Eric Biggers wrote:
> On Sun, Jan 09, 2022 at 10:01:11AM -0700, Jens Axboe wrote:
>> On 1/7/22 1:58 PM, Bart Van Assche wrote:
>>> On 1/6/22 13:41, Eric Biggers wrote:
>>>> Jens, any reason you haven't applied this series yet?  It looks like you've been
>>>> applying other patches.  To be clear, I've been expecting that this would go in
>>>> through the block tree, rather than the docs tree.
>>>
>>> We are close to the v5.17 merge window so this is not a good time for a maintainer to
>>> apply a large patch series. If Jens does not reply I propose to repost this patch
>>> series after the v5.17 merge window has closed (three weeks from now?).
>>
>> I'm fine with it, but it should probably just go through the doc tree.
> 
> I think it makes much more sense for subsystems to be responsible for
> their own documentation; that's why patch 8 in this series adds the
> block layer documentation to the block layer MAINTAINERS entry.  Do
> you disagree with that?

I agree, but then we often end up with merge conflicts between the doc
tree and others. That's why it's usually punted there. As a maintainer,
any conflicts is a pain in the butt to deal with, something the
contributor doesn't necessarily see or understand.

If there are no conflicts this time around, I can queue them up.

-- 
Jens Axboe

