Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A205C19F28
	for <linux-block@archiver.kernel.org>; Wed,  3 Aug 2022 15:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiHCPQH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Aug 2022 11:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiHCPQG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Aug 2022 11:16:06 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013905F52
        for <linux-block@vger.kernel.org>; Wed,  3 Aug 2022 08:16:03 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h145so13092266iof.9
        for <linux-block@vger.kernel.org>; Wed, 03 Aug 2022 08:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=UqA5JlnpsDwul9u59013mVQ6fOF0xwKEdAApbjpUB4k=;
        b=a3LTxcEJqq+ygKX8syI8HoO2pQVzQMP3crz/gwBQjPIRR6ctkXnEMkjQAUGfiF9a6h
         KJYWDSnniE/uoqfpJLDou8eQjP2fBMM42T1i5l/AsQms8GusgbCXmBSYpxu8AL+b4Baq
         EYloDOoHBObhD5ToRXce6gr8VcPFREHe0TxSMhd4DciUuxgCmUWt/85OsVk20daSygaI
         qOh3pU3KjgC5OqWzXtnDRhMd3qEkf65E+8thqe0fF2hQzBab7NS8n4y3F/SS1z131jfT
         AxGhVPk3ljDeXCA05q9F5IMWAs6VkNOPg+meYbeRQKEiL630Ylf0VGoc6SCe1yThN7lQ
         ibaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=UqA5JlnpsDwul9u59013mVQ6fOF0xwKEdAApbjpUB4k=;
        b=KKMwKUywFSltXIZBlwvfeGakNhhrnFfaJ/NopFi/s5BlYejXnp83wPrDosYLOeDHH6
         D8uXRrfZapMzpnA9W94FJbb5jMBhhTgIA5pgtCj6c0hQsuJnm3NGUGJRR7P5U2S4frxW
         IcPCjjTnKg3EnXJ7WXWCYuX2b3VAXtYUhN7ixL/xcc7O6C0qRPcGvsisU4LLJz1Kx7cc
         dshN0OKfzu+H2EkI5c41R7EZdSvpI02W5nFN78D6RDafXDaVrvQHmWm1MeHEM/e/oGkl
         JhtWCsvEXJ6aJfLDAHueC76izFw4eAHwaTLotRfgNcNG0YhFZYy7e+aXIPI5LJzx4uFB
         el4Q==
X-Gm-Message-State: AJIora9bvzPRa97a7Y65zYTTrKW9fH7AjlEK0MNsEqEg9Bsp+oxsEVLB
        rsw1EW8ToIZ8h7jeuam4BURYpw==
X-Google-Smtp-Source: AGRyM1vxYZdVXmuwtN6fcqeq0S2s9ueB1GSJmwmeelGjfBhcStC117U+UgfylPisIOv+J33c4aRy1w==
X-Received: by 2002:a05:6602:160a:b0:67c:28b:7627 with SMTP id x10-20020a056602160a00b0067c028b7627mr8991152iow.207.1659539763301;
        Wed, 03 Aug 2022 08:16:03 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z14-20020a02938e000000b0033f1953b15esm7872404jah.60.2022.08.03.08.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 08:16:02 -0700 (PDT)
Message-ID: <3af4127a-f453-4cf7-f133-a181cce06f73@kernel.dk>
Date:   Wed, 3 Aug 2022 09:16:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
 <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
 <YumYKVWYnoALoSBR@kbusch-mbp.dhcp.thefacebook.com>
 <74bb310b-b602-14eb-85f7-4b08327b0092@kernel.dk>
 <CAHk-=wgAeL8+BYsy4mnut+y7sBF_+LXmW5bjUfegBpg8SisBJQ@mail.gmail.com>
 <7d663c1a-67a2-159e-3f93-28ec18f3bd9d@kernel.dk>
 <CAHk-=wgALRccia0ouYywoDAH7RDCpi3rwfjwT0TZ7gV4O1+qaA@mail.gmail.com>
 <38164718-0f09-76e5-a21d-2122613cdf73@kernel.dk>
 <CAHk-=wii5SG2=P1kStBYJ9JiK97GYZcYdozy-JP15qNcfQXF3g@mail.gmail.com>
 <2ae97675-383b-c2c7-9bed-6a9a55ce64f1@kernel.dk>
 <CAHk-=wjQpMT+Z-=B4QzGT_BkSe0kuqDuK+hBvOq7YTXKmM2HEQ@mail.gmail.com>
 <c1b1b619-9142-9818-0536-ce4b97d3e979@kernel.dk>
In-Reply-To: <c1b1b619-9142-9818-0536-ce4b97d3e979@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/2/22 5:08 PM, Jens Axboe wrote:
> On 8/2/22 5:03 PM, Linus Torvalds wrote:
>> On Tue, Aug 2, 2022 at 3:59 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> Actually, I'm mistaken, on the build box it's running 11.3. So that
>>> might explain it? I use 12.1 elsewhere.
>>
>> It's possible this -Waddress error is new to gcc-12.
>>
>> I try to keep most of my machines in sync just to avoid the pain of
>> different distro details, so I don't have gcc-11 around any more.
> 
> I'll get gcc-12 back on it - I originally swapped back to 11 for
> building kernels to avoid spurious warnings with the new release.

On the topic of warnings, on my new build box I get a lot of these:

ld: warning: arch/x86/lib/putuser.o: missing .note.GNU-stack section implies executable stack
ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker

which ends up polluting the output quite a bit.

axboe@r7525 ~> ld --version
GNU ld (GNU Binutils for Debian) 2.38.90.20220713


-- 
Jens Axboe

