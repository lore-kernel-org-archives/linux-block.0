Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE7AC433EF
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 17:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344407AbiEPRlO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 13:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiEPRkz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 13:40:55 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121B43701D
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 10:40:54 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e194so16714209iof.11
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bkBYbqFw8Uqt2LrlL3b8A2k4CheYeXwKOqf0DAmC3h4=;
        b=n1mNAB+0PSwsAxiakcc+rlhe/EZVDgezWHiyER1cVuh4UPi8Ymz2Syc3w6wYTymETD
         pr2G+uID5qk/YWsWl0tUYPtYQBsBW9gAfcctEIWpNzFxIm/5/SoH/ZugZXxd8dr/9Se4
         DwAg20e8QGCXPzZ0AaTnlCL1hCBAjwXIyhURn+858wfM4tfuL+JPpem6qUf0vDQbC5dl
         Fs4gXpfr0ZH7NCdNV6gDoN2V3k/rejOnfR08RACy0bUvkXOXWwFdyuW1EQIq3kHJxXNv
         OHeH/C6qrx0Okx7gnHjXHm28c6ZlvLzHWsmSyKs9c5g5n9fH85Wz/H147j7CK8XXZD1T
         Ujxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bkBYbqFw8Uqt2LrlL3b8A2k4CheYeXwKOqf0DAmC3h4=;
        b=NTdW8CUfPgoUNjYTQybFZB+EwgzDgLb3eIVbY09ff2Y4Nqq0pkwHpLRjfLHycIw4xC
         KuxzZjf7tIGaMiVTJ/S9EcUGb9ANVikdMBo1VqdpYyXUz6EZdUDnbzIo1OyRE83Q7K+L
         G98Zz8iqTmvqIWD0o/6qRXLrC9ka6fdzflNS6EZc+EDEtZxZNHG0wLS13qhgRIaLSfoa
         1WawdcQVv+2goQpcsKwdED+xWqayJwBVcugOTh6H7vpKjlwR3RqvFpVtCod/6Nq8F4GV
         AqkXak2tLLjNNiX/Gvah3L3rb/B7htGgRmiZqMw21BdWtR1ZyqovGRc68bTZ6IRzPjVr
         ZwAA==
X-Gm-Message-State: AOAM5303EdZLSynyFKgBkk/Ku5ERuPHFEqGwYLjsKtMCK8isFG95mjAa
        Vf+FDnS7sdc8NlgQEFZY9OhS0g==
X-Google-Smtp-Source: ABdhPJwzFS9gS5AVmSDi/Y7kLQ3Xm6tjAaR656Vkq1IYvhBKxr5hb7ksEb4pvoQfzpinz9N7d7RqLQ==
X-Received: by 2002:a05:6638:196:b0:32d:fde1:582d with SMTP id a22-20020a056638019600b0032dfde1582dmr8912456jaq.134.1652722853481;
        Mon, 16 May 2022 10:40:53 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n11-20020a02714b000000b0032e16c566adsm1757970jaf.109.2022.05.16.10.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 10:40:52 -0700 (PDT)
Message-ID: <83042952-30e9-849a-be31-c31e951e8d70@kernel.dk>
Date:   Mon, 16 May 2022 11:40:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] blk-iocos: fix inuse clamp when iocg deactivate or free
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
References: <20220516101909.99768-1-zhouchengming@bytedance.com>
 <bbd8744f-d938-c4a5-cb02-145c9875ea53@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <bbd8744f-d938-c4a5-cb02-145c9875ea53@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/22 6:18 AM, Chengming Zhou wrote:
> Then this effect is very small, unlikely to have an impact in
> practice. Should I modify the commit message to send v2 or just drop
> it?

Send a v2 please.

-- 
Jens Axboe

