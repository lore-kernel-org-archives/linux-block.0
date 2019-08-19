Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B44C3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 19:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24AA2087E
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 19:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfHSTLe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:11:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50854 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfHSTLd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 15:11:33 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hzn3z-0004bC-Gq
        for linux-block@vger.kernel.org; Mon, 19 Aug 2019 19:11:31 +0000
Received: by mail-pf1-f199.google.com with SMTP id 22so3044657pfn.22
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2019 12:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/ySB6YO3oF918LqImPkt1biBidhOND2V5EhnMg++S00=;
        b=hzJn5iqhS2rXL3bTANtRtcLwSghUAKpXLJL83TWE8IWsUFtvvNXONvswOi+uIJTZ2P
         MT9L45bs79KcZngSdtvGprlfBZYTULNuwqe8N5N6v4coPfT+9OfI5pcmNzko3tGApiCR
         7uRtZSELwCE5LxjAOK/KjyLMfoBEQjvIFDGJhRhaQzcsEyQJJLqdege+NcBtKr6j4aWa
         FNZShGud5OLwyalWVbWnlOfHqLEDtfXpwE9qGFK8+koFWtFcZSIJA54mMbdbm4QFUlFY
         ziaTx0GiyeJQIQl5vtKNSOn/sr8IM8TQksOlaev/3dSKSTgkrpGgWDo4wqQeIUKPMcm0
         yDcg==
X-Gm-Message-State: APjAAAV8Yc3v8AmwL4s82UkaRDRgFOlTaqVfEk5PZ3G1vh0clTCO9LJa
        DD3i8ZKfXcJSWxl/M/Wbe/KuLwNj/pEY0yxu8cX7q2jGFb5yeWqdpJQA93iYFI1EkupBLw4jNy6
        44yV/lqsFSsch/Q/CJREImlIiZ5U5pL2Fc5kk7n2c
X-Received: by 2002:a17:902:461:: with SMTP id 88mr22927484ple.296.1566241890274;
        Mon, 19 Aug 2019 12:11:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzNEpRGwYs6DWGIGDDRFL2S18tMDGGxhnrBNm+6nd3jyDBZ1FXzsMTaP2clZai7ya03x177uA==
X-Received: by 2002:a17:902:461:: with SMTP id 88mr22927463ple.296.1566241890108;
        Mon, 19 Aug 2019 12:11:30 -0700 (PDT)
Received: from [192.168.1.75] ([191.13.19.2])
        by smtp.gmail.com with ESMTPSA id a15sm20256729pfg.102.2019.08.19.12.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 12:11:29 -0700 (PDT)
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
Message-ID: <4c95f76c-dfbc-150c-2950-d34521d1e39d@canonical.com>
Date:   Mon, 19 Aug 2019 16:11:19 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1725F15D-7CA2-4B8D-949A-4D8078D53AA9@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/08/2019 15:57, Song Liu wrote:
>[...] 
> 
> I was thinking, if we can set MD_BROKEN when the device fails, we can 
> just test MD_BROKEN in array_state_show() (instead of iterating through 
> all devices). 
> 
> Would this work?
> 
> Thanks,
> Song
> 

This could work, but will require some refactors; it'll simplify the
check for a healthy array (no need for is_missing_dev() function) but
will complicate the criteria to clear MD_BROKEN and the detection of
more members failing (we would stop the detection after the 1st failure
if we only test MD_BROKEN).

We will always need to test the GENHD_FL_UP in some code path, to be
able to show users device recovered from a failure.
Where do you suggest to test this flag?

Thanks,


Guilherme
