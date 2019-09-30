Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF008C32792
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 20:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCDF224FE
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 20:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbfI3Upp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:45:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37975 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbfI3Upp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 16:45:45 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1iF1Ws-00057c-L6
        for linux-block@vger.kernel.org; Mon, 30 Sep 2019 19:40:18 +0000
Received: by mail-pl1-f198.google.com with SMTP id m8so5815483plt.14
        for <linux-block@vger.kernel.org>; Mon, 30 Sep 2019 12:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=09P9hryk4X9pxrU6lU1eu8xnMAXUu4sGNFiOeA8zkAc=;
        b=eW+8OOWcjuHRndZ6yHOe/qFiOHGTCnqbMYJ8rg8MsslTNqnBggg0okph5z3tecQ79C
         IcNWaQJnoAxYdLN5FklIL4BFwCRbNjua9Kw89RUpSuCb1Sh+ugENE4C/RMlOXxsgVGBV
         0EBOwaH6U6XjeA/1uTGei0chrdJQ9wf9bnDNa+D1tF6UgOu1Q0JWjDW6VyEBTHujE5ev
         hJdXGJ3ZcR2+g/IOeA1hAYMBVnr0RgjxCnD/2ENlTZ3tj23ZXhE6Yx0pgm58vRwVZaVM
         jnZu94Az1WtiLBxCIgACJTlloa0L2r82YJRTX2NBYxoWeiQmlovFqpNYgozCiV34FnGP
         kLLg==
X-Gm-Message-State: APjAAAV2dwKH0NLX4kh7I/ZTF8nFGADbWord5NgMdZHWxWBtlB/hgFYe
        aFRbMxZT48/XfjwAIrDoJpEx4Zvbh0Rw4rQX4fEtCl61WeKWIIkfGYstGSROTEko7SsPUwpfxGV
        /qMfFfucRKQ05sBIhtmUTz6MshBjfi3OQYSv9XARf
X-Received: by 2002:a17:90a:264a:: with SMTP id l68mr1039492pje.74.1569872417341;
        Mon, 30 Sep 2019 12:40:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwZ8h4rNs89cKWhr/JmybSS+4c+v6Mw1oFylzJu67DnGjq96+R4Zln+w1cF96kir99q9ot53A==
X-Received: by 2002:a17:90a:264a:: with SMTP id l68mr1039458pje.74.1569872416994;
        Mon, 30 Sep 2019 12:40:16 -0700 (PDT)
Received: from [192.168.1.75] (201-0-39-188.dsl.telesp.net.br. [201.0.39.188])
        by smtp.gmail.com with ESMTPSA id o60sm373324pje.21.2019.09.30.12.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 12:40:15 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] mdadm: Introduce new array state 'broken' for
 raid0/linear
To:     Jes Sorensen <jes.sorensen@gmail.com>, linux-raid@vger.kernel.org
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        jay.vosburgh@canonical.com, liu.song.a23@gmail.com,
        nfbrown@suse.com, NeilBrown <neilb@suse.de>,
        Song Liu <songliubraving@fb.com>
References: <20190903194901.13524-1-gpiccoli@canonical.com>
 <20190903194901.13524-2-gpiccoli@canonical.com>
 <608284db-7b82-6545-74bf-7a9f1d578c2f@gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 mQENBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAG0LUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPokBNwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltveuQENBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAGJAR8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <a7796eb4-f28f-9360-2ad2-a76d472c2e4c@canonical.com>
Date:   Mon, 30 Sep 2019 16:40:05 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <608284db-7b82-6545-74bf-7a9f1d578c2f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 30/09/2019 16:36, Jes Sorensen wrote:
> [...]
> Applied thanks!
> 
> I fixed up one minor nit rather than having to do the merry-go-round by
> email one more time:
> 
>> diff --git a/Monitor.c b/Monitor.c
>> index 036103f..cf0610b 100644
>> --- a/Monitor.c
>> +++ b/Monitor.c
> [snip]
> 
>> @@ -1116,7 +1119,8 @@ int WaitClean(char *dev, int verbose)
>>               rv = read(state_fd, buf, sizeof(buf));
>>               if (rv < 0)
>>                   break;
>> -            if (sysfs_match_word(buf, clean_states) <= 4)
>> +            if (sysfs_match_word(buf, clean_states)
>> +                < (int)ARRAY_SIZE(clean_states)-1)
> 
> I moved the < up to the correct line where it belongs, and added spaces
> ") - 1)"
> 
> Cheers,
> Jes


Thanks a lot Jes, much appreciated!
Cheers,


Guilherme
