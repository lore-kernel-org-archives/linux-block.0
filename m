Return-Path: <SRS0=ptuj=WK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1453C433FF
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 16:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC212083B
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 16:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfHNQSh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:18:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43727 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfHNQSg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Aug 2019 12:18:36 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hxvyt-0007gS-Br
        for linux-block@vger.kernel.org; Wed, 14 Aug 2019 16:18:35 +0000
Received: by mail-pf1-f198.google.com with SMTP id w30so7028993pfj.4
        for <linux-block@vger.kernel.org>; Wed, 14 Aug 2019 09:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=E+Pb90HpR+04FXOEpn0mIzhlML/pWoL5asLbYKZAoO0=;
        b=iaEBPCU17d7Kzel1pPuVAbnmQqNKetJNxbUr6Z7FeuTl8cXfj2ZgvBwauvpxUvFtui
         ib0/JfjhdK6OcXzxVntXm4FGDPKuXoGK6p75xK3+n4wDyz7o9PypysBffL/A+ys94Umc
         /wtLQTo3JR/7yCclTg8h+t9OW73qf4A0zriaQwvFp41ehZ/ZstC42LowY+2hgoCNP56u
         1nyxH9B+6batgjIr3E/voAc+XfHobq+85xr/QDHDc8czrGkWhP3lmbkxU9ZarjcLOsfA
         z78qHzM8brjCBn7/LdClOeCn72epsQK1CiPBaia+St9gz8f7jnt3Igqre9PeIM7y4yo/
         qONA==
X-Gm-Message-State: APjAAAXPLG90aC5GI8cHnVouAqUfDNTEUEVLjKNYcctEl1vzT/1/RYtZ
        GWnVpCZJEWzMPvdOUGanhlcregX8++JJakSJLfb9/NPsMjvfZWrutQrM/Wtp0jjjXheHUEE3wGM
        RVQswrNDiHvQ/CPgact1rdQoVDL2O7pt1l8rMTpk/
X-Received: by 2002:a62:5487:: with SMTP id i129mr761233pfb.69.1565799514179;
        Wed, 14 Aug 2019 09:18:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz/T9k3EqiQrbnOxy3ybKa+BYrNtctlQTXHMDp+MTfg7rHremw8llryLenot/c59IZl1wqyjA==
X-Received: by 2002:a62:5487:: with SMTP id i129mr761221pfb.69.1565799513984;
        Wed, 14 Aug 2019 09:18:33 -0700 (PDT)
Received: from [192.168.1.75] ([191.13.19.2])
        by smtp.gmail.com with ESMTPSA id x128sm263924pfd.52.2019.08.14.09.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 09:18:33 -0700 (PDT)
Subject: Re: [PATCH] nvme: Use first ctrl->instance id as subsystem id
To:     Keith Busch <kbusch@kernel.org>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jay.vosburgh@canonical.com" <jay.vosburgh@canonical.com>
References: <20190814142836.2322-1-gpiccoli@canonical.com>
 <20190814160640.GA3256@localhost.localdomain>
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
Message-ID: <abfc4bd0-f4f0-5655-81ee-ec32d3516f35@canonical.com>
Date:   Wed, 14 Aug 2019 13:18:22 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814160640.GA3256@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14/08/2019 13:06, Keith Busch wrote:
> On Wed, Aug 14, 2019 at 07:28:36AM -0700, Guilherme G. Piccoli wrote:
>>[...]
> 
> The subsystem lifetime is not tied to a single controller's. Disconnect
> the "first" controller in a multipathed subsystem with this patch, then
> connect another controller from a different subsystem, and now you will
> create naming collisions.
> 

Hi Keith, thanks for your clarification. Isn't the controller id unique?
Could the new connected controller from a different subsystem have the
same id? If you can give a rough example I appreciate.

But given the above statement is a fact, what do you think of trying the
ctrl->instance first and in case we have duplicity, fallback to
subsystem ID allocator?

Since the creation of subsystems is not a critical path, adding this
small burden shouldn't be a huge penalty, and it'll help a lot with the
huge amount of reports of "confusion" after the introduction of nvme
multipathing, also it helps for the case I mentioned in the description,
some multipath'ed controllers, some single ones.

Cheers,


Guilherme
