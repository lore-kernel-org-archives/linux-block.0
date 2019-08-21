Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5481CC3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 19:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2521F22DD3
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 19:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfHUTLC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:11:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39563 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfHUTLC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 15:11:02 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1i0W0a-0006HH-Qh
        for linux-block@vger.kernel.org; Wed, 21 Aug 2019 19:11:01 +0000
Received: by mail-pf1-f199.google.com with SMTP id w16so2234525pfn.12
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2019 12:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UPqwaakYaQb+VSOrBDrebKUBnTco9ysuGlVqdvNVkSw=;
        b=Ygs0QzZL9DCvDJMjSNjoAXVDHoPlHEPDubA+5FBT5qqkWPfguaGkIFpZ0h0GbjMQnT
         g6TKyH0xQ1mlxN8rYl6EDbVpqGxz7goj+hqb/WKs0OfTrW/C45OfR7lv2MsJvwqYwylJ
         UY1MKmnOu0DrkyxicPWynji4whGYOWOswHNDfnH/uQaJRMSS2/8PMVzuVJQkHZZtZD9D
         DISL2bqa2TXA+A0MxvozsLPDksDECbGlTpFf1IvlJZFnvMx3PQaUZLQccBgzZTTZX8wA
         RFgp4Mso5UBH9Bw6DGG4g3L/oROzcIWkOD2hGNb9l+f8DYuHglNkJdJHTzH6xXxrrACM
         s0Hg==
X-Gm-Message-State: APjAAAVpugm0viQK9yaj/dsxrlhwdGwjSRjadpJyZmMIzZRiQ+LeVkzn
        w16SfFSnNOGkE03ogGaKTFHsS8IaV7W60v6aVXIcDn+W3sn/khYem2YgXYX5LyPrRt6XnTDD1AU
        y8x/JYYRdmznNWE4OpZ6eLZw/Atz+gB3svkhfSxnN
X-Received: by 2002:a17:90a:2629:: with SMTP id l38mr1560960pje.71.1566414659644;
        Wed, 21 Aug 2019 12:10:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxmKMFO7M4tiSY81Gu7reGySRGb3BkOv8g6B7CwJ1yTxujGgz+TjukuMXqixNi/3l0yCv7ELA==
X-Received: by 2002:a17:90a:2629:: with SMTP id l38mr1560933pje.71.1566414659356;
        Wed, 21 Aug 2019 12:10:59 -0700 (PDT)
Received: from [192.168.1.75] ([191.13.61.137])
        by smtp.gmail.com with ESMTPSA id 1sm32518759pfx.56.2019.08.21.12.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 12:10:58 -0700 (PDT)
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
 <c35cd395-fc54-24c0-1175-d3ea0ab0413d@canonical.com>
 <B7287054-70AC-47A8-BA5A-4D3D7C3F689F@fb.com>
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
Message-ID: <d0a3709e-c3a9-c0b1-c3c1-bf5a6d6932af@canonical.com>
Date:   Wed, 21 Aug 2019 16:10:47 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <B7287054-70AC-47A8-BA5A-4D3D7C3F689F@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21/08/2019 13:14, Song Liu wrote:
> [...] 
> 
> What do you mean by "not clear MD_BROKEN"? Do you mean we need to restart
> the array? 
> 
> IOW, the following won't work:
> 
>   mdadm --fail /dev/md0 /dev/sdx
>   mdadm --remove /dev/md0 /dev/sdx
>   mdadm --add /dev/md0 /dev/sdx
>   
> And we need the following instead:
> 
>   mdadm --fail /dev/md0 /dev/sdx
>   mdadm --remove /dev/md0 /dev/sdx
>   mdadm --stop /dev/md0 /dev/sdx
>   mdadm --add /dev/md0 /dev/sdx
>   mdadm --run /dev/md0 /dev/sdx
> 
> Thanks,
> Song
> 

Song, I've tried the first procedure (without the --stop) and failed to
make it work on linear/raid0 arrays, even trying in vanilla kernel.
What I could do is:

1) Mount an array and while writing, remove a member (nvme1n1 in my
case); "mdadm --detail md0" will either show 'clean' state or 'broken'
if we have my patch;

2) Unmount the array and run: "mdadm -If nvme1n1 --path
pci-0000:00:08.0-nvme-1"
This will result: "mdadm: set device faulty failed for nvme1n1:  Device
or resource busy"
Despite the error, md0 device is gone.

3) echo 1 > /sys/bus/pci/rescan [nvme1 device is back]

4) mdadm -A --scan [md0 is back, with both devices and 'clean' state]

So, either if we "--stop" or if we incremental fail a member of the
array, when it's back the state will be 'clean' and not 'broken'.
Hence, I don't see a point in clearing the MD_BROKEN flag for
raid0/linear arrays, nor I see where we could do it.

And thanks for the link for your tree, I'll certainly rebase my patch
against that.
Cheers,


Guilherme
