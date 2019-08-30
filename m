Return-Path: <SRS0=imVF=W2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FE3C3A5A4
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 12:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17402186A
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 12:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfH3Ms2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:48:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53294 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfH3Ms1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Aug 2019 08:48:27 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1i3gKH-0000Uc-N7
        for linux-block@vger.kernel.org; Fri, 30 Aug 2019 12:48:25 +0000
Received: by mail-pg1-f198.google.com with SMTP id j9so3886991pgk.20
        for <linux-block@vger.kernel.org>; Fri, 30 Aug 2019 05:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3B311aOKf6/H7N61CF4bou7LUlCA79yh6nnh0SwNi/Q=;
        b=oesRQMpZUGAIAMBe1i4htjrQgR12ENu5TY9odlz5t4dIPI08oNB0WeZGS943CxjAY5
         jUxN01bhDJ74x3UhYH52trm2bTlBcvAC4IxD+USaxV2X4gMKi79tuf6OKkmbeLjevKoj
         hk8TbSrZ4QZ1tp44z9UCVFlq4xbmNTFjxxCWyiZu6MvEqgEeCKwM2xmQLFC0Q1FofJFh
         u+DUzFnzsJSzGfoyj6/lnakDUgQ40c1v5MERDejxLrTmn4t6lvUztONO1Zn3Mc5o26TP
         Ecp6eDuwabWX+i9nZkH4Do0arKVp53MJNqLwkT4Q9lLb4I9h39tpjPU3/WoFLhPnIi2h
         eWRA==
X-Gm-Message-State: APjAAAWY1MbXqYKwlpae3DyckPeXFxRtsyFaI9BWBqp3U+kyJVX21aQm
        czEsf+mCHLZbuECqqNeYL2psDbHKC9fOYCU428FxpPbUSw/yu4MUPahLfCcN0u5hitAbiI0SSYE
        xwmGo1q/jghdjmP41ykfYI2BAjQvzwafLiXoG0kkU
X-Received: by 2002:aa7:8b0f:: with SMTP id f15mr17989422pfd.235.1567169304542;
        Fri, 30 Aug 2019 05:48:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxH9FffgY03+3ukV083CL3t5W7RGoTCxctd0RJaul7GbYkOx6jLTZSFn1Wnh+ToobhMYKpIFg==
X-Received: by 2002:aa7:8b0f:: with SMTP id f15mr17989403pfd.235.1567169304280;
        Fri, 30 Aug 2019 05:48:24 -0700 (PDT)
Received: from [192.168.1.201] (200-158-227-228.dsl.telesp.net.br. [200.158.227.228])
        by smtp.gmail.com with ESMTPSA id m13sm9765525pgn.57.2019.08.30.05.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 05:48:23 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] mdadm: Introduce new array state 'broken' for
 raid0/linear
To:     NeilBrown <neilb@suse.de>
Cc:     linux-raid@vger.kernel.org, jay.vosburgh@canonical.com,
        Song Liu <songliubraving@fb.com>, liu.song.a23@gmail.com,
        dm-devel@redhat.com, Neil F Brown <nfbrown@suse.com>,
        linux-block@vger.kernel.org, jes.sorensen@gmail.com
References: <20190822161318.26236-1-gpiccoli@canonical.com>
 <20190822161318.26236-2-gpiccoli@canonical.com>
 <87a7brf4or.fsf@notabene.neil.brown.name>
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
Message-ID: <1a215cee-cbbb-ec3a-937a-2bcfb8049fef@canonical.com>
Date:   Fri, 30 Aug 2019 09:48:11 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87a7brf4or.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Neil! CCing Jes, also comments inline:


On 30/08/2019 05:17, NeilBrown wrote:
>> [...]
>> +	char arrayst[12] = { 0 }; /* no state is >10 chars currently */
> 
> Why do you have an array?  Why not just a "char *".
> Then all the "strncpy" below become simple pointer assignment.

OK, makes sense! I'll try to change it.


>> [...]  
>>  int WaitClean(char *dev, int verbose)
>>  {
>> @@ -1116,7 +1120,8 @@ int WaitClean(char *dev, int verbose)
>>  			rv = read(state_fd, buf, sizeof(buf));
>>  			if (rv < 0)
>>  				break;
>> -			if (sysfs_match_word(buf, clean_states) <= 4)
> 
> Arg.  That is horrible.  Who wrote that code???
> Oh, it was me.  And only 8 years ago.

rofl, happens!


> sysfs_match_word() should return a clear "didn't match" indicator, like
> "-1".
> 
> Ideally that should be fixed, but I cannot really expect you to do that.
> 
> Maybe make it
>    if (clean_states[sysfs_match_word(buf, clean_states)] != NULL)
>  ??
> or
>    if (sysfs_match_word(buf, clean_states) < ARRAY_SIZE(clean_states)-1)
> 
> Otherwise the patch looks ok.

OK, thanks for the review! I'll try to change that in V4 too.
cheers,


Guilherme
