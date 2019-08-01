Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39528C19759
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 20:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D914206A2
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 20:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfHAU2y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 16:28:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33734 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfHAU2y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 16:28:54 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1htHgy-0005xd-RI
        for linux-block@vger.kernel.org; Thu, 01 Aug 2019 20:28:53 +0000
Received: by mail-pl1-f197.google.com with SMTP id o6so40263492plk.23
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 13:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QCJ4vg6Bq4PcT5glXzSZy5Mkbbyr2Ef4lNDEIG8R548=;
        b=QlCCvMCJNxaMvMDhLu1i3tQ5wa4wuI8diW0OhWWjZlb93bLm9uL7aC3xBWX/IRxe2A
         +Lp/X/KxN6kbvSZ+k8199Rbsf9o/8/1P2mTEnfMjF8pZ1cXQDkabd83iKZvW6z8rR5y1
         SmhcXrI8Pvtiyvi4siLlkGRDBW+PtAMqo7DPNB17G3RskqDDtRCx5+QW29gm5kp/n3ft
         6Of5rcPjbT0cPaA9RViGNT06c+TfZJ5sOh0eSwx6JQ66+T4YSfY9o444hi09caPJamYM
         BLiMH3gyZ6N8mQFRqbZ6pKEE+VuBVeMcoHrQPVTwJsYkSm3Bo9K5/EUyb8CUSp9ic3ks
         NI9A==
X-Gm-Message-State: APjAAAXg1yme8NzCXW/bAVc0xgjr8eGku7nC6ZXIaMBqcEs9zmK2IFT8
        Tc+B1ajZBIoN5XOWj77XhJLo1yK4vEeUiwP4uq27g0KwNgYi/WJTcW6bzBY+NvpJVHYzAv8gWPN
        xxCaTaH6N9whJUBhLUMCHMOWWSgTDucqw/pXF5nTV
X-Received: by 2002:a63:ee0c:: with SMTP id e12mr122830313pgi.184.1564691331090;
        Thu, 01 Aug 2019 13:28:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw1+AnMSrYjUU0Qm4tA1sS6bn3wBA6lqGpHC1DrfTXAN56OY92iiKg27Q4q1jM6d9J5vCJtDQ==
X-Received: by 2002:a63:ee0c:: with SMTP id e12mr122830290pgi.184.1564691330808;
        Thu, 01 Aug 2019 13:28:50 -0700 (PDT)
Received: from [192.168.1.201] (201-43-220-172.dsl.telesp.net.br. [201.43.220.172])
        by smtp.gmail.com with ESMTPSA id o14sm4976723pjp.19.2019.08.01.13.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 13:28:43 -0700 (PDT)
Subject: Re: [PATCH] md/raid0: Fail BIOs if their underlying block device is
 gone
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     NeilBrown <neilb@suse.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Song Liu <songliubraving@fb.com>, dm-devel@redhat.com,
        Neil F Brown <nfbrown@suse.com>, linux-block@vger.kernel.org
References: <20190729193359.11040-1-gpiccoli@canonical.com>
 <87zhkwl6ya.fsf@notabene.neil.brown.name>
 <6400083b-3cf3-cbc6-650a-c3ae6629b14c@canonical.com>
 <CAPhsuW69YrpHqBCOob2b5wzzWS9FM087sfe3iC0odX8kZWRwmA@mail.gmail.com>
 <CAPhsuW5zB=Kik4rq9YA-xBer7Z-h-23QV4WSCWe-jvhFgGc0Cw@mail.gmail.com>
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
Message-ID: <9674ca8f-4325-3023-8a1d-39782103f55d@canonical.com>
Date:   Thu, 1 Aug 2019 17:28:24 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5zB=Kik4rq9YA-xBer7Z-h-23QV4WSCWe-jvhFgGc0Cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 31/07/2019 16:56, Song Liu wrote:
> On Wed, Jul 31, 2019 at 12:54 PM Song Liu <liu.song.a23@gmail.com> wrote:
>>
>> On Tue, Jul 30, 2019 at 5:31 AM Guilherme G. Piccoli
>> <gpiccoli@canonical.com> wrote:
>>>
>>> On 29/07/2019 21:08, NeilBrown wrote:
>>>> [...]
>>>>> +    if (unlikely(test_bit(MD_BROKEN, &mddev->flags))) {
>>>>> +            bio_io_error(bio);
>>>>> +            return BLK_QC_T_NONE;
>>>>> +    }
>>>>
>>>> I think this should only fail WRITE requests, not READ requests.
>>>>
>>>> Otherwise the patch is probably reasonable.
>>>>
>>>> NeilBrown
>>>
>>> Thanks for the feedback Neil! I thought about it; it seemed to me better
>>> to deny/fail the reads instead of returning "wrong" reads, since a file
>>> read in a raid0 will be incomplete if one member is missing.
>>> But it's fine for me to change that in the next iteration of this patch.
>>
>> For reads at block/page level, we will either get EIO or valid data, right?
>>
>> If that's not the case, we should fail all writes.
> 
> Oops, I meant all _reads_.

Hi Song, thanks for the feedback! After changing the patch and testing a
bit, it behaves exactly as you said, we got either valid data read from
the healthy devices or -EIO for the data tentatively read from the
failed/missing array members.

So, I'll resubmit with that change. Also, I've noticed clearing the
BROKEN flag seem unnecessary, if user stops the array in order to fix
the missing member, it'll require a re-assembly and the array is gonna
work again.

Do you / Neil considers this fix relevant to md/linear too? If so, I can
also include that in the V2.
Thanks,


Guilherme
