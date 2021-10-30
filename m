Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BCDC433EF
	for <linux-block@archiver.kernel.org>; Sat, 30 Oct 2021 15:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1FD060F93
	for <linux-block@archiver.kernel.org>; Sat, 30 Oct 2021 15:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhJ3Ph4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Oct 2021 11:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhJ3Phz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Oct 2021 11:37:55 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DDAC061570
        for <linux-block@vger.kernel.org>; Sat, 30 Oct 2021 08:35:25 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id i14so16164159ioa.13
        for <linux-block@vger.kernel.org>; Sat, 30 Oct 2021 08:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=f0VQ2JX5AOK/Ek0/MqjwIs7xw0kREUgashuR5g3imFs=;
        b=Zh2tC6Z9VNRR+OTeVJuhyHtzSAjhrZRw/IW88z2gmyDfu/ZYlt6fOHzJe259sKpVT9
         odFn2u5LEQd4c7piFbk5haaRxdVMlrtFCEQhvd5dgWSX7RfOWNva0eBMrxVsgm3GZCq3
         oINMxfw730inZpAkkVM1YBuGYwVoMOHVrBPJ7kPHfKxwg3adZybVfjVQRRu8kJ+pI1pV
         oxWPwcWShHRgIAKAJvHW6EG8TZ+BUjcIkUdat55QahJm0NtzbR/ecz6qdD7YM9XQjBfG
         ANz8ZClgYR6hsQXj175+ZqN4pcC87mbqjsZV9GB8tHFALlAogObPy1H80SyxYG7Q/Xey
         hu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f0VQ2JX5AOK/Ek0/MqjwIs7xw0kREUgashuR5g3imFs=;
        b=gBZi1RH0opVyPFx8ba9JUoVSmkg2A3Do7Bt1werxBMIMcr8Qf0coa8rrxfpK/+Ab0M
         QGnATNM0RRRBGf2zgpG+vVhxIoCCilKJ3QawSvOpS+Xujva+u0KIEEysJdyPRGWn2NKg
         MU8T/pDqo9wRR2/S2vmbNKuP9l1/JY8JQg+j5yejGBRD8QEu/m/nSkVl1LjN7pdJ6Lta
         OP9vooRvmzDaacgY/oKHFRk0mMZoLEGkBTrSmLyQaatPU0wddkK0tQcQfWZIYPt6Mixz
         Ul2Xtd/MipLT1pOUbLmA15ZEBR55OfqfCfJWYOSeAeQTEQed01QXEXigS4vTRExtzQjw
         3SQw==
X-Gm-Message-State: AOAM531ASXbfeRRXWBVUJaGu4SI+iuhyoJuYTXrv8tYAu3myzq+sFp5M
        H5HIwqTMDuY/MD87wCbQSxBqHcuis3oAZA==
X-Google-Smtp-Source: ABdhPJz9g40AOVUsyawdg6hGVSaTGKx7CRf4yTpNTk04xL3Y8P60iZBlurb6KMgLTeDEwGZrcF2Yfg==
X-Received: by 2002:a05:6602:158a:: with SMTP id e10mr12878034iow.157.1635608124287;
        Sat, 30 Oct 2021 08:35:24 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id a20sm5166990iow.5.2021.10.30.08.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Oct 2021 08:35:23 -0700 (PDT)
Subject: Re: [PATCH for-next] blk-mq: fix redundant check of !e expression
To:     =?UTF-8?Q?J=ce=b5an_Sacren?= <sakiwit@gmail.com>,
        linux-block@vger.kernel.org
References: <20211029202945.3052-1-sakiwit@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b312c21a-3391-deb2-02df-639b34a30b22@kernel.dk>
Date:   Sat, 30 Oct 2021 09:35:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211029202945.3052-1-sakiwit@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/29/21 2:29 PM, Jεan Sacren wrote:
> From: Jean Sacren <sakiwit@gmail.com>
> 
> In the if branch, e is checked.  In the else branch, ->dispatch_busy is
> merely a number and has no effect on !e.  We should remove the check of
> !e since it is always true.

Applied, thanks.

-- 
Jens Axboe

