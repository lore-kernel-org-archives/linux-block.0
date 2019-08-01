Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B97C19759
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 12:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966B920838
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 12:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfHAMHg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:07:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45703 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfHAMHf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 08:07:35 -0400
Received: from mail-qk1-f199.google.com ([209.85.222.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1ht9rp-0001wz-Nl
        for linux-block@vger.kernel.org; Thu, 01 Aug 2019 12:07:33 +0000
Received: by mail-qk1-f199.google.com with SMTP id c207so60927997qkb.11
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 05:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=T40t7s213Mp+18EcHtTWk6QKiI1nw6vK09jgcYOJXSo=;
        b=Sbm2b8szaeQ8cpwwvXWC5GNJ05Cj7RMARtZFEjuZgYFFkk/gx2AOAlgxOeD9PujVhN
         yuFWehpTEvHeonmsMiZ7YrtsLmlTOrmU/0eOwVeGQAoYp+yypGKGa1TMrQsXZFbn4/Oo
         APS2Q+EmnyFcry+6ZkvjW2qKOfACVAn3seOn3wkrHoelPQfyPBZbc92Gs0sIW3PxSRE+
         MkxhUcoteA1IjfYQsDN1/Op65B4GM3ZnlzX6NHzLwisAvXUDNVOzEutUgwkeOQENO3rZ
         5B8tL5byJi2IsGN9jCRDCuWTD50+OibD/l1A3KdeYxyaVhUN0mahWG4q8e39fycCaigK
         G0ng==
X-Gm-Message-State: APjAAAWG27xapor7ZSHA6DU7k4ppnb+cbN2w/WOWG0iP4YUNm9BIz8RI
        4opKbZtRyks3OUZIkYlzbEmbtsc9XLDB4XfE96GamDdYZlbL3ZAy2FW3T7Knzi1vMldD5OT9t3O
        P6PuniKBlfiXfjS+dVJ9yEY0ISmwSdKEDim9b9S1j
X-Received: by 2002:ac8:2baa:: with SMTP id m39mr90937727qtm.242.1564661252940;
        Thu, 01 Aug 2019 05:07:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqygDHL715/PEznszVqRRyj/i2NkbmqlN2dd6blZ4AD2LB1WsZHIhTfE3C41A7h6B1l2Ab7RcQ==
X-Received: by 2002:ac8:2baa:: with SMTP id m39mr90937702qtm.242.1564661252703;
        Thu, 01 Aug 2019 05:07:32 -0700 (PDT)
Received: from [192.168.1.202] ([152.254.214.186])
        by smtp.gmail.com with ESMTPSA id i27sm29457201qkk.58.2019.08.01.05.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 05:07:31 -0700 (PDT)
Subject: Re: [PATCH 1/2] md/raid0: Introduce new array state 'broken' for
 raid0
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        NeilBrown <neilb@suse.com>, Song Liu <songliubraving@fb.com>
References: <20190729203135.12934-1-gpiccoli@canonical.com>
 <20190729203135.12934-2-gpiccoli@canonical.com>
 <CAPhsuW5n9TCZjVT3QnFhHkbfPTvh7ifFiNXypOHouL5ByZS7+w@mail.gmail.com>
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
Message-ID: <037ef0ef-1a34-f522-6b31-e388906a87fa@canonical.com>
Date:   Thu, 1 Aug 2019 09:07:28 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5n9TCZjVT3QnFhHkbfPTvh7ifFiNXypOHouL5ByZS7+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 31/07/2019 16:43, Song Liu wrote:
>[...]
>> @@ -4315,6 +4329,7 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
>>                 break;
>>         case write_pending:
>>         case active_idle:
>> +       case broken:
>>                 /* these cannot be set */
>>                 break;
>>         }
> 
> Maybe it is useful to set "broken" state? When user space found some issues
> with the drive?
> 
> Thanks,
> Song

Hi Song, thanks a lot for your feedback. I can easily add that in V2
along with Neil's suggestion, I agree with you.
There is a 2/2 patch regarding the mdadm counterpart; you should have
received the email, but for completeness, the link is:

lore.kernel.org/linux-block/20190729203135.12934-3-gpiccoli@canonical.com

Thanks,


Guilherme

