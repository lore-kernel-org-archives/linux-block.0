Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A32C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 22:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A594A61A21
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 22:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhCXWQp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 18:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbhCXWQ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 18:16:27 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FBBC06174A
        for <linux-block@vger.kernel.org>; Wed, 24 Mar 2021 15:16:27 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id c17so442225ilj.7
        for <linux-block@vger.kernel.org>; Wed, 24 Mar 2021 15:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t4EAKLGlDBPqsHkx1Hf+LwBirXN7TSbNjZM26FU5ENQ=;
        b=s1PJqso1IqkVkrwVukI13CpEc9iae9MvjXoellXiUf6p4FGz1GGBEfWikSkWEMmUBz
         C6jpP+qYXoHW/dnRyszg74E7QZyBTl8ZDWrjoKM1a1pCxTN+T2aUvF4QbhfGQ7VAmhOs
         9Mo+CkGCXSNXqbYYMuAHcr5dA1XGFvpN90RKJNDFDiZ7PDn8Y7v6bCG3Ez/6UyJQdCLh
         aIqQFSLH8CWC2LMaYmMF9MvT/ZrwmOsQJKEFwj1arfJeb075S7D7TM0JlR30PMUtkVMc
         VVbd33sti933hk/B/yZxTyINd4sRiiTN7nYkfHLVK2/FX9oSfFnBFSQnXG/rLIFDsjYo
         sbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t4EAKLGlDBPqsHkx1Hf+LwBirXN7TSbNjZM26FU5ENQ=;
        b=e7sEOPNEXfknOYZkPl7snpa7BdzPVuKEozGYBi67bSZC3eSeCe1S0YUXMJmEp6tkSY
         ohrEgMcDTgNn1GEXLOlLGwzhvG/LDF7EKy6pVx2d6Om7MeR2F2gUFvVdriIOqkmNbnZQ
         1iFssg7ZwX9yquYG6masQWgDQu2XZMqtGU+mV7c5S8fLCN4vpKybmyLnZfCYYNYMiFwf
         rurbsJzlmfJG+NCmQn0jwYqgYC3q6m4BkeOO49dkhCfKuY+e8tkx6WLx+HWtc/kJV667
         97Sh7Q/zdpaedPqxodXe48TPanj0xYt1A1U/O8KMjpYQ/Q7YoIBYq/dIufcj9ULgXIlK
         5urQ==
X-Gm-Message-State: AOAM530F+0ErwW4PXBrprIdA6gLBtMgbhw6vtOZcDF4pfSKeLN2LJgu0
        i3aEqP6DE0z0dycVADh5hvHKzg==
X-Google-Smtp-Source: ABdhPJzSNKLsvpcNVsuw4iE/jlLoEFJWRHH2F0qxnP4QmmzLbOTaXDA/LSwZ+pffg0ROo9RVTXvnbw==
X-Received: by 2002:a05:6e02:de2:: with SMTP id m2mr4432672ilj.274.1616624186387;
        Wed, 24 Mar 2021 15:16:26 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a14sm1718460ilm.68.2021.03.24.15.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 15:16:26 -0700 (PDT)
Subject: Re: [RFC] iosched: add cfq -> bfq alias
To:     Xose Vazquez Perez <xose.vazquez@gmail.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        BLOCK ML <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
References: <7962131d-12c5-0862-483f-e8873cac8ba0@gmail.com>
 <20210307192634.xdq52ntb2sxc34mh@spock.localdomain>
 <6dc9784e-9eb3-6f99-9200-7f39a91fc180@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <85fec70c-e908-7828-503a-59f313bb454a@kernel.dk>
Date:   Wed, 24 Mar 2021 16:16:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6dc9784e-9eb3-6f99-9200-7f39a91fc180@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/21 4:10 PM, Xose Vazquez Perez wrote:
> On 3/7/21 8:26 PM, Oleksandr Natalenko wrote:
> 
>> Hmmm NACK.
>>
>> CFQ and BFQ are completely different beasts.
>>
>> If you are going to tune BFQ to match old CFQ behaviour (somehow; I
>> don't know why one would do this, how one would do this and whether it
>> is possible at all), you for sure have enough time to fix your old udev
>> rules and scripts.
>>
>> If you are just tolerating default BFQ behaviour, you should explicitly
>> acknowledge it by amending your rules and scripts. For personal systems
>> this is not a big deal. For enterprise systems you better do it NOW so
>> that another person that comes to work on those systems in 10 years
>> after you resign knows what and why was done.
>>
>> If you are just lazy (no offence! I don't know your real intention
>> here), I'm not sure we are going to hide such an indifference behind
>> another aliasing kludge.
>>
>> Thanks.
>>
> 
> You are writing a lot, and say nothing.
> 
> bfq is the natural choice coming from cfq. There is NO other option.
> 
> Still waiting... for a valid *technical* response against my change.

Let's lay off the aggression a bit, it's not helpful.

They are two very different schedulers. Yes, they support some of the
same options, but they really have nothing in common outside of that. On
top of that, it's also very late to introduce a change like that, it
should've been done with the introduction of it.

> Or do you prefer to apply the below patch?.

Not a valid example, as mq-deadline and deadline are identical, one just
supports multiple queues.

-- 
Jens Axboe

