Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04753C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 22:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85D32087B
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 22:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfD3WlW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:41:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:32877 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfD3WlV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 18:41:21 -0400
Received: from mail-qt1-f199.google.com ([209.85.160.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hLbR9-0000O0-QB
        for linux-block@vger.kernel.org; Tue, 30 Apr 2019 22:41:19 +0000
Received: by mail-qt1-f199.google.com with SMTP id f53so2555338qte.21
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2019 15:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BNuNywNm3nYV5TRhn28+hTsGtHkLiVwZcTZZouyHt4g=;
        b=tA5jSFNiv3ixUql/3PLVDfOnp7iNt38zXvtRekc7C0BF50c+0xeLvG9owjrKZ7kV6K
         ygVwr+rrcDUMCyodCcXpZCxPs4sltbL0Bp+ndd7/axQLenpoDZ2vpMBMZgWIXfQhW86T
         Kmaz1vv+60zSzHqaWuxfvdRuHQyL2L4Pb29C4d4sC0Ogu/EE/l2jetkAp6ukBzyLPCTp
         KmWET0udWbC6HQMgksMDumMr+VzntgZPIIlYFXdDCXynxKbK6OrHCaJhYZdd5EmlbAXi
         WjR5/emwEPQayG2xay2tf8x2h512nZlPjZgDB6D8sUu38sqXEG7GFG7t//PcoFMaYaUj
         LUgw==
X-Gm-Message-State: APjAAAUE2JACU38o1PaQBOa5+dq4uO+8e+A4Q9oeBsIyxMIaox5jZ8vv
        EkbwBlUVJF5YatEdOTbpsci1Rc47w3D9jwTtmM1cQLYQouoM5IQ4IsGtxXX/kTkrkHi0lP+4UKq
        L3bHmlYxsOfdu3IBpvVrWPwjeuQEMhjHBbzPxuZzO
X-Received: by 2002:ac8:352f:: with SMTP id y44mr31084094qtb.130.1556664078999;
        Tue, 30 Apr 2019 15:41:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqySp93LhP+mvPSQT1QyiKl5ZSHs1A52qRRiJ0rIyZm1NyCtfU5TBHrXwypsgBA0n7j+OqPs4w==
X-Received: by 2002:ac8:352f:: with SMTP id y44mr31084081qtb.130.1556664078788;
        Tue, 30 Apr 2019 15:41:18 -0700 (PDT)
Received: from [192.168.1.201] (201-13-157-136.dial-up.telesp.net.br. [201.13.157.136])
        by smtp.gmail.com with ESMTPSA id m60sm20407664qte.81.2019.04.30.15.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 15:41:18 -0700 (PDT)
Subject: Re: [RFC] [PATCH V2 0/1] Introduce emergency raid0 stop for mounted
 arrays
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     axboe@kernel.dk, linux-raid <linux-raid@vger.kernel.org>,
        jay.vosburgh@canonical.com, kernel@gpiccoli.net,
        NeilBrown <neilb@suse.com>, dm-devel@redhat.com,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, gavin.guo@canonical.com
References: <20190418220448.7219-1-gpiccoli@canonical.com>
 <CAPhsuW4k5zz2pJBPL60VzjTcj6NTnhBh-RjvWASLcOxAk+yDEw@mail.gmail.com>
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
Message-ID: <b39b96ea-2540-a407-2232-1af91e3e6658@canonical.com>
Date:   Tue, 30 Apr 2019 19:41:11 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4k5zz2pJBPL60VzjTcj6NTnhBh-RjvWASLcOxAk+yDEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 19/04/2019 14:08, Song Liu wrote:
> [...]
> I read through the discussion in V1, and I would agree with Neil that
> current behavior is reasonable.
> 
> For the following example:
> 
> fd = open("file", "w");
> write(fd, buf, size);
> ret = fsync(fd);
> 
> If "size" is big enough, the write is not expected to be atomic for
> md or other drives. If we remove the underlining block device
> after write() and before fsync(), the file could get corrupted. This
> is the same for md or NVMe/SCSI drives.
> 
> The application need to check "ret" from fsync(), the data is safe
> only when fsync() returns 0.
> 
> Does this make sense?
> 

Hi Song, thanks for your quick response, and sorry for my delay.
I've noticed after v4.18 kernel started to crash when we remove one
raid0 member while writing, so I was investigating this
before perform your test (in fact, found 2 issues [0]), hence my delay.

Your test does make sense; in fact I've tested your scenario with the
following code (with the patches from [0]):
https://pastebin.ubuntu.com/p/cyqpDqpM7x/

Indeed, fsync returns -1 in this case.
Interestingly, when I do a "dd if=<some_file> of=<raid0_mount>" and try
to "sync -f <some_file>" and "sync", it succeeds and the file is
written, although corrupted.

Do you think this behavior is correct? In other devices, like a pure
SCSI disk or NVMe, the 'dd' write fails.
Also, what about the status of the raid0 array in mdadm - it shows as
"clean" even after the member is removed, should we change that?


> Also, could you please highlight changes from V1 (if more than
> just rebase)?

No changes other than rebase. Worth mentioning here that a kernel bot
(and Julia Lawall) found an issue in my patch; I forgot a
"mutex_lock(&mddev->open_mutex);" in line 6053, which caused the first
caveat (hung mdadm and persistent device in /dev). Thanks for pointing
this silly mistake from me! in case this patch gets some traction, I'll
re-submit with that fixed.

Cheers,


Guilherme

[0] https://marc.info/?l=linux-block&m=155666385707413

> 
> Thanks,
> Song
> 
