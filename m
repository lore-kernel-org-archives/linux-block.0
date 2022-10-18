Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16D2C4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 22:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJRWLt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 18:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJRWLr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 18:11:47 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5D6BEAE8
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 15:11:43 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id q9so35773051ejd.0
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 15:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Q1Bo1NOfImcyyTBS4cIDNC7uZFtunDU2SA9Z06ciYg=;
        b=ZzR4xOFTAOW00qLiwCYwHEQeQ8xh3ODm6QZacqJo3mjId8wCDfmCJKw7HrnvYvpV0G
         jMH+yaYIY5VnK0xoDTiEOF3e8mNTbIW+o96OmoBVUAadeadkYTjYoV2HficczE+SdMUB
         Xvino41p37CffarOujPXNr4CSdA4oq1sZrBup0zyUjhAE+Qorg1h1E6LMwxMpz+7pbcs
         ZnbZlINaHV7Pr60jcPoSugWwGJOemEoEZlvx7K2DIIlrNvgprMHTWjUUzBbOND6S2WFb
         2ofSGsRHP7pbOIvVemxa0vhBgEpc1ATWltXD3EwynF8MvTxOFQ9qsN0+XBzGDhhimcY4
         k+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Q1Bo1NOfImcyyTBS4cIDNC7uZFtunDU2SA9Z06ciYg=;
        b=ekhL/XPXRFzuG2M8F2oLQrkyu870QExtyjTkrjXuVh9ogxCGJZDhPrLl1nudC8W+dq
         kF+G+FTZOYe8TQ6nnAkEQWFbLCL9PWvrv3aVFlgYF11LLq6uXEPGPpjvIejraLFdZ8UE
         ip+dP+Vj2EMVYHQZF1q0SOGVUDQETsF1cA9n4R2O8aYjrT9zWP/zIOdDSNVo6WnHKlp2
         yWuzN7xSnnEerRJIqM/jwTCQ5dqgUhpSoRh6p2hfBQiFwNv95CgauUe7J+P0HF1neWuG
         8J8SGbGCJBzTwCuDdlv+hUULEQKBcdhgzyRtAiSHpOcHiJ4VWdGlRK6O+Ai7N9gneuQq
         rbSg==
X-Gm-Message-State: ACrzQf0qVLM2En2Q+g2tOjJJPwog+FI/4R21v6vCzX2osdVMhmgoBqwX
        hwQEXxja57062fVsilBk62bTwLsMyUM=
X-Google-Smtp-Source: AMsMyM6zlPhfj9UPXGe2hQ73kVErzhC0ypl8flD0nntIbW8asoQpRbn4rPIbfkqnfdOor8C6R+RSfA==
X-Received: by 2002:a17:907:2701:b0:78d:cb12:6d94 with SMTP id w1-20020a170907270100b0078dcb126d94mr4321132ejk.344.1666131091468;
        Tue, 18 Oct 2022 15:11:31 -0700 (PDT)
Received: from [192.168.2.30] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709061ba100b0072a881b21d8sm8060745ejg.119.2022.10.18.15.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 15:11:15 -0700 (PDT)
Message-ID: <b9608b92-fab8-93a0-2821-80a49c3328eb@gmail.com>
Date:   Wed, 19 Oct 2022 00:11:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [git pull] device mapper changes for 6.1
Content-Language: en-US
To:     Mike Snitzer <snitzer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        Alasdair G Kergon <agk@redhat.com>,
        Jiangshan Yi <yijiangshan@kylinos.cn>
References: <Y07SYs98z5VNxdZq@redhat.com> <Y07twbDIVgEnPsFn@infradead.org>
 <CAHk-=wg3cpPyoO8u+8Fu1uk86bgTUYanfKhmxMsZzvY_mV=Cxw@mail.gmail.com>
 <CAHk-=wiE_p66JtpfsM2GMk0ctuLcP+HBuNOEnpZRY0Ees8oFXw@mail.gmail.com>
 <Y08W5Tj1YC8/BZDM@redhat.com>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <Y08W5Tj1YC8/BZDM@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/22 23:13, Mike Snitzer wrote:
...
>> In the absence of that kind of unification, just use 'errno'.
> 
> Mikulas touches on why why using errno isn't useful for DM. And for
> DM's device stacking it is hard to know which error spewed to dmesg
> (via DMERR, DMCRIT, DMINFO, etc) is relevant to a particular admin
> interface issuing the DM ioctl.
> 
> So the idea to send the (hopefully useful) error string back up to the
> relevant userspace consumer was one task that seemed needed (based on
> Milan Broz's various complaints against DM.. which sprang from your
> regular remainder that DM's version numbers are broken and need to be
> removed/replaced).

Well, when you mention my complaints, I think we are moving from one extreme
to another.

For the error reporting - we use errno values in libcryptsetup everywhere,
so if DM ioctls (through libdevmapper we use) returns proper errno, this is
the minimal solution that helps here.
The problem is that ioctl() are often just translated to -EINVAL.
(Or lost in libdevmapper compatibility layers.)

 From the dm-crypt/verity/integrity perspective, ENOMEM, ENODEV (bad block device),
ENOTSUP/ENOENT (for crypto algs not available), EIO for IO error,
EILSEQ for data integrity failure is the basic what we need.
(I perhaps forgot some, I can go through the code if you need it.)

As a bonus, if DM ioctl() returns fixed string that describes user-friendly error
(like: "keysize not compatible" or so) that's all we need
(ti->error strings are already in DM targets).

I have never asked for dynamically allocated error strings in kernel
and I do not know Mikulas' motivation to implement it.

Milan
