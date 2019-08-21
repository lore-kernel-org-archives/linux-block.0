Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0703FC3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 14:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67E8233A2
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 14:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfHUOQl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:16:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58533 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbfHUOQk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 10:16:40 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1i0RPi-0001QU-OL
        for linux-block@vger.kernel.org; Wed, 21 Aug 2019 14:16:38 +0000
Received: by mail-pl1-f199.google.com with SMTP id b30so1549142pla.16
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2019 07:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Go+GEHhUcbN1bHosP4BsuQGAO6IN3p1GHI03GXEZEAE=;
        b=WqUerRKLBotz+u9UMT934Ns87lRucXNG4KRLi+FM7mWmzoHD/iVlnmcKBFe7kq0U2F
         SPR68QYkAyfjsFmflct4DMZL10MKA17+gFXF6CNlCf7h1qwa7twnZkBFpqcbQqRfXfH4
         mrDv7JVa8mN85mngLDUFSO117HWcS0XDlTLwhhASJLYuBnc4u57H2xlr/9PUjRlS9uLL
         FZHMZyph75CZtmCp7sP7jcdqfgmYaNEaEPmSz5uyhBToZVm3Q2GN0pANuGEDKQZfUDLn
         DZJLJWP0JxAd+1WkAIc9bfTYcHqDfy50vR7k0+SmfqrZ1tB5qOsm50x0QA+lCCqEVFLP
         PaIQ==
X-Gm-Message-State: APjAAAUTLZeg7KMVR7AE7BCK8ZpeuT7SL423rnA9TOG1jfHB0PvpSgC5
        Afnb/aWi/X9cKXhiMBTvo+4iUCxs7wcVcc5bsK05iN0Eb9cu8XJCvCG3FXiMjNqb0X2IPTrUowZ
        cPqhnCZ8fNdhCqpPIO3Zc2VUv8ar8s+yV+3174Mdh
X-Received: by 2002:a17:90b:8e:: with SMTP id bb14mr204490pjb.35.1566396996932;
        Wed, 21 Aug 2019 07:16:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxAjW0ZfAAXYn4C5kkD1j8vOncVe99b8Y9EmPCf9G9eITmAA4IV8N6JlbdPHP10+0fky8YxRw==
X-Received: by 2002:a17:90b:8e:: with SMTP id bb14mr204473pjb.35.1566396996764;
        Wed, 21 Aug 2019 07:16:36 -0700 (PDT)
Received: from [192.168.1.75] ([191.13.61.137])
        by smtp.gmail.com with ESMTPSA id g36sm41138577pgb.78.2019.08.21.07.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 07:16:35 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] md raid0/linear: Introduce new array state
 'broken'
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <liu.song.a23@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        NeilBrown <neilb@suse.com>
References: <20190816134059.29751-1-gpiccoli@canonical.com>
 <CAPhsuW7aGze5p9DgNAe=KakJGXTNqRZpNCtvi8nKxzS2MPXrNQ@mail.gmail.com>
 <1f16110b-b798-806f-638b-57bbbedfea49@canonical.com>
 <1725F15D-7CA2-4B8D-949A-4D8078D53AA9@fb.com>
 <4c95f76c-dfbc-150c-2950-d34521d1e39d@canonical.com>
 <8E880472-67DA-4597-AFAD-0DAFFD223620@fb.com>
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
Message-ID: <c35cd395-fc54-24c0-1175-d3ea0ab0413d@canonical.com>
Date:   Wed, 21 Aug 2019 11:16:25 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8E880472-67DA-4597-AFAD-0DAFFD223620@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/08/2019 18:57, Song Liu wrote:
> [...]
> How about we test this when we do clear_bit(Faulty..)? And maybe also in 
> add_new_disk()?
> 
> Thanks,
> Song
> 

Song, thanks for the suggestions. I've been working in the refactor, so
far it's working fine. But I cannot re-add a member to raid0/linear
without performing a full stop (with "mdadm --stop"), and in this case
md_clean() will clear the flag. Restarting array this way works fine.

If I try writing 'inactive' to array_state, I cannot reinsert the member
to the array. That said, I don't think we need to worry in clearing
MD_BROKEN for RAID0/LINEAR, and it makes things far easier.
Are you ok with that? I'll submit V3 after our discussion.

Thanks,


Guilherme
