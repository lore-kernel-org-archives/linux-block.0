Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17331C49ED7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 16:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5E2214D9
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 16:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jhfxILuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbfIPQBq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:01:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37115 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731935AbfIPQBq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 12:01:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id b10so90093plr.4
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2019 09:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BEJp88C2i8e+N1eeCwl/bIylkv3ygkyUoC1HYN2SV/k=;
        b=jhfxILuEU5LSCsXnCz+qhXGXW+5xTSEXtoXYBOnG0tgqgkC8QZkpPUuxQS62iaEG8G
         lT+fOZdcERuiq+rmr7NKKowWHPu1M3Nlu66ab6zYsjKUrb1NfoiBR4+pGdYnWyXPH9ia
         n72cJDV1heSbw50qfUMyU8NJuMBHfd7NNfFemrdfpdYGV14gqqhLmCvweCBP5OZh0Eid
         +tex2GW5MJvYVr4jZm8KmWW4oUqRExEUbwAwIJp6twGSL36gZnm0rNMmHBRrI4tzbdag
         NGG8To8FUUqrnZkyiDoHUAbv71m5kZ38+aZMFOph6Txy+3qAiacUbGFD9gw64AHhFR/A
         T/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BEJp88C2i8e+N1eeCwl/bIylkv3ygkyUoC1HYN2SV/k=;
        b=f5ODGV6iuce0sC7rmkp0IYpfX55CjLQxzQ7Kf30HEaBgqhRD5ntL/nlINkUVm9dcb0
         38xqVaPWyHjP6K1qWwI4wznsPYZvsfRYuYHGEH0nSEY3LMvmOOYO3sTCqThXBn2yLgp9
         uvuAmkWm4JnDMoRp0dGt+UAewBNhK/cn7gDh3vMUo+DfTgJIEwzm8S5qw+GB1yEpj+B4
         1BBH/I8wONRHKDy2VVytJ/lJsyAeVb89AbRn2POisJGTOcQ4Wu2jdVg6N7oGcs+2He78
         7I6drUdNV9ItYxDceG2u3u1tjzuKcbpeGlPUQQ4bLde2HOjVZpdnkGbzExorHC+DVJ50
         TkmQ==
X-Gm-Message-State: APjAAAWICNPF7W/npq9LdMIIzQQFp/APa1ObszbRQYg4WwqiltaXGIUQ
        SburME4lX6LLnieQFmH+n29+rg==
X-Google-Smtp-Source: APXvYqzMhCRQP8tJyGIBAZV9PplFz6in7yvRK1pn+2rxCPUn97+FSPxvfs4gGo1B4/W4BWJWbGEGrA==
X-Received: by 2002:a17:902:b08f:: with SMTP id p15mr560731plr.158.1568649703947;
        Mon, 16 Sep 2019 09:01:43 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:c484:c1a1:f495:ecae? ([2605:e000:100e:83a1:c484:c1a1:f495:ecae])
        by smtp.gmail.com with ESMTPSA id a8sm10024107pfo.118.2019.09.16.09.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 09:01:42 -0700 (PDT)
Subject: Re: [PATCH 0/1] block, bfq: remove bfq prefix from cgroups filenames
To:     Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        cgroups@vger.kernel.org
References: <20190909073117.20625-1-paolo.valente@linaro.org>
 <80C56C11-DA21-4036-9006-2F459ACE9A8C@linaro.org>
 <c67c4d4b-ee56-85c1-5b94-7ae1704918b6@kernel.dk>
 <1F3898DA-C61F-4FA7-B586-F0FA0CAF5069@linaro.org>
 <20190916151643.GC3084169@devbig004.ftw2.facebook.com>
 <64329DDB-FFF4-4709-83B1-39D5E6BF6AB6@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <91deff5b-4a0d-a7ef-8bb2-7e7e5dad767b@kernel.dk>
Date:   Mon, 16 Sep 2019 10:01:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <64329DDB-FFF4-4709-83B1-39D5E6BF6AB6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/16/19 9:21 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 16 set 2019, alle ore 17:16, Tejun Heo <tj@kernel.org> ha scritto:
>>
>> Hello, Paolo.
>>
>> On Mon, Sep 16, 2019 at 05:07:29PM +0200, Paolo Valente wrote:
>>> Tejun, could you put your switch-off-io-cost code into a standalone
>>> patch, so that I can put it together with this one in a complete
>>> series?
>>
>> It was more of a proof-of-concept / example, so the note in the email
>> that the code is free to be modified / used any way you see fit.  That
>> said, if you like it as it is, I can surely prep it as a standalone
>> patch.
>>
> 
> AFAICT your proposal contains no evident error.  Plus, no one seems to
> have complained about the idea (regardless from the exact
> implementation).  So I guess the best next step is to go for it.

Not filling me with a lot of confidence that you actually tested it?

-- 
Jens Axboe

