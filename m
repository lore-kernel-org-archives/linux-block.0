Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DD8C61DA4
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 18:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjBBSER (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 13:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBBSEP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 13:04:15 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8040A1D920
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 10:04:07 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id u8so1072742ilq.13
        for <linux-block@vger.kernel.org>; Thu, 02 Feb 2023 10:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7mJPXdAyQaNMenfmKVPe1FNvGsSeoHs0bYtrg1AgZQ=;
        b=FehBfZo++g5qKEFE///0kNP14j2r+akWBT6YHaxhdz8T6i311HvoXAa2keCg1sqSrl
         S/jig4aI1QTvXkHXAG7LMzr/XRbbu9a90wCfuDq/Pi1nuPNG3lTPn+XQ4GiLRhv9YUXR
         8nZHGZwpQnllXb6WT6RbTjkUrxe/irjrNXGZcbXmfcSvReAmX8204wMS2EiLOXIxYqqR
         bLe9GDlKqiuMyU2nY5HZXIBIOMBI0OVICz1D1dZqUjr4g8RuAKZU5PbBBublZpGkMCwd
         1vJqO+JwinLzY2KvKYXJna8TFromRW32wIVdiwHxibxTc+yA72OwtUnelAPKbNvdu35W
         apwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7mJPXdAyQaNMenfmKVPe1FNvGsSeoHs0bYtrg1AgZQ=;
        b=eT8KWsIVQIpH96nvbusI27ovk25PIvQVf1fZveNE0XYUieoL1fl23Wrmymk6g9O72o
         O9bvATIWfn9lQs6kXoyhrsbW3Rn82L2QzK4WksIGCgLIpAlynSffSux+4rK9o7fKn/fq
         d7FQtHgiqEESJIfd0bUw7amnhiuF4dXE4OBB2qiZAZezgm/huC2ooQ/kLMIxeJSM+VRq
         RuLYYEyoOAguShBktuT2bCpc7sHt9LcfrXL36rj54fmB+0rPkyH4uNpH4sAhP7qW4o7L
         wCxE/XzEYH6ASba5dQmhZAIgnEtrHUicOfbzdOiBUNxo91ZaPPR/7oIMCPDhJvUYpdEf
         VBUg==
X-Gm-Message-State: AO0yUKWj5TD9fA37s9Cu2H/nMLNoYN3W3SB6+HYzvBJugeK0pAZ2E5WZ
        WmIi9DR38q3/+jL61q0RfQw/ew==
X-Google-Smtp-Source: AK7set9KkDQIRAlOPw79OCZq9pMNaSE3B1kSx9yJIeCefckSXSJYplWQ5ZJvYh3SpPmp9udsI/GS2g==
X-Received: by 2002:a92:d150:0:b0:311:1949:dd99 with SMTP id t16-20020a92d150000000b003111949dd99mr4130561ilg.3.1675361046771;
        Thu, 02 Feb 2023 10:04:06 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g14-20020a05663811ce00b003b77432cc37sm111272jas.106.2023.02.02.10.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 10:04:06 -0800 (PST)
Message-ID: <98014ebd-7e57-0fc3-9ab0-49f4b727150d@kernel.dk>
Date:   Thu, 2 Feb 2023 11:04:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mmc: core: Imply IOSCHED_BFQ
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
References: <20230131084742.1038135-1-linus.walleij@linaro.org>
 <CAPDyKFrLetcCcFueJzZeWa-SVbsJcspwZ+nXWUDCGRXawxNhdg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAPDyKFrLetcCcFueJzZeWa-SVbsJcspwZ+nXWUDCGRXawxNhdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/2/23 8:22 AM, Ulf Hansson wrote:
> On Tue, 31 Jan 2023 at 09:47, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> If we enable the MMC/SD block layer, use Kconfig to imply the BFQ
>> I/O scheduler.
>>
>> As all MMC/SD devices are single-queue, this is the scheduler that
>> users want so let's be helpful and make sure it gets
>> default-selected into a manual kernel configuration. It will still
>> need to be enabled at runtime (usually with udev scripts).
>>
>> Cc: linux-block@vger.kernel.org
>> Cc: Paolo Valente <paolo.valente@linaro.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I have taken the various arguments (for and against), but I think
> $subject patch makes sense to me. In the end, this is about moving
> towards a more sensible default kernel configuration and the "imply"
> approach works fine for me.
> 
> More importantly, $subject patch doesn't really hurt anything, as it's
> still perfectly fine to build MMC without I/O schedulers and BFQ, for
> those configurations that need this.
> 
> That said, applied for next, thanks!

It doesn't make sense, for all the reasons that Christoph applied.
But you guys seemed to already have your mind made up and ignoring
valid feedback, so...

-- 
Jens Axboe


