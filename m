Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133A6C3A59D
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 13:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69342064A
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 13:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfHPNp6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 09:45:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54931 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfHPNp6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 09:45:58 -0400
Received: from mail-qk1-f199.google.com ([209.85.222.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hycYF-0001bs-Rc
        for linux-block@vger.kernel.org; Fri, 16 Aug 2019 13:45:56 +0000
Received: by mail-qk1-f199.google.com with SMTP id d11so5305657qkb.20
        for <linux-block@vger.kernel.org>; Fri, 16 Aug 2019 06:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yQ7ZqGhNs6hoTT3VOscezDfSlNkxdejGDFgNpEXCUTQ=;
        b=aVsTVeRZ1IJ5pha1+x/ZRb0T2Uc9nCJ408YWb3sit6QEboMMZdI5Mi351bhUS3Tznu
         GNNsECyi5biWlU6Sb/Vo18IafDxG0xcRkKGfTy+mdUR9//9CVzc7Tg8j9+bKadt0mdQN
         Kqdt8ctY0rR+PsqoQC2eZUwmLm0kBt6E5SgT0tVU9S93a6qQwZcWh6H3DmPgKoEB4VJA
         +0jnnCo8tuvnejVjGsQS0AgCFxXUAmk4p6jfTz1xeBx+XIHTsDtLlFlA6f8CfOjNiK+J
         J3YBnApkfAeNvXRaWcyZ4umMZUlW2WecHQUtB7kR2/94Ki2kPcXcVkPdmqypvMNSrqea
         FwzQ==
X-Gm-Message-State: APjAAAUE0Bk539R75Uci6UTDfsqEifxZcLJDWxJ3DaS1i9UxZvhGTy0X
        OPhc+XgBRFT9gt5OxMZWNQbuzuhXzaXuFZnecvinH86qHwvDxLqJWD9AXiH8dy8GwmK+8r4HlvC
        KfNVHqG2ricndtcNJfgh1/WzsNHx4bPPDBCA+MdhH
X-Received: by 2002:a05:620a:1456:: with SMTP id i22mr8551561qkl.272.1565963154825;
        Fri, 16 Aug 2019 06:45:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw5gXfy/6A7axKULrd+X/hnmjkeHFTrxSIH2xhnbcphEt8DuTT36yrjtyewW/+PSg2DVsc4Hw==
X-Received: by 2002:a05:620a:1456:: with SMTP id i22mr8551542qkl.272.1565963154691;
        Fri, 16 Aug 2019 06:45:54 -0700 (PDT)
Received: from [192.168.1.203] ([191.13.19.2])
        by smtp.gmail.com with ESMTPSA id u45sm2749604qta.13.2019.08.16.06.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 06:45:53 -0700 (PDT)
Subject: Re: [PATCH] md/raid0: Fail BIOs if their underlying block device is
 gone
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <liu.song.a23@gmail.com>, NeilBrown <neilb@suse.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Neil F Brown <nfbrown@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20190729193359.11040-1-gpiccoli@canonical.com>
 <87zhkwl6ya.fsf@notabene.neil.brown.name>
 <6400083b-3cf3-cbc6-650a-c3ae6629b14c@canonical.com>
 <CAPhsuW69YrpHqBCOob2b5wzzWS9FM087sfe3iC0odX8kZWRwmA@mail.gmail.com>
 <CAPhsuW5zB=Kik4rq9YA-xBer7Z-h-23QV4WSCWe-jvhFgGc0Cw@mail.gmail.com>
 <9674ca8f-4325-3023-8a1d-39782103f55d@canonical.com>
 <72C166DF-3984-4330-8C60-BBDA07358771@fb.com>
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
Message-ID: <47eea35a-c932-66e6-159e-37936b8e60f6@canonical.com>
Date:   Fri, 16 Aug 2019 10:45:48 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <72C166DF-3984-4330-8C60-BBDA07358771@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01/08/2019 19:43, Song Liu wrote:
> 
> [...]
>> Hi Song, thanks for the feedback! After changing the patch and testing a
>> bit, it behaves exactly as you said, we got either valid data read from
>> the healthy devices or -EIO for the data tentatively read from the
>> failed/missing array members.
> 
> Thanks for testing this out. 
> 
>>
>> So, I'll resubmit with that change. Also, I've noticed clearing the
>> BROKEN flag seem unnecessary, if user stops the array in order to fix
>> the missing member, it'll require a re-assembly and the array is gonna
>> work again.
>>
>> Do you / Neil considers this fix relevant to md/linear too? If so, I can
>> also include that in the V2.
> 
> Yes, please also include fix for md/linear. 
> 
> Song
> 

V2 just sent:
lore.kernel.org/linux-block/20190816133441.29350-1-gpiccoli@canonical.com

Thanks,


Guilherme
