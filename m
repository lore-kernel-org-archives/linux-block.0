Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29F8C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3E260F58
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhH0Qnu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhH0Qnu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 12:43:50 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C91C061757
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 09:43:01 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id i13so7614401ilm.4
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o8HYW+/Zf9tw4nz6INWaZfNYr7Epxy2up1nFtkB25JQ=;
        b=GxgqdxMWR2a4lVPqvXO4MdUuktX4lzdzW6VYP0M/om/QSsuYEfWRJdTLfyTxplhCAW
         9vAbrZviLYO81r5ZTPFigzzutvMs/kRg7NYozrY+69KfemTTVJoCRyVE6HrlJAKKyHfC
         NQjS6Rg+1ABF8LVTztYal9y+KiEEcFtEEy6Dm/s5NHiKTQboZrZwjVbKecnXgy90xIab
         2YVkwkpftpVa6y4BubtxGIui385/HwtSqWLcvKVZhCg5x+IvehwVZHDxGMg4Nrt/kBzs
         ZgZTGE+mn2IP5btFJaDoN+8GVehxxM3umIaRUjj4NfVDC1s0BJpUzTFClVpfbX7ZyDTo
         ZRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o8HYW+/Zf9tw4nz6INWaZfNYr7Epxy2up1nFtkB25JQ=;
        b=TLfFJXJMExBseYeWu5Pw+CJRimuh4eILTzUut7bH3USsf9jWEmLSvwLJZ95Ne/xXMX
         VA8SMzaGF07wt2Nbu6b/omcsPfhhi2OclFOZFlGcYufhyXveMfvjayahnA2LXyiUNpI7
         Dn2Yp729OGQxqv945/9XC6Hw93wAsQcY5Rvys2hPWjJ69zWm2fU2VYqKD2i8I37UdLeN
         H+ddomEWRlTS9s+UpkX8QtTWXigN/cN2uR7AIgiWR+XZY3Usq9aiXOf2C8g0V7EGc7mB
         fssoB03fRUN5HBW1TSkBHz8MXtMrrfmPU5UeccgPfIra+PUNa0CF/NfZGizRkV4cQi/t
         Bynw==
X-Gm-Message-State: AOAM533RjBZVPkcFFIIAOGBrmoSiUl5Zc8QIhdLbwxtKQz9A9I28E3hN
        vwDx90it8kV05jUf6HYlM8GUZ6c+bwOGNA==
X-Google-Smtp-Source: ABdhPJygSJeSuB44Cb6VG2IUydSQj3gjJwaxVgiSgRLJt7n5wZkiSh7JV0KhETKHE7GfedKxFqYU/w==
X-Received: by 2002:a05:6e02:1044:: with SMTP id p4mr7030016ilj.227.1630082580432;
        Fri, 27 Aug 2021 09:43:00 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p135sm3767692iod.26.2021.08.27.09.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 09:43:00 -0700 (PDT)
Subject: Re: [PATCH for-5.14] cryptoloop: add a deprecation warning
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210827163250.255325-1-hch@lst.de>
 <59808096-34ff-151f-b7a2-f53d4262f00a@kernel.dk>
 <20210827164051.GA26147@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cc2108b6-c688-cceb-a953-f156ad21c3a5@kernel.dk>
Date:   Fri, 27 Aug 2021 10:42:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210827164051.GA26147@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/21 10:40 AM, Christoph Hellwig wrote:
> On Fri, Aug 27, 2021 at 10:37:41AM -0600, Jens Axboe wrote:
>> On 8/27/21 10:32 AM, Christoph Hellwig wrote:
>>> Support for cryptoloop has been officially marked broken and deprecated
>>> in favor of dm-crypt (which supports the same broken algorithms if
>>> needed) in Linux 2.6.4 (released in March 2004), and support for it has
>>> been entirely removed from losetup in util-linux 2.23 (released in April
>>> 2013).  Add a warning and a deprecation schedule.
>>
>> Would probably look better to queue with the 5.15 patches at this point.
>> Which then begs the question of whether we want to make the removal
>> target 5.17 instead.
> 
> File locking also just managed to sneak in a short-term deprecation for
> a very similar situation.

But what's the point? Why not just wait for 5.15, it's not like we're
in a mad dash to get it removed.

-- 
Jens Axboe

