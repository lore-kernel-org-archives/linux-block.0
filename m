Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12966C04AAD
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 18:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8F920675
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 18:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfEFSsL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 14:48:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49156 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfEFSsK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 14:48:10 -0400
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hNiem-0007H5-Ee
        for linux-block@vger.kernel.org; Mon, 06 May 2019 18:48:08 +0000
Received: by mail-qt1-f197.google.com with SMTP id z34so16325919qtz.14
        for <linux-block@vger.kernel.org>; Mon, 06 May 2019 11:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bC2THTg10tW16ub7PNyNptaheYbyDqPTCbofTdADo6U=;
        b=MyfnSUYYEkoYWZP9P+ViDkQa4k9ZarNruhnVq9ujDREzYd+vJ1AlARcJZFW8tpVWjd
         IlU5X01GE8GYyn97hotgOeoJ97QO4gSt1A4EWo8jIJmULIXNUbaqwqIqOG9J9ev2KAXv
         FCK72Z/MK44COrOBBXQu/6cApZbHufZqyUkYYu49PGMigdKh+l773A3Lyw5Qf7NmJX/E
         1i9qCpY7M7EocpEbaX1EuHGUbUE0ZNZEQ1cUdLtzW5o/Q0+7HlMSHqhc38MzKT9OHjvX
         K57m1lCW51yCe5EB3LwxogSEjE0S2hWn8gxebx4o4ZAL0SS5liNMBCuw1nC8mePrqPHC
         zBkw==
X-Gm-Message-State: APjAAAXu0HBCQiPhwNVTFeX8Me3Y3VOsWczAVYMGpLY5V5bB2iS0yoJv
        3AtT/wSP1pqnwLLe0k3RJaPRuuWea/NUYq0xEPzudpddPFQmAIu4vHrWGCD5+yvlvOEkjoSjhac
        A7HC2YKCpAg6ZqjtGofFaPMqTMkPT5L+S0NhulhW6
X-Received: by 2002:ac8:1c39:: with SMTP id a54mr20851829qtk.344.1557168487498;
        Mon, 06 May 2019 11:48:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwli31XV/EPuqTTwm6MSINbZHcbpJYoivTjqAbSmdTKZRc/DelL2WjDxPfeSm6BWH7j+Norfw==
X-Received: by 2002:ac8:1c39:: with SMTP id a54mr20851815qtk.344.1557168487296;
        Mon, 06 May 2019 11:48:07 -0700 (PDT)
Received: from [192.168.0.239] ([177.183.163.179])
        by smtp.gmail.com with ESMTPSA id j123sm6316420qkf.23.2019.05.06.11.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 11:48:06 -0700 (PDT)
Subject: Re: [PATCH 2/2] md/raid0: Do not bypass blocking queue entered for
 raid0 bios
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>, dm-devel@redhat.com,
        axboe@kernel.dk, Gavin Guo <gavin.guo@canonical.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>, kernel@gpiccoli.net,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        stable@vger.kernel.org
References: <20190430223722.20845-1-gpiccoli@canonical.com>
 <20190430223722.20845-2-gpiccoli@canonical.com>
 <CAPhsuW4SeUhNOJJkEf9wcLjbbc9qX0=C8zqbyCtC7Q8fdL91hw@mail.gmail.com>
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
Message-ID: <c8721ba3-5d38-7906-5049-e2b16e967ecf@canonical.com>
Date:   Mon, 6 May 2019 15:48:01 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4SeUhNOJJkEf9wcLjbbc9qX0=C8zqbyCtC7Q8fdL91hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/05/2019 13:50, Song Liu wrote:
> [...] 
> IIUC, we need this for all raid types. Is it possible to fix that in md.c so
> all types get the fix?
> 
> Thanks,
> Song
> 

Hi Song, thanks again for reviewing my code and provide input, much
appreciated!

I understand this could in theory affects all the RAID levels, but in
practice I don't think it'll happen. RAID0 is the only "blind" mode of
RAID, in the sense it's the only one that doesn't care at all with
failures. In fact, this was the origin of my other thread [0], regarding
the change of raid0's behavior in error cases..because it currently does
not care with members being removed and rely only in filesystem failures
(after submitting many BIOs to the removed device).

That said, in this change I've only took care of raid0, since in my
understanding the other levels won't submit BIOs to dead devices; we can
experiment that to see if it's true.

But I'd be happy to change all other levels also if you think it's
appropriate (or a simple generic change to md.c if it is enough). Do you
think we could go ahead with this change, and further improve that (to
cover all raid cases if necessary)?

Cheers,


Guilherme



[0] https://marc.info/?l=linux-raid&m=155562509905735
