Return-Path: <SRS0=KgRV=V2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA1DC76186
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 20:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3A8206A2
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 20:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbfG2UuI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:50:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43581 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388150AbfG2UuI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jul 2019 16:50:08 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hsCas-0002q5-0E
        for linux-block@vger.kernel.org; Mon, 29 Jul 2019 20:50:06 +0000
Received: by mail-pf1-f198.google.com with SMTP id 191so39235665pfy.20
        for <linux-block@vger.kernel.org>; Mon, 29 Jul 2019 13:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+XMk/43ITQRym8v4Qdx3eFC21tUKiobsXb5aceQcHUs=;
        b=pMPdlYoJnxh9/TDxGoooVsz2FJ5FTllDG2pLch9WDSs2JRspiUcALB8Gs2PnNjZXt2
         5dskPYrsrfoQV+m1CPpRTI7EwHrVgX8HRkolVHQK4+gTgK57opFSmmEy5piJIt0+JAwM
         BqTTCIn17U/wbqou/cxHCwfSbRkFLtaL4NG/VURpwxaaa0hzA2oNEYEJHk2pHwfy1pZB
         59ag9eIszneOE3YJmAHVTFyNhjd0juWs1zhXz45EgfKFIXOsxsLIzQSDRX/f1nIV9Tgm
         obI2qw8/F/8fUX5f5o/drwtHrFioY/BMdZXSChZXgU3OQ2pqucO/HKRQAh/QAZKu1eXa
         EtUA==
X-Gm-Message-State: APjAAAVTWtaCFLDD8gGOgSdR6Bg9zQuJASR60xJv3A4Xk5MtuwLKyWRV
        0wUYbCdgNX8TiORXXG0v/61rrWCuUZeVFZm6Z7udWWhmQAkXO/49kBAfSt3qXrKE9gInABilkGd
        z/DD50kP+Tzo9zJubvsLzjSHmsTEivgrNz5ZZ3hLV
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr105442013pld.6.1564433404787;
        Mon, 29 Jul 2019 13:50:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzaUg3ADJPjfnAjCJyPt9dLggL/fkXvIF9JUqX9bu89XttSG2+HLu5IvXqgA8k8lD4EPCAhPA==
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr105441989pld.6.1564433404363;
        Mon, 29 Jul 2019 13:50:04 -0700 (PDT)
Received: from [192.168.1.202] ([152.254.214.186])
        by smtp.gmail.com with ESMTPSA id v184sm58410396pgd.34.2019.07.29.13.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:50:03 -0700 (PDT)
Subject: Re: [PATCH] md/raid0: Fail BIOs if their underlying block device is
 gone
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, jay.vosburgh@canonical.com,
        NeilBrown <neilb@suse.com>, Song Liu <songliubraving@fb.com>
References: <20190729193359.11040-1-gpiccoli@canonical.com>
 <20190730011850.2f19e140@natsu>
 <053c88e1-06ec-0db1-de8f-68f63a3a1305@canonical.com>
 <20190730013655.229020ea@natsu>
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
Message-ID: <ac032580-d2cb-5616-1101-46993b14466e@canonical.com>
Date:   Mon, 29 Jul 2019 17:49:54 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730013655.229020ea@natsu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 29/07/2019 17:36, Roman Mamedov wrote:
> On Mon, 29 Jul 2019 17:27:15 -0300
> "Guilherme G. Piccoli" <gpiccoli@canonical.com> wrote:
> 
>> Hi Roman, I don't think this is usual setup. I understand that there are
>> RAID10 (also known as RAID 0+1) in which we can have like 4 devices, and
>> they pair in 2 sets of two disks using stripping, then these sets are
>> paired using mirroring. This is handled by raid10 driver however, so it
>> won't suffer for this issue.
>>
>> I don't think it's common or even makes sense to back a raid1 with 2
>> pure raid0 devices.
> 
> It might be not a usual setup, but it is a nice possibility that you get with
> MD. If for the moment you don't have drives of the needed size, but have
> smaller drives. E.g.:
> 
> - had a 2x1TB RAID1;
> - one disk fails;
> - no 1TB disks at hand;
> - but lots of 500GB disks;
> - let's make a 2x500GB RAID0 and have that stand in for the missing 1TB
> member for the time being;
> 
> Or here's for a detailed rationale of a more permanent scenario:
> https://louwrentius.com/building-a-raid-6-array-of-mixed-drives.html
> 

Oh, that's nice to know, thanks for the clarification Roman.
I wasn't aware this was more or less common.

Anyway, I agree with you: in this case, it's a weak point of raid0 to be
so slow to react in case of failures in one member. I hope this patch
helps to alleviate the issue.
Cheers,


Guilherme
