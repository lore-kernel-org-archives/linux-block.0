Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FE0C4332F
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E09AF6121F
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhJUOiD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhJUOiC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 10:38:02 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC64C061348
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 07:35:46 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id v77so1129799oie.1
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nYizJ/nuHwnjXaUlZmhnL7XHcjukCYe58+uBV+TNUy0=;
        b=dXL+Dez8Df/+OmQhuQ2fBPJ0e/poY80CtbtBu6UwvKYX+w3HSUl0FtArgV6P2EMvrW
         8ZGPuU1dWbaIeJCpL2tL7Nq9wovOmzZtrVNlp0nnMGnevX+FGBQQYYdhQhJD19AyGAll
         S6uexlYkXy7k2X41zKaLNX0uc3xuaMBrndnx0HcFRDaS2LNQ1+gzcjvKuDMXHIUnZ03S
         XPpzAoGZLKcbvm1tkKGVxbwHyRUiAuwu7IqfQ/9Z96H1otdsJ2Fej6NX5hFG5GuhSYGy
         RfFskthZctAvDgEf/QrTJXTZTTn5AAiFxlskwdvFtdOyp4uy8+Dj9zfhjwWxtwP6siWD
         A2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nYizJ/nuHwnjXaUlZmhnL7XHcjukCYe58+uBV+TNUy0=;
        b=lcAIPi4T5dFnDYAL2ztzDX4Ff6HRKoE/yBZwyf6g3WJJ6AA0bVh/VElSQxVYoA8OaN
         qR9+267u3Qm8hSktFMvdp8RdfKDohH8ZljTQt8yEbB6LdnQTjn5WXx5EqLD5ZL6laP9P
         EwH9kPXoqth0IL0BeHGiAEcE2shkXMe8cV1d+JfiieaUm8ivp7a4nju9YTn/qi2oGd4I
         YdeDv9W42bnVabXPnM94rBE8v7NteETGtgy4T5xKAQjoZaMtqS/wgv7z8OxDyNatXHAd
         FEdITmk/4FbSHWv2vyYK6lOPjJYpgXAYuA0OKplf33wYYz2wtcvwNv1UPmfLdofXE7Ja
         uIXg==
X-Gm-Message-State: AOAM531B2DVSJGw5boagnICvQkn4S9ipDmQJc7qOsGtr57F5Caj/O7DW
        BVYEa+lsj+97cAq/GmIUokak5dehq+bHX3C3
X-Google-Smtp-Source: ABdhPJxWqA09KwjQoOuT19z0e5ihfYskg5XFT15ttw6yi8pWO9OO7fg1NnzWrh1819t+8NgtGboBlw==
X-Received: by 2002:a05:6808:221e:: with SMTP id bd30mr4767332oib.115.1634826946186;
        Thu, 21 Oct 2021 07:35:46 -0700 (PDT)
Received: from ?IPv6:2600:380:783a:c43c:af64:c142:4db7:63ac? ([2600:380:783a:c43c:af64:c142:4db7:63ac])
        by smtp.gmail.com with ESMTPSA id w20sm1069864otj.23.2021.10.21.07.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 07:35:45 -0700 (PDT)
Subject: Re: [PATCH 1/2] fs: bdev: fix conflicting comment from lookup_bdev
From:   Jens Axboe <axboe@kernel.dk>
To:     Jackie Liu <liu.yun@linux.dev>, hch@lst.de
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <20211021071344.1600362-1-liu.yun@linux.dev>
 <163482627258.38562.7953994214106016215.b4-ty@kernel.dk>
Message-ID: <2f3adf35-28d4-9fe3-0541-8aa580cda6f4@kernel.dk>
Date:   Thu, 21 Oct 2021 08:35:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <163482627258.38562.7953994214106016215.b4-ty@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/21 8:24 AM, Jens Axboe wrote:
> On Thu, 21 Oct 2021 15:13:43 +0800, Jackie Liu wrote:
>> From: Jackie Liu <liuyun01@kylinos.cn>
>>
>> We switched to directly use dev_t to get block device, lookup changed the
>> meaning of use, now we fix this conflicting comment.
>>
>>
> 
> Applied, thanks!
> 
> [1/2] fs: bdev: fix conflicting comment from lookup_bdev
>       commit: 057178cf518e699695a4b614a7a08c350b1fdcfd
> [2/2] scsi: bsg: fix errno when scsi_bsg_register_queue fails
>       commit: e85c8915cf374af76efdc03a53a20fdec9d8eb5a

Eh, I only applied 1/2. The other can go through the SCSI tree.

-- 
Jens Axboe

