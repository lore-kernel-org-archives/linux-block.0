Return-Path: <SRS0=U2g7=XK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C2CC4CEC7
	for <linux-block@archiver.kernel.org>; Sun, 15 Sep 2019 19:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBAA20830
	for <linux-block@archiver.kernel.org>; Sun, 15 Sep 2019 19:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfIOTjX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Sep 2019 15:39:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49635 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfIOTjX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Sep 2019 15:39:23 -0400
Received: from mail-qt1-f198.google.com ([209.85.160.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1i9aMj-0003WZ-2V
        for linux-block@vger.kernel.org; Sun, 15 Sep 2019 19:39:21 +0000
Received: by mail-qt1-f198.google.com with SMTP id u8so14671410qtq.19
        for <linux-block@vger.kernel.org>; Sun, 15 Sep 2019 12:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jFGCIfzQsU5xnbkAwOQ/cWsVPPngjr/o/8PhxsMzzrI=;
        b=frN2OYVonklfaxMqnEBHIzDv1Q9hKZxYefoozEjFhZ287i/NkbFfDHXIyjQxUr1h7F
         YrhfJH+BlVuQYZRPmXNujP//vyU7b2c2I36ykyKx14rXuYVQLgY8kq6z15RUlHyng3Gh
         E+ytrgY3Z4tniwEmir5exShOOC5nsSZsjvYDkSyB4OTfc95SOr/0K/qLnsENF84RGhS5
         cWwRcKZJIaeGBo4ZeKWqQ2Gl9vcebu9deLb2nS11J5P1/OOFET/xIlngEcNEn0u9hprS
         0/N7DneX6OC0YGhFO4o36uTRly4eWJEYVPgvHxdZUZj/yRGeqXW+1Mfie4kVq1r/C8gd
         uMOA==
X-Gm-Message-State: APjAAAW5PE4PL7U8xoN9zLQjvhoGZJVLGbrQ/PBDYF949Exap3LiXolV
        8e/tnCTyZZbO6vAoT+xEU/AuRO3eA1Qbj+Bkyh/GPnuicGtBTLwBrE3hD7XnSqF9J1hynLPv/au
        m4626TdmeObWcAS7TwxcQD6LRD75DyhIXeASoRwjp
X-Received: by 2002:ac8:36b7:: with SMTP id a52mr14358113qtc.181.1568576360318;
        Sun, 15 Sep 2019 12:39:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwwyo50DPpAitPmFw2d2/Jnhl2dHtjT1HtTBsLwqq5BMzRsdx7D4p/nHvvIEbElTyONxI06rw==
X-Received: by 2002:ac8:36b7:: with SMTP id a52mr14358098qtc.181.1568576360149;
        Sun, 15 Sep 2019 12:39:20 -0700 (PDT)
Received: from [192.168.0.239] ([177.183.163.179])
        by smtp.gmail.com with ESMTPSA id w131sm3088195qka.85.2019.09.15.12.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Sep 2019 12:39:19 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] mdadm: Introduce new array state 'broken' for
 raid0/linear
To:     Jes Sorensen <jsorensen@fb.com>,
        "jes.sorensen@gmail.com" <jes.sorensen@gmail.com>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jay.vosburgh@canonical.com" <jay.vosburgh@canonical.com>,
        "liu.song.a23@gmail.com" <liu.song.a23@gmail.com>,
        "nfbrown@suse.com" <nfbrown@suse.com>, NeilBrown <neilb@suse.de>
References: <20190903194901.13524-1-gpiccoli@canonical.com>
 <20190903194901.13524-2-gpiccoli@canonical.com>
 <A0D1B6AB-50CF-4B38-8452-A4E18AFDC8EB@fb.com>
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
Message-ID: <5a17d353-3d47-d994-d462-cbe1e9d75778@canonical.com>
Date:   Sun, 15 Sep 2019 16:39:11 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <A0D1B6AB-50CF-4B38-8452-A4E18AFDC8EB@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/09/2019 12:51, Song Liu wrote:
> [...] 
>>
>> Cc: Jes Sorensen <jes.sorensen@gmail.com>
>> Cc: NeilBrown <neilb@suse.de>
>> Cc: Song Liu <songliubraving@fb.com>
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> 
> Jes, does this look good?
> 
> Thanks,
> Song
> 

Jes, do you have any comment about this patch? It'd be good having this
code merged before the 5.4 kernel windows ends, since the kernel
counterpart is ready to get merged (it's on Jens' tree).

Thanks in advance,


Guilherme
