Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FB9C433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 09:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19F861108
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 09:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhJVJYr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 05:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhJVJYq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 05:24:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97B2C061764;
        Fri, 22 Oct 2021 02:22:29 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t16so2898619eds.9;
        Fri, 22 Oct 2021 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8wRakYYkxElrlaPhMN+8m3gMM0Ofd4s2CuL6BRUXvDg=;
        b=Ek+biRSv3O/qpa+FWdKUcAZraqR5s1HBhR6mdRXfJ4HHquUO2xiApOLTlxDeBaU9kM
         /g9txSdLG9fjqogY8NOlllRSg9ZrQNyozBBobR5yTzqIwHRQkLV/IfiH+Iyh5I72MOkL
         z96dGco0XKWw3z0hWxi8QOoqqK6aAPN5kUeFJMxIyEUNE0doDhRC4B1EaI4/9jWBRftY
         YZExPyG9ySS+dNW3GlCs2LFFvIVsebA0ippVa0xlWC9ZZ6AXYyF6wBYVebVHrlpH5jay
         WV8D9vAgy0zXGMApypzfHvVfwmwGdr7zakcQVH7feMW5A491MCxfN5UGyTeQL4bn819m
         mxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8wRakYYkxElrlaPhMN+8m3gMM0Ofd4s2CuL6BRUXvDg=;
        b=uNrwoEVjWxr9re2tvoXey+qZpAusvqMB7t6bQVQF4DCdSxO7ZbmV2pg76t8T/vMqYA
         ROVibpDXnYb8j+7VbC7M94QrB4/ORB56pvZABzcXvpuAf7SSglPZJ6ikaOGL1Bi0I5R2
         qGfBv/tDj9hT2kT7ew+BPNTCNTO3vCrffoMCZuIQejdDE5YsYuhoe3l81I2eGVwOwwf5
         AUlbDzizYh/R+gWDy5w+Gw6hw/RVoGL3nL6e3szD17k04fSl7DHIhknmLoAit/dvSRo5
         rtsnERUN5A5PISt/a2Hs63GGh1nm1y0KWJlXkb4WQflJQaGS5IDN1FFTKs+apIGgE9z8
         xnIQ==
X-Gm-Message-State: AOAM530K3dkJ7NNDP0tWIfO/h9XzODI3yNzAXr6H/7Kc4s3uKSZIgOfW
        TY4MPR0UNwipQyz0LSzrgKhiw1ePbsE=
X-Google-Smtp-Source: ABdhPJxqBmr5FAEZ2PoX3cXSIj5DNGJdKaGG2ygmftNBfkNh29V9Xqkw0DSi8xp96ScR62uKQQNJ2g==
X-Received: by 2002:a17:906:912:: with SMTP id i18mr13903323ejd.131.1634894548338;
        Fri, 22 Oct 2021 02:22:28 -0700 (PDT)
Received: from [192.168.8.198] ([148.252.133.195])
        by smtp.gmail.com with ESMTPSA id o25sm691981ejc.22.2021.10.22.02.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 02:22:28 -0700 (PDT)
Message-ID: <cdf7c768-47ad-78c4-a22a-f0f1a435b6f6@gmail.com>
Date:   Fri, 22 Oct 2021 10:22:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] percpu_ref: percpu_ref_tryget_live() version
 holding RCU
Content-Language: en-US
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>
References: <cover.1634822969.git.asml.silence@gmail.com>
 <3066500d7a6eb3e03f10adf98b87fdb3b1c49db8.1634822969.git.asml.silence@gmail.com>
 <YXFytAdeF5RPRERf@fedora>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YXFytAdeF5RPRERf@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/21 15:01, Dennis Zhou wrote:
> Hello,
> 
> On Thu, Oct 21, 2021 at 02:30:51PM +0100, Pavel Begunkov wrote:
>> Add percpu_ref_tryget_live_rcu(), which is a version of
>> percpu_ref_tryget_live() but the user is responsible for enclosing it in
>> a RCU read lock section.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>   include/linux/percpu-refcount.h | 33 +++++++++++++++++++++++----------
>>   1 file changed, 23 insertions(+), 10 deletions(-)
>>
[...]
>> +
>>   /**
>>    * percpu_ref_tryget_live - try to increment a live percpu refcount
>>    * @ref: percpu_ref to try-get
> 
> Nit: it's dumb convention at this point, but do you mind copying this
> guy up. I like consistency.

Looks Jens already took it. If you still want it moved, do you mind
it in a separate patch?

And I'm not sure I follow where you want it to be, currently it's
right before percpu_ref_tryget_live, which uses it.

-- 
Pavel Begunkov
