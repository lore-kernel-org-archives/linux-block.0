Return-Path: <SRS0=WP4r=WL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF63C3A589
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 13:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF27206C1
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 13:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfHONBx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:01:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44489 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfHONBx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 09:01:53 -0400
Received: from mail-qk1-f199.google.com ([209.85.222.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hyFO3-0007X8-9P
        for linux-block@vger.kernel.org; Thu, 15 Aug 2019 13:01:51 +0000
Received: by mail-qk1-f199.google.com with SMTP id r200so1952785qke.19
        for <linux-block@vger.kernel.org>; Thu, 15 Aug 2019 06:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WcgGhKrzEqQFcbftTHdoLG8OGi4gCwQvJKGdNd0Y8Mc=;
        b=jxJhqyM+c5hSRfg7gHuFB5lako9GhDNR6rHNK+nNhR1bVxX4dXj7EMYTTPrEH6ay5/
         98IMgz1cM2UJuajpCYsCFUDVfeLeAV6IeVcFpHUXopNmTYxR/o6Nam1WBK8CGvhDaxGX
         AURAkDaMFsZEDwF74/+wqk6WZY3rGdQCq0yQkvmrD1moG15M1XLgi23L0fC2Oy/jT2kV
         wC4Dh4cG4DOx7Ko3ZqNNGnF6+zDW9Ze2vPv24brs+1DG8ky0cW2PV6xlV/T/emecseNJ
         x4D27EBQ1E0nPjwM8UhIAQfcJq6kWxgs69S34fyvvL+m4+9AlfylF5w4eibMTciA/gGT
         80ng==
X-Gm-Message-State: APjAAAUIx0J/jks74ZbFCGovzFozxWXl/nDWDGFD24jH740zfRg7uA2Y
        xoz38Rbkv6AZuQJ9hPmQaXMaWc17TaYJgKYhnifW6uA66lxtA/h653C6sfNJh23bnxp4gRxyuTt
        DNS6my6+0bMvKoOpJNZJg70+RAt9dL4mpU3A+1RQb
X-Received: by 2002:a37:9c88:: with SMTP id f130mr3837759qke.494.1565874110546;
        Thu, 15 Aug 2019 06:01:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyn7TqrI2aPfIK5FkKXReFXUa6cToRv5dkS287uBNrZhKNDXoFPigPVQKtNordm0tBgQ55XYw==
X-Received: by 2002:a37:9c88:: with SMTP id f130mr3837738qke.494.1565874110392;
        Thu, 15 Aug 2019 06:01:50 -0700 (PDT)
Received: from [192.168.1.75] ([191.13.19.2])
        by smtp.gmail.com with ESMTPSA id g207sm1345819qke.11.2019.08.15.06.01.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 06:01:48 -0700 (PDT)
Subject: Re: [PATCH] nvme: Use first ctrl->instance id as subsystem id
To:     Keith Busch <kbusch@kernel.org>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jay.vosburgh@canonical.com" <jay.vosburgh@canonical.com>,
        Dan Streetman <dan.streetman@canonical.com>
References: <20190814142836.2322-1-gpiccoli@canonical.com>
 <20190814160640.GA3256@localhost.localdomain>
 <abfc4bd0-f4f0-5655-81ee-ec32d3516f35@canonical.com>
 <20190814162754.GB3256@localhost.localdomain>
 <b5b471cc-8935-cf96-d55a-a7dc731cb0d6@canonical.com>
 <20190814190814.GC3256@localhost.localdomain>
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
Message-ID: <9edcb6b3-806c-a422-8d44-c1ab49ce0b57@canonical.com>
Date:   Thu, 15 Aug 2019 10:01:43 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814190814.GC3256@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14/08/2019 16:08, Keith Busch wrote:
> On Wed, Aug 14, 2019 at 11:29:17AM -0700, Guilherme G. Piccoli wrote:
>> It is a suggestion from my colleague Dan (CCed here), something like:
>> for non-multipath nvme, keep nvmeC and nvmeCnN (C=controller ida,
>> N=namespace); for multipath nvme, use nvmeScCnN (S=subsystem ida).
> 
> This will inevitably lead to collisions. The existing naming scheme was
> selected specifically to avoid that problem.
> 

Thanks again for the discussion Keith! So, I guess the way to go is
really the kernel parameter in case users want to fallback to the old
numbering (and only if they're not using multipath).

Cheers,


Guilherme
