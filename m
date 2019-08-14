Return-Path: <SRS0=ptuj=WK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9215DC32753
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 18:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF7D2133F
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 18:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfHNS3e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:29:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46451 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHNS3e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Aug 2019 14:29:34 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hxy1b-0006ic-HI
        for linux-block@vger.kernel.org; Wed, 14 Aug 2019 18:29:31 +0000
Received: by mail-pf1-f199.google.com with SMTP id 22so7138838pfn.22
        for <linux-block@vger.kernel.org>; Wed, 14 Aug 2019 11:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=46iubCDOXlxt4E39L63blEhtpBpLW6BHD3hd+Wl/cwo=;
        b=tEVfcn07zfFLAGVIjM9tSA4Sg/4pTaRR16iBfL+vwBRJxYlf0iPe3GRBbuZscJfbGF
         1enlAeARmFSjwXnmg+KjA34pfY1r7h6c79jHA3zNuR89HVjfhbIqjy/r4pS2MvXyEq4g
         iPCr5fK943IPNpHjMQSMULkp9tBDxUd1jGn/ftGdpO2pVjSHLN0IQazFbpzRaQ+NhHQ7
         fuziE5V5tRo4zvIONAbM/VaaeP1g0kgWI7Q4/N/h7P1WUrR/GIfFpGVGr3FlX2MkjssW
         /LWIk8c5KhuAWjeklelcu4xdDBjOEk9BHhfU8A8T2qyjdOhPtL3K3hdIyRnDrJzxBXtM
         fe9A==
X-Gm-Message-State: APjAAAWbGWfZ9AIoj1ZPcmvZdBCxrwnLBvDb9zmZUqb37ApkVqkjM8Ge
        d4B2Ni44u9hNnXt5n8DgoceLjlKYtVosHIvtaWIubkgNblNiLymaBUJBIgiMUMr2p6uff8A+2or
        nalpGBSwLEXoKE5Sg3Zl5x/RUX0/pur9bMFsHzvhi
X-Received: by 2002:a63:d741:: with SMTP id w1mr414189pgi.155.1565807370225;
        Wed, 14 Aug 2019 11:29:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyNO3VOHh6JV+kyspaLlY7t4Pj6c4hpAZt0TjmteD2P2Ib1uvHB/cx6eK6wj7oJF8GZyOPyGg==
X-Received: by 2002:a63:d741:: with SMTP id w1mr414167pgi.155.1565807369923;
        Wed, 14 Aug 2019 11:29:29 -0700 (PDT)
Received: from [192.168.1.75] ([191.13.19.2])
        by smtp.gmail.com with ESMTPSA id f6sm296974pga.50.2019.08.14.11.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 11:29:29 -0700 (PDT)
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
Message-ID: <b5b471cc-8935-cf96-d55a-a7dc731cb0d6@canonical.com>
Date:   Wed, 14 Aug 2019 15:29:17 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814162754.GB3256@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14/08/2019 13:27, Keith Busch wrote:
> On Wed, Aug 14, 2019 at 09:18:22AM -0700, Guilherme G. Piccoli wrote:
>> [...]If you can give a rough example I appreciate.
> 
> Sure, start with nvme subsystem A, with host connected to to
> controllers, X and Y.
> 
>  ctrl X gets instance 0, which you assign to the newly discovered
>  subsytem
> 
>  ctrl Y gets instance 1
> 
>  disconnect ctrl X, which releases instance 0 back to the allocator
> 

Thanks a lot for the example Keith! This is the point I missed,
returning the id back to allocator. If we happen to have some IDA in
kernel without this property, my idea could work!

>  connect to a new ctrl Z in new subsystem B: ctrl Z gets the first
>  available instance, which is now 0, and you assign that name to the new
>  susbystem, colliding with the sysfs nvme-subsys entries we've created
>  for subsys A, as well as any namespaces.
>  
>> But given the above statement is a fact, what do you think of trying the
>> ctrl->instance first and in case we have duplicity, fallback to
>> subsystem ID allocator?
> 
> At the point we assign the subsystem identifier, we're locked into using
> that for the namespace names, which may be discovered long before we're
> aware the host has multiple connections to the same subsystem.
> 
> I think it'd be better to just completely disassociate any notion of
> relationships based on names. The following patch enforces that way of
> thinking:
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2019-May/024142.html
> 

Interesting thread, thanks for the pointer. I think no matter what we do
in this front (to disassociate the relation of nvme numbering), it'll
always be confusion, specially since we broke valid assumptions since
nvme day-0. Would it be possible of instead reusing the numbering
positions in the naming, add more fields?
It is a suggestion from my colleague Dan (CCed here), something like:
for non-multipath nvme, keep nvmeC and nvmeCnN (C=controller ida,
N=namespace); for multipath nvme, use nvmeScCnN (S=subsystem ida).

Let me know your thoughts, and thanks again for the prompt response!
Cheers,


Guilherme
