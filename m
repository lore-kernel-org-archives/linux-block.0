Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E66C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E2E217F4
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EJTgFb9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfDHPL7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:11:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34034 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbfDHPL7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 11:11:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so7810197pfd.1
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 08:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uf+JOVrp+blctphj7Zs1rQG3HF1Cn+THqJ2M8iLrb1c=;
        b=EJTgFb9VdOiZ3WFFpaPgJFIf9Tkd2aPGPju4O/0isvdn8mVDyqRtpXvTvL70aF/oRL
         1Hk6SjAVDj3dibWg2l4nxfx4Whz4ILNVdgxsqHCb/V9+E3WanlMbtyyzU4T+RZ6NAyFj
         exPQy8utF73fc+ovNJRmwXOR7C3EIpnmluc3N/6XwG3XNiM8w8LJehjnrCZP1jHdoLEy
         f8fvJte0Z08DRJRNxscnly9VMq0pmAczAHRCewJ9g7f6DbUmCk0/fdxDrQycbeWM0I9b
         rc10jr98vCwSmW0YUgCqFwwZ8J6sTTJ21+AfkW8h5qBsh1AdpsuMyNhX+qSEC280t3Gl
         Wang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uf+JOVrp+blctphj7Zs1rQG3HF1Cn+THqJ2M8iLrb1c=;
        b=mPkY6IRgInBT3HkchwPBxRxG99qXFtW6mUVHxEvi6ltDoPsve9n7GV3KqMwq/M+gRc
         pcg8enPx6e5OCkAsHp2KT+b44YBL0ldo8R5u6eh6Kmc5LKXGAM5kqwoncF7qS0gmb9Qa
         hl8z4g4L3VES9D3e8veD49C7gzThGKPgCqV0uCH0rLOT5Ms3d/UJGKKM+2bKJtjSonyi
         ZHeNVMwvFbv1vxTXXY9+Tuk6AWLD7nHFObA/DKhPDo99OlEeDt9czhMJ5cVj+W3L4eRY
         vKDRdZnSLVhEx+dLmNcvKzFAj0JHR0ygLWo4BBSIu9tgor6UvN0YTYKuVw60NFLIpsWI
         D0nA==
X-Gm-Message-State: APjAAAUa+mV46D3JVJDM94v+6KMCO95+oHNNnIFTax5YSzIyqe6wrz06
        3zS/aobw5bxIzGjcbrvqxHCWCQ==
X-Google-Smtp-Source: APXvYqxLsZurE7GMkskGV+BlS1/DzOWq1oc466BhIMR1Y2yB0qR5OtfIXHfx+ZgGAH9RBdkXh+I2yg==
X-Received: by 2002:a65:524a:: with SMTP id q10mr27889823pgp.224.1554736318373;
        Mon, 08 Apr 2019 08:11:58 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id i10sm54250398pfj.7.2019.04.08.08.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:11:57 -0700 (PDT)
Subject: Re: [PATCH 1/1] block, bfq: delete "bfq" prefix from cgroup filenames
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        lennart@poettering.net, mkoutny@suse.cz
References: <20190408143935.9062-1-paolo.valente@linaro.org>
 <20190408143935.9062-2-paolo.valente@linaro.org>
 <20190408144925.GA23021@linux-x5ow.site>
 <7B68DAA9-61D9-4AE0-9FA9-05C07C7FE408@linaro.org>
 <20190408150430.GB23021@linux-x5ow.site>
 <df1dfe5d-c763-91c2-4aca-25d4622c4820@kernel.dk>
 <938957C8-3A0F-4664-8D1F-A822F6D6D4E7@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <85f1978b-bb31-c6bc-e824-c0682bbd2922@kernel.dk>
Date:   Mon, 8 Apr 2019 09:11:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <938957C8-3A0F-4664-8D1F-A822F6D6D4E7@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/19 9:06 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 8 apr 2019, alle ore 17:05, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 4/8/19 9:04 AM, Johannes Thumshirn wrote:
>>> [+Cc Michal ]
>>> On Mon, Apr 08, 2019 at 04:54:39PM +0200, Paolo Valente wrote:
>>>>
>>>>
>>>>> Il giorno 8 apr 2019, alle ore 16:49, Johannes Thumshirn <jthumshirn@suse.de> ha scritto:
>>>>>
>>>>> On Mon, Apr 08, 2019 at 04:39:35PM +0200, Paolo Valente wrote:
>>>>>> From: Angelo Ruocco <angeloruocco90@gmail.com>
>>>>>>
>>>>>> When bfq was merged into mainline, there were two I/O schedulers that
>>>>>> implemented the proportional-share policy: bfq for blk-mq and cfq for
>>>>>> legacy blk. bfq's interface files in the blkio/io controller have the
>>>>>> same names as cfq. But the cgroups interface doesn't allow two
>>>>>> entities to use the same name for their files, so for bfq we had to
>>>>>> prepend the "bfq" prefix to each of its files. However no legacy code
>>>>>> uses these modified file names. This naming also causes confusion, as,
>>>>>> e.g., in [1].
>>>>>>
>>>>>> Now cfq has gone with legacy blk, so there is no need any longer for
>>>>>> these prefixes in (the never used) bfq names. In view of this fact, this
>>>>>> commit removes these prefixes, thereby enabling legacy code to truly
>>>>>> use the proportional share policy in blk-mq.
>>>>>>
>>>>>> [1] https://github.com/systemd/systemd/issues/7057
>>>>>
>>>>> Hmm, but isn't this a user-space facing interface and thus some sort of ABI?
>>>>> Do you know what's using it and what breaks due to this conversion?
>>>>>
>>>>
>>>> Yep, but AFAIK, the problem is exactly the opposite: nobody uses these
>>>> names for the proportional-share policy, or wants to use these names.  I'm
>>>> CCing Lennart too, in case he has some improbable news on this.
>>>>
>>>> So the idea is to align names to what people expect, possibly before
>>>> more confusion arises.
>>>
>>> OK, crazy idea, not sure if Jens and Tejun will beat me for this, but
>>> symlinks?
>>>
>>> This way we can a) keep the old files and b) have them point to the new (a.k.a
>>> cfq style) files.
>>
>> I did consider that, and that would be doable. But honestly, I'm having a
>> hard time seeing what issue we are attempting to fix by doing this.
>>
> 
> The problem is ~100% of people and software believing to set weights and not doing it.

I'm sorry, but I don't know what that means?

-- 
Jens Axboe

