Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C96C0650F
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 12:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6600F2087F
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 12:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfG3MTJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:19:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37127 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfG3MTJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 08:19:09 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hsR5u-0004w9-Tz
        for linux-block@vger.kernel.org; Tue, 30 Jul 2019 12:19:07 +0000
Received: by mail-pg1-f200.google.com with SMTP id n23so28620435pgf.18
        for <linux-block@vger.kernel.org>; Tue, 30 Jul 2019 05:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=duNeCgPARK5/DNYmXliLtl2PHvOx7FRmtH6Afr/ogZ8=;
        b=YuR9mRhnZwuad9YicqJEQ+exEpMVmHs63PTWYaHQ/cy8IkwE6OldHA407EuBSFtHzz
         mHLWKTKYbUjD4WZvSW+o8f9lQ+ffRAD+d1FxwsV0N2FZo3hTNsUvEZRNHNOouc4IiPfC
         3btHU2NdujeNQ1TiGh5+y6bHpzh/hh4gWY9UZ9oD9lZdMNaAHDcxqL28XC5CnMQLnTYL
         7xrCdEU60fudCT1L0e9Azrq6cIcf9zCvNMLrvJlgJky78tM8ZwiZMEm68NwcHmFRkVEy
         ihPp5+IIsbh0sM3IIk+1yx8+BGD0jlsPPtJMUjEoTdxvTauKpq38D7th7sZ+dh7TD18+
         epSQ==
X-Gm-Message-State: APjAAAUtcPjKZ6pBFuvNHl9RgOD4jQpAMVkUMru8MNFwKTqWU1Q5VMaJ
        Uk0AvWx5A640RJYcmIcTWhDtNn8ZX7IuXSwsbQCtwT8mzD8NZKG/bpW2N3XoJcBXxioLarwj0xJ
        wcWC2/Ay4co5gMs1eDbiaHDmyLS7R7UYgAmMjlxi0
X-Received: by 2002:a62:1d8f:: with SMTP id d137mr42586380pfd.207.1564489145694;
        Tue, 30 Jul 2019 05:19:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz3VqyZIP60VysathrWyL1Khg+ulJL5jfJ25tNxj1jx8o8wkADOY5OI0aR6Pr1uAwShW4fTiQ==
X-Received: by 2002:a62:1d8f:: with SMTP id d137mr42586372pfd.207.1564489145562;
        Tue, 30 Jul 2019 05:19:05 -0700 (PDT)
Received: from [192.168.1.202] ([152.254.214.186])
        by smtp.gmail.com with ESMTPSA id e189sm45931655pgc.15.2019.07.30.05.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 05:19:04 -0700 (PDT)
Subject: Re: [PATCH 1/2] md/raid0: Introduce new array state 'broken' for
 raid0
To:     Bob Liu <bob.liu@oracle.com>, linux-raid@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        jay.vosburgh@canonical.com, neilb@suse.com, songliubraving@fb.com
References: <20190729203135.12934-1-gpiccoli@canonical.com>
 <20190729203135.12934-2-gpiccoli@canonical.com>
 <d730c417-a328-3df3-1e31-32b6df48b6ad@oracle.com>
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
Message-ID: <000c20fe-3bcd-2dff-a5ab-9a294bdc7746@canonical.com>
Date:   Tue, 30 Jul 2019 09:18:54 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d730c417-a328-3df3-1e31-32b6df48b6ad@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 30/07/2019 03:20, Bob Liu wrote:
> [...]
>> + * broken
>> + *     RAID0-only: same as clean, but array is missing a member.
>> + *     It's useful because RAID0 mounted-arrays aren't stopped
>> + *     when a member is gone, so this state will at least alert
>> + *     the user that something is wrong.
> 
> 
> Curious why only raid0 has this issue? 
> 
> Thanks, -Bob

Hi Bob, I understand that all other levels have fault-tolerance logic,
while raid0 is just a "bypass" driver that selects the correct
underlying device to send the BIO and blindly sends it. It's known to be
a performance-only /lightweight solution whereas the other levels aim to
be reliable.

I've quickly tested raid5 and rai10, and see messages like this on
kernel log when removing a device (in raid5):

[35.764975] md/raid:md0: Disk failure on nvme1n1, disabling device.
md/raid:md0: Operation continuing on 1 devices.

The message seen in raid10 is basically the same. As a (cheap)
comparison of the complexity among levels, look that:

<...>/linux-mainline/drivers/md# cat raid5* | wc -l
14191

<...>/linux-mainline/drivers/md# cat raid10* | wc -l
5135

<...>/linux-mainline/drivers/md# cat raid0* | wc -l
820

Cheers,


Guilherme
