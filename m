Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1DCC3A5A2
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 22:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C1321883
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 22:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfICWUL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Sep 2019 18:20:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60988 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfICWUL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Sep 2019 18:20:11 -0400
Received: from mail-qk1-f199.google.com ([209.85.222.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1i5H9k-0002ko-Tn
        for linux-block@vger.kernel.org; Tue, 03 Sep 2019 22:20:09 +0000
Received: by mail-qk1-f199.google.com with SMTP id x77so3244794qka.11
        for <linux-block@vger.kernel.org>; Tue, 03 Sep 2019 15:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=u0k3XnaaOH+YvkPPo0BqIKxocTRXrQHC0zFyGWZv4eg=;
        b=lhY3xbXPPRoa8hBtJlMgAxjEUhaUdfMsQq6RUOCkmlyKDxI/a3+n54c2LlSl3WgH4P
         1O0rxYacx08KxT+mbar9Lx2s9lgexF7pnlmR2eCFu3cNW+88W2Ez19vzREEMg7dN9Ay3
         26qc3yzoEQyCcGtLbjz9gWfZYhTLqzexHXvFLSrQxkQgG2hoC0ZjOVxALyKkZwbbdFKT
         zZjDYYMId4fzKgl825KSBYeqdI19sdnyFPSNvdd9ywp+AoueZ7qPJVveuBPvwiQjUT8X
         qMpsmhEXNFvsPwpDXvOJbyynW+QOCDThoj309+y4EvN0QStBmqf4E0MhpXldPxhRb5mB
         HMyA==
X-Gm-Message-State: APjAAAWf9a/SRl9mFJ3vOjBcoOPPMKNGVZwLZY4uHgC7BhWhkP2uMC3S
        LDfIynHMgWURPVY5mGEZsmjbAsunW9SPSrd99Fj1Xqbr9teWvTztvgUpyRBkAVcqddCG6t0Xwrm
        fMPzA7v/UtYv1qZPH+1BIVoFML/gCrlkR/OInsLHt
X-Received: by 2002:a37:4a8d:: with SMTP id x135mr35319753qka.472.1567549208183;
        Tue, 03 Sep 2019 15:20:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxu1D2zYJ06nd5yZW9zEhNaIRg1S5Xyi0L1I8Gx7RslRfRbxnXGaaDntVnwvIFQ9lx3oP6aXw==
X-Received: by 2002:a37:4a8d:: with SMTP id x135mr35319746qka.472.1567549208041;
        Tue, 03 Sep 2019 15:20:08 -0700 (PDT)
Received: from [192.168.1.203] (201-93-37-171.dial-up.telesp.net.br. [201.93.37.171])
        by smtp.gmail.com with ESMTPSA id r19sm10188022qte.63.2019.09.03.15.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 15:20:07 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] md raid0/linear: Mark array as 'broken' and fail
 BIOs if a member is gone
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jay.vosburgh@canonical.com" <jay.vosburgh@canonical.com>,
        "liu.song.a23@gmail.com" <liu.song.a23@gmail.com>,
        "nfbrown@suse.com" <nfbrown@suse.com>,
        "jes.sorensen@gmail.com" <jes.sorensen@gmail.com>,
        NeilBrown <neilb@suse.de>
References: <20190903194901.13524-1-gpiccoli@canonical.com>
 <E393EAA5-6A9D-464A-A70E-56A258559712@fb.com>
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
Message-ID: <cfb3d90f-ff93-7ddd-9178-7542cab3b17b@canonical.com>
Date:   Tue, 3 Sep 2019 19:20:02 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <E393EAA5-6A9D-464A-A70E-56A258559712@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/09/2019 18:56, Song Liu wrote:
> [...] 
> Applied to md-next. 
> 
> Thanks!
> 

Thanks a lot Song!
How can we get the mdadm counterpart applied?
